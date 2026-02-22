PATH=%PATH%;c:\avkit
cd src
avmac85.exe %1.a85 df(var,5) df(mode,01) mf(f1.mxp) sm si vb xr pg pr(f1.prn)
avlink.exe %1.hex=%1.obj -sy -sm -sp
avsim85.exe -c1 dfL%1.zgr
:: pause
:: exit
