@echo off
title StuManager-欢迎
mode con: cols=100 lines=37
goto start
::///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
::该模块负责二级菜单切换动画
:QE_Linear_Motion_lite
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%调用QE_Linear_Motion_lite模块>>RunningData.log
if exist "Motionoff.fxl" goto :eof
::Time
::call :HFunc_ADModeTimeCheck
::QE_Linear_Motion_lite V2.0.0	 
::----------------------------------------------------------
::个性化预设内容
set /p fps=<Symbol\fps.data
if "%fps%"=="10" (set fps=5)
if "%fps%"=="8" (set fps=5)
if "%fps%"=="6" (set fps=1)
set Init_Posi=20
set range=75
if exist "Symbol\mini.fxl" (set CanvasSize_X=521&set CanvasSize_Y=594) else (set CanvasSize_X=800&set CanvasSize_Y=594)
::----------------------------------------------------------
::预计算
set /a a=%CanvasSize_X%-%range%&set /a b=%CanvasSize_Y%-%range%
plugins\pmos /G
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 0 if %x% leq 200 if %y% geq 0 if %y% leq 300 (
    set /a a1=%Init_Posi%&set /a b1=%Init_Posi%
)
if %x% geq 600 if %x% leq 800 if %y% geq 0 if %y% leq 300 (
    set /a a1=%Range%-%Init_Posi%&set /a b1=%Init_Posi%
)
if %x% geq 0 if %x% leq 200 if %y% geq 300 if %y% leq 600 (
    set /a a1=%Init_Posi%&set /a b1=%Range%-%Init_Posi%
)
if %x% geq 600 if %x% leq 800 if %y% geq 300 if %y% leq 600 (
    set /a a1=%Range%-%Init_Posi%&set /a b1=%Range%-%Init_Posi%
)
if %x% geq 200 if %x% leq 600 if %y% geq 0 if %y% leq 600 (
    set /a a1=%Range%/2&set /a b1=%Range%/2
)
if exist "Symbol\mini.fxl" (set x=521&set y=592) else (set x=800&set y=592)
::----------------------------------------------------------
::预处理
set rounder=0
set /a xzhou=(!x!-!a!)/!fps!
set /a yzhou=(!y!-!b!)/!fps!
set /a xzhou1=(!a1!-!x1!)/!fps!
set /a yzhou1=(!b1!-!y1!)/!fps!
::----------------------------------------------------------
::循环画图
SETLOCAL ENABLEDELAYEDEXPANSION
for /l %%i in (1 1 !fps!) do (
   set /a var_x=%%i*!xzhou!
   set /a var_y=%%i*!yzhou!
   set /a size_x=%%i*!xzhou1!
   set /a size_y=%%i*!yzhou1!
   ::动态图片大小（原大小+累计增量）
   set /a mov_sizeX=!a!+!var_x!
   set /a mov_sizeY=!b!+!var_y!
   ::动态图片位置（原位置+累计增量）
   set /a mov_posiX=!a1!-!size_x!
   set /a mov_posiY=!b1!-!size_y!
   if !mov_posiX! leq 0 set mov_posiX=0
   if !mov_posiY! leq 0 set mov_posiY=0
   if !rounder!==0 (set symbol=:) else (set symbol=?)
   Plugins\img Pictures\!name!1.png!symbol!!mov_posiX!,!mov_posiY!,!mov_sizeX!,!mov_sizeY!
   set /a rounder=!rounder!+1
)
goto :eof
::///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
::该模块负责二级菜单切换动画
:QE_secondary_menu

echo.%date%%time%-%name%调用QE_secondary_menu模块>>RunningData.log
if exist "Symbol\developer_mode-overlay.fxl" echo.%symbol%,%secon_symbol%
if "%symbol%"=="head" Plugins\img pictures\white.png:260,0
goto QE_secondary_menu-head

	Plugins\img pictures\22.png?260,0,541,600
    Plugins\img pictures\22.png?260,0,541,600
    Plugins\img pictures\22.png?260,0,541,600
