@echo off
title StuManager-管理员密码
:1
::窗体大小
if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
::position
if exist "Symbol\mini.fxl" (set position=-140) else (set position=0)
::DiyStartMenu
if exist "Symbol\DiyStartMenu.data" (set /p DiyStartMenu=<Symbol\DiyStartMenu.data)
::Mode
if "%DiyStartMenu%"=="main" (set mode=Normal) else (set mode=HiEff)

if "%mode%"=="Normal" (
set background=background
set address=Skin\SkinPackage
    if exist "Skin\SkinPackage\dark.fxl" (
        if exist "darkmode.fxl" (set background=background-dark))
	)
)
if "%mode%"=="HiEff" (
set address=Pictures
    if "%DiyStartMenu%"=="add" (set background=clean1)
    if "%DiyStartMenu%"=="edit" (set background=edit1)
    if "%DiyStartMenu%"=="statistic" (set background=safe1)
    if "%DiyStartMenu%"=="settings" (set background=setting1)
    if "%DiyStartMenu%"=="output" (set background=safe1)
    if "%DiyStartMenu%"=="elect" (set background=edit1)
)
::background
Plugins\img %address%\%background%.png:%position%,0,800,594
::echo.Plugins\img %address%\%background%.png:%position%,0,800,594

if not exist "darkmode.fxl" (
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img introduce\first.png?0,0,800,600) else (
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img introduce\first.png?0,0,800,600)

set count=3
set /p value=<$key.key
:begin
if %count%==0 goto a
set "message=请输入管理员密码,您还可以尝试%count%次："
set "title=验证密码"
set "note="
set "vbs=GotUserInputedDataProgram.vbs"
set "data=UserInputedData.tmp"
if exist "%vbs%" del /s /q /f "%vbs%">nul
echo On Error Resume Next>>"%vbs%"
echo Dim fso,wri,data,file>>"%vbs%"
echo Set fso=Wscript.CreateObject^("Scripting.FileSystemObject"^)>>"%vbs%"
echo file="%data%">>"%vbs%"
echo if fso.FileExists^(file^) Then fso.DeleteFile^(file^)>>"%vbs%"
echo Set wri=fso.CreateTextFile^(file,True^)>>"%vbs%"
echo data=InputBox^("%message%","%title%","%note%"^)>>"%vbs%"
echo wri.Write data>>"%vbs%"
echo wri.Close>>"%vbs%"
echo Set fso=Nothing>>"%vbs%"
echo Set op=Nothing>>"%vbs%"
echo fso.DeleteFile^(Wscript.ScriptFullName^)>>"%vbs%"
echo Wscript.Quit>>"%vbs%"
call "%vbs%"
for /f "delims=" %%i in (%data%) do set "speak=%%i"
if exist "%vbs%" del /s /q /f "%data%">nul
if exist "%vbs%" del /s /q /f "%vbs%">nul
if "%speak%"=="%value%" (goto :eof) else (call warning\wrong_key.vbs&set /a count=%count%-1&goto begin)
:a
exit
