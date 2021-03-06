; RUN: llvm-as %s -o %t.o
; RUN: %gold -plugin %llvmshlibdir/LLVMgold.so \
; RUN:    --plugin-opt=save-temps \
; RUN:    -shared %t.o -o %t.so
; RUN: llvm-readobj -r %t.so.o | FileCheck %s

; Test that we produce R_X86_64_GOTPCREL instead of R_X86_64_GOTPCRELX
; CHECK: R_X86_64_GOTPCREL foo

@foo = external global i32
define i32 @bar() {
  %t = load i32, i32* @foo
  ret i32 %t
}