:QE_secondary_menu-head
::位置
set symbol=:
set secon_symbol=:
set /a delta=5/2
set a=541
set b=594
set a1=260
set b1=0
set /a delta_size=2*%delta%

set /a a1_2=a1+%delta%
set /a a1_3=a1_2+%delta%
set /a a1_4=a1_3+%delta%
set /a a1_5=a1_4+%delta%

set /a b1_2=b1+%delta%
set /a b1_3=b1_2+%delta%
set /a b1_4=b1_3+%delta%
set /a b1_5=b1_4+%delta%
::大小
set /a a_2=a-%delta_size%
set /a a_3=a_2-%delta_size%
set /a a_4=a_3-%delta_size%
set /a a_5=a_4-%delta_size%

set /a b_2=b-%delta_size%
set /a b_3=b_2-%delta_size%
set /a b_4=b_3-%delta_size%
set /a b_5=b_4-%delta_size%
if exist "Symbol\developer_mode-overlay.fxl" echo.%name%%secon_symbol%%a1%,%b1%,%a%,%b%

if exist "已禁用动画.fxl" (
    Plugins\img pictures\%name%%secon_symbol%%a1%,%b1%,%a%,%b%) else (
	if "%secon_symbol%" NEQ "?" (Plugins\img pictures\white.png:260,0)
    Plugins\img introduce\%name%%secon_symbol%%a1_5%,%b1_5%,%a_5%,%b_5%
    Plugins\img introduce\%name%%secon_symbol%%a1_4%,%b1_4%,%a_4%,%b_4%
    Plugins\img introduce\%name%%secon_symbol%%a1_3%,%b1_3%,%a_3%,%b_3%
    Plugins\img introduce\%name%%secon_symbol%%a1_2%,%b1_2%,%a_2%,%b_2%
    Plugins\img introduce\%name%%secon_symbol%%a1%,%b1%,%a%,%b%)
	 set symbol=   
	 
if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
:QE_secondary_menu-bar
if "%duty%"=="bar" (
	Plugins\img Pictures\22.png?260,0,541,600
    Plugins\img Pictures\22.png?260,0,541,600
    Plugins\img Pictures\22.png?260,0,541,600
    Plugins\img Pictures\22.png?260,0,541,600
	) 
goto :eof
::///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////








:start
if exist "Symbol\DarkMode.fxl" (
    if exist "Skin\SkinPackage\dark.fxl" (set background=background-dark)) else (set background=background)
Plugins\img skin\SkinPackage\%background%.png:0,0,800,592
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img Pictures\22.png?0,0,800,600
Plugins\img introduce\content.png?0,0,800,600
:start_withoutDe
Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 650 if %x% leq 750 if %y% geq 505 if %y% leq 548 (
::原图片大小
set a=94&set b=94
::原图片位置
set a1=241&set b1=264
::放大后图片大小
set x=800&set y=594
::放大后图片位置
set x1=0&set y1=0
set name=market
set duty=main
call :QE_Linear_Motion_lite
goto features-1)
if %x% geq 557 if %x% leq 605 if %y% geq 513 if %y% leq 541 (
del firstuse.fxl>nul 2>nul
goto :eof)
goto start_withoutDe

