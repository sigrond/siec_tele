copy modelV2.mod "D:\Moje dokumenty\ZAH\amplide.mswin64\amplide.mswin64"
copy dataV2.dat "D:\Moje dokumenty\ZAH\amplide.mswin64\amplide.mswin64"
copy run.run "D:\Moje dokumenty\ZAH\amplide.mswin64\amplide.mswin64"
cd "D:\Moje dokumenty\ZAH\amplide.mswin64\amplide.mswin64"
ampl.exe run.run > out
copy out "%~f0\..\"
