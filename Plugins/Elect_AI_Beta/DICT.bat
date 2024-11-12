@echo off
color 8f
title Elect AI
setlocal enabledelayedexpansion
mode con: cols=85 lines=35
cls
Plugins\img Plugins\Elect_Assistant\plugin\Translatemode.bmp
ping -n 2 127.1>nul
:main
Plugins\image /d
cls
title Elect AI
set scanr=
set code=
set speak=
if exist plugins\Elect_Assistant\Elect_Conver.data (type plugins\Elect_Assistant\Elect_Conver.data & call :G_getrows plugins\Elect_Assistant\Elect_Conver.data lines ) else goto none
if %lines% LSS 20 goto none
for /l %%i in (1,1,5) do ( echo. )
goto none
:G_getrows 
set %2=0 
for /f %%i in ('findstr /n .* %1') do ( 
set /a %2=%2+2 
) 
goto :eof 
:none
Plugins\image Plugins\Elect_Assistant\120.bmp 0 480
Plugins\image Plugins\Elect_Assistant\100.bmp 0 480
Plugins\image Plugins\Elect_Assistant\80.bmp 0 480
Plugins\image Plugins\Elect_Assistant\60.bmp 0 480
Plugins\image Plugins\Elect_Assistant\40.bmp 0 480
Plugins\image Plugins\Elect_Assistant\20.bmp 0 480
Plugins\image Plugins\Elect_Assistant\background.bmp 0 480
:main1
plugins\Elect_Assistant\curs /crv 0
plugins\Elect_Assistant\cmos 0 -1 1
set /a x=%errorlevel:~0,-3%
set /a y=%errorlevel%-1000*%x%
if %x% geq 38 if %x% leq 46 if %y% geq 32 if %y% leq 35 goto getkey
if %x% geq 4 if %x% leq 10 if %y% geq 32 if %y% leq 34 (
goto :eof)
if %x% geq 76 if %x% leq 82 if %y% geq 33 if %y% leq 34 goto more 
goto main1

:getkey
Plugins\image Plugins\Elect_Assistant\120.bmp 0 480
Plugins\image Plugins\Elect_Assistant\100.bmp 0 480
Plugins\image Plugins\Elect_Assistant\80.bmp 0 480
Plugins\image Plugins\Elect_Assistant\60.bmp 0 480
Plugins\image Plugins\Elect_Assistant\40.bmp 0 480
Plugins\image Plugins\Elect_Assistant\20.bmp 0 480
Plugins\image Plugins\Elect_Assistant\background.bmp 0 480
Plugins\image plugin\white.bmp 0 0
set "message=我说："
set "title=Elect Ai"
set "note="
:begin
set "vbs=%Temp%\GotUserInputedDataProgram.vbs"
set "data=%Temp%\UserInputedData.tmp"
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
if "%speak%"=="" goto main
title Elect - Thinking
Plugins\image /d
Plugins\image Plugins\Elect_Assistant\background.bmp 0 480
Plugins\image Plugins\Elect_Assistant\20.bmp 0 480
Plugins\image Plugins\Elect_Assistant\40.bmp 0 480
Plugins\image Plugins\Elect_Assistant\60.bmp 0 480
Plugins\image Plugins\Elect_Assistant\80.bmp 0 480
Plugins\image Plugins\Elect_Assistant\100.bmp 0 480
Plugins\image Plugins\Elect_Assistant\120.bmp 0 480
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo 我:%time:~0,5%>>plugins\Elect_Assistant\Elect_Conver.data
echo %speak%>plugins\Elect_Assistant\Elect_Thinking.data
::______________________________________________________________________________________________________________
if "%speak%"=="天气" (
start www.weather.com
)
if "%speak%"=="新闻" (
echo.打开“新闻”>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
start www.cctv.com
)
if "%speak%"=="返回" (
call plugins\Elect_Assistant\core.bat
)
if "%speak%"=="设置" (
goto EAsetting
)
goto scan
:respeak
echo %yss%>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo Elect %time:~0,5%>>plugins\Elect_Assistant\Elect_Conver.data
echo %scanr%>>plugins\Elect_Assistant\Elect_Conver.data
goto main
:scan
set line=
set str=
echo %speak%>plugins\Elect_Assistant\Elect_Thinking.data
for /f "tokens=1*" %%a in (plugins\Elect_Assistant\DICT.fxl) do (
set /a line+=1
find /i "%%a" plugins\Elect_Assistant\Elect_Thinking.data>nul
if "!errorlevel!"=="0" goto :scand
)
goto scanf
:scand
set /a line-=1
for /f "tokens=2*" %%a in ('more +%line% plugins\Elect_Assistant\DICT.fxl') do set "scanr=%%a"&goto :scand1
:scand1
set yss=%speak%
goto respeak
:scanf
echo %yss%>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo Elect %time:~0,5%>>plugins\Elect_Assistant\Elect_Conver.data
echo 我累了，不想回答你这个问题：）>>Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
goto main
:weather
echo %yss%>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
echo Elect %time:~0,5%>>plugins\Elect_Assistant\Elect_Conver.data
echo.好的，正在打开“天气”>>Elect_Conver.data
echo.>>plugins\Elect_Assistant\Elect_Conver.data
goto menu
pause