:features-1
::>>>>>>>>>>>>>>>>>>>>>>>>写入日志记录>>>>>>>>>>>>>>>>>>>>>>>>
echo.%date%%time%-settings>>RunningData.log
:features-1_Button
::>>>>>>>>>>>>>>>>>>>>>>>>加载按钮信息>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::按钮大小（长乘宽）
    set button1_sizeX=234
	set button1_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::计算
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button2--------
    ::按钮大小（长乘宽）
    set button2_sizeX=234
	set button2_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::计算
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button3--------
    ::按钮大小（长乘宽）
    set button3_sizeX=234
	set button3_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::计算
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button4--------
    ::按钮大小（长乘宽）
    set button4_sizeX=234
	set button4_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button5--------
    ::按钮大小（长乘宽）
    set button5_sizeX=234
	set button5_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button5_clickX1=12) else (set button5_clickX1=12)
	if exist "Symbol\mini.fxl" (set button5_clickY1=379) else (set button5_clickY1=379)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button5_clickX1%+260)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button6--------
    ::按钮大小（长乘宽）
    set button6_sizeX=234
	set button6_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button6_clickX1=12) else (set button6_clickX1=12)
	if exist "Symbol\mini.fxl" (set button6_clickY1=457) else (set button6_clickY1=457)
    ::计算
	if "%duty%"=="bar" (set /a button6_clickX1=%button6_clickX1%+260)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button7--------
    ::按钮大小（长乘宽）
    set button7_sizeX=234
	set button7_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button7_clickX1=12) else (set button7_clickX1=12)
	if exist "Symbol\mini.fxl" (set button7_clickY1=535) else (set button7_clickY1=535)
    ::计算
	if "%duty%"=="bar" (set /a button7_clickX1=%button7_clickX1%+260)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%
::--------------------------------------------------------------

::>>>>>>>>>>>>>>>>>>>>>>>>加载界面信息>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=features-1.png) else (set name=features-1.png)
if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
set symbol=
call :QE_secondary_menu
if exist "High_resolution.resche" (
Plugins\img introduce\features-sidebar.png:0,0,518,1400)
if exist "Low_resolution.resche" (
Plugins\img introduce\features-sidebar.png?0,0,259,700)
:features-1_motion
::Plugins\img introduce\fluencedesign.gif?305,230,200,150,1,2
::Plugins\img introduce\refresh.png?305,230,200,150

::>>>>>>>>>>>>>>>>>>>>>>>>加载控件信息>>>>>>>>>>>>>>>>>>>>>>>>
:features-1_withoutDe
echo.%date%%time%-settings>>RunningData.log
::Plugins\img Pictures\watermark.png?0,0,800,592
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto start
if %x% geq 458 if %x% leq 495 if %y% geq 326 if %y% leq 362 goto features-1_motion

::if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
::goto features-1)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
goto features-2)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
goto features-3)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
goto features-4)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
goto features-5)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
goto features-6)

::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
::goto features-7)
goto features-1_withoutDe

:features-2
::>>>>>>>>>>>>>>>>>>>>>>>>写入日志记录>>>>>>>>>>>>>>>>>>>>>>>>
echo.%date%%time%-settings>>RunningData.log
:features-2_Button
::>>>>>>>>>>>>>>>>>>>>>>>>加载按钮信息>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::按钮大小（长乘宽）
    set button1_sizeX=234
	set button1_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::计算
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button2--------
    ::按钮大小（长乘宽）
    set button2_sizeX=234
	set button2_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::计算
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button3--------
    ::按钮大小（长乘宽）
    set button3_sizeX=234
	set button3_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::计算
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button4--------
    ::按钮大小（长乘宽）
    set button4_sizeX=234
	set button4_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button5--------
    ::按钮大小（长乘宽）
    set button5_sizeX=234
	set button5_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button5_clickX1=12) else (set button5_clickX1=12)
	if exist "Symbol\mini.fxl" (set button5_clickY1=379) else (set button5_clickY1=379)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button5_clickX1%+260)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button6--------
    ::按钮大小（长乘宽）
    set button6_sizeX=234
	set button6_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button6_clickX1=12) else (set button6_clickX1=12)
	if exist "Symbol\mini.fxl" (set button6_clickY1=457) else (set button6_clickY1=457)
    ::计算
	if "%duty%"=="bar" (set /a button6_clickX1=%button6_clickX1%+260)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button7--------
    ::按钮大小（长乘宽）
    set button7_sizeX=234
	set button7_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button7_clickX1=12) else (set button7_clickX1=12)
	if exist "Symbol\mini.fxl" (set button7_clickY1=535) else (set button7_clickY1=535)
    ::计算
	if "%duty%"=="bar" (set /a button7_clickX1=%button7_clickX1%+260)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%
