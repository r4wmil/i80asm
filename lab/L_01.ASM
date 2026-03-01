$allpublic
;        TITLE   'LAB. RAB. i8085 95/96'

	%INCLUDE "opis.inc"
        %INCLUDE "LAB_IO.INC"
	%INCLUDE "INIT_BU.MAC"

RAM     EQU     0800H
ROM     EQU     0000H
LEN_RAM EQU     0800H

;	buffers
TEXTSIZE        EQU     20H

        DEFSEG  DATA1,CLASS=DATA,START=RAM
        SEG     DATA1
BUF1:   DS      TEXTSIZE-1
        DB      0

BUF2:   DS      TEXTSIZE-1
        DB      0

BUF3:   DS      TEXTSIZE-1
        db      0

;       STACK
STACKSIZE	EQU	32
        DEFSEG  STACK,CLASS=DATA,START=RAM+LEN_RAM-STACKSIZE
        SEG     STACK
STACKR: DS      STACKSIZE
STPOINT EQU     $               ;

;       FLAGS
        SEG     DATA1
PASS1	DS	1
;       MASKS FOR EXAMPLES
MASK11  EQU     00000011B       ;
MASK12	EQU	01010000B	;

;
;       PROGRAMM
;
        EXTERN  DEQH

        SEG     CODE,CLASS=CODE,START=ROM

PROG:   LXI     SP,STPOINT
        mvi     a,0     ;all input
        out     db8355
	dcr	a
        out     da8355  ;all output

	INIT1	STACKR,'.',STACKSIZE
        INIT1   BUF1,'1',TEXTSIZE-1
        INIT1   BUF2,'2',TEXTSIZE-1
        INIT1   BUF3,'3',TEXTSIZE-1
;
;       MAIN
;
;       input to port A 8355
        LXI     H,BUF1
        LXI     D,BUF1+TEXTSIZE-1
LOOPIN:
        IN      PB8355
        MOV     M,A
        INX     H
        CALL    DEQH
        JNZ     LOOPIN
;       decoding
        LXI     H,BUF1
	CALL	KONSUM

	LXI	D,BUF2
	MVI	A,1
	STA	PASS1
LOOP1:
        MOV     A,M
	ORA	A
	JZ	ENDTEXT
	CALL	CODING
	STAX	D
	INX	H
	INX	D
	JMP	LOOP1
ENDTEXT:
        LDAX    D
	LDA	PASS1
	ORA	A
	MVI	A,0
	STA	PASS1
	JZ	HALT
PRODOLJ:
;       once more
	LXI	H,BUF2
	LXI	D,BUF3
	JMP	LOOP1
;
HALT:
        LXI     H,BUF3
        CALL    KONSUM
;       output from the port B
        LXI     H,BUF2
        MVI     B,TEXTSIZE-1
LOOPOUT:
        MOV     A,M
        OUT     PA8355
        INX     H
        DCR     B
        JNZ     LOOPout
;
	HLT

;	SUBROUTINES
CODING:
        cma
	RET
;

KONSUM:
	;
	RET
;
	END	PROG
