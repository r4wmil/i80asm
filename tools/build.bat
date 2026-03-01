PATH=%PATH%;c:\avkit
PATH=%PATH%;c:\tools
cd c:\lab
call asm %1
call link %1
call sim %1
:: pause
:: exit
