import dbus, dbus.mainloop.glib, gobject, logging, re, sys, time, subprocess

ssid           = sys.argv[1]
security       = sys.argv[2]
psk            = sys.argv[3]
assoc_timeout  = float(sys.argv[4])
config_timeout = float(sys.argv[5])
reset_timeout  = float(sys.argv[6]) if len(sys.argv) > 6 else assoc_timeout

bus_loop = dbus.mainloop.glib.DBusGMainLoop(set_as_default=True)
bus = dbus.SystemBus(mainloop=bus_loop)
manager = dbus.Interface(bus.get_object("org.chromium.flimflam", "/"),
    "org.chromium.flimflam.Manager")


def DbusSetup():
    try:
        path = manager.GetService(({
                    "Type": "wifi",
                    "Mode": "managed",
                    "SSID": ssid,
                    "Security": security,
                    "Passphrase": psk }))
        service = dbus.Interface(
            bus.get_object("org.chromium.flimflam", path),
            "org.chromium.flimflam.Service")
    except Exception, e:
        print "FAIL(GetService): ssid %s exception %s" %(ssid, e)
        sys.exit(1)

    return (path, service)


def ParseProps(props):
    proplist = []
    for p in props:
        proplist.append("'%s': '%s'" % (str(p), str(props[p])))
    return '{ %s }' % ', '.join(proplist)


def ResetService(init_state):
    wait_time = 0

    if init_state == 'idle':
        # If we are already idle, we have nothing to do
        return
    if init_state == 'ready':
        # flimflam is already connected.  Disconnect.
        service.Disconnect()
    else:
        # Workaround to force flimflam out of error state and back to 'idle'
        service.ClearProperty('Error')

    while wait_time < reset_timeout:
        if service.GetProperties().get("State", None) == "idle":
            break
        time.sleep(2)
        wait_time += 2

    print>>sys.stderr, "cleared ourselves out of '%s' after %3.1f secs" % \
        (init_state, wait_time)
    time.sleep(4)
    

def TryConnect(assoc_time):
    init_assoc_time = assoc_time
    try:
        init_state = service.GetProperties().get("State", None)
    except dbus.exceptions.DBusException, e:
        print>>sys.stderr, "We just lost the service handle!"
        return (None, 'DBUSFAIL')

    ResetService(init_state)

    # print "INIT_STATUS1: %s" % service.GetProperties().get("State", None)

    try:
        service.Connect()
    except Exception, e:
        print "FAIL(Connect): ssid %s exception %s" %(ssid, e)
        sys.exit(2)

    properties = None
    # wait up to assoc_timeout seconds to associate
    while assoc_time < assoc_timeout:
        properties = service.GetProperties()
        status = properties.get("State", None)
        #    print>>sys.stderr, "time %3.1f state %s" % (assoc_time, status)
        if status == "failure":
            if assoc_time == init_assoc_time:
                print>>sys.stderr, "failure on first try!  Sleep 5 seconds"
                time.sleep(5)
            return (properties, 'FAIL')
        if status == "configuration" or status == "ready":
            return (properties, None)
        time.sleep(.5)
        assoc_time += .5
    if assoc_time >= assoc_timeout:
        if properties is None:
            properties = service.GetProperties()
        return (properties, 'TIMEOUT')
        sys.exit(4)


# Open /var/log/messages and seek to the current end
def OpenLogs(*logfiles):
    logs = []
    for logfile in logfiles:
        try:
            msgs = open(logfile)
            msgs.seek(0, 2)
            logs.append({ 'name': logfile, 'file': msgs })
        except Exception, e:
            # If we cannot open the file, this is not necessarily an error
            pass

    return logs


def DumpLogs(logs):
    for log in logs:
        print>>sys.stderr, "Content of %s during our run:" % log['name']
        print>>sys.stderr, "\n  )))  ".join(log['file'].readlines())

    print>>sys.stderr, "iw dev wlan0 scan output: %s" % \
        subprocess.Popen(["iw", "dev", "wlan0", "scan"],
                         stdout=subprocess.PIPE).communicate()[0]


logs = OpenLogs('/var/log/messages', '/var/log/hostap.log')

(path, service) = DbusSetup()

assoc_start = time.time()
for attempt in range(5):
    assoc_time = time.time() - assoc_start
    print>>sys.stderr, "connect attempt #%d %3.1f secs" % (attempt, assoc_time)
    (properties, failure_type) = TryConnect(assoc_time)
    if failure_type is None or failure_type == 'TIMEOUT':
        break
    if failure_type == 'DBUSFAIL':
        (path, service) = DbusSetup()

assoc_time = time.time() - assoc_start

if failure_type is not None:
    print "%s(assoc): ssid %s assoc %3.1f secs props %s" \
        %(failure_type, ssid, assoc_time, ParseProps(properties))
    DumpLogs()
    sys.exit(3)

# wait another config_timeout seconds to get an ip address
config_time = 0
status = properties.get("State", None)
if status != "ready":
    while config_time < config_timeout:
        properties = service.GetProperties()
        status = properties.get("State", None)
#        print>>sys.stderr, "time %3.1f state %s" % (config_time, status)
        if status == "failure":
            print "FAIL(config): ssid %s assoc %3.1f config %3.1f secs" \
                %(ssid, assoc_time, config_time)
            sys.exit(5)
        if status == "ready":
            break
        if status != "configuration":
            print "FAIL(config): ssid %s assoc %3.1f config %3.1f secs *%s*" \
                %(ssid, assoc_time, config_time, status)
            break
        time.sleep(.5)
        config_time += .5
    if config_time >= config_timeout:
        print "TIMEOUT(config): ssid %s assoc %3.1f config %3.1f secs" \
            %(ssid, assoc_time, config_time)
        DumpLogs()
        sys.exit(6)

print "OK %3.1f %3.1f (assoc and config times in sec)" \
    %(assoc_time, config_time)
sys.exit(0)

