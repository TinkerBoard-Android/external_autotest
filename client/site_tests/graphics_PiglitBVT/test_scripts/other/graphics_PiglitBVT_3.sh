#!/bin/bash


need_pass=314
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
run_test "shaders/glsl-fs-implicit-array-size-03" 0.0 "bin/shader_runner tests/shaders/glsl-fs-implicit-array-size-03.shader_test -auto"
run_test "shaders/glsl-fs-log" 0.0 "bin/shader_runner tests/shaders/glsl-fs-log.shader_test -auto"
run_test "shaders/glsl-fs-log2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-log2.shader_test -auto"
run_test "shaders/glsl-fs-loop" 0.0 "bin/glsl-fs-loop -auto"
run_test "shaders/glsl-fs-loop-300" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-300.shader_test -auto"
run_test "shaders/glsl-fs-loop-break" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-break.shader_test -auto"
run_test "shaders/glsl-fs-loop-const-decr" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-const-decr.shader_test -auto"
run_test "shaders/glsl-fs-loop-const-incr" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-const-incr.shader_test -auto"
run_test "shaders/glsl-fs-loop-continue" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-continue.shader_test -auto"
run_test "shaders/glsl-fs-loop-diagonal-break" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-diagonal-break.shader_test -auto"
run_test "shaders/glsl-fs-loop-ge" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-ge.shader_test -auto"
run_test "shaders/glsl-fs-loop-gt" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-gt.shader_test -auto"
run_test "shaders/glsl-fs-loop-le" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-le.shader_test -auto"
run_test "shaders/glsl-fs-loop-lt" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-lt.shader_test -auto"
run_test "shaders/glsl-fs-loop-nested" 0.0 "bin/glsl-fs-loop-nested -auto"
run_test "shaders/glsl-fs-loop-nested-if" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-nested-if.shader_test -auto"
run_test "shaders/glsl-fs-loop-redundant-condition" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-redundant-condition.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-01.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-02" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-02.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-03" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-03.shader_test -auto"
run_test "shaders/glsl-fs-loop-two-counter-04" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-two-counter-04.shader_test -auto"
run_test "shaders/glsl-fs-loop-zero-iter" 0.0 "bin/shader_runner tests/shaders/glsl-fs-loop-zero-iter.shader_test -auto"
run_test "shaders/glsl-fs-lots-of-tex" 0.0 "bin/shader_runner tests/shaders/glsl-fs-lots-of-tex.shader_test -auto"
run_test "shaders/glsl-fs-main-return" 0.0 "bin/shader_runner tests/shaders/glsl-fs-main-return.shader_test -auto"
run_test "shaders/glsl-fs-max" 0.0 "bin/shader_runner tests/shaders/glsl-fs-max.shader_test -auto"
run_test "shaders/glsl-fs-max-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-max-2.shader_test -auto"
run_test "shaders/glsl-fs-max-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-max-3.shader_test -auto"
run_test "shaders/glsl-fs-min" 0.0 "bin/shader_runner tests/shaders/glsl-fs-min.shader_test -auto"
run_test "shaders/glsl-fs-min-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-min-2.shader_test -auto"
run_test "shaders/glsl-fs-min-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-min-3.shader_test -auto"
run_test "shaders/glsl-fs-mix" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mix.shader_test -auto"
run_test "shaders/glsl-fs-mix-constant" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mix-constant.shader_test -auto"
run_test "shaders/glsl-fs-mod" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mod.shader_test -auto"
run_test "shaders/glsl-fs-mov-masked" 0.0 "bin/shader_runner tests/shaders/glsl-fs-mov-masked.shader_test -auto"
run_test "shaders/glsl-fs-neg" 0.0 "bin/shader_runner tests/shaders/glsl-fs-neg.shader_test -auto"
run_test "shaders/glsl-fs-neg-abs" 0.0 "bin/shader_runner tests/shaders/glsl-fs-neg-abs.shader_test -auto"
run_test "shaders/glsl-fs-neg-dot" 0.0 "bin/shader_runner tests/shaders/glsl-fs-neg-dot.shader_test -auto"
run_test "shaders/glsl-fs-normalmatrix" 0.0 "bin/shader_runner tests/shaders/glsl-fs-normalmatrix.shader_test -auto"
run_test "shaders/glsl-fs-pointcoord" 0.0 "bin/glsl-fs-pointcoord -auto"
run_test "shaders/glsl-fs-post-increment-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-post-increment-01.shader_test -auto"
run_test "shaders/glsl-fs-raytrace-bug27060" 0.0 "bin/glsl-fs-raytrace-bug27060 -auto"
run_test "shaders/glsl-fs-reflect" 0.0 "bin/shader_runner tests/shaders/glsl-fs-reflect.shader_test -auto"
run_test "shaders/glsl-fs-roundEven" 0.0 "bin/shader_runner tests/shaders/glsl-fs-roundEven.shader_test -auto"
run_test "shaders/glsl-fs-sampler-numbering" 0.0 "bin/glsl-fs-sampler-numbering -auto"
run_test "shaders/glsl-fs-sampler-numbering-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-sampler-numbering-2.shader_test -auto"
run_test "shaders/glsl-fs-sampler-numbering-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-sampler-numbering-3.shader_test -auto"
run_test "shaders/glsl-fs-sign" 0.0 "bin/shader_runner tests/shaders/glsl-fs-sign.shader_test -auto"
run_test "shaders/glsl-fs-sqrt-branch" 0.0 "bin/glsl-fs-sqrt-branch -auto"
run_test "shaders/glsl-fs-statevar-call" 0.0 "bin/shader_runner tests/shaders/glsl-fs-statevar-call.shader_test -auto"
run_test "shaders/glsl-fs-step" 0.0 "bin/shader_runner tests/shaders/glsl-fs-step.shader_test -auto"
run_test "shaders/glsl-fs-struct-equal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-struct-equal.shader_test -auto"
run_test "shaders/glsl-fs-struct-notequal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-struct-notequal.shader_test -auto"
run_test "shaders/glsl-fs-swizzle-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-swizzle-1.shader_test -auto"
run_test "shaders/glsl-fs-tan-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-tan-1.shader_test -auto"
run_test "shaders/glsl-fs-tan-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-tan-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2d" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-bias" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-bias.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-branching" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-branching.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-1.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-3.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-4.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-dependent-5" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-dependent-5.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked-3.shader_test -auto"
run_test "shaders/glsl-fs-texture2d-masked-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2d-masked-4.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj-bias" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj-bias.shader_test -auto"
run_test "shaders/glsl-fs-texture2dproj-bias-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texture2dproj-bias-2.shader_test -auto"
run_test "shaders/glsl-fs-texture2drect" 0.0 "bin/glsl-fs-texture2drect -auto"
run_test "shaders/glsl-fs-texture2drect-proj3" 0.0 "bin/glsl-fs-texture2drect -auto -proj3"
run_test "shaders/glsl-fs-texture2drect-proj4" 0.0 "bin/glsl-fs-texture2drect -auto -proj4"
run_test "shaders/glsl-fs-texturecube" 0.0 "bin/glsl-fs-texturecube -auto"
run_test "shaders/glsl-fs-texturecube-2" 0.0 "bin/glsl-fs-texturecube-2 -auto"
run_test "shaders/glsl-fs-texturecube-2-bias" 0.0 "bin/glsl-fs-texturecube-2 -auto -bias"
run_test "shaders/glsl-fs-texturecube-bias" 0.0 "bin/glsl-fs-texturecube -auto -bias"
run_test "shaders/glsl-fs-textureenvcolor-statechange" 0.0 "bin/glsl-fs-textureenvcolor-statechange -auto"
run_test "shaders/glsl-fs-texturelod-01" 0.0 "bin/shader_runner tests/shaders/glsl-fs-texturelod-01.shader_test -auto"
run_test "shaders/glsl-fs-trunc" 0.0 "bin/shader_runner tests/shaders/glsl-fs-trunc.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-1.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-2.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-3.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-4.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-5" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-5.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-6" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-6.shader_test -auto"
run_test "shaders/glsl-fs-uniform-array-7" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-array-7.shader_test -auto"
run_test "shaders/glsl-fs-uniform-bool-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-bool-1.shader_test -auto"
run_test "shaders/glsl-fs-uniform-bool-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-bool-2.shader_test -auto"
run_test "shaders/glsl-fs-uniform-sampler-array" 0.0 "bin/shader_runner tests/shaders/glsl-fs-uniform-sampler-array.shader_test -auto"
run_test "shaders/glsl-fs-unroll-out-param" 0.0 "bin/shader_runner tests/shaders/glsl-fs-unroll-out-param.shader_test -auto"
run_test "shaders/glsl-fs-unroll-side-effect" 0.0 "bin/shader_runner tests/shaders/glsl-fs-unroll-side-effect.shader_test -auto"
run_test "shaders/glsl-fs-varying-array" 0.0 "bin/shader_runner tests/shaders/glsl-fs-varying-array.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-1" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-1.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-2" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-2.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-3" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-3.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-4" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-4.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-5" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-5.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-6" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-6.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-7" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-7.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-dst" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-dst.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-dst-in-loop" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-dst-in-loop.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-dst-in-nested-loop-combined" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-dst-in-nested-loop-combined.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-src" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-src.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-src-in-loop" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-src-in-loop.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-src-in-nested-loop-combined" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-src-in-nested-loop-combined.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-src-in-nested-loop-inner" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-src-in-nested-loop-inner.shader_test -auto"
run_test "shaders/glsl-fs-vec4-indexing-temp-src-in-nested-loop-outer" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-indexing-temp-src-in-nested-loop-outer.shader_test -auto"
run_test "shaders/glsl-fs-vec4-operator-equal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-operator-equal.shader_test -auto"
run_test "shaders/glsl-fs-vec4-operator-notequal" 0.0 "bin/shader_runner tests/shaders/glsl-fs-vec4-operator-notequal.shader_test -auto"
run_test "shaders/glsl-function-chain16" 0.0 "bin/shader_runner tests/shaders/glsl-function-chain16.shader_test -auto"
run_test "shaders/glsl-function-prototype" 0.0 "bin/shader_runner tests/shaders/glsl-function-prototype.shader_test -auto"
run_test "shaders/glsl-fwidth" 0.0 "bin/glsl-fwidth -auto"
run_test "shaders/glsl-getactiveuniform-array-size" 0.0 "bin/glsl-getactiveuniform-array-size -auto"
run_test "shaders/glsl-getactiveuniform-count: glsl-getactiveuniform-length" 0.0 "bin/glsl-getactiveuniform-count -auto shaders/glsl-getactiveuniform-length.vert 1"
run_test "shaders/glsl-getactiveuniform-length" 0.0 "bin/glsl-getactiveuniform-length -auto"
run_test "shaders/glsl-getattriblocation" 0.0 "bin/glsl-getattriblocation -auto"
run_test "shaders/glsl-gnome-shell-dim-window" 0.0 "bin/shader_runner tests/shaders/glsl-gnome-shell-dim-window.shader_test -auto"
run_test "shaders/glsl-if-assign-call" 0.0 "bin/shader_runner tests/shaders/glsl-if-assign-call.shader_test -auto"
run_test "shaders/glsl-implicit-conversion-01" 0.0 "bin/shader_runner tests/shaders/glsl-implicit-conversion-01.shader_test -auto"
run_test "shaders/glsl-implicit-conversion-02" 0.0 "bin/shader_runner tests/shaders/glsl-implicit-conversion-02.shader_test -auto"
run_test "shaders/glsl-inexact-overloads" 0.0 "bin/shader_runner tests/shaders/glsl-inexact-overloads.shader_test -auto"
run_test "shaders/glsl-inout-struct-01" 0.0 "bin/shader_runner tests/shaders/glsl-inout-struct-01.shader_test -auto"
run_test "shaders/glsl-inout-struct-02" 0.0 "bin/shader_runner tests/shaders/glsl-inout-struct-02.shader_test -auto"
run_test "shaders/glsl-invalid-asm-01" 0.0 "bin/glsl-invalid-asm-01 -auto"
run_test "shaders/glsl-invalid-asm-02" 0.0 "bin/glsl-invalid-asm-02 -auto"
run_test "shaders/glsl-invariant-pragma" 0.0 "bin/shader_runner tests/shaders/glsl-invariant-pragma.shader_test -auto"
run_test "shaders/glsl-kwin-blur-1" 0.0 "bin/glsl-kwin-blur-1 -auto"
run_test "shaders/glsl-kwin-blur-2" 0.0 "bin/glsl-kwin-blur-2 -auto"
run_test "shaders/glsl-light-model" 0.0 "bin/glsl-light-model -auto"
run_test "shaders/glsl-link-array-01" 0.0 "bin/shader_runner tests/shaders/glsl-link-array-01.shader_test -auto"
run_test "shaders/glsl-link-bug30552" 0.0 "bin/glsl-link-bug30552 -auto"
run_test "shaders/glsl-link-bug38015" 0.0 "bin/glsl-link-bug38015 -auto"
run_test "shaders/glsl-link-empty-prog-01" 0.0 "bin/glsl-link-empty-prog-01 -auto"
run_test "shaders/glsl-link-empty-prog-02" 0.0 "bin/glsl-link-empty-prog-02 -auto"
run_test "shaders/glsl-link-varying-TexCoord" 0.0 "bin/shader_runner tests/shaders/glsl-link-varying-TexCoord.shader_test -auto"
run_test "shaders/glsl-link-varyings-1" 0.0 "bin/shader_runner tests/shaders/glsl-link-varyings-1.shader_test -auto"
run_test "shaders/glsl-link-varyings-2" 0.0 "bin/shader_runner tests/shaders/glsl-link-varyings-2.shader_test -auto"
run_test "shaders/glsl-link-varyings-3" 0.0 "bin/shader_runner tests/shaders/glsl-link-varyings-3.shader_test -auto"
run_test "shaders/glsl-lod-bias" 0.0 "bin/glsl-lod-bias -auto"
run_test "shaders/glsl-mat-110" 0.0 "bin/shader_runner tests/shaders/glsl-mat-110.shader_test -auto"
run_test "shaders/glsl-mat-attribute" 0.0 "bin/glsl-mat-attribute -auto"
run_test "shaders/glsl-mat-from-int-ctor-01" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-int-ctor-01.shader_test -auto"
run_test "shaders/glsl-mat-from-int-ctor-02" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-int-ctor-02.shader_test -auto"
run_test "shaders/glsl-mat-from-int-ctor-03" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-int-ctor-03.shader_test -auto"
run_test "shaders/glsl-mat-from-vec-ctor-01" 0.0 "bin/shader_runner tests/shaders/glsl-mat-from-vec-ctor-01.shader_test -auto"
run_test "shaders/glsl-mat-mul-1" 0.0 "bin/shader_runner tests/shaders/glsl-mat-mul-1.shader_test -auto"
run_test "shaders/glsl-max-varyings" 0.0 "bin/glsl-max-varyings -auto -fbo"
run_test "shaders/glsl-max-vertex-attrib" 0.0 "bin/glsl-max-vertex-attrib -auto"
run_test "shaders/glsl-novertexdata" 0.0 "bin/glsl-novertexdata -auto"
run_test "shaders/glsl-octal" 0.0 "bin/shader_runner tests/shaders/glsl-octal.shader_test -auto"
run_test "shaders/glsl-orangebook-ch06-bump" 0.0 "bin/glsl-orangebook-ch06-bump -auto"
run_test "shaders/glsl-override-builtin" 0.0 "bin/shader_runner tests/shaders/glsl-override-builtin.shader_test -auto"
run_test "shaders/glsl-override-builtin-2" 0.0 "bin/shader_runner tests/shaders/glsl-override-builtin-2.shader_test -auto"
run_test "shaders/glsl-pp-elif-no-expression-1" 0.0 "bin/shader_runner tests/shaders/glsl-pp-elif-no-expression-1.shader_test -auto"
run_test "shaders/glsl-precision-110" 0.0 "bin/shader_runner tests/shaders/glsl-precision-110.shader_test -auto"
run_test "shaders/glsl-preprocessor-comments" 0.0 "bin/glsl-preprocessor-comments -auto"
run_test "shaders/glsl-reload-source" 0.0 "bin/glsl-reload-source -auto"
run_test "shaders/glsl-routing" 0.0 "bin/glsl-routing -auto"
run_test "shaders/glsl-sin" 0.0 "bin/glsl-sin -auto"
run_test "shaders/glsl-struct-constructor-01" 0.0 "bin/shader_runner tests/shaders/glsl-struct-constructor-01.shader_test -auto"
run_test "shaders/glsl-texcoord-array-2" 0.0 "bin/shader_runner tests/shaders/glsl-texcoord-array-2.shader_test -auto"
run_test "shaders/glsl-uniform-initializer-1" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-initializer-1.shader_test -auto"
run_test "shaders/glsl-uniform-initializer-2" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-initializer-2.shader_test -auto"
run_test "shaders/glsl-uniform-initializer-3" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-initializer-3.shader_test -auto"
run_test "shaders/glsl-uniform-initializer-4" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-initializer-4.shader_test -auto"
run_test "shaders/glsl-uniform-initializer-5" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-initializer-5.shader_test -auto"
run_test "shaders/glsl-uniform-initializer-6" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-initializer-6.shader_test -auto"
run_test "shaders/glsl-uniform-initializer-7" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-initializer-7.shader_test -auto"
run_test "shaders/glsl-uniform-linking-1" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-linking-1.shader_test -auto"
run_test "shaders/glsl-uniform-non-uniform-array-compare" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-non-uniform-array-compare.shader_test -auto"
run_test "shaders/glsl-uniform-out-of-bounds" 0.0 "bin/glsl-uniform-out-of-bounds -auto"
run_test "shaders/glsl-uniform-struct" 0.0 "bin/shader_runner tests/shaders/glsl-uniform-struct.shader_test -auto"
run_test "shaders/glsl-uniform-update" 0.0 "bin/glsl-uniform-update -auto"
run_test "shaders/glsl-unused-varying" 0.0 "bin/glsl-unused-varying -auto"
run_test "shaders/glsl-useprogram-displaylist" 0.0 "bin/glsl-useprogram-displaylist -auto"
run_test "shaders/glsl-varying-mat3x2" 0.0 "bin/shader_runner tests/shaders/glsl-varying-mat3x2.shader_test -auto"
run_test "shaders/glsl-varying-read" 0.0 "bin/shader_runner tests/shaders/glsl-varying-read.shader_test -auto"
run_test "shaders/glsl-vec-array" 0.0 "bin/shader_runner tests/shaders/glsl-vec-array.shader_test -auto"
run_test "shaders/glsl-version-define" 0.0 "bin/shader_runner tests/shaders/glsl-version-define.shader_test -auto"
run_test "shaders/glsl-version-define-110" 0.0 "bin/shader_runner tests/shaders/glsl-version-define-110.shader_test -auto"
run_test "shaders/glsl-version-define-120" 0.0 "bin/shader_runner tests/shaders/glsl-version-define-120.shader_test -auto"
run_test "shaders/glsl-vs-abs-attribute" 0.0 "bin/shader_runner tests/shaders/glsl-vs-abs-attribute.shader_test -auto"
run_test "shaders/glsl-vs-abs-neg" 0.0 "bin/shader_runner tests/shaders/glsl-vs-abs-neg.shader_test -auto"
run_test "shaders/glsl-vs-abs-neg-with-intermediate" 0.0 "bin/shader_runner tests/shaders/glsl-vs-abs-neg-with-intermediate.shader_test -auto"
run_test "shaders/glsl-vs-all-01" 0.0 "bin/shader_runner tests/shaders/glsl-vs-all-01.shader_test -auto"
run_test "shaders/glsl-vs-all-02" 0.0 "bin/shader_runner tests/shaders/glsl-vs-all-02.shader_test -auto"
run_test "shaders/glsl-vs-array-redeclaration" 0.0 "bin/shader_runner tests/shaders/glsl-vs-array-redeclaration.shader_test -auto"
run_test "shaders/glsl-vs-arrays" 0.0 "bin/glsl-vs-arrays -auto"
run_test "shaders/glsl-vs-arrays-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-arrays-2.shader_test -auto"
run_test "shaders/glsl-vs-arrays-3" 0.0 "bin/shader_runner tests/shaders/glsl-vs-arrays-3.shader_test -auto"
run_test "shaders/glsl-vs-clamp-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-clamp-1.shader_test -auto"
run_test "shaders/glsl-vs-constructor-call" 0.0 "bin/shader_runner tests/shaders/glsl-vs-constructor-call.shader_test -auto"
run_test "shaders/glsl-vs-copy-propagation-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-copy-propagation-1.shader_test -auto"
run_test "shaders/glsl-vs-cross" 0.0 "bin/shader_runner tests/shaders/glsl-vs-cross.shader_test -auto"
run_test "shaders/glsl-vs-cross-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-cross-2.shader_test -auto"
run_test "shaders/glsl-vs-cross-3" 0.0 "bin/shader_runner tests/shaders/glsl-vs-cross-3.shader_test -auto"
run_test "shaders/glsl-vs-deadcode-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-deadcode-1.shader_test -auto"
run_test "shaders/glsl-vs-deadcode-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-deadcode-2.shader_test -auto"
run_test "shaders/glsl-vs-dot-vec2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-dot-vec2.shader_test -auto"
run_test "shaders/glsl-vs-double-negative-copy-propagation" 0.0 "bin/shader_runner tests/shaders/glsl-vs-double-negative-copy-propagation.shader_test -auto"
run_test "shaders/glsl-vs-f2b" 0.0 "bin/shader_runner tests/shaders/glsl-vs-f2b.shader_test -auto"
run_test "shaders/glsl-vs-ff-frag" 0.0 "bin/shader_runner tests/shaders/glsl-vs-ff-frag.shader_test -auto"
run_test "shaders/glsl-vs-functions" 0.0 "bin/glsl-vs-functions -auto"
run_test "shaders/glsl-vs-functions-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-functions-2.shader_test -auto"
run_test "shaders/glsl-vs-functions-3" 0.0 "bin/shader_runner tests/shaders/glsl-vs-functions-3.shader_test -auto"
run_test "shaders/glsl-vs-if-bool" 0.0 "bin/glsl-vs-if-bool -auto"
run_test "shaders/glsl-vs-if-greater" 0.0 "bin/shader_runner tests/shaders/glsl-vs-if-greater.shader_test -auto"
run_test "shaders/glsl-vs-if-greater-equal" 0.0 "bin/shader_runner tests/shaders/glsl-vs-if-greater-equal.shader_test -auto"
run_test "shaders/glsl-vs-if-less" 0.0 "bin/shader_runner tests/shaders/glsl-vs-if-less.shader_test -auto"
run_test "shaders/glsl-vs-if-less-equal" 0.0 "bin/shader_runner tests/shaders/glsl-vs-if-less-equal.shader_test -auto"
run_test "shaders/glsl-vs-if-nested" 0.0 "bin/shader_runner tests/shaders/glsl-vs-if-nested.shader_test -auto"
run_test "shaders/glsl-vs-if-nested-loop" 0.0 "bin/shader_runner tests/shaders/glsl-vs-if-nested-loop.shader_test -auto"
run_test "shaders/glsl-vs-large-uniform-array" 0.0 "bin/shader_runner tests/shaders/glsl-vs-large-uniform-array.shader_test -auto"
run_test "shaders/glsl-vs-loop" 0.0 "bin/glsl-vs-loop -auto"
run_test "shaders/glsl-vs-loop-300" 0.0 "bin/shader_runner tests/shaders/glsl-vs-loop-300.shader_test -auto"
run_test "shaders/glsl-vs-loop-break" 0.0 "bin/shader_runner tests/shaders/glsl-vs-loop-break.shader_test -auto"
run_test "shaders/glsl-vs-loop-continue" 0.0 "bin/shader_runner tests/shaders/glsl-vs-loop-continue.shader_test -auto"
run_test "shaders/glsl-vs-loop-nested" 0.0 "bin/glsl-vs-loop-nested -auto"
run_test "shaders/glsl-vs-loop-redundant-condition" 0.0 "bin/shader_runner tests/shaders/glsl-vs-loop-redundant-condition.shader_test -auto"
run_test "shaders/glsl-vs-main-return" 0.0 "bin/shader_runner tests/shaders/glsl-vs-main-return.shader_test -auto"
run_test "shaders/glsl-vs-masked-cos" 0.0 "bin/shader_runner tests/shaders/glsl-vs-masked-cos.shader_test -auto"
run_test "shaders/glsl-vs-masked-dot" 0.0 "bin/shader_runner tests/shaders/glsl-vs-masked-dot.shader_test -auto"
run_test "shaders/glsl-vs-mat-add-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-mat-add-1.shader_test -auto"
run_test "shaders/glsl-vs-mat-div-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-mat-div-1.shader_test -auto"
run_test "shaders/glsl-vs-mat-div-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-mat-div-2.shader_test -auto"
run_test "shaders/glsl-vs-mat-mul-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-mat-mul-1.shader_test -auto"
run_test "shaders/glsl-vs-mat-mul-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-mat-mul-2.shader_test -auto"
run_test "shaders/glsl-vs-mat-mul-3" 0.0 "bin/shader_runner tests/shaders/glsl-vs-mat-mul-3.shader_test -auto"
run_test "shaders/glsl-vs-mat-sub-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-mat-sub-1.shader_test -auto"
run_test "shaders/glsl-vs-mov-after-deref" 0.0 "bin/glsl-vs-mov-after-deref -auto"
run_test "shaders/glsl-vs-mvp-statechange" 0.0 "bin/glsl-vs-mvp-statechange -auto"
run_test "shaders/glsl-vs-neg-abs" 0.0 "bin/shader_runner tests/shaders/glsl-vs-neg-abs.shader_test -auto"
run_test "shaders/glsl-vs-neg-attribute" 0.0 "bin/shader_runner tests/shaders/glsl-vs-neg-attribute.shader_test -auto"
run_test "shaders/glsl-vs-normalscale" 0.0 "bin/glsl-vs-normalscale -auto"
run_test "shaders/glsl-vs-point-size" 0.0 "bin/glsl-vs-point-size -auto"
run_test "shaders/glsl-vs-position-outval" 0.0 "bin/shader_runner tests/shaders/glsl-vs-position-outval.shader_test -auto"
run_test "shaders/glsl-vs-post-increment-01" 0.0 "bin/shader_runner tests/shaders/glsl-vs-post-increment-01.shader_test -auto"
run_test "shaders/glsl-vs-raytrace-bug26691" 0.0 "bin/glsl-vs-raytrace-bug26691 -auto"
run_test "shaders/glsl-vs-sign" 0.0 "bin/shader_runner tests/shaders/glsl-vs-sign.shader_test -auto"
run_test "shaders/glsl-vs-statechange-1" 0.0 "bin/glsl-vs-statechange-1 -auto"
run_test "shaders/glsl-vs-swizzle-swizzle-lhs" 0.0 "bin/shader_runner tests/shaders/glsl-vs-swizzle-swizzle-lhs.shader_test -auto"
run_test "shaders/glsl-vs-swizzle-swizzle-rhs" 0.0 "bin/shader_runner tests/shaders/glsl-vs-swizzle-swizzle-rhs.shader_test -auto"
run_test "shaders/glsl-vs-texturematrix-1" 0.0 "bin/glsl-vs-texturematrix-1 -auto"
run_test "shaders/glsl-vs-texturematrix-2" 0.0 "bin/glsl-vs-texturematrix-2 -auto"
run_test "shaders/glsl-vs-uniform-array-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-uniform-array-1.shader_test -auto"
run_test "shaders/glsl-vs-uniform-array-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-uniform-array-2.shader_test -auto"
run_test "shaders/glsl-vs-uniform-array-3" 0.0 "bin/shader_runner tests/shaders/glsl-vs-uniform-array-3.shader_test -auto"
run_test "shaders/glsl-vs-uniform-array-4" 0.0 "bin/shader_runner tests/shaders/glsl-vs-uniform-array-4.shader_test -auto"
run_test "shaders/glsl-vs-user-varying-ff" 0.0 "bin/glsl-vs-user-varying-ff -auto"
run_test "shaders/glsl-vs-varying-array" 0.0 "bin/shader_runner tests/shaders/glsl-vs-varying-array.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-1" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-1.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-2" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-2.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-3" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-3.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-4" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-4.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-5" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-5.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-6" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-6.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-dst" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-dst.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-dst-in-loop" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-dst-in-loop.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-dst-in-nested-loop-combined" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-dst-in-nested-loop-combined.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-src" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-src.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-src-in-loop" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-src-in-loop.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-src-in-nested-loop-combined" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-src-in-nested-loop-combined.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-src-in-nested-loop-inner" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-src-in-nested-loop-inner.shader_test -auto"
run_test "shaders/glsl-vs-vec4-indexing-temp-src-in-nested-loop-outer" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-indexing-temp-src-in-nested-loop-outer.shader_test -auto"
run_test "shaders/glsl-vs-vec4-operator-equal" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-operator-equal.shader_test -auto"
run_test "shaders/glsl-vs-vec4-operator-notequal" 0.0 "bin/shader_runner tests/shaders/glsl-vs-vec4-operator-notequal.shader_test -auto"
run_test "shaders/link-mismatch-layout-03" 0.0 "bin/link-mismatch-layout-03 -auto"
run_test "shaders/link-struct-usage" 0.0 "bin/shader_runner tests/shaders/link-struct-usage.shader_test -auto"
run_test "shaders/link-uniform-array-size" 0.0 "bin/shader_runner tests/shaders/link-uniform-array-size.shader_test -auto"
run_test "shaders/link-unresolved-function" 0.0 "bin/link-unresolved-function -auto"
run_test "shaders/loopfunc" 0.0 "bin/shader_runner tests/shaders/loopfunc.shader_test -auto"
run_test "shaders/really-big-triangle" 0.0 "bin/shader_runner tests/shaders/really-big-triangle.shader_test -auto"
run_test "shaders/sso-simple" 0.0 "bin/sso-simple -auto"
run_test "shaders/sso-uniforms-01" 0.0 "bin/sso-uniforms-01 -auto"
run_test "shaders/sso-uniforms-02" 0.0 "bin/sso-uniforms-02 -auto"
run_test "shaders/useprogram-flushverts-1" 0.0 "bin/useprogram-flushverts-1 -auto"
run_test "shaders/useprogram-flushverts-2" 0.0 "bin/useprogram-flushverts-2 -auto"
run_test "shaders/useprogram-inside-begin" 0.0 "bin/useprogram-inside-begin -auto"
run_test "shaders/useprogram-refcount-1" 0.0 "bin/useprogram-refcount-1 -auto"
run_test "shaders/useshaderprogram-bad-program" 0.0 "bin/useshaderprogram-bad-program -auto"
run_test "shaders/useshaderprogram-bad-type" 0.0 "bin/useshaderprogram-bad-type -auto"
run_test "shaders/useshaderprogram-flushverts-1" 0.0 "bin/useshaderprogram-flushverts-1 -auto"
run_test "shaders/vbo/vbo-generic-float" 0.0 "bin/shader_runner tests/shaders/vbo/vbo-generic-float.shader_test -auto"
run_test "shaders/vbo/vbo-generic-int" 0.0 "bin/shader_runner tests/shaders/vbo/vbo-generic-int.shader_test -auto"
run_test "shaders/vbo/vbo-generic-uint" 0.0 "bin/shader_runner tests/shaders/vbo/vbo-generic-uint.shader_test -auto"
run_test "shaders/vp-combined-image-units" 0.0 "bin/vp-combined-image-units -auto"
run_test "shaders/vp-ignore-input" 0.0 "bin/vp-ignore-input -auto"
run_test "spec/!OpenGL 1.0/gl-1.0-edgeflag" 0.0 "bin/gl-1.0-edgeflag -auto -fbo"
run_test "spec/!OpenGL 1.1/GL_SELECT - alpha-test enabled" 0.0 "bin/select alpha"
run_test "spec/!OpenGL 1.1/GL_SELECT - depth-test enabled" 0.0 "bin/select depth"
run_test "spec/!OpenGL 1.1/GL_SELECT - no test function" 0.0 "bin/select gl11"
run_test "spec/!OpenGL 1.1/GL_SELECT - scissor-test enabled" 0.0 "bin/select scissor"
run_test "spec/!OpenGL 1.1/GL_SELECT - stencil-test enabled" 0.0 "bin/select stencil"
run_test "spec/!OpenGL 1.1/array-stride" 0.0 "bin/array-stride -auto"
run_test "spec/!OpenGL 1.1/clear-accum" 0.0 "bin/clear-accum -auto"
run_test "spec/!OpenGL 1.1/copypixels-draw-sync" 0.0 "bin/copypixels-draw-sync -auto"
run_test "spec/!OpenGL 1.1/copypixels-sync" 0.0 "bin/copypixels-sync -auto"
run_test "spec/!OpenGL 1.1/copyteximage 1D" 0.0 "bin/copyteximage -auto 1D"
run_test "spec/!OpenGL 1.1/copyteximage-border" 0.0 "bin/copyteximage-border -auto"
run_test "spec/!OpenGL 1.1/copyteximage-clipping" 0.0 "bin/copyteximage-clipping -auto"
run_test "spec/!OpenGL 1.1/copytexsubimage" 0.0 "bin/copytexsubimage -auto"
run_test "spec/!OpenGL 1.1/depthfunc" 0.0 "bin/depthfunc -auto"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-blit" 0.0 "bin/fbo-depthstencil -auto blit default_fb"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-copypixels" 0.0 "bin/fbo-depthstencil -auto copypixels default_fb"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-drawpixels-24_8" 0.0 "bin/fbo-depthstencil -auto drawpixels default_fb 24_8"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-drawpixels-32F_24_8_REV" 0.0 "bin/fbo-depthstencil -auto drawpixels default_fb 32F_24_8_REV"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-drawpixels-FLOAT-and-USHORT" 0.0 "bin/fbo-depthstencil -auto drawpixels default_fb FLOAT-and-USHORT"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-readpixels-24_8" 0.0 "bin/fbo-depthstencil -auto readpixels default_fb 24_8"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-readpixels-32F_24_8_REV" 0.0 "bin/fbo-depthstencil -auto readpixels default_fb 32F_24_8_REV"
run_test "spec/!OpenGL 1.1/depthstencil-default_fb-readpixels-FLOAT-and-USHORT" 0.0 "bin/fbo-depthstencil -auto readpixels default_fb FLOAT-and-USHORT"
run_test "spec/!OpenGL 1.1/dlist-clear" 0.0 "bin/dlist-clear -auto"
run_test "spec/!OpenGL 1.1/dlist-color-material" 0.0 "bin/dlist-color-material -auto"
popd

if [ $need_pass == 0 ] ; then
  echo "+---------------------------------------------+"
  echo "| Overall pass, as all 314 tests have passed. |"
  echo "+---------------------------------------------+"
else
  echo "+-----------------------------------------------------------+"
  echo "| Overall failure, as $need_pass tests did not pass and $failures failed. |"
  echo "+-----------------------------------------------------------+"
fi
exit $need_pass

