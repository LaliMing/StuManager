@echo off
title StuManager
color 00
SETLOCAL ENABLEDELAYEDEXPANSION

::HUOCHAI PluginCode
title StuManager-Elect Assistant
::------------------------------------------
::可自定义参数区域
set ProgName=Elect_AI_Beta
set FullScreen_X=680
set FullScreen_Y=560
set logosize=100
set Textsize_X=80
set Textsize_Y=14
::------------------------------------------
call :HFunc_PlugWinSizeCalc
mode con: cols=%Console_X% lines=%Console_Y%
if exist "Symbol\DarkMode.fxl" (set extralogo=-dark) else (set extralogo=)
if exist "Symbol\DarkMode.fxl" (Plugins\img Pictures\Colour\black.png:0,0,%FullScreen_X%,%FullScreen_Y%) else (Plugins\img Pictures\Colour\white.png:0,0,%FullScreen_X%,%FullScreen_Y%)
Plugins\img Plugins\%ProgName%\Pluginlogo%extralogo%.png?%LogoPosi_X%,%LogoPosi_Y%,%logosize%,%logosize%
Plugins\img Plugins\%ProgName%\PluginName.png?%TextPosi_X%,%TextPosi_Y%,%Textsize_X%,%Textsize_Y%
ping -n 2 127.1>nul
goto ProgramInit

:HFunc_PlugWinSizeCalc
set /a Console_X=%FullScreen_X%/8
set /a Console_Y=%FullScreen_Y%/16
set /a LogoPosi_X=%FullScreen_X%/2-%logosize%/2
set /a LogoPosi_Y=%FullScreen_Y%/2-%logosize%/2-20
set /a TextPosi_X=%FullScreen_X%/2-%Textsize_X%/2
set /a TextPosi_Y=%FullScreen_Y%/2+%logosize%/2+10
goto :eof

:ProgramInit
::------------------------------------------
::可自定义参数区域
call Plugins\%ProgName%\MainProg.bat

::------------------------------------------