::--------------------------------------------------------------

::>>>>>>>>>>>>>>>>>>>>>>>>加载界面信息>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=features-2.png) else (set name=features-2.png)

if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
set symbol=
call :QE_secondary_menu
if exist "High_resolution.resche" (
Plugins\img introduce\features-sidebar.png:0,0,518,1400)
if exist "Low_resolution.resche" (
Plugins\img introduce\features-sidebar.png?0,0,259,700)
:features-2_motion
::Plugins\img introduce\mini.gif?305,230,200,150,1,2
::Plugins\img introduce\refresh.png?305,230,200,150

::>>>>>>>>>>>>>>>>>>>>>>>>加载控件信息>>>>>>>>>>>>>>>>>>>>>>>>
:features-2_withoutDe
echo.%date%%time%-settings>>RunningData.log
::Plugins\img Pictures\watermark.png?0,0,800,592
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto start
if %x% geq 458 if %x% leq 495 if %y% geq 326 if %y% leq 362 goto features-2_motion

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
goto features-1)

::if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
::goto features-2)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
goto features-3)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
goto features-4)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
goto features-5)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
goto features-6)

::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
::goto features-7)
goto features-2_withoutDe

:features-3
::>>>>>>>>>>>>>>>>>>>>>>>>写入日志记录>>>>>>>>>>>>>>>>>>>>>>>>
echo.%date%%time%-settings>>RunningData.log
:features-3_Button
::>>>>>>>>>>>>>>>>>>>>>>>>加载按钮信息>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::按钮大小（长乘宽）
    set button1_sizeX=234
	set button1_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::计算
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button2--------
    ::按钮大小（长乘宽）
    set button2_sizeX=234
	set button2_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::计算
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button3--------
    ::按钮大小（长乘宽）
    set button3_sizeX=234
	set button3_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::计算
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button4--------
    ::按钮大小（长乘宽）
    set button4_sizeX=234
	set button4_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button5--------
    ::按钮大小（长乘宽）
    set button5_sizeX=234
	set button5_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button5_clickX1=12) else (set button5_clickX1=12)
	if exist "Symbol\mini.fxl" (set button5_clickY1=379) else (set button5_clickY1=379)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button5_clickX1%+260)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button6--------
    ::按钮大小（长乘宽）
    set button6_sizeX=234
	set button6_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button6_clickX1=12) else (set button6_clickX1=12)
	if exist "Symbol\mini.fxl" (set button6_clickY1=457) else (set button6_clickY1=457)
    ::计算
	if "%duty%"=="bar" (set /a button6_clickX1=%button6_clickX1%+260)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button7--------
    ::按钮大小（长乘宽）
    set button7_sizeX=234
	set button7_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button7_clickX1=12) else (set button7_clickX1=12)
	if exist "Symbol\mini.fxl" (set button7_clickY1=535) else (set button7_clickY1=535)
    ::计算
	if "%duty%"=="bar" (set /a button7_clickX1=%button7_clickX1%+260)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%
::--------------------------------------------------------------

::>>>>>>>>>>>>>>>>>>>>>>>>加载界面信息>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=features-3.png) else (set name=features-3.png)

if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
set symbol=
call :QE_secondary_menu
if exist "High_resolution.resche" (
Plugins\img introduce\features-sidebar.png:0,0,518,1400)
if exist "Low_resolution.resche" (
Plugins\img introduce\features-sidebar.png?0,0,259,700)
:features-3_motion
::set position=535
::if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
::if exist "Symbol\mini.fxl" (set /a position=%position%-260)
::if exist "synergism_off.fxl" (Plugins\img Pictures\启%button_mode%.png?%position%,412) else Plugins\img Pictures\禁%button_mode%.png?%position%,412
::Plugins\img introduce\features-3.gif?305,230,200,150,1,2
::Plugins\img introduce\refresh.png?305,230,200,150

