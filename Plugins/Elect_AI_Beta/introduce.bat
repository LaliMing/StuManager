@echo off
title ÉèÖÃ
mode con: cols=85 lines=35
plugins\Elect_Assistant\image /d
:1
plugins\Elect_Assistant\image plugin\xieyi.bmp 0 0
plugins\Elect_Assistant\cmos 0 -1 1
set /a x=%errorlevel:~0,-3%
set /a y=%errorlevel%-1000*%x%
if %x% geq 62 if %x% leq 78 if %y% geq 31 if %y% leq 33 goto 2
goto 1
:2
plugins\Elect_Assistant\image plugin\introduce.bmp 0 0
ping -n 2 127.1>nul
plugins\Elect_Assistant\cmos 0 -1 1
set /a x=%errorlevel:~0,-3%
set /a y=%errorlevel%-1000*%x%
if %x% geq 62 if %x% leq 78 if %y% geq 31 if %y% leq 33 goto 3
goto 2
:3
plugins\Elect_Assistant\image plugin\introduce2.bmp 0 0
ping -n 2 127.1>nul
plugins\Elect_Assistant\cmos 0 -1 1
set /a x=%errorlevel:~0,-3%
set /a y=%errorlevel%-1000*%x%
if %x% geq 62 if %x% leq 78 if %y% geq 31 if %y% leq 33 del plugins\Elect_Assistant\firstuse.fxl&goto :eof
goto 3