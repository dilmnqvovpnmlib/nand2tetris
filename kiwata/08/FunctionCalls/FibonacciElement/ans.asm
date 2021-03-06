// SP を RAM[256] に対応付ける
// Sys.init 関数を呼び出す (call Sys.init)

// SP を RAM[256] に対応付ける
@256
D=A
@SP
M=D

// Sys.init 関数を呼び出す
// call Sys.init
@_CALL_Sys.init1
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP - n - 5
@SP
D=M
@5
D=D-A
@0
D=D-A
@ARG
M=D
// LCL = SP
@SP
D=M
@LCL
M=D
// goto Sys.init
@Sys.init // わからん
0;JMP
(_CALL_Sys.init1) // わからん

// Main 関数に制御が移ってる

// function Main.fibonacci 0
(Main.fibonacci)

// push argument 0
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1

// push constant 2
@2 // 2をpushする
D=A
@SP
A=M // アドレスを256に設定する
M=D // RAM[256]にconstant 2が入る
@SP
M=M+1 // SPレジスタ(RAM[256])に1を追加してDレジスタに退避

// lt
@SP // popするのでアドレスを1減らす
M=M-1
D=M
A=D // アドレスをRAM[SP]に変更する
D=M // DレジスタにRAM[SP]の中身を退避させる
A=A-1 // RAM[SP-1]の中身をみるためにアドレスを減算させる
D=M-D // RAM[SP] - RAM[SP-1]
@GTHAN_EQ0 // RAM[SP] - RAM[SP-1]
D;JLT // RAM[SP] - RAM[SP-1]
@SP
D=M
A=D-1
M=0
@GTHAN_EQ_END0
0;JMP
(GTHAN_EQ0)
  @SP
  D=M
  A=D-1
  M=-1
(GTHAN_EQ_END0)

// if-goto IF_TRUE
@SP // global スタックポインタをセットする
M=M-1
A=M
D=M
@Main$IF_TRUE
D;JNE

// goto IF_FALSE
@Main$IF_FALSE
0;JMP

// label IF_TRUE
(Main$IF_TRUE)

// push argument 0
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1

// return
@LCL
D=M
@R13
M=D
// RET = *(FRAME - 5)
@5
D=A
@R13
A=M-D
D=M
@R14
M=D
// *ARG = pop()
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
// SP = ARG+1
@ARG
D=M+1
@SP
M=D
// THAT = *(FRAME - 1)
@R13
AM=M-1
D=M
@THAT
M=D
// THIS = *(FRAME - 2)
@R13
AM=M-1
D=M
@THIS
M=D
// ARG = *(FRAME - 3)
@R13
AM=M-1
D=M
@ARG
M=D
// LCL = *(FRAME - 4)
@R13
AM=M-1
D=M
@LCL
M=D
// goto RET
@R14
A=M
0;JMP

// label IF_FALSE
(Main$IF_FALSE)

// push argument 0
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1

// push constant 2
@2
D=A
@SP
A=M // アドレスを256に設定する
M=D // RAM[256]にconstant 2が入る
@SP
M=M+1 // SPレジスタ(RAM[256])に1を追加してDレジスタに退避

// subコマンド
@SP // popするのでアドレスを1減らす
M=M-1
D=M
A=D // アドレスをRAM[SP]に変更する
D=M // DレジスタにRAM[SP]の中身を退避させる
A=A-1 // RAM[SP-1]の中身をみるためにアドレスを減算させる
M=M-D // RAM[SP] - RAM[SP-1]

// call Main.fibonacci 1
// push return-address コマンド
@_CALL_Main.fibonacci2
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL コマンド
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG コマンド
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS コマンド
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT コマンド
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP - n - 5
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
// LCL = SP
@SP
D=M
@LCL
M=D
// goto Main.fibonacci
@Main.fibonacci
0;JMP
(_CALL_Main.fibonacci2)

// push argument 0
@ARG
A=M
D=M
@SP
A=M
M=D
@SP
M=M+1

// push constant 1
@1 // 1をpushする
D=A
@SP
A=M // アドレスを256に設定する
M=D // RAM[256]にconstant 1が入る
@SP
M=M+1 // SPレジスタ(RAM[256])に1を追加してDレジスタに退避

// sub
@SP // popするのでアドレスを1減らす
M=M-1
D=M
A=D // アドレスをRAM[SP]に変更する
D=M // DレジスタにRAM[SP]の中身を退避させる
A=A-1 // RAM[SP-1]の中身をみるためにアドレスを減算させる
M=M-D // RAM[SP] - RAM[SP-1]

// call Main.fibonacci 1
// push return-address コマンド
@_CALL_Main.fibonacci3
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL コマンド
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG コマンド
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS コマンド
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT コマンド
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP - n - 5
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
// LCL = SP
@SP
D=M
@LCL
M=D
// goto Main.fibonacci
@Main.fibonacci
0;JMP
(_CALL_Main.fibonacci3)

// addコマンド
@SP // popするのでアドレスを1減らす
M=M-1
D=M
A=D // アドレスをRAM[SP]に変更する
D=M // DレジスタにRAM[SP]の中身を退避させる
A=A-1 // RAM[SP-1]の中身をみるためにアドレスを減算させる
M=M+D // RAM[SP] + RAM[SP-1]

// writeReturn コマンド
// FRAME = LCL FRAME = R13
@LCL
D=M
@R13
M=D
// RET = *(FRAME - 5)
@5
D=A
@R13
A=M-D
D=M
@R14
M=D
// *ARG = pop()
@SP
M=M-1
A=M
D=M
@ARG
A=M
M=D
// SP = ARG+1
@ARG
D=M+1
@SP
M=D
// THAT = *(FRAME - 1)
@R13
AM=M-1
D=M
@THAT
M=D
// THIS = *(FRAME - 2)
@R13
AM=M-1
D=M
@THIS
M=D
// ARG = *(FRAME - 3)
@R13
AM=M-1
D=M
@ARG
M=D
// LCL = *(FRAME - 4)
@R13
AM=M-1
D=M
@LCL
M=D
// goto RET
@R14
A=M
0;JMP

// 制御が Sys.vm に移る
// function Sys.init 0
(Sys.init)

// push constant 4 コマンド
@4 // 4をpushする
D=A
@SP
A=M // アドレスを256に設定する
M=D // RAM[256]にconstant 4が入る
@SP
M=M+1 // SPレジスタ(RAM[256])に1を追加してDレジスタに退避

// call Main.fibonacci 1
// push return-address コマンド
@_CALL_Main.fibonacci4
D=A
@SP
A=M
M=D
@SP
M=M+1
// push LCL コマンド
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
// push ARG コマンド
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THIS コマンド
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
// push THAT コマンド
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
// ARG = SP - n - 5
@SP
D=M
@5
D=D-A
@1
D=D-A
@ARG
M=D
// LCL = SP
@SP
D=M
@LCL
M=D
// goto Main.fibonacci
@Main.fibonacci
0;JMP
(_CALL_Main.fibonacci4)

// label WHILE
(Sys$WHILE)

// goto WHILE
@Sys$WHILE
0;JMP