::>>>>>>>>>>>>>>>>>>>>>>>>加载控件信息>>>>>>>>>>>>>>>>>>>>>>>>
:features-3_withoutDe
echo.%date%%time%-settings>>RunningData.log
::Plugins\img Pictures\watermark.png?0,0,800,592

if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto start
if %x% geq 458 if %x% leq 495 if %y% geq 326 if %y% leq 362 goto features-3_motion

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
goto features-1)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
goto features-2)

::if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
::goto features-3)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
goto features-4)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
goto features-5)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
goto features-6)

::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
::goto features-7)
if %x% geq 534 if %x% leq 577 if %y% geq 411 if %y% leq 432 (
if exist "synergism_off.fxl" (del synergism_off.fxl) else echo.q>synergism_off.fxl
if exist "synergism_off.fxl" (Plugins\img Pictures\启%button_mode%.png?%position%,412) else Plugins\img Pictures\禁%button_mode%.png?%position%,412
ping -n 2 127.1>nul
goto features-3_withoutDe)
goto features-3_withoutDe


:features-4
::>>>>>>>>>>>>>>>>>>>>>>>>写入日志记录>>>>>>>>>>>>>>>>>>>>>>>>
echo.%date%%time%-settings>>RunningData.log
:features-4_Button
::>>>>>>>>>>>>>>>>>>>>>>>>加载按钮信息>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::按钮大小（长乘宽）
    set button1_sizeX=234
	set button1_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::计算
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button2--------
    ::按钮大小（长乘宽）
    set button2_sizeX=234
	set button2_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::计算
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button3--------
    ::按钮大小（长乘宽）
    set button3_sizeX=234
	set button3_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::计算
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button4--------
    ::按钮大小（长乘宽）
    set button4_sizeX=234
	set button4_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button5--------
    ::按钮大小（长乘宽）
    set button5_sizeX=234
	set button5_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button5_clickX1=12) else (set button5_clickX1=12)
	if exist "Symbol\mini.fxl" (set button5_clickY1=379) else (set button5_clickY1=379)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button5_clickX1%+260)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button6--------
    ::按钮大小（长乘宽）
    set button6_sizeX=234
	set button6_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button6_clickX1=12) else (set button6_clickX1=12)
	if exist "Symbol\mini.fxl" (set button6_clickY1=457) else (set button6_clickY1=457)
    ::计算
	if "%duty%"=="bar" (set /a button6_clickX1=%button6_clickX1%+260)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button7--------
    ::按钮大小（长乘宽）
    set button7_sizeX=234
	set button7_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button7_clickX1=12) else (set button7_clickX1=12)
	if exist "Symbol\mini.fxl" (set button7_clickY1=535) else (set button7_clickY1=535)
    ::计算
	if "%duty%"=="bar" (set /a button7_clickX1=%button7_clickX1%+260)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%
::--------------------------------------------------------------

::>>>>>>>>>>>>>>>>>>>>>>>>加载界面信息>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=features-4.png) else (set name=features-4.png)

if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
set symbol=
call :QE_secondary_menu
if exist "High_resolution.resche" (
Plugins\img introduce\features-sidebar.png:0,0,518,1400)
if exist "Low_resolution.resche" (
Plugins\img introduce\features-sidebar.png?0,0,259,700)
:features-4_motion
::Plugins\img introduce\features-4.gif?305,230,200,150,1,2
::Plugins\img introduce\refresh.png?305,230,200,150

::>>>>>>>>>>>>>>>>>>>>>>>>加载控件信息>>>>>>>>>>>>>>>>>>>>>>>>
:features-4_withoutDe
echo.%date%%time%-settings>>RunningData.log
::Plugins\img Pictures\watermark.png?0,0,800,592

if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto start
if %x% geq 458 if %x% leq 495 if %y% geq 326 if %y% leq 362 goto features-4_motion

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
goto features-1)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
goto features-2)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
goto features-3)

