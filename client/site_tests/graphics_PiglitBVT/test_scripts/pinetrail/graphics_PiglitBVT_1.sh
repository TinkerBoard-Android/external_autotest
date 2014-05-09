#!/bin/bash


need_pass=211
failures=0
PIGLIT_PATH=/usr/local/autotest/deps/piglit/piglit/
export PIGLIT_SOURCE_DIR=/usr/local/autotest/deps/piglit/piglit/
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PIGLIT_PATH/lib
export DISPLAY=:0


function run_test()
{
  local name="$1"
  local time="$2"
  local command="$3"
  echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
  echo "+ Running test "$name" of expected runtime $time sec: $command"
  sync
  $command
  if [ $? == 0 ] ; then
    let "need_pass--"
    echo "+ Return code 0 -> Test passed. ($name)"
  else
    let "failures++"
    echo "+ Return code not 0 -> Test failed. ($name)"
  fi
}


pushd $PIGLIT_PATH
run_test "glean/api2" 0.0 "bin/glean -o -v -v -v -t +api2 --quick"
run_test "glean/basic" 0.0 "bin/glean -o -v -v -v -t +basic --quick"
run_test "glean/bufferObject" 0.0 "bin/glean -o -v -v -v -t +bufferObject --quick"
run_test "glean/fp1-ABS test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ADD an immediate" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ADD negative immediate" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ADD negative immediate (2)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ADD test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ADD with saturation" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ARB_fog_exp test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ARB_fog_exp2 test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-ARB_fog_linear test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-CMP test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-COS test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-Computed fog exp test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-Computed fog exp2 test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-Computed fog linear test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-DP3 test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-DP3 test (2)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-DP4 test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-DPH test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-DST test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-Divide by zero test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-EX2 test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-FLR test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-FRC test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-Infinity and nan test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-LG2 test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-LIT test 1" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-LIT test 2 (degenerate case: 0 ^ 0 -> 1)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-LIT test 3 (case x < 0)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-MAD test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-MAX test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-MIN test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-MOV test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-MUL test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-POW test (exponentiation)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-RCP test (reciprocal)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-RCP test 2 (reciprocal)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-RSQ test 1 (reciprocal square root)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-RSQ test 2 (reciprocal square root of negative value)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-SCS test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-SGE test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-SIN test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-SLT test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-SUB test (with swizzle)" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-SUB with saturation" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-SWZ test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-XPD test 1" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-Z-write test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-masked MUL test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-swizzled add test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fp1-swizzled move test" 0.0 "bin/glean -o -v -v -v -t +fragProg1 --quick"
run_test "glean/fpexceptions" 0.0 "bin/glean -o -v -v -v -t +fpexceptions --quick"
run_test "glean/getString" 0.0 "bin/glean -o -v -v -v -t +getString --quick"
run_test "glean/glsl1-! (not) operator (1, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-! (not) operator (1, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-! (not) operator (2, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-! (not) operator (2, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-&& operator (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-&& operator (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-&& operator, short-circuit" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-2D Texture lookup with explicit lod (Vertex shader)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Addition" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Comment test (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Comment test (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Comment test (3)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Comment test (4)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Comment test (5)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Directly set fragment color" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Directly set vertex color" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Divide by zero" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Empty blocks ({}), nil (;) statements" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Float Literals" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GL state variable reference (diffuse product)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GL state variable reference (gl_FrontMaterial.ambient)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GL state variable reference (gl_LightSource[0].diffuse)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GL state variable reference (point attenuation)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GL state variable reference (point size)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 1" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 2" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 3" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 4" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 5" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 6" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 7" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array constructor 8" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array error check" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 array.length()" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 arrays" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 const array constructor 1" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 const array constructor 2" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 invariant, centroid qualifiers" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.20 uniform array constructor" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-GLSL 1.30 precision qualifiers" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Global vars and initializers" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Global vars and initializers (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Integer Literals" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Negation" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Negation2" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Pass-through vertex color" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test (11)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test (extension test 1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test (extension test 2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test (extension test 3)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 1 (#if 0)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 10 (#if defined())" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 11 (#elif)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 12 (#elif)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 13 (nested #if)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 14 (nested #if)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 15 (nested #if, #elif)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 2 (#if 1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 3 (#if ==)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 4 (#if 1, #define macro)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 5 (#if 1, #define macro)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 6 (#if 0, #define macro)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 7 (multi-line #define)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 8 (#ifdef)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Preprocessor test 9 (#ifndef)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Primary plus secondary color" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzle" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzle (rgba)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzle (stpq)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzle in-place" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzled expression" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzled swizzle" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzled swizzled swizzle" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzled writemask" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzled writemask (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzled writemask (rgba)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Swizzled writemask (stpq)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-TIntermediate::addUnaryMath" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-TPPStreamCompiler::assignOperands" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-Writemask" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-^^ operator (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-^^ operator (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-abs() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-acos(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-all() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-any() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-asin(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-assignment operators" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-atan(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-break with no loop" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-built-in constants" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-ceil() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-chained assignment" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-clamp() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-clamp() function, vec4" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-conditional expression" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-conditional expression (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-constant array of vec4 with variable indexing, vertex shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-constant array with constant indexing, fragment shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-constant array with constant indexing, vertex shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-constant array with variable indexing, vertex shader" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-constant array with variable indexing, vertex shader (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-continue with no loop" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-cos(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-cross() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-cross() function, in-place" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-discard statement (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-discard statement (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-discard statement in for loop" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-dot product" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (float, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (float, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (vec2, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (vec2, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (vec3, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (vec3, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (vec4, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-equality (vec4, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-exp(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-exp2(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-floor() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-for-loop" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-fract() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-function call with in, out params" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-function call with inout params" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-function prototype" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-function with early return (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-function with early return (2)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-function with early return (3)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-function with early return (4)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-gl_FragDepth writing" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-gl_FrontFacing var (1)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-gl_Position not written check" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-if (boolean-scalar) check" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-illegal assignment" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (float, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (float, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (vec2, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (vec2, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (vec3, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (vec3, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (vec4, fail)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-inequality (vec4, pass)" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-integer division" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-integer division with uniform var" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-integer, float arithmetic" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-length() function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-length() functions" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-linear fog" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-log(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-log2(vec4) function" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mat2x3 construct" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mat2x4 construct" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mat3x2 construct" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mat3x4 construct" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
run_test "glean/glsl1-mat4x2 * mat2x4" 0.0 "bin/glean -o -v -v -v -t +glsl1 --quick"
popd

if [ $need_pass == 0 ] ; then
  echo "+---------------------------------------------+"
  echo "| Overall pass, as all 211 tests have passed. |"
  echo "+---------------------------------------------+"
else
  echo "+-----------------------------------------------------------+"
  echo "| Overall failure, as $need_pass tests did not pass and $failures failed. |"
  echo "+-----------------------------------------------------------+"
fi
exit $need_pass