::if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
::goto features-4)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
goto features-5)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
goto features-6)

::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
::goto features-7)
goto features-4_withoutDe


:features-5
::>>>>>>>>>>>>>>>>>>>>>>>>写入日志记录>>>>>>>>>>>>>>>>>>>>>>>>
echo.%date%%time%-settings>>RunningData.log
:features-5_Button
::>>>>>>>>>>>>>>>>>>>>>>>>加载按钮信息>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::按钮大小（长乘宽）
    set button1_sizeX=234
	set button1_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::计算
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button2--------
    ::按钮大小（长乘宽）
    set button2_sizeX=234
	set button2_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::计算
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button3--------
    ::按钮大小（长乘宽）
    set button3_sizeX=234
	set button3_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::计算
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button4--------
    ::按钮大小（长乘宽）
    set button4_sizeX=234
	set button4_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button5--------
    ::按钮大小（长乘宽）
    set button5_sizeX=234
	set button5_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button5_clickX1=12) else (set button5_clickX1=12)
	if exist "Symbol\mini.fxl" (set button5_clickY1=379) else (set button5_clickY1=379)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button5_clickX1%+260)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::--------------------------------------------------------------

::>>>>>>>>>>>>>>>>>>>>>>>>加载界面信息>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=features-5.png) else (set name=features-5.png)

if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
set symbol=
call :QE_secondary_menu
if exist "High_resolution.resche" (
Plugins\img introduce\features-sidebar.png:0,0,518,1400)
if exist "Low_resolution.resche" (
Plugins\img introduce\features-sidebar.png?0,0,259,700)
:features-5_motion

::>>>>>>>>>>>>>>>>>>>>>>>>加载控件信息>>>>>>>>>>>>>>>>>>>>>>>>
:features-5_withoutDe
echo.%date%%time%-settings>>RunningData.log
::Plugins\img Pictures\watermark.png?0,0,800,592

if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto start

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
goto features-1)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
goto features-2)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
goto features-3)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
goto features-4)

::if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
::goto features-5)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
goto features-6)

::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
::goto features-7)
goto features-5_withoutDe

:features-6
::>>>>>>>>>>>>>>>>>>>>>>>>写入日志记录>>>>>>>>>>>>>>>>>>>>>>>>
echo.%date%%time%-settings>>RunningData.log
:features-6_Button
::>>>>>>>>>>>>>>>>>>>>>>>>加载按钮信息>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::按钮大小（长乘宽）
    set button1_sizeX=234
	set button1_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::计算
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button2--------
    ::按钮大小（长乘宽）
    set button2_sizeX=234
	set button2_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::计算
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button3--------
    ::按钮大小（长乘宽）
    set button3_sizeX=234
	set button3_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::计算
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button4--------
    ::按钮大小（长乘宽）
    set button4_sizeX=234
	set button4_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button5--------
    ::按钮大小（长乘宽）
    set button5_sizeX=234
	set button5_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button5_clickX1=12) else (set button5_clickX1=12)
	if exist "Symbol\mini.fxl" (set button5_clickY1=379) else (set button5_clickY1=379)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button5_clickX1%+260)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button6--------
    ::按钮大小（长乘宽）
    set button6_sizeX=234
	set button6_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button6_clickX1=12) else (set button6_clickX1=12)
	if exist "Symbol\mini.fxl" (set button6_clickY1=457) else (set button6_clickY1=457)
    ::计算
	if "%duty%"=="bar" (set /a button6_clickX1=%button6_clickX1%+260)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button7--------
    ::按钮大小（长乘宽）
    set button7_sizeX=234
	set button7_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button7_clickX1=12) else (set button7_clickX1=12)
	if exist "Symbol\mini.fxl" (set button7_clickY1=535) else (set button7_clickY1=535)
    ::计算
	if "%duty%"=="bar" (set /a button7_clickX1=%button7_clickX1%+260)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%
::--------------------------------------------------------------

::>>>>>>>>>>>>>>>>>>>>>>>>加载界面信息>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=features-6.png) else (set name=features-6.png)

if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
set symbol=
call :QE_secondary_menu
if exist "High_resolution.resche" (
Plugins\img introduce\features-sidebar.png:0,0,518,1400)
if exist "Low_resolution.resche" (
Plugins\img introduce\features-sidebar.png?0,0,259,700)
:features-6_motion

::>>>>>>>>>>>>>>>>>>>>>>>>加载控件信息>>>>>>>>>>>>>>>>>>>>>>>>
:features-6_withoutDe
echo.%date%%time%-settings>>RunningData.log
::Plugins\img Pictures\watermark.png?0,0,800,592

if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto start

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
goto features-1)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
goto features-2)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
goto features-3)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
goto features-4)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
goto features-5)

::if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
::goto features-6)

::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
::goto features-7)
goto features-6_withoutDe

:features-7
::>>>>>>>>>>>>>>>>>>>>>>>>写入日志记录>>>>>>>>>>>>>>>>>>>>>>>>
echo.%date%%time%-settings>>RunningData.log
:features-7_Button
::>>>>>>>>>>>>>>>>>>>>>>>>加载按钮信息>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::按钮大小（长乘宽）
    set button1_sizeX=234
	set button1_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::计算
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button2--------
    ::按钮大小（长乘宽）
    set button2_sizeX=234
	set button2_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::计算
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button3--------
    ::按钮大小（长乘宽）
    set button3_sizeX=234
	set button3_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::计算
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button4--------
    ::按钮大小（长乘宽）
    set button4_sizeX=234
	set button4_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button5--------
    ::按钮大小（长乘宽）
    set button5_sizeX=234
	set button5_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button5_clickX1=12) else (set button5_clickX1=12)
	if exist "Symbol\mini.fxl" (set button5_clickY1=379) else (set button5_clickY1=379)
    ::计算
	if "%duty%"=="bar" (set /a button4_clickX1=%button5_clickX1%+260)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button6--------
    ::按钮大小（长乘宽）
    set button6_sizeX=234
	set button6_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button6_clickX1=12) else (set button6_clickX1=12)
	if exist "Symbol\mini.fxl" (set button6_clickY1=457) else (set button6_clickY1=457)
    ::计算
	if "%duty%"=="bar" (set /a button6_clickX1=%button6_clickX1%+260)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%
::--------------------------------------------------------------
::-----------------------------------------------Button7--------
    ::按钮大小（长乘宽）
    set button7_sizeX=234
	set button7_sizeY=66
    ::按钮位置（左上顶点坐标）
    if exist "Symbol\mini.fxl" (set button7_clickX1=12) else (set button7_clickX1=12)
	if exist "Symbol\mini.fxl" (set button7_clickY1=535) else (set button7_clickY1=535)
    ::计算
	if "%duty%"=="bar" (set /a button7_clickX1=%button7_clickX1%+260)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%
::--------------------------------------------------------------

::>>>>>>>>>>>>>>>>>>>>>>>>加载界面信息>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=features-5.png) else (set name=features-5.png)

if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%
set symbol=
call :QE_secondary_menu
if exist "High_resolution.resche" (
Plugins\img introduce\features-sidebar.png:0,0,518,1400)
if exist "Low_resolution.resche" (
Plugins\img introduce\features-sidebar.png?0,0,259,700)
:features-7_motion

::>>>>>>>>>>>>>>>>>>>>>>>>加载控件信息>>>>>>>>>>>>>>>>>>>>>>>>
:features-7_withoutDe
echo.%date%%time%-settings>>RunningData.log
::Plugins\img Pictures\watermark.png?0,0,800,592

if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

Plugins\curs /crv 0
plugins\pmos /K -1:5000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto start

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
goto features-1)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
goto features-2)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
goto features-3)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
goto features-4)

::::if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
::::goto features-5)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
goto features-6)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
goto features-7)
goto features-7_withoutDe