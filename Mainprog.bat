@echo off
title StuManager
color 00
SETLOCAL ENABLEDELAYEDEXPANSION
:Program_Start
::------Ĭ��ȫ�ֲ�������------
call :HFunc_DefConfig

::------���ر�������ת------
::Time
call :HFunc_ADModeTimeCheck
::windows
if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
::position
if exist "Symbol\mini.fxl" (set position=-140) else (set position=0)
::synWindows
if exist "*.tmpdual" (call :HFunc_SynWindows)
::DiyStartMenu
if exist "Symbol\DiyStartMenu.data" (set /p DiyStartMenu=<Symbol\DiyStartMenu.data)
::Mode
if "%DiyStartMenu%"=="main" (set mode=Normal) else (set mode=HiEff)

if "%mode%"=="Normal" (
set background=background
set address=Skin\SkinPackage
    if exist "Skin\SkinPackage\dark.fxl" (
        if exist "Symbol\DarkMode.fxl" (set background=background-dark))
	)
)
if "%mode%"=="HiEff" (
set address=Pictures
    if "%DiyStartMenu%"=="add" (set background=clean1)
    if "%DiyStartMenu%"=="edit" (set background=edit1)
    if "%DiyStartMenu%"=="statistic" (set background=safe1)
    if "%DiyStartMenu%"=="settings" (set background=settings1)
    if "%DiyStartMenu%"=="output" (set background=safe1)
    if "%DiyStartMenu%"=="elect" (set background=edit1)
	if "%DiyStartMenu%"=="ReInstall" (set background=settings1)
)
::background
Plugins\Img %address%\%background%.png:%position%,0,800,594
::call :HFunc_TimeDelay

::------�ֱ��ʼ�鲢ƥ�䴰�ڴ�С------
echo._______>>RunningData.log
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Ӧ�ó���>>RunningData.log
echo.Ӧ�ó���汾��V2.1.%HUOCHAI_UpdateDate%>>RunningData.log
del *.resche>nul 2>nul
if exist "Symbol\mini.fxl" (set WindowSize=mini) else (set WindowSize=normal)
echo.%CurrentHorizontalResolution%��%CurrentVerticalResolution%>>Low_resolution.resche

::------�ļ���������------
if exist "Skin\SkinPackage\NewPackage.fxl" (
    del Skin\SkinPackage\Uninstall.exe>nul 2>nul
    del Skin\SkinPackage\nsUninstall.dat>nul 2>nul
    del Skin\SkinPackage\NewPackage.fxl>nul 2>nul
)
if not exist "symbol\register.data" (echo.Elect_Assistant>symbol\register.data)
::------״̬��Ϣ���------
if exist "firstuse.fxl" call welcome.bat
if exist "Password_auth.fxl" call Password_auth.bat
if exist "oldpeople.fxl" goto ����
::if not exist "QyulEngine.exe" (echo.1>Motionoff.fxl&start bubble.exe)
)

::---------���ü�����---------
call Plugins\AddONLoading.bat

::------����Ƿ�ع�����------
del Symbol\QuickControl.fxl>nul 2>nul
if exist "Symbol\developer_mode.fxl" goto Basic_Check
if exist "Symbol\version.fxl" (goto Basic_Check0)
::if not exist "Symbol\version.fxl" (goto verhigh)

:Basic_Check0
set /p version=<Symbol\version.fxl
if "%version%" GTR "%HUOCHAI_Version_1%%HUOCHAI_Version_2%%HUOCHAI_UpdateDate%" (goto verhigh) else (echo.%HUOCHAI_Version_1%%HUOCHAI_Version_2%%HUOCHAI_UpdateDate%>Symbol\version.fxl)

:Basic_Check
::------���ظ�Чģʽ------
::if "%Mode%"=="HiEff" (set QE_JumpCode=QE_DeepeningToColour&call QyulEngine.bat)

if exist "Symbol\mini.fxl" (set position=-140) else (set position=0)

set /p DiyStartMenu=<Symbol\DiyStartMenu.data

if "%DiyStartMenu%"=="main" (goto Features_Check)
if "%DiyStartMenu%"=="add" (
set background=clean1
set BackgroundColor=clean
set HUOCHAI_JumpCode=clean
)
if "%DiyStartMenu%"=="edit" (
set background=edit1
set BackgroundColor=edit
set HUOCHAI_JumpCode=edit
)
if "%DiyStartMenu%"=="statistic" (
set background=safe1
set BackgroundColor=safe
set HUOCHAI_JumpCode=safe
)
if "%DiyStartMenu%"=="settings" (
set background=settings1
set BackgroundColor=settings
set HUOCHAI_JumpCode=settings
)
if "%DiyStartMenu%"=="output" (
set background=safe1
set BackgroundColor=tools1
set HUOCHAI_JumpCode=tools
)
if "%DiyStartMenu%"=="elect" (
set background=edit1
set BackgroundColor=elect
echo.1>elect.tmp
)
if "%DiyStartMenu%"=="ReInstall" (
echo.main>Symbol\DiyStartMenu.data
goto xiufu
)

if "%mode%"=="HiEff" (call :HFunc_Reload_color&goto MainInterface_leaveJump)

:Features_Check
::------�������Ƿ�����------
set Features_Check_flag=0
if not exist "Plugins\image.exe" (set Features_Check_flag=1)
if not exist "Plugins\pmos.exe" (set Features_Check_flag=1)
if not exist "Plugins\curs.exe" (set Features_Check_flag=1)
if not exist "Plugins\img.exe" (set Features_Check_flag=1)
if not exist "Password_auth.bat" (set Features_Check_flag=1)
if not exist "Functional_Components.exe" (set Features_Check_flag=1)
if not exist "setup.exe" (set Features_Check_flag=1)
::if not exist "QyulEngine.exe" (set Features_Check_flag=1)
if not exist "URLS\QQsupport.url" (set Features_Check_flag=1)
if not exist "URLS\update.url" (set Features_Check_flag=1)

if "%Features_Check_flag%"=="1" (echo.0>Symbol\lostassembly.fxl) else (del Symbol\lostassembly.fxl>nul 2>nul)

goto MainInterface_withDe

:Key
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����Keyģ��>>RunningData.log
if exist "$key.key" (set /p value=<$key.key)
set "message=���������Ա���룺"
set "title=��֤����"
set "note="
set "speak="
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
if "%speak%"=="%value%" (set point=1) else (set point=2)
goto :eof

:QE_Open_Subroutine
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_open_subroutineģ��>>RunningData.log

if exist "Symbol\DarkMode.fxl" (set color=black) else set color=gray
if exist "Motionoff.fxl" goto :eof
::Time
call :HFunc_ADModeTimeCheck
::QE_Linear_Motion_lite V2.0.0	 
::----------------------------------------------------------
::���Ի�Ԥ������
set /p fps=<Symbol\fps.data
if "%fps%"=="10" (set fps=5)
if "%fps%"=="8" (set fps=5)
if "%fps%"=="6" (set fps=1)
set Init_Posi=15
set range=60
if exist "Symbol\mini.fxl" (set CanvasSize_X=521&set CanvasSize_Y=594) else (set CanvasSize_X=800&set CanvasSize_Y=594)
::----------------------------------------------------------
::Ԥ����
set /a a=%CanvasSize_X%-%range%&set /a b=%CanvasSize_Y%-%range%
plugins\pmos /G
call :HFunc_MouseClick
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
::Plugins\Img Pictures\15pc-black.png?0,0,800,594
::Plugins\Img Pictures\15pc-black.png?0,0,800,594
::----------------------------------------------------------
::Ԥ����
set rounder=0
set /a xzhou=(!x!-!a!)/!fps!
set /a yzhou=(!y!-!b!)/!fps!
set /a xzhou1=(!a1!-!x1!)/!fps!
set /a yzhou1=(!b1!-!y1!)/!fps!
::----------------------------------------------------------
::ѭ����ͼ
SETLOCAL ENABLEDELAYEDEXPANSION
for /l %%i in (1 1 !fps!) do (
   set /a var_x=%%i*!xzhou!
   set /a var_y=%%i*!yzhou!
   set /a size_x=%%i*!xzhou1!
   set /a size_y=%%i*!yzhou1!
   ::��̬ͼƬ��С��ԭ��С+�ۼ�������
   set /a mov_sizeX=!a!+!var_x!
   set /a mov_sizeY=!b!+!var_y!
   ::��̬ͼƬλ�ã�ԭλ��+�ۼ�������
   set /a mov_posiX=!a1!-!size_x!
   set /a mov_posiY=!b1!-!size_y!
   if !mov_posiX! leq 0 set mov_posiX=0
   if !mov_posiY! leq 0 set mov_posiY=0
   if !rounder!==0 (set symbol=:) else (set symbol=?)
   Plugins\Img Pictures\!color!.png!symbol!!mov_posiX!,!mov_posiY!,!mov_sizeX!,!mov_sizeY!
   set /a rounder=!rounder!+1
)
goto :eof


:QE_menu_rolled
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_menu_rolledģ��>>RunningData.log
set name_locate=%name%1.png
set name_bar=%name%-sidebar.png
if not exist "Motionoff.fxl" (
if exist "Symbol\mini.fxl" (
    goto :eof
	) else (
    Plugins\Img pictures\%name_locate%:100,0,800,600
    Plugins\Img pictures\%name_locate%:50,0,800,600
    Plugins\Img pictures\%name_locate%:30,0,800,600
    Plugins\Img pictures\%name_locate%:15,0,800,600
    Plugins\Img pictures\%name_locate%:7,0,800,600
    Plugins\Img pictures\%name_locate%:4,0,800,600
	Plugins\Img pictures\%name_locate%:2,0,800,600
    Plugins\Img pictures\%name_locate%:1,0,800,600	
	))
Plugins\Img pictures\%name_locate%:0,0,800,600
if exist "Symbol\DarkMode.fxl" (
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600) else (
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600)
Plugins\Img pictures\%name_bar%?0,0
::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)
if "%WaterMark%"=="True" (Plugins\Img Pictures\watermark.png?0,0,800,592)
goto :eof

::��ģ�鸺������˵��л�����
:QE_secondary_menu
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_secondary_menuģ��>>RunningData.log
::Time
call :HFunc_ADModeTimeCheck
::HareLoad
if exist "Symbol\linear_motion.fxl" (set HARE_EngineLaunch_ProcessWaitOpt=False&call :HARE_EngineLaunch)

if exist "Symbol\developer_mode-overlay.fxl" echo.%symbol%,%secon_symbol%
if "%symbol%"=="head" (goto QE_secondary_menu-head)
if "%secon_symbol%"=="?" (goto QE_secondary_menu-head)
if exist "Symbol\mini.fxl" (set position=0) else (set position=260)

:QE_secondary_menu-head
::λ��
set /a delta=%QE_secondary_menu_DELTA%
set a=541
set b=594
if exist "Symbol\mini.fxl" (set a1=0) else set a1=260
if "%MsgMore_flag%"=="True" (set a=622&set a1=178&set MsgMore_flag=False)
set b1=0
set /a delta_size=2*%delta%

set /a a1_2=a1+%delta%
set /a a1_3=a1_2+%delta%
set /a a1_4=a1_3+%delta%
set /a a1_5=a1_4+%delta%
set /a a1_6=a1_5+%delta%

set /a b1_2=b1+%delta%
set /a b1_3=b1_2+%delta%
set /a b1_4=b1_3+%delta%
set /a b1_5=b1_4+%delta%
set /a b1_6=b1_5+%delta%
::��С
set /a a_2=a-%delta_size%
set /a a_3=a_2-%delta_size%
set /a a_4=a_3-%delta_size%
set /a a_5=a_4-%delta_size%
set /a a_6=a_5-%delta_size%

set /a b_2=b-%delta_size%
set /a b_3=b_2-%delta_size%
set /a b_4=b_3-%delta_size%
set /a b_5=b_4-%delta_size%
set /a b_6=b_5-%delta_size%

SET QE_secondary_menu_DELTA=1

if exist "Symbol\Motionoff_Internal_bus.fxl" (Plugins\Img pictures\%name%%secon_symbol%%a1%,%b1%,%a%,%b%&goto QE_secondary_menu_eof)

::�˻ض�Ч
::echo.nametempedit:%nametempedit%\name:%name%\name_temp:%name_temp%\InputName_temp:%InputName_temp%
::if "%QE_Errorcode%" NEQ "1" (
::    if "%symbol%" NEQ "head" (
::	    if not exist "Symbol\developer_mode-overlay.fxl" (
::            if not exist "Motionoff.fxl" (
::                echo.Plugins\Img pictures\%name_temp%%secon_symbol%%a1_2%,%b1_2%,%a_2%,%b_2%
::                Plugins\Img pictures\%name_temp%%secon_symbol%%a1_3%,%b1_3%,%a_3%,%b_3%
::                Plugins\Img pictures\%name_temp%%secon_symbol%%a1_4%,%b1_4%,%a_4%,%b_4%
::			)
::    	)
::	)
::)

::�ɰ�
if exist "Symbol\DarkMode.fxl" (set MaskColor=11.png) else (set MaskColor=22.png)
if "%QE_Errorcode%" NEQ "1" (
    if "%symbol%" NEQ "head" (
	    if not exist "Symbol\developer_mode-overlay.fxl" (
            if not exist "Motionoff.fxl" (
                Plugins\Img pictures\%MaskColor%?%a1%,0,541,594
				Plugins\Img pictures\%MaskColor%?%a1%,0,541,594
			)
    	)
	)
) 

::���㴰�嶯Ч
if exist "Symbol\developer_mode-overlay.fxl" echo.%name%,%secon_symbol%%a1%,%b1%,%a%,%b%
if exist "Symbol\mini.fxl" (
    if "%nametempedit%"=="True" (set name_temp=%name%&set name=%name%1.png)
	if exist "Motionoff.fxl" (Plugins\Img pictures\%name%%secon_symbol%%a1%,%b1%,%a%,%b%&set symbol=&goto :eof)
	if "%secon_symbol%" NEQ "?" (if exist "Symbol\DarkMode.fxl" (Plugins\Img pictures\black.png:0,0) else Plugins\Img pictures\white.png:0,0)
    Plugins\Img pictures\%name%%secon_symbol%%a1_6%,%b1_6%,%a_6%,%b_6%
    Plugins\Img pictures\%name%%secon_symbol%%a1_5%,%b1_5%,%a_5%,%b_5%
    Plugins\Img pictures\%name%%secon_symbol%%a1_4%,%b1_4%,%a_4%,%b_4%
    Plugins\Img pictures\%name%%secon_symbol%%a1_3%,%b1_3%,%a_3%,%b_3%
    Plugins\Img pictures\%name%%secon_symbol%%a1_2%,%b1_2%,%a_2%,%b_2%
    Plugins\Img pictures\%name%%secon_symbol%%a1%,%b1%,%a%,%b%
	set symbol=
	if "%nametempedit%"=="True" (set name=%name_temp%&set nametempedit=False)
    goto :eof
)

::��׼���嶯Ч
if "%nametempedit%"=="True" (set InputName_temp=%name%&set name=%name%1.png)
if exist "Motionoff.fxl" (
    Plugins\Img pictures\%name%%secon_symbol%%a1%,%b1%,%a%,%b%) else (
    if "%secon_symbol%" NEQ "?" (
        if exist "Symbol\DarkMode.fxl" (Plugins\Img pictures\black.png:260,0) else Plugins\Img pictures\white.png:260,0
    )
    Plugins\Img pictures\%name%%secon_symbol%%a1_6%,%b1_6%,%a_6%,%b_6%
    Plugins\Img pictures\%name%%secon_symbol%%a1_5%,%b1_5%,%a_5%,%b_5%
    Plugins\Img pictures\%name%%secon_symbol%%a1_4%,%b1_4%,%a_4%,%b_4%
    Plugins\Img pictures\%name%%secon_symbol%%a1_3%,%b1_3%,%a_3%,%b_3%
    Plugins\Img pictures\%name%%secon_symbol%%a1_2%,%b1_2%,%a_2%,%b_2%
    Plugins\Img pictures\%name%%secon_symbol%%a1%,%b1%,%a%,%b%
	if "%nametempedit%"=="True" (set name=%InputName_temp%&set nametempedit=False)
    )
::ˮӡ
if "%WaterMark%"=="True" (Plugins\Img Pictures\watermark.png?0,0,800,592)
set symbol=   
set name_temp=%name%
::���Ӳ�
if exist "Symbol\developer_mode-overlay.fxl" echo.%duty%

:QE_secondary_menu-bar
if "%duty%"=="bar" (
    if exist "Symbol\DarkMode.fxl" (
    Plugins\Img Pictures\15pc-black.png?260,0,541,600
    Plugins\Img Pictures\15pc-black.png?260,0,541,600
	Plugins\Img Pictures\15pc-black.png?260,0,541,600
    Plugins\Img Pictures\15pc-black.png?260,0,541,600) else (
	Plugins\Img Pictures\22.png?260,0,541,600
    Plugins\Img Pictures\22.png?260,0,541,600
    Plugins\Img Pictures\22.png?260,0,541,600
    Plugins\Img Pictures\22.png?260,0,541,600)
	) 
goto :eof

:QE_secondary_menu_eof
del Symbol\Motionoff_Internal_bus.fxl>nul 2>nul
set symbol=
goto :eof


:QE_secondary_menu-emphasize
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_secondary_menu-emphasizeģ��>>RunningData.log
::Time
call :HFunc_ADModeTimeCheck
if exist "Symbol\developer_mode-overlay.fxl" echo.%symbol%,%secon_symbol%
if exist "Symbol\mini.fxl" (set position=0) else (set position=260)
::λ��
set /a delta=1
set QE_Errorcode=0
set a=541
set b=594
if exist "Symbol\mini.fxl" (set a1=0) else set a1=260
if "%MsgMore_flag%"=="True" (set a=622&set a1=178&set MsgMore_flag=False)
set b1=0
set /a delta_size=2*%delta%

set /a a1_2=a1+%delta%
set /a a1_3=a1_2+%delta%
set /a a1_4=a1_3+%delta%
set /a a1_5=a1_4+%delta%
set /a a1_6=a1_5+%delta%

set /a b1_2=b1+%delta%
set /a b1_3=b1_2+%delta%
set /a b1_4=b1_3+%delta%
set /a b1_5=b1_4+%delta%
set /a b1_6=b1_5+%delta%
::��С
set /a a_2=a-%delta_size%
set /a a_3=a_2-%delta_size%
set /a a_4=a_3-%delta_size%
set /a a_5=a_4-%delta_size%
set /a a_6=a_5-%delta_size%

set /a b_2=b-%delta_size%
set /a b_3=b_2-%delta_size%
set /a b_4=b_3-%delta_size%
set /a b_5=b_4-%delta_size%
set /a b_6=b_5-%delta_size%
SET QE_secondary_menu_DELTA=1

::�˻ض�Ч
if exist "Symbol\Motionoff_Internal_bus.fxl" (Plugins\Img pictures\%name%%secon_symbol%%a1%,%b1%,%a%,%b%&goto QE_secondary_menu_eof)
if "%QE_Errorcode%" NEQ "1" (
    if "%symbol%" NEQ "head" (
	    if not exist "Symbol\developer_mode-overlay.fxl" (
            if not exist "Motionoff.fxl" (
                Plugins\Img pictures\%name_temp%%secon_symbol%%a1_2%,%b1_2%,%a_2%,%b_2%
                Plugins\Img pictures\%name_temp%%secon_symbol%%a1_3%,%b1_3%,%a_3%,%b_3%
                Plugins\Img pictures\%name_temp%%secon_symbol%%a1_4%,%b1_4%,%a_4%,%b_4%
				Plugins\Img pictures\%name_temp%%secon_symbol%%a1_3%,%b1_3%,%a_3%,%b_3%
				Plugins\Img pictures\%name_temp%%secon_symbol%%a1_2%,%b1_2%,%a_2%,%b_2%
				Plugins\Img pictures\%name_temp%%secon_symbol%%a1%,%b1%,%a%,%b%
			)
    	)
	)
)

if "%WaterMark%"=="True" (Plugins\Img Pictures\watermark.png?0,0,800,592)
goto :eof


::��ģ�鸺���°�ť�Ķ���
:QE_Pushed_Button
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Pushed_Buttonģ��>>RunningData.log
::Plugins\Img Pictures\old_FluenceDesign_Pics\mask.png?%a1%,%b1%,%a%,%b%
::λ��
set /a shape_ratio=%a%/%b%
set /a delta_size=2*%QE_Pushed_Button_DELTA%

set /a a1_2=a1+%shape_ratio%*%QE_Pushed_Button_DELTA%
set /a a1_3=a1_2+%shape_ratio%*%QE_Pushed_Button_DELTA%
set /a a1_4=a1_3+%shape_ratio%*%QE_Pushed_Button_DELTA%
set /a a1_5=a1_4+%shape_ratio%*%QE_Pushed_Button_DELTA%

set /a b1_2=b1+%QE_Pushed_Button_DELTA%
set /a b1_3=b1_2+%QE_Pushed_Button_DELTA%
set /a b1_4=b1_3+%QE_Pushed_Button_DELTA%
set /a b1_5=b1_4+%QE_Pushed_Button_DELTA%
::��С
set /a a_2=a-%shape_ratio%*%delta_size%
set /a a_3=a_2-%shape_ratio%*%delta_size%
set /a a_4=a_3-%shape_ratio%*%delta_size%
set /a a_5=a_4-%shape_ratio%*%delta_size%

set /a b_2=b-%delta_size%
set /a b_3=b_2-%delta_size%
set /a b_4=b_3-%delta_size%
set /a b_5=b_4-%delta_size%
if "%place%"==process_plus (set /p name=<Symbol\jump.fxl)
if "%address%"=="button" (set address=%name%-BUTTON)
::Plugins\Img Pictures\11.png?%a1%,%b1%,%a%,%b%           
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_2%,%b1_2%,%a_2%,%b_2%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_3%,%b1_3%,%a_3%,%b_3%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_4%,%b1_4%,%a_4%,%b_4%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_5%,%b1_5%,%a_5%,%b_5%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1_4%,%b1_4%,%a_4%,%b_4%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1_3%,%b1_3%,%a_3%,%b_3%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1_2%,%b1_2%,%a_2%,%b_2%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1%,%b1%,%a%,%b%
::set /a a1_2=a1-%delta%
::set /a a1_3=a1_2-%delta%
::set /a a1_4=a1_3-%delta%
::set /a a1_5=a1_4-%delta%
::
::set /a b1_2=b1-%delta%
::set /a b1_3=b1_2-%delta%
::set /a b1_4=b1_3-%delta%
::set /a b1_5=b1_4-%delta%
::::��С
::set /a a_2=a+%delta_size%
::set /a a_3=a_2+%delta_size%
::set /a a_4=a_3+%delta_size%
::set /a a_5=a_4+%delta_size%
::
::set /a b_2=b+%delta_size%
::set /a b_3=b_2+%delta_size%
::set /a b_4=b_3+%delta_size%
::set /a b_5=b_4+%delta_size%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1_2%,%b1_2%,%a_2%,%b_2%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1_3%,%b1_3%,%a_3%,%b_3%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1_4%,%b1_4%,%a_4%,%b_4%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%address%.png?%a1_5%,%b1_5%,%a_5%,%b_5%

goto :eof

:QE_Pushed_Button2
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Pushed_Button2ģ��>>RunningData.log
::--------------------------------------
::ģ��ʹ��˵��
::a,b (ͼƬ��С��a,b)
::a1,b1 (ͼƬλ�ã�a1,b1)
::name (������Pictures\old_FluenceDesign_Pics�е�ͼ���ļ�)
::place (process_plus/��)
::address (button/��)
::--------------------------------------
::λ��
set /a shape_ratio=%a%/%b%
::echo.%shape_ratio%
set /a delta_size=2*%QE_Pushed_Button2_DELTA%

set /a a1_2=a1+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_3=a1_2+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_4=a1_3+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_5=a1_4+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_6=a1_5+%shape_ratio%*%QE_Pushed_Button2_DELTA%

set /a b1_2=b1+%QE_Pushed_Button2_DELTA%
set /a b1_3=b1_2+%QE_Pushed_Button2_DELTA%
set /a b1_4=b1_3+%QE_Pushed_Button2_DELTA%
set /a b1_5=b1_4+%QE_Pushed_Button2_DELTA%
set /a b1_6=b1_5+%QE_Pushed_Button2_DELTA%
::��С
set /a a_2=a-%shape_ratio%*%delta_size%
set /a a_3=a_2-%shape_ratio%*%delta_size%
set /a a_4=a_3-%shape_ratio%*%delta_size%
set /a a_5=a_4-%shape_ratio%*%delta_size%
set /a a_6=a_5-%shape_ratio%*%delta_size%

set /a b_2=b-%delta_size%
set /a b_3=b_2-%delta_size%
set /a b_4=b_3-%delta_size%
set /a b_5=b_4-%delta_size%
set /a b_6=b_5-%delta_size%
if "%place%"==process_plus (set /p name=<Symbol\jump.fxl)
if "%address%"=="button" (set address=%name%-BUTTON)
::Plugins\Img Pictures\old_FluenceDesign_Pics\BUTTON_Mask.png?%a1%,%b1%,%a%,%b%    
::Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_3%,%b1_3%,%a_3%,%b_3%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_4%,%b1_4%,%a_4%,%b_4%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_5%,%b1_5%,%a_5%,%b_5%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_6%,%b1_6%,%a_6%,%b_6%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_5%,%b1_5%,%a_5%,%b_5%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_4%,%b1_4%,%a_4%,%b_4%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_3%,%b1_3%,%a_3%,%b_3%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_2%,%b1_2%,%a_2%,%b_2%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1%,%b1%,%a%,%b%
set QE_Pushed_Button2_DELTA=3
goto :eof

:QE_Pushed_Button3
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Pushed_Button3ģ��>>RunningData.log
::--------------------------------------
::ģ��ʹ��˵��
::a,b (ͼƬ��С��a,b)
::a1,b1 (ͼƬλ�ã�a1,b1)
::name (������Pictures\old_FluenceDesign_Pics�е�ͼ���ļ�)
::place (process_plus/��)
::address (button/��)
::--------------------------------------
::λ��
set delta=%QE_Pushed_Button3_DELTA%
set /a delta_size=2*%delta%

set /a a1_2=a1-%delta%
set /a a1_3=a1_2-%delta%
set /a a1_4=a1_3-%delta%
set /a a1_5=a1_4-%delta%
set /a a1_6=a1_5-%delta%

set /a b1_2=b1-%delta%
set /a b1_3=b1_2-%delta%
set /a b1_4=b1_3-%delta%
set /a b1_5=b1_4-%delta%
set /a b1_6=b1_5-%delta%
::��С
set /a a_2=a+%delta_size%
set /a a_3=a_2+%delta_size%
set /a a_4=a_3+%delta_size%
set /a a_5=a_4+%delta_size%
set /a a_6=a_5+%delta_size%

set /a b_2=b+%delta_size%
set /a b_3=b_2+%delta_size%
set /a b_4=b_3+%delta_size%
set /a b_5=b_4+%delta_size%
set /a b_6=b_5+%delta_size%
if "%place%"==process_plus (set /p name=<Symbol\jump.fxl)
if "%address%"=="button" (set address=%name%-BUTTON)
::Plugins\Img Pictures\11.png?%a1%,%b1%,%a%,%b%           
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_2%,%b1_2%,%a_2%,%b_2%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_3%,%b1_3%,%a_3%,%b_3%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_4%,%b1_4%,%a_4%,%b_4%
Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_5%,%b1_5%,%a_5%,%b_5%
::Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_6%,%b1_6%,%a_6%,%b_6%
set QE_Pushed_Button3_DELTA=3
goto :eof

::��ģ�鸺���������˵��ɰ涯��
:QE_menu_mask
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����QE_menu_maskģ��>>RunningData.log
if exist "Motionoff.fxl" goto QE_menu_mask-leave
Plugins\Img Pictures\mengban.png?0,0,800,600
Plugins\Img Pictures\mengban.png?0,0,800,600
Plugins\Img Pictures\mengban.png?0,0,800,600
Plugins\Img Pictures\mengban.png?0,0,800,600
if "%MultiProcess_ButtFunc%"=="MultiProcess" (Plugins\Img Pictures\mengban2.png?0,0,800,600)
if "%MultiProcess_ButtFunc%"=="MultiProcess_MiniWindow" (Plugins\Img Pictures\mengban2.png?0,0,800,600)
::Plugins\Img Pictures\menu_mask.gif?0,0,800,600,0,50
goto :eof

:QE_menu_mask-leave
Plugins\Img Pictures\mengban.png?0,0,800,600
Plugins\Img Pictures\mengban.png?0,0,800,600
Plugins\Img Pictures\mengban.png?0,0,800,600
Plugins\Img Pictures\mengban.png?0,0,800,600
if "%MultiProcess_ButtFunc%"=="MultiProcess" (Plugins\Img Pictures\mengban2.png?0,0,800,600)
if "%MultiProcess_ButtFunc%"=="MultiProcess_MiniWindow" (Plugins\Img Pictures\mengban2.png?0,0,800,600)
goto :eof

:QE_MultiProcess
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_MultiProcessģ��>>RunningData.log
::if exist "Symbol\Motionoff_Internal_bus.fxl" (del Symbol\Motionoff_Internal_bus.fxl>nul 2>nul&goto :eof)
::Time
call :HFunc_ADModeTimeCheck
set /p fps=<Symbol\fps.data
set /a fps=%fps%-2
::QyulEngine_V1.0.7	 
::----------------------------------------------------------
::���Ի�Ԥ������
set address=Pictures
::��ͼǿ��
::Plugins\Img Pictures\!name!.png?%a1%,%b1%,%a%,%b%

::������λ�ÿ�ʼ
::set /a a=%a_5%
::set /a b=%b_5%
::set /a a1=%a1_5%
::set /a b1=%b1_5%

::��һ��λ�úʹ�С��ʼ
set /a flag=%a%+%a1%
if "%MultiProcess_Code%"=="first" (
	::echo.%flag%&pause
    if "%flag%" gtr "400" (set /a a1=400-%a%)
	set x1=0
	set y1=0
	set x=400
	set y=595
	)
if "%MultiProcess_Code%"=="second" (
    if "%a1%" LSS "400" (set a1=400)
	set x1=400
	set y1=0
	set x=400
	set y=595
	)
::----------------------------------------------------------
::ִ���ж�
if exist "Motionoff.fxl" goto MainInterface_leaveWithoutDe
set symbol=?
SETLOCAL ENABLEDELAYEDEXPANSION
::----------------------------------------------------------
::Ԥ����
set ct1=1&set ct2=1&set ct3=500
set rounder=0
set /a rounder_judge=!fps!/2
set /a rounder_judge2=!fps!/3

set /a xzhou=(!x!-!a!)/!fps!
set /a yzhou=(!y!-!b!)/!fps!
set /a xzhou1=(!a1!-!x1!)/!fps!
set /a yzhou1=(!b1!-!y1!)/!fps!
::����������
set /a temp1=!a1!-!fps!
set /a temp2=!b1!-!fps!  
if !temp1! LEQ 0 (set xzhou1=1)
if !temp2! LEQ 0 (set yzhou1=1)

::ѭ����ͼ
for /l %%i in (!ct1! !ct2! !ct3!) do (
   set /a var_x=%%i*!xzhou!
   set /a var_y=%%i*!yzhou!
   set /a size_x=%%i*!xzhou1!
   set /a size_y=%%i*!yzhou1!
   ::��̬ͼƬ��С��ԭ��С+�ۼ�������
   set /a mov_sizeX=!a!+!var_x!
   set /a mov_sizeY=!b!+!var_y!
   ::��̬ͼƬλ�ã�ԭλ��+�ۼ�������
   set /a mov_posiX=!a1!-!size_x!
   set /a mov_posiY=!b1!-!size_y!
   if !mov_posiX! leq 0 set mov_posiX=0
   if !mov_posiY! leq 0 set mov_posiY=0
   
   if !rounder! gtr !rounder_judge! (set rounder_name=1&set symbol=?) else (set rounder_name=&set symbol=?&set address=Pictures)
   if !rounder! lss !rounder_judge2! (set rounder_name=-BUTTON&set symbol=?&set address=Pictures\old_FluenceDesign_Pics)
   Plugins\Img !address!\!name!!rounder_name!.png!symbol!!mov_posiX!,!mov_posiY!,!mov_sizeX!,!mov_sizeY!
   if exist "Symbol\developer_mode-overlay.fxl" (cls&echo.Plugins\Img !address!\!name!!rounder_name!.png!symbol!!mov_posiX!,!mov_posiY!,!mov_sizeX!,!mov_sizeY!  !rounder!    !rounder_judge!     !rounder_judge2!&pause)
   set /a rounder=!rounder!+1
   if "%%i" == "!fps!" (
   Plugins\Img Pictures\!name!1.png:!x1!,!y1!,!x!,!y!
   goto :eof)
)

:QE_MultiProcess_lite
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Linear_Motion_liteģ��>>RunningData.log
::Time
call :HFunc_ADModeTimeCheck

if "%MultiProcess_Code%"=="first" (
	::echo.%flag%&pause
    if "%flag%" gtr "400" (set /a a1=400-%a%)
	set x1=0
	set y1=0
	set x=400
	set y=595
	)
if "%MultiProcess_Code%"=="second" (
    if "%a1%" LSS "400" (set a1=400)
	set x1=400
	set y1=0
	set x=400
	set y=595
	)

set a1=%x1%
set b1=%y1%
if "%x%"=="" (set a=%CanvasSize_X%) else (set a=%x%)
if "%y%"=="" (set a=%CanvasSize_Y%) else (set b=%y%)

set modulenametmp=%name%
set LeaveSymbol=
set name=%name%1
set address=Pictures


if exist "Symbol\developer_mode-overlay.fxl" echo.%name%%a1%,%b1%,%a%,%b%
::if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\15pc-black.png?%a1%,%b1%,%a%,%b%) else (Plugins\Img Pictures\22.png?%a1%,%b1%,%a%,%b%)

::λ��
set /a delta=3
set /a delta_size=2*%delta%

set /a a1_2=a1+%delta%
set /a a1_3=a1_2+%delta%
set /a a1_4=a1_3+%delta%
set /a a1_5=a1_4+%delta%

set /a b1_2=b1+%delta%
set /a b1_3=b1_2+%delta%
set /a b1_4=b1_3+%delta%
set /a b1_5=b1_4+%delta%
::��С
set /a a_2=a-%delta_size%
set /a a_3=a_2-%delta_size%
set /a a_4=a_3-%delta_size%
set /a a_5=a_4-%delta_size%

set /a b_2=b-%delta_size%
set /a b_3=b_2-%delta_size%
set /a b_4=b_3-%delta_size%
set /a b_5=b_4-%delta_size%

if exist "Motionoff.fxl" (
    Plugins\Img %address%\%name%.png:%a1%,%b1%,%a%,%b%) else (
    Plugins\Img %address%\%name%.png:%a1_5%,%b1_5%,%a_5%,%b_5%
    Plugins\Img %address%\%name%.png?%a1_4%,%b1_4%,%a_4%,%b_4%
    Plugins\Img %address%\%name%.png?%a1_3%,%b1_3%,%a_3%,%b_3%
    Plugins\Img %address%\%name%.png?%a1_2%,%b1_2%,%a_2%,%b_2%
    Plugins\Img %address%\%name%.png?%a1%,%b1%,%a%,%b%)
set symbol=   
set name=%modulenametmp%
goto :eof

:QE_Linear_Motion
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Linear_Motionģ��>>RunningData.log
::Time
call :HFunc_ADModeTimeCheck
::QyulEngine_V1.0.7	 
::----------------------------------------------------------
::���Ի�Ԥ������
set address=Pictures
::��ͼǿ��
::Plugins\Img Pictures\!name!.png?%a1%,%b1%,%a%,%b%

::������λ�ÿ�ʼ
::set /a a=%a_5%
::set /a b=%b_5%
::set /a a1=%a1_5%
::set /a b1=%b1_5%

::��һ��λ�úʹ�С��ʼ
::set /a a=400&set /a b=300
::set /a a1=a1*2/3&set /a b1=b1*2/3
::----------------------------------------------------------
::ִ���ж�
if exist "Motionoff.fxl" goto MainInterface_leaveWithoutDe
if exist "High_resolution.resche" (
    set /a a=2*a&set /a b=2*b
    set /a a1=2*a1&set /a b1=2*b1
    set x=1594&set y=1200
    set /a x1=2*x1&set /a y1=2*y1
    set symbol=:
)
if exist "Low_resolution.resche" (
    set symbol=?
)
SETLOCAL ENABLEDELAYEDEXPANSION
::----------------------------------------------------------
::Ԥ����
set ct1=1&set ct2=1&set ct3=500
set rounder=0
set /a rounder_judge=!fps!/2
set /a rounder_judge2=!fps!/3

set /a xzhou=(!x!-!a!)/!fps!
set /a yzhou=(!y!-!b!)/!fps!
set /a xzhou1=(!a1!-!x1!)/!fps!
set /a yzhou1=(!b1!-!y1!)/!fps!
::����������
set /a temp1=!a1!-!fps!
set /a temp2=!b1!-!fps!  
if !temp1! LEQ 0 (set xzhou1=1)
if !temp2! LEQ 0 (set yzhou1=1)
::ѭ����ͼ
::Plugins\Img Pictures\!name!.png!symbol!%a1%,%b1%,%a%,%b%
for /l %%i in (!ct1! !ct2! !ct3!) do (
   set /a var_x=%%i*!xzhou!
   set /a var_y=%%i*!yzhou!
   set /a size_x=%%i*!xzhou1!
   set /a size_y=%%i*!yzhou1!
   ::��̬ͼƬ��С��ԭ��С+�ۼ�������
   set /a mov_sizeX=!a!+!var_x!
   set /a mov_sizeY=!b!+!var_y!
   ::��̬ͼƬλ�ã�ԭλ��+�ۼ�������
   set /a mov_posiX=!a1!-!size_x!
   set /a mov_posiY=!b1!-!size_y!
   if !mov_posiX! leq 0 set mov_posiX=0
   if !mov_posiY! leq 0 set mov_posiY=0
   
   if !rounder! gtr !rounder_judge! (set rounder_name=1&set symbol=?) else (set rounder_name=&set symbol=?&set address=Pictures)
   ::if !rounder! lss !rounder_judge2! (set rounder_name=-BUTTON&set symbol=?&set address=Pictures\old_FluenceDesign_Pics)
   Plugins\Img !address!\!name!!rounder_name!.png!symbol!!mov_posiX!,!mov_posiY!,!mov_sizeX!,!mov_sizeY!
   if exist "Symbol\developer_mode-overlay.fxl" (cls&echo.Plugins\Img !address!\!name!!rounder_name!.png!symbol!!mov_posiX!,!mov_posiY!,!mov_sizeX!,!mov_sizeY!  !rounder!    !rounder_judge!     !rounder_judge2!&pause)
   set /a rounder=!rounder!+1
   if "%%i" == "!fps!" goto MainInterface_leaveWithoutDe
)
::----------------------------------------------------------

:QE_Linear_Motion_lite
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Linear_Motion_liteģ��>>RunningData.log
if exist "Motionoff.fxl" goto :eof
::Time
::call :HFunc_ADModeTimeCheck
::QE_Linear_Motion_lite V2.0.0	 
::----------------------------------------------------------
::���Ի�Ԥ������
set /p fps=<Symbol\fps.data
if "%fps%"=="10" (set fps=5)
if "%fps%"=="8" (set fps=5)
if "%fps%"=="6" (set fps=1)
set Init_Posi=15
set range=75
if exist "Symbol\mini.fxl" (set CanvasSize_X=521&set CanvasSize_Y=594) else (set CanvasSize_X=800&set CanvasSize_Y=594)
::----------------------------------------------------------
::Ԥ����
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
::Ԥ����
set rounder=0
set /a xzhou=(!x!-!a!)/!fps!
set /a yzhou=(!y!-!b!)/!fps!
set /a xzhou1=(!a1!-!x1!)/!fps!
set /a yzhou1=(!b1!-!y1!)/!fps!
::----------------------------------------------------------
::ѭ����ͼ
SETLOCAL ENABLEDELAYEDEXPANSION
for /l %%i in (1 1 !fps!) do (
   set /a var_x=%%i*!xzhou!
   set /a var_y=%%i*!yzhou!
   set /a size_x=%%i*!xzhou1!
   set /a size_y=%%i*!yzhou1!
   ::��̬ͼƬ��С��ԭ��С+�ۼ�������
   set /a mov_sizeX=!a!+!var_x!
   set /a mov_sizeY=!b!+!var_y!
   ::��̬ͼƬλ�ã�ԭλ��+�ۼ�������
   set /a mov_posiX=!a1!-!size_x!
   set /a mov_posiY=!b1!-!size_y!
   if !mov_posiX! leq 0 set mov_posiX=0
   if !mov_posiY! leq 0 set mov_posiY=0
   if !rounder!==0 (set symbol=:) else (set symbol=?)
   Plugins\Img Pictures\!name!1.png!symbol!!mov_posiX!,!mov_posiY!,!mov_sizeX!,!mov_sizeY!
   set /a rounder=!rounder!+1
)
goto :eof

:QE_dark_Mask
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����QE_darklight_Maskģ��>>RunningData.log
::if exist "Symbol\mini.fxl" (set x1=0) else set x1=260
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
goto :eof

:QE_darklight_Mask
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����QE_darklight_Maskģ��>>RunningData.log
::if exist "Symbol\mini.fxl" (set x1=0) else set x1=260
if exist "Symbol\DarkMode.fxl" (
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600) else (
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600)
goto :eof

:QE_ModuleReload
if exist "Symbol\mini.fxl" (set x1=0) else (set x1=260)
set y1=0
set BackgroundColor=%ModuleName%
echo.1>Symbol\Motionoff_Internal_bus.fxl
call :HFunc_Reload_color
if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\%ModuleName%-sidebar.png?0,0,259,700)
goto :eof

:QE_FloatMotion
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Pushed_Button2ģ��>>RunningData.log
::--------------------------------------
::ģ��ʹ��˵��
::a,b (ͼƬ��С��a,b)
::a1,b1 (ͼƬλ�ã�a1,b1)
::name (������Pictures\old_FluenceDesign_Pics�е�ͼ���ļ�)
::place (process_plus/��)
::address (button/��)
::--------------------------------------
::λ��
set /a shape_ratio=%a%/%b%
::echo.%shape_ratio%
set /a delta_size=2*%QE_Pushed_Button2_DELTA%

set /a a1_2=a1+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_3=a1_2+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_4=a1_3+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_5=a1_4+%shape_ratio%*%QE_Pushed_Button2_DELTA%
set /a a1_6=a1_5+%shape_ratio%*%QE_Pushed_Button2_DELTA%

set /a b1_2=b1+%QE_Pushed_Button2_DELTA%
set /a b1_3=b1_2+%QE_Pushed_Button2_DELTA%
set /a b1_4=b1_3+%QE_Pushed_Button2_DELTA%
set /a b1_5=b1_4+%QE_Pushed_Button2_DELTA%
set /a b1_6=b1_5+%QE_Pushed_Button2_DELTA%
::��С
set /a a_2=a-%shape_ratio%*%delta_size%
set /a a_3=a_2-%shape_ratio%*%delta_size%
set /a a_4=a_3-%shape_ratio%*%delta_size%
set /a a_5=a_4-%shape_ratio%*%delta_size%
set /a a_6=a_5-%shape_ratio%*%delta_size%

set /a b_2=b-%delta_size%
set /a b_3=b_2-%delta_size%
set /a b_4=b_3-%delta_size%
set /a b_5=b_4-%delta_size%
set /a b_6=b_5-%delta_size%

::Plugins\Img Pictures\11.png?%a1%,%b1%,%a%,%b%    
::Plugins\Img Pictures\old_FluenceDesign_Pics\%name%-BUTTON.png?%a1_3%,%b1_3%,%a_3%,%b_3%
Plugins\Img Pictures\old_FluenceDesign_Pics\%IconName%.png?%a1_4%,%b1_4%,%a_4%,%b_4%
Plugins\Img Pictures\old_FluenceDesign_Pics\%IconName%.png?%a1_5%,%b1_5%,%a_5%,%b_5%
Plugins\Img Pictures\old_FluenceDesign_Pics\%IconName%.png?%a1_4%,%b1_4%,%a_4%,%b_4%
Plugins\Img Pictures\old_FluenceDesign_Pics\%IconName%.png?%a1_3%,%b1_3%,%a_3%,%b_3%
Plugins\Img Pictures\old_FluenceDesign_Pics\%IconName%.png?%a1_2%,%b1_2%,%a_2%,%b_2%
Plugins\Img Pictures\old_FluenceDesign_Pics\%IconName%.png?%a1%,%b1%,%a%,%b%
set QE_Pushed_Button2_DELTA=3
goto :eof

:QE_Load_Maininterface
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����QE_Load_Maininterfaceģ��>>RunningData.log
::WindowSize
if exist "Symbol\mini.fxl" (set WindowSize=mini) else (set WindowSize=normal)
if "%WindowSize%" NEQ "%WindowSize_Temp%" (
    if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
)

::Time
call :HFunc_ADModeTimeCheck
::position
if exist "Symbol\mini.fxl" (set position=-140) else (set position=0)
::settings
set background=background
set address=Skin\SkinPackage
    if exist "Skin\SkinPackage\dark.fxl" (
        if exist "Symbol\DarkMode.fxl" (set background=background-dark))
::background
Plugins\Img %address%\%background%.png:%position%,0,800,594
::darkmode
if exist "Symbol\DarkMode.fxl" (
    if exist "symbol\dark_background.fxl" (
	if not exist "Skin\SkinPackage\dark.fxl" (Plugins\Img Pictures\11.png?0,0,800,594)
	)
) 

if "%QE_Load_Maininterface_Selection%"=="OnlyBG0" (set QE_Load_Maininterface_Selection=&goto :eof)

::pennel
if exist "Symbol\DarkMode.fxl" (
    if exist "Symbol\mini.fxl" (
	    Plugins\Img Pictures\maint_pannel-dark-mini.png?0,0,800,600) else (
        Plugins\Img Pictures\maint_pannel-dark.png?0,0,800,600)) else (
    if exist "Symbol\mini.fxl" (
	    Plugins\Img Pictures\maint_pannel-mini.png?0,0,800,600) else (
        Plugins\Img Pictures\maint_pannel.png?0,0,800,600
	)
)

::selection
if "%QE_Load_Maininterface_Selection%"=="OnlyBG" (set QE_Load_Maininterface_Selection=&goto :eof)

::motion
if not exist "Motionoff.tmp" (
    if not exist "Motionoff.fxl" (
        Plugins\Img Pictures\main.png?0,0,800,600
        Plugins\Img Pictures\main.png?0,0,800,600
        Plugins\Img Pictures\main.png?0,0,800,600
        Plugins\Img Pictures\main.png?0,0,800,600
	)
)
::motion
if exist "Symbol\mini.fxl" (set modelname=maint-mini) else (set modelname=maint)
Plugins\Img Pictures\%modelname%.png?0,0,800,600
if "%WaterMark%"=="True" (Plugins\Img Pictures\watermark.png?0,0,800,592)

::Preload
if exist "Symbol\linear_motion.fxl" (set HARE_EngineLaunch_ProcessWaitOpt=False&call :HARE_EngineLaunch)
goto :eof

:QE_QuickControl_loads
if exist "Symbol\DarkMode.fxl" (set colour=purple2) else (set colour=purple)
	if exist "Symbol\DarkMode.fxl" (
    Plugins\Img Pictures\15pc-black.png?0,0,800,592
	Plugins\Img Pictures\15pc-black.png?0,0,800,592
	Plugins\Img Pictures\Colour\%colour%.png:-60,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-20,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-12,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-6,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-2,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-1,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:0,0,260,600) else (
    Plugins\Img Pictures\15pc-black.png?0,0,800,592
	Plugins\Img Pictures\15pc-black.png?0,0,800,592
	Plugins\Img Pictures\Colour\%colour%.png:-60,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-20,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-12,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-6,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-2,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:-1,0,260,600
	Plugins\Img Pictures\Colour\%colour%.png:0,0,260,600)
goto :eof



:HARE_EngineLaunch
echo.%date%%time%-%name%����HARE_EngineLaunchģ��>>��־��¼.log
::if exist "Symbol\developer_mod1e-overlay.fxl" (start StartHARE.bat) else (start HAREngine.vbs)
if "%HARE_EngineLaunch_ProcessWaitOpt%"=="False" (start HAREngine.vbs&set HARE_EngineLaunch_ProcessWaitOpt=True&goto :eof)
call HAREngine.vbs
set HARE_EngineLaunch_ProcessWaitOpt=True
goto :eof


:HARE_ThirdMenuMask
echo.%date%%time%-%name%����HARE_ThirdMenuMaskģ��>>��־��¼.log
set HARE_a1=0&set HARE_b1=0&set HARE_a=800&set HARE_b=592
::λ��
set /a delta=2
set /a delta_size=2*%delta%

set /a HARE_a1_2=HARE_a1+%delta%
set /a HARE_a1_3=HARE_a1_2+%delta%
set /a HARE_a1_4=HARE_a1_3+%delta%
set /a HARE_a1_5=HARE_a1_4+%delta%

set /a HARE_b1_2=HARE_b1+%delta%
set /a HARE_b1_3=HARE_b1_2+%delta%
set /a HARE_b1_4=HARE_b1_3+%delta%
set /a HARE_b1_5=HARE_b1_4+%delta%
::��С
set /a HARE_a_2=HARE_a-%delta_size%
set /a HARE_a_3=HARE_a_2-%delta_size%
set /a HARE_a_4=HARE_a_3-%delta_size%
set /a HARE_a_5=HARE_a_4-%delta_size%

set /a HARE_b_2=HARE_b-%delta_size%
set /a HARE_b_3=HARE_b_2-%delta_size%
set /a HARE_b_4=HARE_b_3-%delta_size%
set /a HARE_b_5=HARE_b_4-%delta_size%
if exist "Motionoff.fxl" (goto :eof) else (
    if exist "HAREngine\TempPics\PicAfterProcessed.png" (
        Plugins\Img HAREngine\TempPics\PicAfterProcessed.png?%HARE_a1%,%HARE_b1%,%HARE_a%,%HARE_b%
        Plugins\Img HAREngine\TempPics\PicAfterProcessed.png?%HARE_a1_2%,%HARE_b1_2%,%HARE_a_2%,%HARE_b_2%
    	Plugins\Img HAREngine\TempPics\PicAfterProcessed.png?%HARE_a1_3%,%HARE_b1_3%,%HARE_a_3%,%HARE_b_3%
    	Plugins\Img HAREngine\TempPics\PicAfterProcessed.png?%HARE_a1_4%,%HARE_b1_4%,%HARE_a_4%,%HARE_b_4%
    	Plugins\Img HAREngine\TempPics\PicAfterProcessed.png?%HARE_a1_5%,%HARE_b1_5%,%HARE_a_5%,%HARE_b_5%)
    )  
goto :eof

:HARE_OriginSurface
Plugins\Img HAREngine\TempPics\PicBeforeProcessed.png?0,0,800,592
goto :eof

:HFunc_WindowResize
if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)

goto :eof

:HFunc_MouseClick
Plugins\curs /crv 0
plugins\pmos /K -1:50000
set /a "x=%errorlevel%/10000,y=%errorlevel%%%10000"
goto :eof

:HFunc_Plugins
setlocal enabledelayedexpansion
set "inputFile=Symbol\register.data"
set "pluginsFolder=C:\Plugins"
set count=0
if not exist "%inputFile%" (echo.���ļ�)
::��ȡ
for /f "tokens=*" %%a in (%inputFile%) do (
    set /a count+=1
    set "folderName[!count!]=%%a"
)
::���
for /l %%i in (1,1,!count!) do (
    echo Folder name %%i: !folderName[%%i]!
	set PluginsLocate%%i=!folderName[%%i]!
)
echo.%PluginsLocate1%
echo.%PluginsLocate2%
goto :eof

:HFunc_Search
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-%name%����HFunc_Searchģ��>>RunningData.log
set "message=�������ܡ��ļ�����ҳ���ݣ�"
set "title=����"
set "note="
set "speak="
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

if "%speak%"=="" (goto :eof)
if "%speak%"=="����" (start www.weather.com)
if "%speak%"=="����" (start www.cctv.com)
if "%speak%"=="����" (
    set name=settings
	set HUOCHAI_JumpCode=settings
	::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set speak=
	goto MainInterface_leaveDe
	)
if "%speak%"=="����" (
    set speak=
    call plugins\Elect_Assistant\Dict.bat
    if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
    goto MainInterface_WithDe
)
start https://www.baidu.com/s?wd=%speak%

set speak=
goto :eof

:HFunc_DefConfig
::Ĭ�����ò�������
::---------------
set HUOCHAI_Version_1=5
set HUOCHAI_Version_2=3
set HUOCHAI_UpdateDate=240912
set amon=
set name=0
set fps=9
set CanvasSize_X=800
set CanvasSize_Y=592
set secon_symbol=:
set MultiWindow_Count=0
SET QE_secondary_menu_DELTA=1
set QE_Pushed_Button_DELTA=3
set QE_Pushed_Button2_DELTA=3
set QE_Pushed_Button3_DELTA=3
set MainInterface_ButtonMotion=QE_Pushed_Button2
set WaterMark=False
set SynWindows_active=False
set PreLoad=False
::---------------
goto :eof

:HFunc_SynWindows
title StuManager-������
::�����������־�ļ�
::-----------------------------------
setlocal enabledelayedexpansion
for %%f in (*.tmpdual) do (
    rem ��ȡ�ļ���
    set "filename=%%~nf"
    rem ����ļ���ǰ׺
	set HUOCHAI_JumpCode=!filename!
	set SynWindows_active=True
)
del *.tmpdual>nul 2>nul
::-----------------------------------
set position=0
if exist "Symbol\mini.fxl" (set /a position=%position%-135)
if exist "Symbol\DarkMode.fxl" (Plugins\img pictures\store-dark.png?%position%,0,800,600) else Plugins\img pictures\store.png?%position%,0,800,600
set position=385
if exist "Symbol\mini.fxl" (set /a position=%position%-135)
call :HFunc_TimeDelay
::Plugins\img Pictures\5.gif?%position%,380,30,30,1,4
call :QE_darklight_Mask

if "%HUOCHAI_JumpCode%"=="clean" (
    set HUOCHAI_JumpCode=clean
    ::ԭͼƬ��С
    set a=199&set b=199
    ::ԭͼƬλ��
    set a1=32&set b1=54
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
    set name=clean
    set duty=main
    ::call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveWithoutDe
)

if "%HUOCHAI_JumpCode%"=="edit" (
    set HUOCHAI_JumpCode=edit
    ::ԭͼƬ��С
    set a=199
    set b=199
    ::ԭͼƬλ��
    set a1=242
    set b1=54
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    set name=edit
    set duty=main
    ::call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveWithoutDe)

if "%HUOCHAI_JumpCode%"=="safe" (
    set HUOCHAI_JumpCode=safe
    ::ԭͼƬ��С
    set a=199
    set b=199
    ::ԭͼƬλ��
    set a1=32
    set b1=264
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    set name=safe
    set duty=main
    ::call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveWithoutDe)

if "%HUOCHAI_JumpCode%"=="settings" (
    set HUOCHAI_JumpCode=settings
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=241
    set b1=264
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set name=settings
    set duty=main
    ::call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveWithoutDe)
	
if "%HUOCHAI_JumpCode%"=="tools" (
    set HUOCHAI_JumpCode=tools
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=242
    set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    echo.tools>Symbol\jump.fxl
    set duty=main
	set name=tools
    ::call :%MainInterface_ButtonMotion%
    set name=safe
    goto MainInterface_leaveWithoutDe)
	
if "%HUOCHAI_JumpCode%"=="myclean" (
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=347
    set b1=264
	if exist "Symbol\DarkMode.fxl" (set name=myclean) else (set name=myclean)
    ::call :%MainInterface_ButtonMotion%
    goto myclean
)

if "%HUOCHAI_JumpCode%"=="elect" (
    set HUOCHAI_JumpCode=elect
    ::ԭͼƬ��С
    set a=94&set b=94
    ::ԭͼƬλ��
    set a1=347&set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
	set name=elect
    ::call :%MainInterface_ButtonMotion%
    set name=edit
    goto MainInterface_leaveJump
)
	
if "%HUOCHAI_JumpCode%"=="Search" (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	::set QE_Pushed_Button2_DELTA=1
    ::call :QE_Pushed_Button2
    goto Search
)
if "%HUOCHAI_JumpCode%"=="Mainelse" (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	::set QE_Pushed_Button2_DELTA=1
    ::call :QE_Pushed_Button2
    goto Mainelse
)

if "%HUOCHAI_JumpCode%"=="message_more" (
    ::abԭʼ��С | a1b1ԭʼλ�� | xy���մ�С | x1y1����λ��
    set a=181&set b=43&set a1=461&set b1=339
    set x=800&set y=592&set x1=0&set y1=0
	::��ť
	::if exist "Symbol\DarkMode.fxl" (set name=msg-more) else (set name=msg-more)
	::set QE_Pushed_Button2_DELTA=1
    ::call :QE_Pushed_Button2
	::��ת
    set name=settings
	set HUOCHAI_JumpCode=message_more
    goto MainInterface_leaveDe
)
set duty=1
goto :eof

:HFunc_Reload_color
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����HFunc_Reload_colorģ��>>RunningData.log
::Time
call :HFunc_ADModeTimeCheck
if exist "Symbol\developer_mode-overlay.fxl" echo.%name%,%x1%,%y1%
if exist "Symbol\mini.fxl" (set x1=0) else set x1=260
set y1=0
if exist "Symbol\developer_mode-overlay.fxl" echo.%name%,%x1%,%y1%
if exist "Symbol\DarkMode.fxl" (
Plugins\Img Pictures\%BackgroundColor%1.png:0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600) else (
Plugins\Img Pictures\%BackgroundColor%1.png:0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600)
::if "%ReloadColor_Sidebar%"=="True" (
::::echo.%duty%,%BackgroundColor%
::    if "%duty%"=="bar" (
::	    Plugins\Img Pictures\%BackgroundColor%-sidebar.png?260,0,259,700&set duty=
::	)
::	set ReloadColor_Sidebar=False
::)
goto :eof

:HFunc_TimeDelay
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����HFunc_TimeDelayģ��>>RunningData.log
Plugins\Img Pictures\5.gif?800,600,2,2,1,5
goto :eof

:HFunc_TimeCheck
set Hour=%time:~0,2%
if %Hour% geq 0 (
    if %Hour% lss 7 (
        set Time_Horizon=night))
if %Hour% geq 7 (
    if %Hour% lss 19 (
        set Time_Horizon=morning))
::if %Hour% geq 12 (
::    if %Hour% lss 17 (
::        set Time_Horizon=afternoon))
::if %Hour% geq 16 (
::    if %Hour% lss 19 (
::        set Time_Horizon=dawn))
if %Hour% geq 19 (
    if %Hour% lss 24 (
        set Time_Horizon=night)
	)
goto :eof

:HFunc_ADModeTimeCheck
if not exist "symbol\Auto_DarkMode.fxl" (goto :eof)
call :HFunc_TimeCheck
if ��%Time_Horizon%��==��morning�� (
    if exist "Symbol\DarkMode.fxl" (del Symbol\DarkMode.fxl>nul 2>nul)
)
if ��%Time_Horizon%��==��night�� (
    if not exist "Symbol\DarkMode.fxl" (echo.night>Symbol\DarkMode.fxl)
)
goto :eof

:HFunc_Reset
::--------------------------------------
::Module Version��HFunc_Reset2.1.0.3
::UpdateDate:2024-8-24
::--------------------------------------
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����HFunc_Resetģ��>>RunningData.log
::delete
if exist "Symbol\DarkMode.fxl" (del Symbol\DarkMode.fxl)
del Symbol\developer_mode.fxl>nul 2>nul
del Symbol\developer_mode-overlay.fxl>nul 2>nul
del Symbol\linear_motion.fxl>nul 2>nul
del symbol\Auto_DarkMode.fxl>nul 2>nul
del symbol\SynWinQC.fxl>nul 2>nul
del symbol\LogRecoder_OFF.fxl>nul 2>nul
del Symbol\MultiProcessFunc.data>nul 2>nul
del symbol\CrashCounter.data>nul 2>nul
::create
echo.Function>Symbol\MultiProcessFunc.data
echo.1>Symbol\synergism_off.fxl
echo.icon>Symbol\HomeStyle.data
echo.8>Symbol\fps.data
echo.main>Symbol\DiyStartMenu.data
echo.0>symbol\dark_background.fxl
set /p version=<Symbol\version.fxl
if "%version%" LSS "%HUOCHAI_Version%" (echo.%HUOCHAI_Version%>Symbol\version.fxl)
echo.1>Symbol\Motionoff_Internal_bus.fxl
if exist "$key.key" echo.1>Password_auth.fxl

goto :eof

:HFunc_ResetDoc
del student_information.csv>nul 2>nul
del student_information.txt>nul 2>nul
del symbol\register.data>nul 2>nul

:HFunc_NotiCalc
::--------------------------------------
::Module Version��HFunc_NotiCalc2.1.5.0
::UpdateDate:2024-9-11
::explain:ͳ��֪ͨ��Ŀ��д�뱾���ļ���
::--------------------------------------
set msgcount=0
del Symbol\NotificationRec.data>nul 2>nul
::�̶�֪ͨ1-��ʧ���
if exist "Symbol\lostassembly.fxl" (
    set name=lost
    set /a msgcount=%msgcount%+1
	echo.lost>>Symbol\NotificationRec.data
)
::�̶�֪ͨ2-������
set storage=0
for /f "delims=" %%a in ('dir /b *.log') do (set /a "storage+=%%~za/1024")
if %storage% GEQ 5000 (
    set name=log
    set /a msgcount=%msgcount%+1
	echo.log>>Symbol\NotificationRec.data
)
::�̶�֪ͨ3-��ɫģʽ
call :HFunc_TimeCheck
if ��%Time_Horizon%��==��night�� (
    if not exist "Symbol\DarkMode.fxl" (
	    set name=darkmode
		set /a msgcount=%msgcount%+1
		echo.darkmode>>Symbol\NotificationRec.data
		)
)
::�̶�֪ͨ4-����Ա����
if exist "Password_auth.fxl" (
    set name=lock
    set /a msgcount=%msgcount%+1
	echo.lock>>Symbol\NotificationRec.data
)
::�̶�֪ͨ5-�ڲ�
if "%WaterMark%"=="True" (
    set name=inver
    set /a msgcount=%msgcount%+1
	echo.inver>>Symbol\NotificationRec.data
)
::�̶�֪ͨ6-������ģʽ
set checkflag=0
if exist "Symbol\developer_mode.fxl" (set /a checkflag=%checkflag%+1)
if exist "Symbol\developer_mode-overlay.fxl" (set /a checkflag=%checkflag%+1)
if "%checkflag%" NEQ "0" (
    set name=dev
    set /a msgcount=%msgcount%+1
	echo.dev>>Symbol\NotificationRec.data
)
if "%msgcount%" geq "4" (set OverMessage=True) else (set OverMessage=False)
goto :eof


:HFunc_Notification
::--------------------------------------
::Module Version��HFunc_Notification2.1.5.0
::UpdateDate:2024-9-11
::Explain:ѭ����Ȿ��֪ͨ�ļ�����ʾ������
::--------------------------------------
call :HFunc_NotiCalc
setlocal enabledelayedexpansion
set file=Symbol\NotificationRec.data
if "%HFunc_NotiCode%"=="Bar" (
    set max_per_row=1
	set max_notifi_num=3
    if exist "Symbol\mini.fxl" (set x=181) else (set x=461)
    set y=63
	set h_gap=8
    set v_gap=8
    set MessageBox_X=181
    set MessageBox_Y=86
    set MessageBar_X=199
    set MessageBar_Y=408
	)
if "%HFunc_NotiCode%"=="App" (
    set max_per_row=3
	set max_notifi_num=15
    if exist "Symbol\mini.fxl" (set x=210) else (set x=210)
    set y=70
	set h_gap=10
    set v_gap=15
    set MessageBox_X=181
    set MessageBox_Y=86
    set MessageBar_X=199
    set MessageBar_Y=408
	)
set count=0
::set Max_Quantity=auto
::
::if "%Max_Quantity%"=="auto" (set /a Max_Quantity=%MessageBar_Y%/%MessageBox_Y%-1)
::set /a msg_space=%MessageBox_Y%+%space%
if not exist "%file%" (Plugins\Img Pictures\msg-none.png?%x%,90&goto :eof)
for /f "tokens=*" %%a in (%file%) do (
    set /a count+=1
    set "folderName[!count!]=%%a"
)
if "%COUNT%"=="0" (Plugins\Img Pictures\msg-none.png?%x%,90&goto :eof)

set Noti_num=1
set total=!count!
set count=0

:HFunc_Notification_loop
set "folder_name=!folderName[%Noti_num%]!"
set /a row=!count! / !max_per_row!
set /a col=!count! %% !max_per_row!
set /a pos_x=!x! + (!col! * (!MessageBox_X! + !h_gap!))
set /a pos_y=!y! + (!row! * (!MessageBox_Y! + !v_gap!))
set /a pos_x2=!pos_x! + !MessageBox_X!
set /a pos_y2=!pos_y! + !MessageBox_Y!
set click_X1_Button%Noti_num%=!pos_x!
set click_Y1_Button%Noti_num%=!pos_y!
set click_X2_Button%Noti_num%=!pos_x2!
set click_Y2_Button%Noti_num%=!pos_y2!

::ͼ����ʾ����
::-----------------------------------------------
if exist "Symbol\DarkMode.fxl" (
    if exist "Pictures\msg-!folder_name!-dark.png" (set extralogo=-dark) else (set extralogo=)
	)
if exist "Pictures\msg-!folder_name!.png" (Plugins\Img Pictures\msg-!folder_name!%extralogo%.png?!pos_x!,!pos_y!,!MessageBox_X!,!MessageBox_Y!) else (Plugins\Img Pictures\msg-none.png?!pos_x!,!pos_y!,!MessageBox_X!,!MessageBox_Y!)
set /a count+=1
set /a Noti_num+=1
::if %Noti_num% leq %total% (goto HFunc_Notification_loop)
if %total% leq %max_notifi_num% (set totalcount=%total%) else (set totalcount=%max_notifi_num%)
::echo.С�ڵ���3����totalcount%totalcount%,����ѭ����Noti_num%Noti_num%,��֪ͨ��total%total%
if %Noti_num% leq %totalcount% (goto HFunc_Notification_loop) 
if %total% gtr %max_notifi_num% (
    set /a msgmorePosi_Y=!pos_y!+!MessageBox_Y!+!h_gap!
    Plugins\Img Pictures\msg-more.png?!pos_x!,!msgmorePosi_Y!
	)
::-----------------------------------------------	

goto :eof

:HFunc_NotificationBar
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����HFunc_NotificationBarģ��>>RunningData.log
::����֪ͨ������
if exist "Symbol\DarkMode.fxl" (
    if exist "Symbol\mini.fxl" (
	    Plugins\Img Pictures\main-message_bar-dark.png?173,54,0,0) else (
        Plugins\Img Pictures\main-message_bar-dark.png?452,54,0,0)	
) else (
    if exist "Symbol\mini.fxl" (
        Plugins\Img Pictures\main-message_bar.png?173,54,0,0) else (
        Plugins\Img Pictures\main-message_bar.png?452,54,0,0)
)
call :HFunc_Notification
goto :eof


:NotificationBar_mini
::-----------------------------------------------messages--------
::��ΪС������֪ͨ���İ�ť
    ::��ť��С�����˿�
    set button11_sizeX=46
	set button11_sizeY=46
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button11_clickX1=152) else (set button11_clickX1=800)
	if exist "Symbol\mini.fxl" (set button11_clickY1=520) else (set button11_clickY1=600)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button11_clickX1=%button11_clickX1%+400)
)
	::����
    set /a button11_clickX2=%button11_sizeX%+%button11_clickX1%
    set /a button11_clickY2=%button11_sizeY%+%button11_clickY1%
::------------------------------------------messagemore--------
::��Ϊ�����¸���֪ͨ��ť
    ::��ť��С�����˿�
    set button12_sizeX=181
	set button12_sizeY=43
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button12_clickX1=181) else (set button12_clickX1=181)
	if exist "Symbol\mini.fxl" (set button12_clickY1=345) else (set button12_clickY1=345)
	if "%MultiWindow_Exist%"=="1" (
        if "%ModuleName%"=="%jump2%" (set /a button12_clickX1=%button12_clickX1%+400)
)
	::����
    set /a button12_clickX2=%button12_sizeX%+%button12_clickX1%
    set /a button12_clickY2=%button12_sizeY%+%button12_clickY1%
	call :HFunc_NotiCalc
	if "%OverMessage%"=="False" (set button12_clickX1=800&set button12_clickX2=801&set button12_clickY1=600&set button12_clickY2=601)


::֪ͨ��ť���
::---------------------------------------------
setlocal enabledelayedexpansion
call :HFunc_NotiCalc
if not exist "Symbol\NotificationRec.data" (goto NotificationBar_mini_withoutDe)
set file=Symbol\NotificationRec.data

if exist "Symbol\mini.fxl" (set x=181) else (set x=461)
set y=63
set h_gap=8
set v_gap=8
set MessageBox_X=181
set MessageBox_Y=86
set MessageBar_X=199
set MessageBar_Y=408
set max_per_row=1
set count=0
for /f "tokens=*" %%a in (%file%) do (
    set /a count+=1
    set "folderName[!count!]=%%a"
)
set Noti_num=1
set total=!count!
set count=0
:NotificationBar_mini_NotiTemp
set "folder_name=!folderName[%Noti_num%]!"
set /a row=!count! / !max_per_row!
set /a col=!count! %% !max_per_row!
set /a pos_x=!x! + (!col! * (!MessageBox_X! + !h_gap!))
set /a pos_y=!y! + (!row! * (!MessageBox_Y! + !v_gap!))
set /a pos_x2=!pos_x! + !MessageBox_X!
set /a pos_y2=!pos_y! + !MessageBox_Y!
set click_X1_Button%Noti_num%=!pos_x!
set click_Y1_Button%Noti_num%=!pos_y!
set click_X2_Button%Noti_num%=!pos_x2!
set click_Y2_Button%Noti_num%=!pos_y2!
set /a count+=1
set /a Noti_num+=1
if %total% leq 3 (set totalcount=%total%) else (set totalcount=3)
if %Noti_num% leq %totalcount% (goto NotificationBar_mini_NotiTemp) 

call :HFunc_NotiCalc
if "%msgcount%" neq "0" (Plugins\Img Pictures\yellow.png?184,532)

:NotificationBar_mini_withoutDe
call :HFunc_MouseClick

::֪ͨ��ť
if exist "Symbol\NotificationRec.data" (
    for /l %%i in (1,1,%total%) do (
        if %x% geq !click_X1_Button%%i! if %x% leq !click_X2_Button%%i! if %y% geq !click_Y1_Button%%i! if %y% leq !click_Y2_Button%%i! (
    	    Plugins\Img Pictures\msgmask.png?!click_X1_Button%%i!,!click_Y1_Button%%i!,!MessageBox_X!,!MessageBox_Y!
    		call :HFunc_TimeDelay
    	    if !folderName[%%i]!==darkmode (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto surface)
    		if !folderName[%%i]!==dev (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto developer)
    		if !folderName[%%i]!==inver (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto surface)
    		if !folderName[%%i]!==lock (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto schema-key)
    		if !folderName[%%i]!==log (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto schema)
    		if !folderName[%%i]!==lost (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto xiufu)
    	    )
    )
)
if %x% geq 515 if %x% leq 520 if %y% geq 0 if %y% leq 600 (del Symbol\mini.fxl&mode con: cols=100 lines=37&goto MainInterface_withDe)
if %x% geq 152 if %x% leq 197 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Msg-dark) else (set name=Msg)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto MainInterface_withDe
)
if %x% geq 32 if %x% leq 135 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=103&set b=46
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    call :QE_Load_Maininterface&goto MultiProcess_MiniWindow
)
if %x% geq %button12_clickX1% if %x% leq %button12_clickX2% if %y% geq %button12_clickY1% if %y% leq %button12_clickY2% (
    ::abԭʼ��С | a1b1ԭʼλ�� | xy���մ�С | x1y1����λ��
    set a=%button12_sizeX%&set b=%button12_sizeY%&set a1=%button12_clickX1%&set b1=%button12_clickY1%
    set x=800&set y=592&set x1=0&set y1=0
	::��ť
	if exist "Symbol\DarkMode.fxl" (set name=msg-more) else (set name=msg-more)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	::��ת
    set name=settings
	set HUOCHAI_JumpCode=message_more
    goto MainInterface_leaveDe
)
goto NotificationBar_mini


::��ģ�鸺�����QuickControl��
:Quick_Control_Bar
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Quick_Control_Barģ��>>RunningData.log
if exist "Symbol\DarkMode.fxl" (set name1=main_load) else (set name1=main_load)
if exist "Symbol\DarkMode.fxl" (set name2=main_load_active) else (set name2=main_load_active)
if "%SynWindows_active%"=="True" (set name1=%name1%_Syn)
if not exist "Motionoff.fxl" (
    if exist "Symbol\linear_motion.fxl" (call :HARE_ThirdMenuMask) else (call :QE_dark_Mask)
    Plugins\Img Pictures\%name1%.png?0,0,800,585
    Plugins\Img Pictures\%name1%.png?0,0,800,590
    Plugins\Img Pictures\%name1%.png?0,0,800,594
    Plugins\Img Pictures\%name1%.png?0,0,800,597
    Plugins\Img Pictures\%name1%.png?0,0,800,599)
	Plugins\Img Pictures\%name1%.png?0,0,800,600
    Plugins\Img Pictures\%name2%.png?0,0,800,600
set place=process_plus
set flag=0
set MultiWindow_Count=0

:Quick_Control_Bar_Widgets
if "%flag%"=="1" (set jump1=%name%)
if "%flag%"=="2" (set jump2=%name%)
if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=1)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
if exist "Symbol\mini.fxl" (set xx1_2=152&set xx2_2=197) else (set xx1_2=790&set xx2_2=800)
if exist "Symbol\developer_mode-overlay.fxl" echo.flag=%flag% jump1=%jump1% jump2=%jump2%
::��ʾͼƬ
if "%flag%"=="1" (
    ::ԭͼƬ��С
    set a=42&set b=42&set a1=135&set b1=421
	set IconName=%jump1%-TinyIcon
	set QE_Pushed_Button2_DELTA=1
    call :QE_FloatMotion
)
if "%flag%"=="2" (	
    set a=42&set b=42&set a1=191&set b1=421
	set IconName=%jump2%-TinyIcon
	set QE_Pushed_Button2_DELTA=1
    call :QE_FloatMotion
)
if "%flag%"=="2" set flag=0&goto MultiProcess_Jump
if exist "synergism.fxl" (set extention_name=tmpdual) else (set extention_name=tmp)
if "%timess%"=="0" (call :HFunc_TimeDelay)
set timess=1
set QE_secondary_menu_DELTA=1
set QE_MotionStatus=0

:Quick_Control_Bar_WithoutDe


call :HFunc_MouseClick
::�രЭͬ
if %x% geq 200 if %x% leq 218 if %y% geq 182 if %y% leq 200 (echo.1>clean.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto Quick_Control_Bar_WithoutDe)
if %x% geq 200 if %x% leq 218 if %y% geq 222 if %y% leq 240 (echo.1>edit.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto Quick_Control_Bar_WithoutDe)
if %x% geq 200 if %x% leq 218 if %y% geq 262 if %y% leq 280 (echo.1>safe.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto Quick_Control_Bar_WithoutDe)
if %x% geq 200 if %x% leq 218 if %y% geq 302 if %y% leq 320 (echo.1>tools.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto Quick_Control_Bar_WithoutDe)
::���ܷ���
if %x% geq 166 if %x% leq 183 if %y% geq 182 if %y% leq 200 (
    ::ͼƬ��С,λ���趨
    set a=234&set b=52&set a1=13&set b1=416
	::��ת�ж�
	set name=clean
	set /a flag=flag+1
    goto Quick_Control_Bar_Widgets)
if %x% geq 166 if %x% leq 183 if %y% geq 222 if %y% leq 240 (
    ::ͼƬ��С,λ���趨
    set a=234&set b=52&set a1=13&set b1=416
	::��ת�ж�
	set name=edit
	set /a flag=flag+1
    goto Quick_Control_Bar_Widgets)
if %x% geq 166 if %x% leq 183 if %y% geq 262 if %y% leq 280 (
    ::ͼƬ��С,λ���趨
    set a=234&set b=52&set a1=13&set b1=416
	::��ת�ж�
	set name=safe
	set /a flag=flag+1
    goto Quick_Control_Bar_Widgets)
if %x% geq 166 if %x% leq 183 if %y% geq 302 if %y% leq 320 (
    ::ͼƬ��С,λ���趨
    set a=234&set b=52&set a1=13&set b1=416
	::��ת�ж�
	set name=safe
	set HUOCHAI_JumpCode=tools
	set /a flag=flag+1
    goto Quick_Control_Bar_Widgets)
if %x% geq 166 if %x% leq 183 if %y% geq 342 if %y% leq 360 (
    ::ͼƬ��С,λ���趨
    set a=234&set b=52&set a1=13&set b1=416
	::��ת�ж�
	set name=settings
	set HUOCHAI_JumpCode=settings
	set /a flag=flag+1
    goto Quick_Control_Bar_Widgets)
	
::һ������
if %x% geq 29 if %x% leq 230 if %y% geq 131 if %y% leq 168 (
    if "%SynWindows_active%"=="True" (exit)
    goto MainInterface_withDe
)

if %x% geq 29 if %x% leq 230 if %y% geq 171 if %y% leq 209 (
::������������������������������������������������������������������������������������������������������������������������������������
if exist "synergism.fxl" (echo.1>>clean.%extention_name%&start StartProg.exe&call :HFunc_TimeDelay&goto MainInterface_withDe) else (
echo.1>>clean.%extention_name%
set name=clean1.png
set duty=bar
set symbol=head
if not exist "Symbol\mini.fxl" call :QE_secondary_menu
set HUOCHAI_JumpCode=clean)
echo.1>Symbol\QuickControl.fxl
goto MainInterface_leaveJump)

if %x% geq 29 if %x% leq 230 if %y% geq 211 if %y% leq 250 (
::������������������������������������������������������������������������������������������������������������������������������������
if exist "synergism.fxl" (echo.1>>edit.%extention_name%&start StartProg.exe&call :HFunc_TimeDelay&goto MainInterface_withDe) else (
echo.1>>edit.%extention_name%
set nametempedit=True
set name=edit
set duty=bar
set symbol=head
if not exist "Symbol\mini.fxl" call :QE_secondary_menu
set HUOCHAI_JumpCode=edit)
echo.1>Symbol\QuickControl.fxl
goto MainInterface_leaveJump)

if %x% geq 29 if %x% leq 230 if %y% geq 251 if %y% leq 290 (
::������������������������������������������������������������������������������������������������������������������������������������
if exist "synergism.fxl" (echo.1>>safe.%extention_name%&start StartProg.exe&call :HFunc_TimeDelay&goto MainInterface_withDe) else (
echo.1>>safe.%extention_name%
set nametempedit=True
set name=safe
set duty=bar
set symbol=head
if not exist "Symbol\mini.fxl" call :QE_secondary_menu
set HUOCHAI_JumpCode=safe)
echo.1>Symbol\QuickControl.fxl
goto MainInterface_leaveJump)

if %x% geq 29 if %x% leq 230 if %y% geq 332 if %y% leq 371 (
::������������������������������������������������������������������������������������������������������������������������������������
if exist "synergism.fxl" (echo.1>>settings.%extention_name%&start StartProg.exe&call :HFunc_TimeDelay&goto MainInterface_withDe) else (
echo.1>>settings.%extention_name%
set nametempedit=True
set name=settings
set duty=bar
set symbol=head
if not exist "Symbol\mini.fxl" call :QE_secondary_menu
set HUOCHAI_JumpCode=settings)
echo.1>Symbol\QuickControl.fxl
goto MainInterface_leaveJump)

if %x% geq 29 if %x% leq 230 if %y% geq 292 if %y% leq 331 (
::������������������������������������������������������������������������������������������������������������������������������������
if exist "synergism.fxl" (echo.1>>tools.%extention_name%&start StartProg.exe&call :HFunc_TimeDelay&goto MainInterface_withDe) else (
echo.1>>tools.%extention_name%
set nametempedit=True
set name=safe
set duty=bar
set symbol=head
if not exist "Symbol\mini.fxl" call :QE_secondary_menu
set HUOCHAI_JumpCode=tools)
echo.1>Symbol\QuickControl.fxl
goto MainInterface_leaveJump)

if %x% geq 14 if %x% leq 247 if %y% geq 417 if %y% leq 468 (
    if "%flag%"=="0" (
        Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?29,432,69,22
        Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?28,432,69,22
        Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?30,432,69,22
        Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?32,432,69,22
        Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?35,432,69,22
		Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?36,432,69,22
        Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?34,432,69,22
		Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?33,432,69,22
        Plugins\Img Pictures\old_FluenceDesign_Pics\Text1.png?32,432,69,22
    )
)

if %x% geq 13 if %x% leq 247 if %y% geq 478 if %y% leq 530 (
    ::abԭʼ��С | a1b1ԭʼλ�� | xy���մ�С | x1y1����λ��	
    set a=234&set b=52&set a1=13&set b1=478
    set x=800&set y=592&set x1=0&set y1=0
	::��ת
    set name=settings
	set HUOCHAI_JumpCode=message_more
    goto MainInterface_leaveDe
)
goto Quick_Control_Bar_WithoutDe

:MainInterface_withDe
::--------------------------------------
::Module Version��MainInterface5.3.0
::UpdateDate:2023-12-15
::--------------------------------------
::set QE_Load_Maininterface_Selection=OnlyBG0&call :QE_Load_Maininterface
title StuManager
set ModuleName=MainInterface
set WindowSize_Temp=%WindowSize%
set MultiWindow_Exist=0
if exist "Symbol\mini.fxl" (set WindowSize=mini) else (set WindowSize=normal)
if "%WindowSize%" NEQ "%WindowSize_Temp%" (
    if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
)
del *.tmp>nul 2>nul


::��ǰ���ؼ�С�۸��ӳ�
if "%PreLoad%"=="True" (
set background=background
set address=Skin\SkinPackage
    if exist "Skin\SkinPackage\dark.fxl" (
        if exist "Symbol\DarkMode.fxl" (set background=background-dark)
	)
::position
if exist "Symbol\mini.fxl" (set position=-140) else (set position=0)
::background
Plugins\Img %address%\%background%.png:%position%,0,800,594
)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::if "%MultiWindow_Exist%"=="1" (
::    if "%ModuleName%"=="%jump1%" (
::		Plugins\Img Pictures\MultiWinLine_White.png?175,568
::		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?584,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?584,568)
::	)
::    if "%ModuleName%"=="%jump2%" (
::		Plugins\Img Pictures\MultiWinLine_White.png?584,568
::		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?175,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?175,568)
::	)
::)
::
::if "%MultiWindow_Exist%"=="1" (
::    if "%MultiWindow_Count%"=="0" (goto MainInterface_withoutDe)
::)
::if "%MultiWindow_Count%"=="2" (set BarPosition=400) else (set BarPosition=0)
::
::if "%duty%"=="bar" (Plugins\Img Pictures\settings-sidebar.png?260,0,259,700&set duty=&goto MainInterface_withoutDe)

::����������
call :QE_Load_Maininterface
if exist "Symbol\mini.fxl" (
    call :HFunc_NotiCalc
    if "%msgcount%" neq "0" (Plugins\Img Pictures\yellow.png?184,532)
	)
if not exist "Symbol\mini.fxl" (set HFunc_NotiCode=Bar&call :HFunc_NotificationBar)


::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)

::Plugins\Img Pictures\settings-sidebar.png?%BarPosition%,0,259,700
::if "%MultiWindow_Count%"=="1" (set /a MultiWindow_Count+=1&goto :eof)
::if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=0)

::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-MainInterface_withDe>>RunningData.log
:MainInterface_Button
::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------add--------
    ::��ť��С
    set button1_sizeX=199
	set button1_sizeY=199
    ::��ťλ��
    if exist "Symbol\mini.fxl" (set button1_clickX1=32) else (set button1_clickX1=32)
	if exist "Symbol\mini.fxl" (set button1_clickY1=55) else (set button1_clickY1=55)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::-----------------------------------------------edit--------
    ::��ť��С
    set button2_sizeX=199
	set button2_sizeY=199
    ::��ťλ��
    if exist "Symbol\mini.fxl" (set button2_clickX1=242) else (set button2_clickX1=242)
	if exist "Symbol\mini.fxl" (set button2_clickY1=55) else (set button2_clickY1=55)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button2_clickX1=%button2_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::-----------------------------------------------statistic--------
    ::��ť��С
    set button3_sizeX=199
	set button3_sizeY=199
    ::��ťλ��
    if exist "Symbol\mini.fxl" (set button3_clickX1=32) else (set button3_clickX1=32)
	if exist "Symbol\mini.fxl" (set button3_clickY1=264) else (set button3_clickY1=264)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button3_clickX1=%button3_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::-----------------------------------------------settings--------
    ::��ť��С
    set button4_sizeX=94
	set button4_sizeY=94
    ::��ťλ��
    if exist "Symbol\mini.fxl" (set button4_clickX1=242) else (set button4_clickX1=242)
	if exist "Symbol\mini.fxl" (set button4_clickY1=264) else (set button4_clickY1=264)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button4_clickX1=%button4_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
::-----------------------------------------------tools--------
    ::��ť��С�����˿�
    set button5_sizeX=94
	set button5_sizeY=94
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button5_clickX1=242) else (set button5_clickX1=242)
	if exist "Symbol\mini.fxl" (set button5_clickY1=369) else (set button5_clickY1=369)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button5_clickX1=%button5_clickX1%+400)
)
	::����
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%
::-----------------------------------------------myclean--------
    ::��ť��С�����˿�
    set button6_sizeX=94
	set button6_sizeY=94
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button6_clickX1=347) else (set button6_clickX1=347)
	if exist "Symbol\mini.fxl" (set button6_clickY1=264) else (set button6_clickY1=264)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button6_clickX1=%button6_clickX1%+400)
)
	::����
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%
::-----------------------------------------------elect--------
    ::��ť��С�����˿�
    set button7_sizeX=94
	set button7_sizeY=94
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button7_clickX1=347) else (set button7_clickX1=347)
	if exist "Symbol\mini.fxl" (set button7_clickY1=369) else (set button7_clickY1=369)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button7_clickX1=%button7_clickX1%+400)
)
	::����``  
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%
::-----------------------------------------------multi--------
    ::��ť��С�����˿�
    set button8_sizeX=103
	set button8_sizeY=47
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button8_clickX1=32) else (set button8_clickX1=32)
	if exist "Symbol\mini.fxl" (set button8_clickY1=520) else (set button8_clickY1=520)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button8_clickX1=%button8_clickX1%+400)
)
	::����
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%
::-----------------------------------------------search--------
    ::��ť��С�����˿�
    set button9_sizeX=46
	set button9_sizeY=46
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button9_clickX1=800) else (set button9_clickX1=152)
	if exist "Symbol\mini.fxl" (set button9_clickY1=600) else (set button9_clickY1=520)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button9_clickX1=%button9_clickX1%+400)
)
	::����
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%
::-----------------------------------------------plugins--------
    ::��ť��С�����˿�
    set button10_sizeX=46
	set button10_sizeY=46
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button10_clickX1=800) else (set button10_clickX1=215)
	if exist "Symbol\mini.fxl" (set button10_clickY1=600) else (set button10_clickY1=520)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button10_clickX1=%button10_clickX1%+400)
)
	::����
    set /a button10_clickX2=%button10_sizeX%+%button10_clickX1%
    set /a button10_clickY2=%button10_sizeY%+%button10_clickY1%
::-----------------------------------------------messages--------
::��ΪС������֪ͨ���İ�ť
    ::��ť��С�����˿�
    set button11_sizeX=46
	set button11_sizeY=46
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button11_clickX1=152) else (set button11_clickX1=800)
	if exist "Symbol\mini.fxl" (set button11_clickY1=520) else (set button11_clickY1=600)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button11_clickX1=%button11_clickX1%+400)
)
	::����
    set /a button11_clickX2=%button11_sizeX%+%button11_clickX1%
    set /a button11_clickY2=%button11_sizeY%+%button11_clickY1%
::------------------------------------------messagemore--------
::��Ϊ�����¸���֪ͨ��ť
    ::��ť��С�����˿�
    set button12_sizeX=181
	set button12_sizeY=43
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button12_clickX1=800) else (set button12_clickX1=461)
	if exist "Symbol\mini.fxl" (set button12_clickY1=600) else (set button12_clickY1=344)
	if "%MultiWindow_Exist%"=="1" (
        if "%ModuleName%"=="%jump2%" (set /a button12_clickX1=%button12_clickX1%+400)
)
	::����
    set /a button12_clickX2=%button12_sizeX%+%button12_clickX1%
    set /a button12_clickY2=%button12_sizeY%+%button12_clickY1%
	call :HFunc_NotiCalc
	if "%OverMessage%"=="False" (set button12_clickX1=800&set button12_clickX2=801&set button12_clickY1=600&set button12_clickY2=601)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:MainInterface_withoutDe
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-MainInterface_withoutDe>>RunningData.log
::Plugins\Img Pictures\watermark.png?0,0,800,594
::��������
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
::set /p MultiProcessFunc=<Symbol\MultiProcessFunc.data
::if "%MultiProcessFunc%"=="Windows" (set MultiProcess_ButtFunc=Process_Plus)
::if "%MultiProcessFunc%"=="Function" (set MultiProcess_ButtFunc=MultiProcess)
set MultiProcess_ButtFunc=MultiProcess
if exist "Symbol\mini.fxl" (set MultiProcess_ButtFunc=MultiProcess_MiniWindow)

::ͬ��������
set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
	    set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
		set Right_X1=400&SET Right_X2=800&SET Right_Y1=0&SET Right_Y2=600
	)
    if "%ModuleName%"=="%jump2%" (
	    set Left_X1=0&SET Left_X2=400&SET Left_Y1=0&SET Left_Y2=600
	    set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
	)
)
::֪ͨ��ť���
::---------------------------------------------
setlocal enabledelayedexpansion
call :HFunc_NotiCalc
if not exist "Symbol\NotificationRec.data" (goto MainInterface_withoutDe_true)
set file=Symbol\NotificationRec.data

if exist "Symbol\mini.fxl" (set x=181) else (set x=461)
set y=63
set h_gap=8
set v_gap=8
set MessageBox_X=181
set MessageBox_Y=86
set MessageBar_X=199
set MessageBar_Y=408
set max_per_row=1
set count=0
for /f "tokens=*" %%a in (%file%) do (
    set /a count+=1
    set "folderName[!count!]=%%a"
)
set Noti_num=1
set total=!count!
set count=0
:MainInterface_NotiTemp
set "folder_name=!folderName[%Noti_num%]!"
set /a row=!count! / !max_per_row!
set /a col=!count! %% !max_per_row!
set /a pos_x=!x! + (!col! * (!MessageBox_X! + !h_gap!))
set /a pos_y=!y! + (!row! * (!MessageBox_Y! + !v_gap!))
set /a pos_x2=!pos_x! + !MessageBox_X!
set /a pos_y2=!pos_y! + !MessageBox_Y!
set click_X1_Button%Noti_num%=!pos_x!
set click_Y1_Button%Noti_num%=!pos_y!
set click_X2_Button%Noti_num%=!pos_x2!
set click_Y2_Button%Noti_num%=!pos_y2!
set /a count+=1
set /a Noti_num+=1
if %total% leq 3 (set totalcount=%total%) else (set totalcount=3)
if %Noti_num% leq %totalcount% (goto MainInterface_NotiTemp) 
::---------------------------------------------

:MainInterface_withoutDe_true
call :HFunc_MouseClick

::֪ͨ��ť
if exist "Symbol\NotificationRec.data" (
    if not exist "Symbol\mini.fxl" (
    for /l %%i in (1,1,%total%) do (
        if %x% geq !click_X1_Button%%i! if %x% leq !click_X2_Button%%i! if %y% geq !click_Y1_Button%%i! if %y% leq !click_Y2_Button%%i! (
    	    Plugins\Img Pictures\msgmask.png?!click_X1_Button%%i!,!click_Y1_Button%%i!,!MessageBox_X!,!MessageBox_Y!
    		::call :HFunc_TimeDelay
			if exist "Symbol\linear_motion.fxl" (call :HARE_ThirdMenuMask)
			::if exist "Symbol\linear_motion.fxl" (set HARE_EngineLaunch_ProcessWaitOpt=True&call :HARE_EngineLaunch&call :HARE_ThirdMenuMask)
    	    if !folderName[%%i]!==darkmode (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto surface)
    		if !folderName[%%i]!==dev (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto developer)
    		if !folderName[%%i]!==inver (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto surface)
    		if !folderName[%%i]!==lock (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto schema-key)
    		if !folderName[%%i]!==log (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto schema)
    		if !folderName[%%i]!==lost (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto xiufu)
    	    )
        )
    )
)

if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (
        mode con: cols=65 lines=37) else (
        mode con: cols=100 lines=37
	)
	set QE_Load_Maininterface_Selection=OnlyBG0&call :QE_Load_Maininterface
    goto MainInterface_WithDe
)

if %x% geq %Left_X1% if %x% leq %Left_X2% if %y% geq %Left_Y1% if %y% leq %Left_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Left_X1:%Left_X1%/Left_X2:%Left_X2%/Left_Y1:%Left_Y1%/Left_Y2:%Left_Y2%/%jump1%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump1%
)
if %x% geq %Right_X1% if %x% leq %Right_X2% if %y% geq %Right_Y1% if %y% leq %Right_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Right_X1:%Right_X1%/Right_X2:%Right_X2%/Right_Y1:%Right_Y1%/Right_Y2:%Right_Y2%/%jump2%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump2%
)


if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
    set HUOCHAI_JumpCode=clean
    ::ԭͼƬ��С
    set a=199&set b=199
    ::ԭͼƬλ��
    set a1=32&set b1=54
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
    set name=clean
    set duty=main
    call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveDe
)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    set HUOCHAI_JumpCode=edit
    ::ԭͼƬ��С
    set a=199
    set b=199
    ::ԭͼƬλ��
    set a1=242
    set b1=54
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    set name=edit
    set duty=main
    call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveDe)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
    set HUOCHAI_JumpCode=safe
    ::ԭͼƬ��С
    set a=199
    set b=199
    ::ԭͼƬλ��
    set a1=32
    set b1=264
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    set name=safe
    set duty=main
    call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveDe)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
    set HUOCHAI_JumpCode=settings
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=241
    set b1=264
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set name=settings
    set duty=main
    call :%MainInterface_ButtonMotion%
    goto MainInterface_leaveDe)
if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
    set HUOCHAI_JumpCode=tools
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=242
    set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    echo.tools>Symbol\jump.fxl
    set duty=main
	set name=tools
    call :%MainInterface_ButtonMotion%
    set name=safe
    goto MainInterface_leaveDe)
	
if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=347
    set b1=264
	if exist "Symbol\DarkMode.fxl" (set name=myclean) else (set name=myclean)
    call :%MainInterface_ButtonMotion%
    goto myclean
)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
    set HUOCHAI_JumpCode=elect
    ::ԭͼƬ��С
    set a=94&set b=94
    ::ԭͼƬλ��
    set a1=347&set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
	set name=elect
    call :%MainInterface_ButtonMotion%
    set name=edit
    goto MainInterface_leaveJump
)
	
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (
    ::ԭͼƬ��С
    set a=103&set b=47
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto %MultiProcess_ButtFunc%
)
if %x% geq %button9_clickX1% if %x% leq %button9_clickX2% if %y% geq %button9_clickY1% if %y% leq %button9_clickY2% (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto Search
)
if %x% geq %button10_clickX1% if %x% leq %button10_clickX2% if %y% geq %button10_clickY1% if %y% leq %button10_clickY2% (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto Mainelse
)
if %x% geq %button11_clickX1% if %x% leq %button11_clickX2% if %y% geq %button11_clickY1% if %y% leq %button11_clickY2% (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Msg-dark) else (set name=Msg)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	set QE_Load_Maininterface_Selection=OnlyBG
	call :QE_Load_Maininterface
	set HFunc_NotiCode=Bar&call :HFunc_NotificationBar
	call :NotificationBar_mini
)
if %x% geq %button12_clickX1% if %x% leq %button12_clickX2% if %y% geq %button12_clickY1% if %y% leq %button12_clickY2% (
    ::abԭʼ��С | a1b1ԭʼλ�� | xy���մ�С | x1y1����λ��
    set a=%button12_sizeX%&set b=%button12_sizeY%&set a1=%button12_clickX1%&set b1=%button12_clickY1%
    set x=800&set y=592&set x1=0&set y1=0
	::��ť
	if exist "Symbol\DarkMode.fxl" (set name=msg-more) else (set name=msg-more)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	::��ת
    set name=settings
	set HUOCHAI_JumpCode=message_more
    goto MainInterface_leaveDe
)

set duty=1
goto MainInterface_withoutDe

:MainInterface_leaveDe
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-MainInterface_leaveDe>>RunningData.log
::���Ӷ���
::Plugins\Img Pictures\15pc-black.png?0,0,800,594
::Plugins\Img Pictures\15pc-black.png?0,0,800,594
::Plugins\Img Skin\SkinPackage\%background%.png:0,0,800,594
::if exist "Symbol\linear_motion.fxl" (call :HARE_ThirdMenuMask)
::if exist "Symbol\linear_motion.fxl" (set HARE_EngineLaunch_ProcessWaitOpt=True&call :HARE_EngineLaunch&call :HARE_ThirdMenuMask)

set flag=0
set /p fps=<Symbol\fps.data
del Symbol\QuickControl.fxl>nul 2>nul
if not exist "Symbol\mini.fxl" (echo.0>Symbol\Motionoff_Internal_bus.fxl)
if not exist "Motionoff.fxl" (set /a flag=%flag%+1)
if exist "Symbol\linear_motion.fxl" (set /a flag=%flag%+1)
if "%flag%"=="2" (call :QE_Linear_Motion&goto MainInterface_leaveWithoutDe) else (call :QE_Linear_Motion_lite)
goto MainInterface_leaveWithoutDe

:MainInterface_leaveWithoutDe
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-MainInterface_leaveWithoutDe>>RunningData.log
::��������ɫ���ɰ�
set BackgroundColor=%HUOCHAI_JumpCode%
::echo.%BackgroundColor%&pause
if "%HUOCHAI_JumpCode%"=="myclean" (set BackgroundColor=clean)
if "%HUOCHAI_JumpCode%"=="tools" (set BackgroundColor=safe)
if "%HUOCHAI_JumpCode%"=="message_more" (set BackgroundColor=settings)
if "%HUOCHAI_JumpCode%"=="" (set BackgroundColor=%name%)
if exist "Symbol\DarkMode.fxl" (
    Plugins\Img Pictures\%BackgroundColor%1.png:%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\15pc-black.png?%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\15pc-black.png?%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\15pc-black.png?%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\15pc-black.png?%x1%,%y1%,%x%,%y%
    goto MainInterface_leaveJump) else (
    Plugins\Img Pictures\%BackgroundColor%1.png:%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\22.png?%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\22.png?%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\22.png?%x1%,%y1%,%x%,%y%
    Plugins\Img Pictures\22.png?%x1%,%y1%,%x%,%y%
    )

:MainInterface_leaveJump
::if "%MultiWindow_Exist_Clear%"=="True" (set MultiWindow_Exist=0)
::set MultiWindow_Exist_Clear=True
set MultiWindow_Exist=0
::�°���ת
set HUOCHAI_JumpAddress=%HUOCHAI_JumpCode%
if exist "Symbol\developer_mode-overlay.fxl" (echo.HUOCHAI_JumpCode:%HUOCHAI_JumpCode%)
if "%HUOCHAI_JumpCode%"=="" (set HUOCHAI_JumpCode=&goto MainInterface_leaveJump2)
if "%HUOCHAI_JumpCode%"=="clean" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)
if "%HUOCHAI_JumpCode%"=="edit" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)
if "%HUOCHAI_JumpCode%"=="safe" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)
if "%HUOCHAI_JumpCode%"=="settings" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)
if "%HUOCHAI_JumpCode%"=="tools" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)
if "%HUOCHAI_JumpCode%"=="elect" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)
if "%HUOCHAI_JumpCode%"=="myclean" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)
if "%HUOCHAI_JumpCode%"=="message_more" (set HUOCHAI_JumpCode=&goto %HUOCHAI_JumpAddress%)

:MainInterface_leaveJump2
if exist "myclean.tmp" (del myclean.tmp&goto myclean)
if exist "clean.tmp" (del clean.tmp&goto clean) 
if exist "edit.tmp" (del edit.tmp&goto edit)
if exist "safe.tmp" (del safe.tmp&goto safe)
if exist "settings.tmp" (del settings.tmp&goto settings)
if exist "tools.tmp" (del tools.tmp&goto tools)
if exist "elect.tmp" (del elect.tmp&call :elect)
if exist "message_more.tmp" (del message_more.tmp&goto message_more)
goto MainInterface_withDe

:leaveDe
if "%SynWindows_active%"=="False" (
    if exist "Symbol\mini.fxl" (goto MainInterface_withDe)
    if not exist "Symbol\synergism_off.fxl" (call :Quick_Control_Bar)
	)
if "%SynWindows_active%"=="True" (
    if exist "Symbol\mini.fxl" (exit)
    if exist "Symbol\SynWinQC.fxl" (call :Quick_Control_Bar) else (exit)
	)
goto MainInterface_withDe

:Search
::--------------------------------------
::Module Version��Search2.1.0.6
::UpdateDate:2024-8-31
::--------------------------------------
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Searchģ��>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=697
	set button1_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=52) else (set button1_clickX1=52)
	if exist "Symbol\mini.fxl" (set button1_clickY1=75) else (set button1_clickY1=75)
	if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button2_sizeX=152
	set button2_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=597) else (set button2_clickX1=597)
	if exist "Symbol\mini.fxl" (set button2_clickY1=189) else (set button2_clickY1=189)
	if "%MultiWindow_Exist%"=="1" (       
    if "%ModuleName%"=="%jump2%" (set /a button2_clickX1=%button2_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
Plugins\Img Pictures\mengban3.png?0,0,800,600
Plugins\Img Pictures\mengban3.png?0,0,800,600
Plugins\Img Pictures\mengban3.png?0,0,800,600
::Plugins\Img Pictures\mengban3.png?0,0,800,600
::Plugins\Img Pictures\5.gif?800,600,2,2,1,100
if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\Search-dark.png?0,0) else (Plugins\Img Pictures\Search.png?0,0)
call :HFunc_Search

:Search_withoutDe
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
call :HFunc_MouseClick
if %x% geq 790 if %x% leq 800 if %y% geq 0 if %y% leq 600 echo.1>Symbol\mini.fxl&mode con: cols=65 lines=37&goto MainInterface_withDe

if %x% geq 32 if %x% leq 135 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=103&set b=46
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    call :QE_Load_Maininterface&goto MultiProcess
)

if %x% geq 215 if %x% leq 261 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    call :QE_Load_Maininterface&goto Mainelse
)
	
if %x% geq 152 if %x% leq 197 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto MainInterface_withDe
)

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (call :HFunc_Search)
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    ::ԭͼƬ��С��λ��
    set a=%button2_sizeX%&set b=%button2_sizeY%&set a1=%button2_clickX1%&set b1=%button2_clickY1%
	if exist "Symbol\DarkMode.fxl" (set name=JumpElect) else (set name=JumpElect)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    call Plugins\Elect_Assistant\StartProg.bat
	call :QE_Load_Maininterface
	goto Search
)

goto Search_withoutDe

:Mainelse
::--------------------------------------
::Module Version��Mainelse2.1.5.0
::UpdateDate:2024-9-2
::--------------------------------------
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Mainelseģ��>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Mainelseģ��>>RunningData.log
Plugins\Img Pictures\mengban3.png?0,0,800,600
Plugins\Img Pictures\mengban3.png?0,0,800,600
Plugins\Img Pictures\mengban3.png?0,0,800,600
if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\Mainelse-menu-dark.png?0,0) else (Plugins\Img Pictures\Mainelse-menu.png?0,0)

:Mainelse_Widgets
if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\Mainelse-dark.png?359,54,409,413) else (Plugins\Img Pictures\Mainelse.png?359,54,409,413)
Plugins\Img Pictures\old_FluenceDesign_Pics\PlugManage-BUTTON.png?209,382,115,35
setlocal enabledelayedexpansion
set file=symbol\register.data
set x=400
set y=150
set width=45
set height=45
set h_gap=45
set v_gap=40
set max_per_row=4
set count=0

if not exist "%file%" (Plugins\Img Pictures\PluginUseless.png?523,250,80,14&goto Mainelse_withoutDe)
:: ��ȡ�ļ�����
for /f "tokens=*" %%a in (%file%) do (
    set /a count+=1
    set "folderName[!count!]=%%a"
)
if "%COUNT%"=="0" (Plugins\Img Pictures\PluginUseless.png?523,250,80,14&goto Mainelse_withoutDe)

set Mainelse_num=1
set total=!count!
set count=0

:Mainelse_loop
set "folder_name=!folderName[%Mainelse_num%]!"
set /a row=!count! / !max_per_row!
set /a col=!count! %% !max_per_row!
set /a pos_x=!x! + (!col! * (!width! + !h_gap!))
set /a pos_y=!y! + (!row! * (!height! + !v_gap!))
set /a pos_x2=!pos_x! + !width!
set /a pos_y2=!pos_y! + !height!
set /a pos_x3=!pos_x!-16
set /a pos_y3=!pos_y!+!height!+5

:: ��¼ֵ������
set "click_X1_Button%Mainelse_num%=!pos_x!"
set "click_Y1_Button%Mainelse_num%=!pos_y!"
set "click_X2_Button%Mainelse_num%=!pos_x2!"
set "click_Y2_Button%Mainelse_num%=!pos_y2!"

::֧����ɫͼ��ľ���ʾ����֧�־Ͳ���ʾ
if exist "Symbol\DarkMode.fxl" (
    if exist "Plugins\!folder_name!\PluginLogo-dark.png" (set extralogo=-dark) else (set extralogo=)
	)
if exist "Plugins\!folder_name!\PluginLogo.png" (Plugins\Img Plugins\!folder_name!\PluginLogo%extralogo%.png?!pos_x!,!pos_y!,!width!,!height!) else (Plugins\Img Pictures\PluginNoneLogo.png?!pos_x!,!pos_y!,!width!,!height!)
if exist "Plugins\!folder_name!\PluginName.png" (Plugins\Img Plugins\!folder_name!\PluginName.png?!pos_x3!,!pos_y3!) else (Plugins\Img Pictures\PluginNoneName.png?!pos_x3!,!pos_y3!,80,14)
set /a count+=1
set /a Mainelse_num+=1
if %Mainelse_num% leq %total% (goto Mainelse_loop)

:: �����������
::for /l %%i in (1,1,%total%) do (
::    echo ͼƬ %%i ���Ͻ�����: !click_X1_Button%%i!, !click_Y1_Button%%i!
::    echo ͼƬ %%i ���½�����: !click_X2_Button%%i!, !click_Y2_Button%%i!
::	echo folder_name=!folderName[%%i]!
::)
::endlocal

:Mainelse_withoutDe
::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=281
	set button1_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=52) else (set button1_clickX1=52)
	if exist "Symbol\mini.fxl" (set button1_clickY1=75) else (set button1_clickY1=75)
	if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=115
	set button2_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=72) else (set button2_clickX1=72)
	if exist "Symbol\mini.fxl" (set button2_clickY1=382) else (set button2_clickY1=382)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=115
	set button3_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=209) else (set button3_clickX1=209)
	if exist "Symbol\mini.fxl" (set button3_clickY1=382) else (set button3_clickY1=382)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%
call :HFunc_MouseClick
if %x% geq 790 if %x% leq 800 if %y% geq 0 if %y% leq 600 echo.1>Symbol\mini.fxl&mode con: cols=65 lines=37&goto MainInterface_withDe
::�Ҳ๦����
for /l %%i in (1,1,%total%) do (
    if %x% geq !click_X1_Button%%i! if %x% leq !click_X2_Button%%i! if %y% geq !click_Y1_Button%%i! if %y% leq !click_Y2_Button%%i! (
        if exist "Plugins\!folderName[%%i]!\StartProg.bat" (
			Plugins\Img Pictures\Colour\black-lucency.png?!click_X1_Button%%i!,!click_Y1_Button%%i!,!width!,!height!
		    call :HFunc_TimeDelay
			call Plugins\!folderName[%%i]!\StartProg.bat
			) else (goto Mainelse_withoutDe)
	    if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
        call :QE_Load_Maininterface&goto Mainelse
    )
)
	
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (call :HFunc_Search)
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    ::ԭͼƬ��С
    set a=%button2_sizeX%&set b=%button2_sizeY%
    ::ԭͼƬλ��
    set a1=%button2_clickX1%&set b1=%button2_clickY1%
	if exist "Symbol\DarkMode.fxl" (set name=DownloadPlug) else (set name=DownloadPlug)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    start URLs\wallpaper.url
)
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
    ::ԭͼƬ��С
    set a=%button3_sizeX%&set b=%button3_sizeY%
    ::ԭͼƬλ��
    set a1=%button3_clickX1%&set b1=%button3_clickY1%
	if exist "Symbol\DarkMode.fxl" (set name=PlugManage) else (set name=PlugManage)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	endlocal
    goto Mainelse_Edit
)

if %x% geq 32 if %x% leq 135 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=103&set b=46
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    call :QE_Load_Maininterface&goto MultiProcess
)
	
if %x% geq 152 if %x% leq 197 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    call :QE_Load_Maininterface&goto Search
)

if %x% geq 215 if %x% leq 261 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    goto MainInterface_withDe
)

goto Mainelse_withoutDe


:Mainelse_Edit
::--------------------------------------
::Module Version��Mainelse2.1.5.0
::UpdateDate:2024-9-2
::--------------------------------------
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Mainelseģ��>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Mainelseģ��>>RunningData.log


:Mainelse_Edit_Widgets
if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\Mainelse-Edit-dark.png?359,54,409,413) else (Plugins\Img Pictures\Mainelse-Edit.png?359,54,409,413)
Plugins\Img Pictures\old_FluenceDesign_Pics\PlugFinish-BUTTON.png?209,382,115,35
setlocal enabledelayedexpansion
set file=symbol\register.data
set x=400
set y=150
set width=45
set height=45
set h_gap=45
set v_gap=40
set TinyIconwidth=25
set TinyIconheight=25
set max_per_row=4
set count=0

if not exist "%file%" (Plugins\Img Pictures\PluginUseless.png?523,250,80,14&goto Mainelse_Edit_withoutDe)
:: ��ȡ�ļ�����
for /f "tokens=*" %%a in (%file%) do (
    set /a count+=1
    set "folderName[!count!]=%%a"
)
if "%COUNT%"=="0" (Plugins\Img Pictures\PluginUseless.png?523,250,80,14&goto Mainelse_Edit_withoutDe)

set Mainelse_num=1
set total=!count!
set count=0

:Mainelse_Edit_loop
set "folder_name=!folderName[%Mainelse_num%]!"
set /a row=!count! / !max_per_row!
set /a col=!count! %% !max_per_row!
set /a pos_x=!x! + (!col! * (!width! + !h_gap!))
set /a pos_y=!y! + (!row! * (!height! + !v_gap!))
set /a pos_x2=!pos_x! + !width!
set /a pos_y2=!pos_y! + !height!
set /a pos_x3=!pos_x!-16
set /a pos_y3=!pos_y!+!height!+5
set /a pos_x4=!pos_x!+!width!-!TinyIconwidth!
set /a pos_y4=!pos_y!+!height!-!TinyIconheight!

:: ��¼ֵ������
set "click_X1_Button%Mainelse_num%=!pos_x!"
set "click_Y1_Button%Mainelse_num%=!pos_y!"
set "click_X2_Button%Mainelse_num%=!pos_x2!"
set "click_Y2_Button%Mainelse_num%=!pos_y2!"

::֧����ɫͼ��ľ���ʾ����֧�־Ͳ���ʾ
if exist "Symbol\DarkMode.fxl" (
    if exist "Plugins\!folder_name!\PluginLogo-dark.png" (set extralogo=-dark) else (set extralogo=)
	)

if exist "Plugins\!folder_name!\PluginLogo.png" (Plugins\Img Plugins\!folder_name!\PluginLogo%extralogo%.png?!pos_x!,!pos_y!,!width!,!height!) else (Plugins\Img Pictures\PluginNoneLogo.png?!pos_x!,!pos_y!,!width!,!height!)

Plugins\Img Pictures\PluginDel.png?!pos_x4!,!pos_y4!,!TinyIconwidth!,!TinyIconheight!
if exist "Plugins\!folder_name!\PluginName.png" (Plugins\Img Plugins\!folder_name!\PluginName.png?!pos_x3!,!pos_y3!) else (Plugins\Img Pictures\PluginNoneName.png?!pos_x3!,!pos_y3!,80,14)

::echo.if exist "Plugins\!folder_name!\PluginLogo.png" (Plugins\Img Plugins\!folder_name!\PluginLogo%extralogo%.png?!pos_x4!,!pos_y4!,!TinyIconwidth!,!TinyIconheight!) else (Plugins\Img Pictures\PluginNoneLogo.png?!pos_x4!,!pos_y4!,!TinyIconwidth!,!TinyIconheight!)
::echo.if exist "Plugins\!folder_name!\PluginName.png" (Plugins\Img Plugins\!folder_name!\PluginName.png?!pos_x3!,!pos_y3!) else (Plugins\Img Pictures\PluginNoneName.png?!pos_x3!,!pos_y3!,80,14)

set /a count+=1
set /a Mainelse_num+=1
if %Mainelse_num% leq %total% (goto Mainelse_Edit_loop)

:: �����������
::for /l %%i in (1,1,%total%) do (
::    echo ͼƬ %%i ���Ͻ�����: !click_X1_Button%%i!, !click_Y1_Button%%i!
::    echo ͼƬ %%i ���½�����: !click_X2_Button%%i!, !click_Y2_Button%%i!
::	echo folder_name=!folderName[%%i]!
::)
::endlocal

:Mainelse_Edit_withoutDe
::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=281
	set button1_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=52) else (set button1_clickX1=52)
	if exist "Symbol\mini.fxl" (set button1_clickY1=75) else (set button1_clickY1=75)
	if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=115
	set button2_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=72) else (set button2_clickX1=72)
	if exist "Symbol\mini.fxl" (set button2_clickY1=382) else (set button2_clickY1=382)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=115
	set button3_sizeY=35
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=209) else (set button3_clickX1=209)
	if exist "Symbol\mini.fxl" (set button3_clickY1=382) else (set button3_clickY1=382)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%


call :HFunc_MouseClick
if %x% geq 790 if %x% leq 800 if %y% geq 0 if %y% leq 600 echo.1>Symbol\mini.fxl&mode con: cols=65 lines=37&goto MainInterface_withDe

for /l %%i in (1,1,%total%) do (
    if %x% geq !click_X1_Button%%i! if %x% leq !click_X2_Button%%i! if %y% geq !click_Y1_Button%%i! if %y% leq !click_Y2_Button%%i! (
        Plugins\Img Pictures\Colour\black-lucency.png?!click_X1_Button%%i!,!click_Y1_Button%%i!,!width!,!height!
        call :HFunc_TimeDelay
		if "!folderName[%%i]!"=="Elect_Assistant" (call Warning\Plugin_Elect.vbs&goto Mainelse_Edit_Widgets)
        :: ɾ�� register.data ���Ӧ����
        findstr /v "!folderName[%%i]!" %file% > temp.txt
        move /y temp.txt %file% >nul 
        if exist temp.txt (del temp.txt)
        :: ɾ�� Plugins �ļ������Ӧ���ļ���
        if exist "Plugins\!folderName[%%i]!" (
            rd /s /q "Plugins\!folderName[%%i]!" >nul 2>nul
        )
        goto Mainelse_Edit_Widgets
    )
)
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (call :HFunc_Search)
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    ::ԭͼƬ��С
    set a=%button2_sizeX%&set b=%button2_sizeY%
    ::ԭͼƬλ��
    set a1=%button2_clickX1%&set b1=%button2_clickY1%
	if exist "Symbol\DarkMode.fxl" (set name=DownloadPlug) else (set name=DownloadPlug)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    start URLs\wallpaper.url
)
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
    ::ԭͼƬ��С
    set a=%button3_sizeX%&set b=%button3_sizeY%
    ::ԭͼƬλ��
    set a1=%button3_clickX1%&set b1=%button3_clickY1%
	if exist "Symbol\DarkMode.fxl" (set name=PlugFinish) else (set name=PlugFinish)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto Mainelse_Widgets
)

if %x% geq 32 if %x% leq 135 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=103&set b=46
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    call :QE_Load_Maininterface&goto MultiProcess
)
	
if %x% geq 152 if %x% leq 197 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    call :QE_Load_Maininterface&goto Search
)

if %x% geq 215 if %x% leq 261 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    goto MainInterface_withDe
)

goto Mainelse_Edit_withoutDe

:MultiProcess
set place=process_plus
call :QE_menu_mask
set flag=0
set MultiWindow_Count=0
:MultiProcess_WithoutDe
if "%flag%"=="1" (set jump1=%name%)
if "%flag%"=="2" (set jump2=%name%)
if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=1)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
if exist "Symbol\mini.fxl" (set xx1_2=152&set xx2_2=197) else (set xx1_2=790&set xx2_2=800)
if exist "Symbol\developer_mode-overlay.fxl" echo.flag=%flag% jump1=%jump1% jump2=%jump2%
if "%flag%"=="2" set flag=0&goto MultiProcess_Jump


call :HFunc_MouseClick
if %x% geq 32 if %x% leq 135 if %y% geq 520 if %y% leq 566 (
del *.tmp>nul 2>nul
del *.tmpdual>nul 2>nul
    ::ԭͼƬ��С
    set a=103&set b=47
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
goto MainInterface_withDe)

if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
	goto MainInterface_withDe
)

if %x% geq %xx1_2% if %x% leq %xx2_2% if %y% geq 0 if %y% leq 600 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Msg-dark) else (set name=Msg)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	set QE_Load_Maininterface_Selection=OnlyBG
	call :QE_Load_Maininterface
    call :HFunc_NotificationBar
	call :NotificationBar_mini
)
	
if %x% geq 152 if %x% leq 197 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto Search
)

if %x% geq 215 if %x% leq 261 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    goto Mainelse
)

if %x% geq 194 if %x% leq 224 if %y% geq 217 if %y% leq 247 (echo.1>clean.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_WithoutDe)
if %x% geq 404 if %x% leq 434 if %y% geq 217 if %y% leq 247 (echo.1>edit.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_WithoutDe)
if %x% geq 299 if %x% leq 329 if %y% geq 426 if %y% leq 456 (echo.1>tools.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_WithoutDe)
if %x% geq 194 if %x% leq 224 if %y% geq 426 if %y% leq 456 (echo.1>safe.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_WithoutDe)

if %x% geq 32 if %x% leq 231 if %y% geq 54 if %y% leq 253 (
    ::ͼƬ��С,λ���趨
    set a=199&set b=199
    set a1=32&set b1=55
	::��ť�㴥
	set address=button
	set name=clean
	set QE_Pushed_Button3_DELTA=1
	call :QE_Pushed_Button3
	::��ת�ж�
	set name=clean
	set /a flag=flag+1
    goto MultiProcess_WithoutDe)

if %x% geq 242 if %x% leq 441 if %y% geq 54 if %y% leq 253 (
    ::ͼƬ��С,λ���趨
    set a=199&set b=199
    set a1=242&set b1=55
	::��ť�㴥
	set address=button
	set name=edit
	set QE_Pushed_Button3_DELTA=1
	call :QE_Pushed_Button3
	::��ת�ж�
	set name=edit
	set /a flag=flag+1
    goto MultiProcess_WithoutDe)
	
if %x% geq 32 if %x% leq 231 if %y% geq 264 if %y% leq 463 (
    ::ͼƬ��С,λ���趨
    set a=199&set b=199
    set a1=32&set b1=264
	::��ť�㴥
	set address=button
	set name=safe
	set QE_Pushed_Button3_DELTA=1
	call :QE_Pushed_Button3
	::��ת�ж�
	set name=safe
	set /a flag=flag+1
    goto MultiProcess_WithoutDe)
	
if %x% geq 242 if %x% leq 336 if %y% geq 369 if %y% leq 463 (
    ::ͼƬ��С,λ���趨
    set a=94&set b=94
    set a1=242&set b1=369
	::��ť�㴥
	set address=button
	set name=tools
	set QE_Pushed_Button3_DELTA=1
	call :QE_Pushed_Button3
	::��ת�ж�
	set name=safe
	set HUOCHAI_JumpCode=tools
	set /a flag=flag+1
    goto MultiProcess_WithoutDe)

if %x% geq 241 if %x% leq 335 if %y% geq 264 if %y% leq 358 (
echo.1>>settings.tmp
    ::ԭͼƬ��С
    set a=94&set b=94
    set a1=241&set b1=264
	::��ť�㴥
	set address=button
	set name=settings
	set QE_Pushed_Button3_DELTA=1
	call :QE_Pushed_Button3
	::��ת�ж�
	set name=settings
	set HUOCHAI_JumpCode=settings
	set /a flag=flag+1
    goto MultiProcess_WithoutDe)

if %x% geq 347 if %x% leq 441 if %y% geq 264 if %y% leq 361 (
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=347
    set b1=264
	if exist "Symbol\DarkMode.fxl" (set name=myclean) else (set name=myclean)
	set QE_Pushed_Button3_DELTA=1
	call :QE_Pushed_Button3
    goto myclean
)

if %x% geq 347 if %x% leq 441 if %y% geq 369 if %y% leq 463 (
    set HUOCHAI_JumpCode=elect
    ::ԭͼƬ��С
    set a=94&set b=94
    ::ԭͼƬλ��
    set a1=347&set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
	set name=elect
	set QE_Pushed_Button3_DELTA=1
	call :QE_Pushed_Button3
    set name=edit
    goto MainInterface_leaveJump
)
goto MultiProcess_WithoutDe

:MultiProcess_NameSet
if "%Jump_Name%"=="clean" (
    set a=199&set b=199
    set a1=32&set b1=55
	set name=clean
    )
if "%Jump_Name%"=="edit" (
    set a=199&set b=199
    set a1=242&set b1=55
	set name=edit
    )
if "%Jump_Name%"=="safe" (
    set a=199&set b=199
    set a1=32&set b1=264
	set name=safe
	)
if "%Jump_Name%"=="tools" (
    set a=94&set b=94
    set a1=242&set b1=369
	set name=safe
    )
if "%Jump_Name%"=="settings" (
    set a=94&set b=94
    set a1=241&set b1=264
	set name=settings
    )
goto :eof

:MultiProcess_Jump
::��ǰ��ת
if "%jump1%"=="%jump2%" (
    set HUOCHAI_JumpCode=%jump1%
	set name=%jump1%
	::�Ŵ��ͼƬ��С
    if exist "Symbol\mini.fxl" (set x=520) else (set x=800)
    set y=594
    set x1=0&set y1=0
	goto MainInterface_leaveDe
    )
::��ת����
set flag2=0
if not exist "Motionoff.fxl" (set /a flag2=%flag2%+1)
if exist "Symbol\linear_motion.fxl" (set /a flag2=%flag2%+1)

set Jump_Name=%jump1%
set MultiProcess_Code=first
call :MultiProcess_NameSet
::echo.Jump_Name:%Jump_Name%,jump1:%jump1%,name:%name%,flag2:%flag2%
if "%flag2%"=="2" (call :QE_MultiProcess) else (call :QE_MultiProcess_lite)
::-----------------
set Jump_Name=%jump2%
set MultiProcess_Code=second
call :MultiProcess_NameSet
::echo.Jump_Name:%Jump_Name%,jump2:%jump2%,name:%name%,flag2:%flag2%
if "%flag2%"=="2" (call :QE_MultiProcess_lite) else (call :QE_MultiProcess_lite)

::��������ɫ���ɰ�
if exist "Symbol\DarkMode.fxl" (
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600
Plugins\Img Pictures\15pc-black.png?0,0,800,600) else (
Plugins\Img Pictures\22.png?0,0,800,600
Plugins\Img Pictures\22.png?0,0,800,600
Plugins\Img Pictures\22.png?0,0,800,600
Plugins\Img Pictures\22.png?0,0,800,600
)
if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\white.png?399,0,2,600) else (Plugins\Img Pictures\white.png?399,0,2,600)
if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\white.png?399,0,2,600) else (Plugins\Img Pictures\white.png?399,0,2,600)

::��ת����
::call :HFunc_TimeDelay
set MultiWindow_Exist=1
set MultiWindow_Count=1
set jump_Code=%jump1%
call :MultiProcess_Jump2
::-----------------
set MultiWindow_Count=2
set jump_Code=%jump2%
call :MultiProcess_Jump2

:MultiProcess_Jump2
if "%jump_Code%"=="clean" (call :clean) 
if "%jump_Code%"=="settings" (call :settings)
if "%jump_Code%"=="safe" (call :safe)
if "%jump_Code%"=="tools" (call :tools)
if "%jump_Code%"=="edit" (call :edit)
goto :eof
goto MainInterface_leavewithoutDe

:MultiProcess_MiniWindow
set place=process_plus
call :QE_menu_mask
Plugins\Img Pictures\mengban2.png?0,0,800,600
set flag=0
set MultiWindow_Count=0
:MultiProcess_MiniWindow_WithoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
if exist "Symbol\mini.fxl" (set xx1_2=152&set xx2_2=197) else (set xx1_2=790&set xx2_2=800)
if exist "Symbol\developer_mode-overlay.fxl" echo.flag=%flag% jump1=%jump1% jump2=%jump2%
if "%flag%"=="2" set flag=0&goto MultiProcess_Jump
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (
        mode con: cols=65 lines=37) else (
        mode con: cols=100 lines=37
	)
	set QE_Load_Maininterface_Selection=OnlyBG0&call :QE_Load_Maininterface
    goto MainInterface_WithDe
)

if %x% geq 194 if %x% leq 224 if %y% geq 217 if %y% leq 247 (echo.1>clean.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_MiniWindow_WithoutDe)
if %x% geq 404 if %x% leq 434 if %y% geq 217 if %y% leq 247 (echo.1>edit.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_MiniWindow_WithoutDe)
if %x% geq 299 if %x% leq 329 if %y% geq 426 if %y% leq 456 (echo.1>tools.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_MiniWindow_WithoutDe)
if %x% geq 194 if %x% leq 224 if %y% geq 426 if %y% leq 456 (echo.1>safe.tmpdual&start StartProg.exe&call :HFunc_TimeDelay&goto MultiProcess_MiniWindow_WithoutDe)

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
    set HUOCHAI_JumpCode=clean
    ::ԭͼƬ��С
    set a=199&set b=199
    ::ԭͼƬλ��
    set a1=32&set b1=54
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
    set name=clean
    set duty=main
	call :QE_Pushed_Button3
    goto MainInterface_leaveDe
)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    set HUOCHAI_JumpCode=edit
    ::ԭͼƬ��С
    set a=199
    set b=199
    ::ԭͼƬλ��
    set a1=242
    set b1=54
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    set name=edit
    set duty=main
	call :QE_Pushed_Button3
    goto MainInterface_leaveDe)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
    set HUOCHAI_JumpCode=safe
    ::ԭͼƬ��С
    set a=199
    set b=199
    ::ԭͼƬλ��
    set a1=32
    set b1=264
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    set name=safe
    set duty=main
	call :QE_Pushed_Button3
    goto MainInterface_leaveDe)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
    set HUOCHAI_JumpCode=settings
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=241
    set b1=264
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set name=settings
    set duty=main
	call :QE_Pushed_Button3
    goto MainInterface_leaveDe)
if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
    set HUOCHAI_JumpCode=tools
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=242
    set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    echo.tools>Symbol\jump.fxl
    set duty=main
	set name=tools
	call :QE_Pushed_Button3
    set name=safe
    goto MainInterface_leaveDe)
	
if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=347
    set b1=264
	if exist "Symbol\DarkMode.fxl" (set name=myclean) else (set name=myclean)
	call :QE_Pushed_Button3
    goto myclean
)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
    set HUOCHAI_JumpCode=elect
    ::ԭͼƬ��С
    set a=94&set b=94
    ::ԭͼƬλ��
    set a1=347&set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
	set name=elect
	call :QE_Pushed_Button3
    set name=edit
    goto MainInterface_leaveJump
)
	
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (
    ::ԭͼƬ��С
    set a=103&set b=47
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto MainInterface_WithDe
)
if %x% geq %button9_clickX1% if %x% leq %button9_clickX2% if %y% geq %button9_clickY1% if %y% leq %button9_clickY2% (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto Search
)
if %x% geq %button10_clickX1% if %x% leq %button10_clickX2% if %y% geq %button10_clickY1% if %y% leq %button10_clickY2% (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto Mainelse
)
if %x% geq %button11_clickX1% if %x% leq %button11_clickX2% if %y% geq %button11_clickY1% if %y% leq %button11_clickY2% (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Msg-dark) else (set name=Msg)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	set QE_Load_Maininterface_Selection=OnlyBG
	call :QE_Load_Maininterface
    call :HFunc_NotificationBar
	call :NotificationBar_mini
)
if %x% geq %button12_clickX1% if %x% leq %button12_clickX2% if %y% geq %button12_clickY1% if %y% leq %button12_clickY2% (
    ::abԭʼ��С | a1b1ԭʼλ�� | xy���մ�С | x1y1����λ��
    set a=181&set b=43&set a1=461&set b1=339
    set x=800&set y=592&set x1=0&set y1=0
	::��ť
	if exist "Symbol\DarkMode.fxl" (set name=msg-more) else (set name=msg-more)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	::��ת
    set name=settings
	set HUOCHAI_JumpCode=message_more
    goto MainInterface_leaveDe
)
goto MultiProcess_MiniWindow_WithoutDe

:process_plus
set place=process_plus
call :QE_menu_mask
set flag=0

:process_plus_a
if "%flag%"=="1" (set jump1=%name%)
if "%flag%"=="2" (set jump2=%name%)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
if exist "Symbol\mini.fxl" (set a=152&set b=197&set c=519&set d=567) else (
    set a=800&set b=801&set c=600&set d=601
	)
if exist "Symbol\developer_mode-overlay.fxl" echo.flag=%flag% jump1=%jump1% jump2=%jump2%
if "%flag%"=="2" set flag=0&goto final


call :HFunc_MouseClick
if %x% geq 32 if %x% leq 135 if %y% geq 520 if %y% leq 566 (
del *.tmp>nul 2>nul
del *.tmpdual>nul 2>nul
    ::ԭͼƬ��С
    set a=103&set b=46
    ::ԭͼƬλ��
    set a1=32&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=ProcessPlus-dark) else (set name=ProcessPlus)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
goto MainInterface_withDe)

if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
	goto MainInterface_withDe
)
if %x% geq %a% if %x% leq %b% if %y% geq %c% if %y% leq %d% (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Msg-dark) else (set name=Msg)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
	set QE_Load_Maininterface_Selection=OnlyBG
	call :QE_Load_Maininterface
    call :HFunc_NotificationBar
	call :NotificationBar_mini
)
	
if %x% geq 152 if %x% leq 197 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=152&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Search-dark) else (set name=Search)
	set QE_Pushed_Button2_DELTA=1
    call :QE_Pushed_Button2
    goto Search
)

if %x% geq 215 if %x% leq 261 if %y% geq 520 if %y% leq 566 (
    ::ԭͼƬ��С
    set a=46&set b=46
    ::ԭͼƬλ��
    set a1=215&set b1=520
	if exist "Symbol\DarkMode.fxl" (set name=Mainelse-dark) else (set name=Mainelse)
	set QE_Pushed_Button2_DELTA=1
    call :%MainInterface_ButtonMotion%
    goto Mainelse
)

if %x% geq 32 if %x% leq 231 if %y% geq 54 if %y% leq 253 (
    ::ͼƬ��С,λ���趨
    set a=199&set b=199
    set a1=32&set b1=55
	::��ť�㴥
	set address=button
	set name=clean
	set QE_Pushed_Button2_DELTA=1
	call :QE_Pushed_Button2
	::��ת�ж�
	set name=clean
	set /a flag=flag+1
    goto process_plus_a)

if %x% geq 242 if %x% leq 441 if %y% geq 54 if %y% leq 253 (
    ::ͼƬ��С,λ���趨
    set a=199&set b=199
    set a1=242&set b1=55
	::��ť�㴥
	set address=button
	set name=edit
	set QE_Pushed_Button2_DELTA=1
	call :QE_Pushed_Button2
	::��ת�ж�
	set name=edit
	set /a flag=flag+1
    goto process_plus_a)
	
if %x% geq 32 if %x% leq 231 if %y% geq 264 if %y% leq 463 (
    ::ͼƬ��С,λ���趨
    set a=199&set b=199
    set a1=32&set b1=264
	::��ť�㴥
	set address=button
	set name=safe
	set QE_Pushed_Button2_DELTA=1
	call :QE_Pushed_Button2
	::��ת�ж�
	set name=safe
	set /a flag=flag+1
    goto process_plus_a)
	
if %x% geq 242 if %x% leq 336 if %y% geq 369 if %y% leq 463 (
    ::ͼƬ��С,λ���趨
    set a=94&set b=94
    set a1=242&set b1=369
	::��ť�㴥
	set address=button
	set name=tools
	set QE_Pushed_Button2_DELTA=1
	call :QE_Pushed_Button2
	::��ת�ж�
	set name=safe
	set HUOCHAI_JumpCode=tools
	set /a flag=flag+1
    goto process_plus_a)

if %x% geq 241 if %x% leq 335 if %y% geq 264 if %y% leq 358 (
echo.1>>settings.tmp
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=241
    set b1=264
    ::�Ŵ��ͼƬ��С
    if exist "Symbol\mini.fxl" (set x=520) else (set x=800)
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set name=settings
	set address=button
    set duty=main
	set QE_Pushed_Button2_DELTA=1
	call :QE_Pushed_Button2
    goto MainInterface_leaveDe)

if %x% geq 347 if %x% leq 441 if %y% geq 264 if %y% leq 361 (
    ::ԭͼƬ��С
    set a=94
    set b=94
    ::ԭͼƬλ��
    set a1=347
    set b1=264
	if exist "Symbol\DarkMode.fxl" (set name=myclean) else (set name=myclean)
	set QE_Pushed_Button2_DELTA=1
	call :QE_Pushed_Button2
    goto myclean
)

if %x% geq 347 if %x% leq 441 if %y% geq 369 if %y% leq 463 (
    set HUOCHAI_JumpCode=elect
    ::ԭͼƬ��С
    set a=94&set b=94
    ::ԭͼƬλ��
    set a1=347&set b1=369
    ::�Ŵ��ͼƬ��С
    if not exist "Symbol\mini.fxl" (set x=800&set y=594) else (set x=520&set y=594)
    ::�Ŵ��ͼƬλ��
    set x1=0&set y1=0
	set name=elect
	set QE_Pushed_Button2_DELTA=1
	call :QE_Pushed_Button2
    set name=edit
    goto MainInterface_leaveJump
)
goto process_plus_a

:final
echo.1>%jump1%.tmp
echo.1>%jump2%.tmpdual
if exist "Symbol\developer_mode-overlay.fxl" echo.[%jump1%.tmp][%jump2%.tmpdual]
if exist "Symbol\DarkMode.fxl" (
Plugins\Img pictures\11.png?0,0,800,600
Plugins\Img pictures\11.png?0,0,800,600
Plugins\Img pictures\11.png?0,0,800,600
Plugins\Img pictures\11.png?0,0,800,600) else (
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600
Plugins\Img pictures\22.png?0,0,800,600)

set position=0
if exist "Symbol\mini.fxl" (set /a position=%position%-135)
if exist "Symbol\DarkMode.fxl" (Plugins\Img pictures\store-dark.png?%position%,0,800,600) else Plugins\Img pictures\store.png?%position%,0,800,600
start StartProg.exe
call :HFunc_TimeDelay
::set position=385
::if exist "Symbol\mini.fxl" (set /a position=%position%-135)
::Plugins\Img Pictures\5.gif?%position%,380,30,30,1,5

goto MainInterface_leavewithoutDe

:message_more
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-message_more>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if "%duty%"=="bar" (Plugins\Img Pictures\message_more-sidebar.png?260,0,259,700&set duty=&goto message_more_withoutDe)
if exist "Symbol\DarkMode.fxl" (set name=message_more-1-dark.png) else set name=message_more-1.png
set symbol=head
set MsgMore_flag=True
if not exist "Symbol\mini.fxl" call :QE_secondary_menu
::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)
Plugins\Img Pictures\message_more-sidebar.png?0,0,259,700

set HFunc_NotiCode=App&call :HFunc_Notification

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:message_more_withoutDe
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

::֪ͨ��ť���
::---------------------------------------------
setlocal enabledelayedexpansion
call :HFunc_NotiCalc
if not exist "Symbol\NotificationRec.data" (goto MainInterface_withoutDe_true)
set file=Symbol\NotificationRec.data

set max_per_row=3
set max_notifi_num=15
if exist "Symbol\mini.fxl" (set x=210) else (set x=210)
set y=70
set h_gap=10
set v_gap=15
set MessageBox_X=181
set MessageBox_Y=86
set MessageBar_X=199
set MessageBar_Y=408
set count=0
for /f "tokens=*" %%a in (%file%) do (
    set /a count+=1
    set "folderName[!count!]=%%a"
)
set Noti_num=1
set total=!count!
set count=0
:message_more_NotiTemp
set "folder_name=!folderName[%Noti_num%]!"
set /a row=!count! / !max_per_row!
set /a col=!count! %% !max_per_row!
set /a pos_x=!x! + (!col! * (!MessageBox_X! + !h_gap!))
set /a pos_y=!y! + (!row! * (!MessageBox_Y! + !v_gap!))
set /a pos_x2=!pos_x! + !MessageBox_X!
set /a pos_y2=!pos_y! + !MessageBox_Y!
set click_X1_Button%Noti_num%=!pos_x!
set click_Y1_Button%Noti_num%=!pos_y!
set click_X2_Button%Noti_num%=!pos_x2!
set click_Y2_Button%Noti_num%=!pos_y2!
set /a count+=1
set /a Noti_num+=1
if %total% leq 3 (set totalcount=%total%) else (set totalcount=3)
if %Noti_num% leq %totalcount% (goto message_more_NotiTemp) 
::---------------------------------------------

:message_more_withoutDe_true
call :HFunc_MouseClick

::֪ͨ��ť
if exist "Symbol\NotificationRec.data" (
    if not exist "Symbol\mini.fxl" (
    for /l %%i in (1,1,%total%) do (
        if %x% geq !click_X1_Button%%i! if %x% leq !click_X2_Button%%i! if %y% geq !click_Y1_Button%%i! if %y% leq !click_Y2_Button%%i! (
    	    Plugins\Img Pictures\msgmask.png?!click_X1_Button%%i!,!click_Y1_Button%%i!,!MessageBox_X!,!MessageBox_Y!
    		call :HFunc_TimeDelay
    	    if !folderName[%%i]!==darkmode (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto surface)
    		if !folderName[%%i]!==dev (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto developer)
    		if !folderName[%%i]!==inver (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto surface)
    		if !folderName[%%i]!==lock (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto schema-key)
    		if !folderName[%%i]!==log (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto schema)
    		if !folderName[%%i]!==lost (
			    set ModuleName=Settings
                call :QE_ModuleReload
				goto xiufu)
    	    )
        )
    )
)


if %x% geq 16 if %x% leq 69 if %y% geq 16 if %y% leq 51 (
    if exist "Symbol\synergism_off.fxl" (goto MainInterface_WithDe)
    if "%SynWindows_active%"=="False" (
        call :QE_QuickControl_loads
        ::::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)
        if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace-dark.png?0,0)
        if not exist "Symbol\synergism_off.fxl" (call :Quick_Control_Bar)
    	)
    if "%SynWindows_active%"=="True" (
        call :QE_QuickControl_loads
        ::::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)
        if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace-dark.png?0,0)
        if exist "Symbol\SynWinQC.fxl" (call :Quick_Control_Bar) else (exit)
    	)
)

if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
::��ת
set BackgroundColor=mid-gray
set JumpCode=message_more
goto MainInterface_leaveDe
)

if %x% geq %X1% if %x% leq %X2% if %y% geq %Y1% if %y% leq %Y2% goto Quick_Control_Bar_WithoutDe

::if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (goto leaveDe)
::if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (goto leaveDe)
goto message_more_withoutDe

:elect
::Plugins\Img Pictures\edit.png?370,388,50,50
if exist "Symbol\mini.fxl" (set xx1=250) else (set xx1=375)
::Plugins\Img Pictures\5.gif?379,401,30,30,1,3
call Plugins\Elect_Assistant\StartProg.bat
if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
goto MainInterface_withDe

:clean
::--------------------------------------
::Module Version��Clean2.1.0.6
::UpdateDate:2023-11-19
::--------------------------------------
set ModuleName=clean
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-add>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
	if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
	if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button2_clickX1=%button2_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
		Plugins\Img Pictures\MultiWinLine_White.png?175,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?584,568) else (if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?584,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?584,568))
	)
    if "%ModuleName%"=="%jump2%" (
		Plugins\Img Pictures\MultiWinLine_White.png?584,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?175,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?175,568)
	)
)
if "%MultiWindow_Exist%"=="1" (
    if "%MultiWindow_Count%"=="0" (goto clean_withoutDe)
	)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if "%MultiWindow_Count%"=="2" (set BarPosition=400) else (set BarPosition=0)
if "%duty%"=="bar" (Plugins\Img Pictures\clean-sidebar.png?260,0,259,700&set duty=&goto clean_withoutDe)
::�����˵�����
if exist "Symbol\DarkMode.fxl" (set name=clean-1-1-night.png) else set name=clean-1-1.png
set symbol=head
if not exist "Symbol\mini.fxl" (
    if "%MultiWindow_Count%"=="0" (
	call :QE_secondary_menu
	)
)

::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)

Plugins\Img Pictures\clean-sidebar.png?%BarPosition%,0,259,700
if "%MultiWindow_Count%"=="1" (set /a MultiWindow_Count+=1&goto :eof)
if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=0)
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>

:clean_withoutDe
if exist "Symbol\developer_mode-overlay.fxl" echo.�����ڣ�clean_withoutDe
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
::ͬ��������
set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
	    set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
		set Right_X1=400&SET Right_X2=800&SET Right_Y1=0&SET Right_Y2=600
	)
    if "%ModuleName%"=="%jump2%" (
	    set Left_X1=0&SET Left_X2=400&SET Left_Y1=0&SET Left_Y2=600
	    set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
	)
)
call :HFunc_MouseClick

if %x% geq 16 if %x% leq 69 if %y% geq 16 if %y% leq 51 (
goto leaveDe)

if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=clean
set HUOCHAI_JumpCode=clean
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq %X1% if %x% leq %X2% if %y% geq %Y1% if %y% leq %Y2% goto Quick_Control_Bar_WithoutDe

if %x% geq %Left_X1% if %x% leq %Left_X2% if %y% geq %Left_Y1% if %y% leq %Left_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Left_X1:%Left_X1%/Left_X2:%Left_X2%/Left_Y1:%Left_Y1%/Left_Y2:%Left_Y2%/%jump1%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump1%
)
if %x% geq %Right_X1% if %x% leq %Right_X2% if %y% geq %Right_Y1% if %y% leq %Right_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Right_X1:%Right_X1%/Right_X2:%Right_X2%/Right_Y1:%Right_Y1%/Right_Y2:%Right_Y2%/%jump2%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump2%
)

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
    ::ԭͼƬ��С
    set a=226
    set b=108
    ::ԭͼƬλ��
    set a1=18
    set b1=63
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set amon=
    set duty=main
	set fps=9
	::Plugins\Img Pictures\5.gif?207,95,20,20,1,5
	if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
	Plugins\Image /d
Functional_Components.exe 1
if "%MultiWindow_Exist%"=="1" (echo.1>Symbol\Motionoff_Internal_bus.fxl&goto MultiProcess_Jump)
set name=clean
set HUOCHAI_JumpCode=clean
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    ::ԭͼƬ��С
    set a=100
    set b=21
    ::ԭͼƬλ��
    set a1=34
    set b1=357
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set amon=
    set duty=main
	set fps=10
	::Plugins\Img Pictures\5.gif?207,172,20,20,1,5
	if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 5
if "%MultiWindow_Exist%"=="1" (echo.1>Symbol\Motionoff_Internal_bus.fxl&goto MultiProcess_Jump)
set name=clean
set HUOCHAI_JumpCode=clean
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

goto clean_withoutDe


:edit
::--------------------------------------
::Module Version��Edit2.1.0.6
::UpdateDate:2023-11-19
::--------------------------------------
set ModuleName=edit
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-add>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
		if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
		if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button2_clickX1=%button2_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
		if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button3_clickX1=%button3_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
		Plugins\Img Pictures\MultiWinLine_White.png?175,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?584,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?584,568)
	)
    if "%ModuleName%"=="%jump2%" (
		Plugins\Img Pictures\MultiWinLine_White.png?584,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?175,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?175,568)
	)
)

if "%MultiWindow_Exist%"=="1" (
    if "%MultiWindow_Count%"=="0" (goto edit_withoutDe)
	)
::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if "%MultiWindow_Count%"=="2" (set BarPosition=400) else (set BarPosition=0)
if "%duty%"=="bar" (Plugins\Img Pictures\edit-sidebar.png?260,0,259,700&set duty=&goto safe_withoutDe)
::�����˵�����
if exist "Symbol\DarkMode.fxl" (set name=edit-1-1-night.png) else set name=edit-1-1.png
set symbol=head
if not exist "Symbol\mini.fxl" (
    if "%MultiWindow_Count%"=="0" (
	call :QE_secondary_menu
	)
)

::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)

Plugins\Img Pictures\edit-sidebar.png?%BarPosition%,0,259,700
if "%MultiWindow_Count%"=="1" (set /a MultiWindow_Count+=1&goto :eof)
if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=0)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:edit_withoutDe
if exist "Symbol\developer_mode-overlay.fxl" echo.�����ڣ�edit_withoutDe
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)


if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
::ͬ��������
set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
	    set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
		set Right_X1=400&SET Right_X2=800&SET Right_Y1=0&SET Right_Y2=600
	)
    if "%ModuleName%"=="%jump2%" (
	    set Left_X1=0&SET Left_X2=400&SET Left_Y1=0&SET Left_Y2=600
	    set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
	)
)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=edit
set HUOCHAI_JumpCode=edit
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
::����
if %x% geq 16 if %x% leq 69 if %y% geq 16 if %y% leq 51 (
goto leaveDe)

if %x% geq %X1% if %x% leq %X2% if %y% geq %Y1% if %y% leq %Y2% goto Quick_Control_Bar_WithoutDe

if %x% geq %Left_X1% if %x% leq %Left_X2% if %y% geq %Left_Y1% if %y% leq %Left_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Left_X1:%Left_X1%/Left_X2:%Left_X2%/Left_Y1:%Left_Y1%/Left_Y2:%Left_Y2%/%jump1%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump1%
)
if %x% geq %Right_X1% if %x% leq %Right_X2% if %y% geq %Right_Y1% if %y% leq %Right_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Right_X1:%Right_X1%/Right_X2:%Right_X2%/Right_Y1:%Right_Y1%/Right_Y2:%Right_Y2%/%jump2%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump2%
)
::�޸�
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
    ::ԭͼƬ��С
    set a=226
    set b=108
    ::ԭͼƬλ��
    set a1=18
    set b1=63
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
    
	set amon=
    set duty=main
	set fps=9
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 3
if "%MultiWindow_Exist%"=="1" (echo.1>Symbol\Motionoff_Internal_bus.fxl&goto MultiProcess_Jump)
set name=edit
set HUOCHAI_JumpCode=edit
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)
::ɾ��
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    ::ԭͼƬ��С
    set a=110
    set b=110
    ::ԭͼƬλ��
    set a1=18
    set b1=182
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	set amon=
    set duty=main
	set fps=9
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 2
if "%MultiWindow_Exist%"=="1" (echo.1>Symbol\Motionoff_Internal_bus.fxl&goto MultiProcess_Jump)
set name=edit
set HUOCHAI_JumpCode=edit
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

::if %x% geq 139 if %x% leq 238 if %y% geq 188 if %y% leq 286 goto clean-button3
::if %x% geq 32 if %x% leq 127 if %y% geq 358 if %y% leq 381 goto clean-button4
::
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
    ::ԭͼƬ��С
    set a=100
    set b=21
    ::ԭͼƬλ��
    set a1=34
    set b1=357
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
	set amon=
    set duty=main
	set fps=10
	if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 5
if "%MultiWindow_Exist%"=="1" (echo.1>Symbol\Motionoff_Internal_bus.fxl&goto MultiProcess_Jump)
set name=edit
set HUOCHAI_JumpCode=edit
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

goto edit_withoutDe

:safe
::--------------------------------------
::Module Version��Safe2.1.0.6
::UpdateDate:2023-11-19
::--------------------------------------
set ModuleName=safe
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-safe>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button2_clickX1=%button2_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button3_clickX1=%button3_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button4_clickX1=%button4_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
		Plugins\Img Pictures\MultiWinLine_White.png?175,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?584,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?584,568)
	)
    if "%ModuleName%"=="%jump2%" (
		Plugins\Img Pictures\MultiWinLine_White.png?584,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?175,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?175,568)
	)
)

if "%MultiWindow_Exist%"=="1" (
    if "%MultiWindow_Count%"=="0" (goto safe_withoutDe)
)
if "%MultiWindow_Count%"=="2" (set BarPosition=400) else (set BarPosition=0)
if "%duty%"=="bar" (Plugins\Img Pictures\safe-sidebar.png?260,0,259,700&set duty=&goto safe_withoutDe)
::�����˵�����
if exist "Symbol\DarkMode.fxl" (set name=safe-1-1-night.png) else set name=safe-1-1.png
set symbol=head
if not exist "Symbol\mini.fxl" (
if "%MultiWindow_Exist%" NEQ "1" (
        if "%MultiWindow_Count%"=="0" (
	        call :QE_secondary_menu
	    )
	)
)

::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)

Plugins\Img Pictures\safe-sidebar.png?%BarPosition%,0,259,700
if "%MultiWindow_Count%"=="1" (set /a MultiWindow_Count+=1&goto :eof)
if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=0)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:safe_withoutDe
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)


if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
::ͬ��������
set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
	    set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
		set Right_X1=400&SET Right_X2=800&SET Right_Y1=0&SET Right_Y2=600
	)
    if "%ModuleName%"=="%jump2%" (
	    set Left_X1=0&SET Left_X2=400&SET Left_Y1=0&SET Left_Y2=600
	    set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
	)
)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (
        mode con: cols=65 lines=37) else (
        mode con: cols=100 lines=37
	)
    set name=safe
    set HUOCHAI_JumpCode=safe
    set x1=0&set y1=0&set x=800&set y=600
    goto MainInterface_leaveWithoutDe
)
if %x% geq 16 if %x% leq 69 if %y% geq 16 if %y% leq 51 (
goto leaveDe)
if %x% geq %X1% if %x% leq %X2% if %y% geq %Y1% if %y% leq %Y2% goto Quick_Control_Bar_WithoutDe

if %x% geq %Left_X1% if %x% leq %Left_X2% if %y% geq %Left_Y1% if %y% leq %Left_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Left_X1:%Left_X1%/Left_X2:%Left_X2%/Left_Y1:%Left_Y1%/Left_Y2:%Left_Y2%/%jump1%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump1%
)
if %x% geq %Right_X1% if %x% leq %Right_X2% if %y% geq %Right_Y1% if %y% leq %Right_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Right_X1:%Right_X1%/Right_X2:%Right_X2%/Right_Y1:%Right_Y1%/Right_Y2:%Right_Y2%/%jump2%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump2%
)


if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
    set name=safe
    if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
	if "%MultiWindow_Exist%"=="1" (
	    if "%ModuleName%"=="%jump2%" (
	        call :QE_menu_rolled
	    )
	)
    goto safe-rank
)
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
     ::ԭͼƬ��С
     set a=110
     set b=110
     ::ԭͼƬλ��
     set a1=18
     set b1=182
     ::�Ŵ��ͼƬ��С
     set x=800
     set y=594
     ::�Ŵ��ͼƬλ��
     set x1=0
     set y1=0
     if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	 set amon=
     set duty=main
	 set fps=9
	 if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	 
	 
	 if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 7
if "%MultiWindow_Exist%"=="1" (echo.1>Symbol\Motionoff_Internal_bus.fxl&goto MultiProcess_Jump)
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)
)
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
     ::ԭͼƬ��С
     set a=109
     set b=109
     ::ԭͼƬλ��
     set a1=133
     set b1=183
     ::�Ŵ��ͼƬ��С
     set x=800
     set y=594
     ::�Ŵ��ͼƬλ��
     set x1=0
     set y1=0
     if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	 set amon=
     set duty=main
	 set fps=9
	 if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	 if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 5
if "%MultiWindow_Exist%"=="1" (echo.1>Symbol\Motionoff_Internal_bus.fxl&goto MultiProcess_Jump)
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
    set name=safe
    if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
	if "%MultiWindow_Exist%"=="1" (
	    if "%ModuleName%"=="%jump2%" (
	        call :QE_menu_rolled
	    )
	)
    goto safe-beifen
)
goto safe_withoutDe

:safe-rank
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%

::-----------------------------------------------QyulEngine--------
    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=safe-rank-dark.png) else set name=safe-rank.png
call :QE_secondary_menu

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:safe-rankWithoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=safe
set HUOCHAI_JumpCode=safe
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set name=safe&call :HFunc_Reload_color&goto safe) else (goto leaveDe))

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
call Functional_Components.exe 6 2
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
call Functional_Components.exe 6 1
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
call Functional_Components.exe 6 4
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (
if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
call Functional_Components.exe 6 3
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (call :QE_secondary_menu-emphasize&goto safe-rankWithoutDe)
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    ::ԭͼƬ��С
    set a=110
    set b=110
    ::ԭͼƬλ��
    set a1=18
    set b1=182
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	set amon=
    set duty=main
	set fps=9
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 7
set name=safe
set HUOCHAI_JumpCode=safe
goto MainInterface_leaveWithoutDe)
)
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
    ::ԭͼƬ��С
    set a=109
    set b=109
    ::ԭͼƬλ��
    set a1=133
    set b1=183
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	set amon=
    set duty=main
	set fps=9
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 5
set name=safe
set HUOCHAI_JumpCode=safe
goto MainInterface_leaveWithoutDe)
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto safe-beifen
goto safe-rankWithoutDe

:safe-beifen
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=safe4-1-dark.png) else set name=safe4-1.png
call :QE_secondary_menu

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:safe-beifenWithoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=safe
set HUOCHAI_JumpCode=safe
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set name=safe&call :HFunc_Reload_color&goto safe) else (goto leaveDe))

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
call Functional_Components.exe 4 1
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
call Functional_Components.exe 4 2
set name=safe
set HUOCHAI_JumpCode=safe
del Symbol\QuickControl.fxl>nul 2>nul
goto MainInterface_leaveWithoutDe)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto safe-rank
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    ::ԭͼƬ��С
    set a=110
    set b=110
    ::ԭͼƬλ��
    set a1=18
    set b1=182
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	set amon=
    set duty=main
	set fps=9
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 7
set name=safe
set HUOCHAI_JumpCode=safe
goto MainInterface_leaveWithoutDe)
)
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
    ::ԭͼƬ��С
    set a=109
    set b=109
    ::ԭͼƬλ��
    set a1=133
    set b1=183
    ::�Ŵ��ͼƬ��С
    set x=800
    set y=594
    ::�Ŵ��ͼƬλ��
    set x1=0
    set y1=0
    if exist "Symbol\DarkMode.fxl" (set name=darkblack) else set name=gray
	set amon=
    set duty=main
	set fps=9
	if not exist "Motionoff.fxl" set /p fps=<Symbol\fps.data&call :QE_open_subroutine
	if exist "Symbol\DarkMode.fxl" (color 00) else color 78
Plugins\Image /d
Functional_Components.exe 5
set name=safe
set HUOCHAI_JumpCode=safe
goto MainInterface_leaveWithoutDe)
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (call :QE_secondary_menu-emphasize&goto safe-beifenWithoutDe)
goto safe-beifenWithoutDe


:tools
::--------------------------------------
::Module Version��Tools2.1.0.6
::UpdateDate:2023-11-19
::--------------------------------------
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-tools>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if "%MultiWindow_Count%"=="2" (set BarPosition=400) else (set BarPosition=0)
if "%duty%"=="bar" (Plugins\Img Pictures\tools-sidebar.png?260,0,259,700&set duty=&goto safe_withoutDe)
::�����˵�����
if exist "Symbol\DarkMode.fxl" (set name=tools-1-1-night.png) else set name=tools-1-1.png
set symbol=head
if not exist "Symbol\mini.fxl" (
    if "%MultiWindow_Count%"=="0" (
	call :QE_secondary_menu
	)
)

::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)

Plugins\Img Pictures\tools-sidebar.png?%BarPosition%,0,259,700
if "%MultiWindow_Count%"=="1" (set /a MultiWindow_Count+=1&goto :eof)
if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=0)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:tools_withoutDe
set position=467
if not exist "Symbol\QuickControl.fxl" (set /a position=%position%-260)
if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)

call :HFunc_MouseClick

if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=safe
set HUOCHAI_JumpCode=tools
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 16 if %x% leq 69 if %y% geq 16 if %y% leq 51 (
goto leaveDe)

if %x% geq %X1% if %x% leq %X2% if %y% geq %Y1% if %y% leq %Y2% goto Quick_Control_Bar_WithoutDe

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
if exist "student_information.csv" (
Plugins\Img Pictures\5.gif?%position%,95,20,20,1,10
call student_information.csv
Plugins\Img Pictures\5.gif?%position%,95,20,20,1,10
TASKKILL /F /IM Excel.exe /T>nul 2>nul) else (
call :help
echo.1>Symbol\Motionoff_Internal_bus.fxl
set name=safe
call :HFunc_Reload_color
goto tools
)
echo.1>Symbol\Motionoff_Internal_bus.fxl
set name=safe
call :HFunc_Reload_color
goto tools)
goto tools_withoutDe


:settings
::--------------------------------------
::Module Version��Settings5.3.0
::UpdateDate:2023-12-16
::--------------------------------------
set ModuleName=settings
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-settings>>RunningData.log
:settings_Button
::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button1_clickX1=%button1_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button1_clickX1=%button1_clickX1%+260)
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button2_clickX1=%button2_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button2_clickX1=%button2_clickX1%+260)
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button3_clickX1=%button3_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button3_clickX1=%button3_clickX1%+260)
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
			if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump2%" (set /a button4_clickX1=%button4_clickX1%+400)
)
    ::����
	if "%duty%"=="bar" (set /a button4_clickX1=%button4_clickX1%+260)
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
		Plugins\Img Pictures\MultiWinLine_White.png?175,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?584,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?584,568)
	)
    if "%ModuleName%"=="%jump2%" (
		Plugins\Img Pictures\MultiWinLine_White.png?584,568
		if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\MultiWinLine_black.png?175,568) else (Plugins\Img Pictures\MultiWinLine_gray.png?175,568)
	)
)

if "%MultiWindow_Exist%"=="1" (
    if "%MultiWindow_Count%"=="0" (goto settings_withoutDe)
)
if "%MultiWindow_Count%"=="2" (set BarPosition=400) else (set BarPosition=0)

if "%duty%"=="bar" (Plugins\Img Pictures\settings-sidebar.png?260,0,259,700&set duty=&goto settings_withoutDe)

::�����˵�����
if exist "Symbol\DarkMode.fxl" (set name=settings-1-1-night.png) else (set name=settings-1-1.png)
set symbol=head
if not exist "Symbol\mini.fxl" (
if "%MultiWindow_Exist%" NEQ "1" (
        if "%MultiWindow_Count%"=="0" (
	        call :QE_secondary_menu
	    )
	)
)

::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)

Plugins\Img Pictures\settings-sidebar.png?%BarPosition%,0,259,700
if "%MultiWindow_Count%"=="1" (set /a MultiWindow_Count+=1&goto :eof)
if "%MultiWindow_Count%"=="2" (set MultiWindow_Count=0)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:settings_withoutDe
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-settings>>RunningData.log

if exist "Symbol\QuickControl.fxl" (set X1=11&set X2=246&set Y1=68&set Y2=467) else (set X1=800&set X2=800&set Y1=600&set Y2=600)
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
::ͬ��������
set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
if "%MultiWindow_Exist%"=="1" (
    if "%ModuleName%"=="%jump1%" (
	    set Left_X1=800&SET Left_X2=801&SET Left_Y1=600&SET Left_Y2=601
		set Right_X1=400&SET Right_X2=800&SET Right_Y1=0&SET Right_Y2=600
	)
    if "%ModuleName%"=="%jump2%" (
	    set Left_X1=0&SET Left_X2=400&SET Left_Y1=0&SET Left_Y2=600
	    set Right_X1=800&SET Right_X2=801&SET Right_Y1=600&SET Right_Y2=601
	)
)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (
        mode con: cols=65 lines=37) else (
        mode con: cols=100 lines=37
	)
    ::if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
    set name=settings
    set HUOCHAI_JumpCode=settings
    set x1=0&set y1=0&set x=800&set y=600
    goto MainInterface_leaveWithoutDe
)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 goto leaveDe

if %x% geq %X1% if %x% leq %X2% if %y% geq %Y1% if %y% leq %Y2% goto Quick_Control_Bar_WithoutDe

if %x% geq %Left_X1% if %x% leq %Left_X2% if %y% geq %Left_Y1% if %y% leq %Left_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Left_X1:%Left_X1%/Left_X2:%Left_X2%/Left_Y1:%Left_Y1%/Left_Y2:%Left_Y2%/%jump1%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump1%
)
if %x% geq %Right_X1% if %x% leq %Right_X2% if %y% geq %Right_Y1% if %y% leq %Right_Y2% (
    if exist "Symbol\developer_mode-overlay.fxl" echo.Right_X1:%Right_X1%/Right_X2:%Right_X2%/Right_Y1:%Right_Y1%/Right_Y2:%Right_Y2%/%jump2%_withoutDe/�����ڣ�%ModuleName%_withoutDe
	goto %jump2%
)

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (
set name=settings
if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
	if "%MultiWindow_Exist%"=="1" (
	    if "%ModuleName%"=="%jump2%" (
	        call :QE_menu_rolled
	    )
	)
goto surface)

if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
set name=settings
if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
	if "%MultiWindow_Exist%"=="1" (
	    if "%ModuleName%"=="%jump2%" (
	        call :QE_menu_rolled
	    )
	)
goto xiufu)

if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (
set name=settings
if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
	if "%MultiWindow_Exist%"=="1" (
	    if "%ModuleName%"=="%jump2%" (
	        call :QE_menu_rolled
	    )
	)
goto update)

if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (
set name=settings
if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
	if "%MultiWindow_Exist%"=="1" (
	    if "%ModuleName%"=="%jump2%" (
	        call :QE_menu_rolled
	    )
	)
goto schema)
set duty=1
goto settings_withoutDe

:schema
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-schema>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%

::-----------------------------------------------QyulEngine--------
    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

::-----------------------------------------------���������--------
    ::��ť��С�����˿�
    set button9_sizeX=295
	set button9_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button9_clickX1=301
	set button9_clickY1=374
	::����
    if exist "Symbol\mini.fxl" (set /a button9_clickX1=%button9_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button9_clickY1=%button9_clickY1%)
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:schema_withSurface
if exist "Symbol\DarkMode.fxl" (set name=tool-schema-night.png) else set name=tool-schema.png
call :QE_secondary_menu

:schema_widget
set storage=0
for /f "delims=" %%a in ('dir /b *.log') do (set /a "storage+=%%~za/1024")
if %storage% GEQ 0 (set judge_size_of_log=green)
if %storage% GEQ 5940 (set judge_size_of_log=yellow)
if %storage% GEQ 10000 (set judge_size_of_log=red)
if exist "Symbol\developer_mode-overlay.fxl" echo.%storage%,%judge_size_of_log%
set storage=0
set position=550
set position2=557
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\mini.fxl" (set /a position2=%position2%-260)
Plugins\Img Pictures\%judge_size_of_log%.png?%position2%,190
::Plugins\Img Pictures\white.png?217,100,7,11
::Plugins\Img Pictures\white.png?217,177,7,11
::Plugins\Img Pictures\white.png?217,254,7,11
::Plugins\Img Pictures\white.png?217,331,7,11
::Plugins\Img Pictures\arrow.png?217,331

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:schema_withoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set BackgroundColor=settings&call :HFunc_Reload_color&goto settings) else (goto leaveDe))

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
Plugins\Img Pictures\5.gif?%position%,183,20,20,1,5
del RunningData.log>nul
echo._______>>RunningData.log
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-����Ӧ�ó���>>RunningData.log
echo.Ӧ�ó���汾��V2.1.%HUOCHAI_Version%>>RunningData.log
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto schema)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
Plugins\Img Pictures\5.gif?%position%,234,20,20,1,5
call :HFunc_Reset

set name=settings
call :HFunc_Reload_color

if exist "Symbol\DarkMode.fxl" (set name=tool-schema-night.png) else set name=tool-schema.png
set symbol=head
call :QE_secondary_menu
del Motionoff.fxl>nul 2>nul
if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\settings-sidebar.png?0,0,259,700)
goto schema_widget
)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% goto schema-key
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% goto developer
::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% (call :QE_secondary_menu-emphasize&goto schema_widget)
goto schema_withoutDe
:schema-key
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-schema-key_withoutDe>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:schema-key-widget
if exist "Symbol\DarkMode.fxl" (set name=tool-schema-key-dark.png) else (set name=tool-schema-key.png)
set symbol=
call :QE_secondary_menu
set position=550
if exist "Symbol\mini.fxl" (set /a position=%position%-260)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:schema-key_withoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto schema) else (goto leaveDe))
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (goto schema)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% goto schema-key-1

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% call :schema-key-2

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto schema-key_withoutDe

:schema-key-1
::�ж��Ƿ���Ҫ��֤����
if exist "$key.key" call :key&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key-1-1
if not exist "$key.key" call :messagebox&start warning\create_completely.vbs&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key 

:schema-key-1-1
::�ж������Ƿ���ȷ
if "%point%"=="1" call :messagebox&start warning\create_completely.vbs&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key
if "%point%"=="2" start warning\wrong_key.vbs&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key
goto schema-key
:schema-key-2
::�ж��Ƿ���Ҫ��֤����
if exist "$key.key" call :key&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key-2-1
if not exist "$key.key" start warning\no_key.vbs&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key 
:schema-key-2-1
::�ж������Ƿ���ȷ
if "%point%"=="1" del Password_auth.fxl&del $key.key&start warning\delete_completely.vbs&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key
if "%point%"=="2" start warning\wrong_key.vbs&echo.1>Symbol\Motionoff_Internal_bus.fxl&goto schema-key

:messagebox
set "title=����������"
set "message=�������¹���Ա����"
set "note="
set "speak="
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
if "%speak%" neq "" del $key.key>nul 2>nul&echo.%speak%>$key.key
if "%speak%" neq "" echo.firstuse>Password_auth.fxl
goto :eof

:developer
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-qyul>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------button5--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------button6--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------button7--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%

::-----------------------------------------------button8--------
    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

::-----------------------------------------------button9--------
    ::��ť��С�����˿�
    set button9_sizeX=295
	set button9_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button9_clickX1=301
	set button9_clickY1=374
	::����
    if exist "Symbol\mini.fxl" (set /a button9_clickX1=%button9_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button9_clickY1=%button9_clickY1%)
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%

::-----------------------------------------------button10--------
    ::��ť��С�����˿�
    set button10_sizeX=295
	set button10_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button10_clickX1=301
	set button10_clickY1=425
	::����
    if exist "Symbol\mini.fxl" (set /a button10_clickX1=%button10_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button10_clickY1=%button10_clickY1%)
    set /a button10_clickX2=%button10_sizeX%+%button10_clickX1%
    set /a button10_clickY2=%button10_sizeY%+%button10_clickY1%

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=tool-schema-developer-dark.png) else (set name=tool-schema-developer.png)
set symbol=
call :QE_secondary_menu
:developer-qyul_widget
set position=535
set position2=550
if exist "Symbol\mini.fxl" (set /a position2=%position2%-260)

if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\developer_mode.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,182) else Plugins\Img Pictures\��%button_mode%.png?%position%,182
if exist "Symbol\developer_mode-overlay.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,233) else Plugins\Img Pictures\��%button_mode%.png?%position%,233
if exist "Symbol\LogRecoder_OFF.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,336) else Plugins\Img Pictures\��%button_mode%.png?%position%,336

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:developer-qyul_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto schema) else (goto leaveDe))
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (goto schema)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
if exist "Symbol\developer_mode.fxl" (del Symbol\developer_mode.fxl) else echo.1>Symbol\developer_mode.fxl
goto developer-qyul_widget)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
if exist "Symbol\developer_mode-overlay.fxl" (del Symbol\developer_mode-overlay.fxl) else echo.1>Symbol\developer_mode-overlay.fxl
goto developer-qyul_widget)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
Plugins\Img Pictures\5.gif?%position2%,284,20,20,1,5
call RunningData.log
Plugins\Img Pictures\5.gif?%position2%,284,20,20,1,5
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto developer)
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (
if exist "Symbol\LogRecoder_OFF.fxl" (del Symbol\LogRecoder_OFF.fxl) else echo.0>Symbol\LogRecoder_OFF.fxl
goto developer-qyul_widget)
::if %x% geq %button9_clickX1% if %x% leq %button9_clickX2% if %y% geq %button9_clickY1% if %y% leq %button9_clickY2% (
::goto developer-comp)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto developer-qyul_withoutDe

:developer-comp
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-qyul>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------button5--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------button6--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------button7--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%

::-----------------------------------------------button8--------
    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

::-----------------------------------------------button9--------
    ::��ť��С�����˿�
    set button9_sizeX=295
	set button9_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button9_clickX1=301
	set button9_clickY1=374
	::����
    if exist "Symbol\mini.fxl" (set /a button9_clickX1=%button9_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button9_clickY1=%button9_clickY1%)
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%

::-----------------------------------------------button10--------
    ::��ť��С�����˿�
    set button10_sizeX=295
	set button10_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button10_clickX1=301
	set button10_clickY1=425
	::����
    if exist "Symbol\mini.fxl" (set /a button10_clickX1=%button10_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button10_clickY1=%button10_clickY1%)
    set /a button10_clickX2=%button10_sizeX%+%button10_clickX1%
    set /a button10_clickY2=%button10_sizeY%+%button10_clickY1%
	
::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=tool-schema-developer-comp-dark.png) else (set name=tool-schema-developer-comp.png)
set symbol=
call :QE_secondary_menu
:developer-comp_widget
set position=535
set position2=550
if exist "Symbol\mini.fxl" (set /a position2=%position2%-260)

if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\developer-comp.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,336) else Plugins\Img Pictures\��%button_mode%.png?%position%,336
::---------------------------------------------
::��ɫģʽ
if exist "nightmode.fxl" (set darkmodeCHECK=GREEN) else (set darkmodeCHECK=RED)

::��Ч���
set motionCHECK=0
if exist "linear_motion.fxl" (set /a motionCHECK=%motionCHECK%+1)
if exist "fps.data" (set /a motionCHECK=%motionCHECK%+1)
set motionCHECK=Red
if "%motionCHECK%" gtr "1" (set motionCHECK=GREEN)

::�രЭͬ��ť
if exist "synergism_off.fxl" (set ProcessPlusCHECK=GREEN) else (set ProcessPlusCHECK=RED)

::����Ա����
set passwdCHECK=0
if exist "firstuse.fxl" (set passwdCHECK=%passwdCHECK%+1)
if exist "$key.key" (set passwdCHECK=%passwdCHECK%+1)
if "%passwdCHECK%"=="2" (set passwdCHECK=GREEN)
if "%passwdCHECK%" NEQ "2" (set passwdCHECK=RED)

::������Աѡ��

::---------------------------------------------
set position3=382
set position4=462
set position5=566
if exist "Symbol\mini.fxl" (set /a position3=%position3%-260)
if exist "Symbol\mini.fxl" (set /a position4=%position4%-260)
if exist "Symbol\mini.fxl" (set /a position5=%position5%-260)
Plugins\Img Pictures\%darkmodeCHECK%.png?%position3%,216
Plugins\Img Pictures\%motionCHECK%.png?%position3%,243
Plugins\Img Pictures\%ProcessPlusCHECK%.png?%position4%,216
Plugins\Img Pictures\red.png?%position4%,243
Plugins\Img Pictures\red.png?%position5%,216
Plugins\Img Pictures\%passwdCHECK%.png?%position5%,243
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:developer-comp_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto schema) else (goto leaveDe))
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (goto developer)


if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
Plugins\Img Pictures\5.gif?%position2%,284,20,20,1,5
call RunningData.log
Plugins\Img Pictures\5.gif?%position2%,284,20,20,1,5
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto developer-comp)
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (
if exist "Symbol\developer-comp.fxl" (del Symbol\developer-comp.fxl) else echo.0>Symbol\developer-comp.fxl
goto developer-comp_widget)


::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto developer-comp_withoutDe

:surface
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=45
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=96
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%

::-----------------------------------------------QyulEngine--------
    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=374
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

::-----------------------------------------------���������--------
    ::��ť��С�����˿�
    set button9_sizeX=295
	set button9_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button9_clickX1=301
	set button9_clickY1=425
	::����
    if exist "Symbol\mini.fxl" (set /a button9_clickX1=%button9_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button9_clickY1=%button9_clickY1%)
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%

::-----------------------------------------------���������--------
    ::��ť��С�����˿�
    set button10_sizeX=200
	set button10_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button10_clickX1=301
	set button10_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button10_clickX1=%button10_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button10_clickY1=%button10_clickY1%)
    set /a button10_clickX2=%button10_sizeX%+%button10_clickX1%
    set /a button10_clickY2=%button10_sizeY%+%button10_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=tool-surface-dark.png) else (set name=tool-surface.png)
call :QE_secondary_menu

:surface_Widget
set position=535
if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)
if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,286) else Plugins\Img Pictures\��%button_mode%.png?%position%,286

set background=background
if exist "Symbol\DarkMode.fxl" (set darkmode=-dark) else set darkmode=
if exist "Symbol\DarkMode.fxl" (
    if exist "Skin\SkinPackage\dark.fxl" (set background=background-dark))
if exist "Symbol\mini.fxl" (Plugins\Img skin\SkinPackage\%background%.png?195,180,100,75) else (Plugins\Img skin\SkinPackage\%background%.png?455,180,100,75)
if exist "Symbol\mini.fxl" (Plugins\Img Pictures\mask-angle%darkmode%.png?195,180,100,75) else (Plugins\Img Pictures\mask-angle%darkmode%.png?455,180,100,75)


::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set BackgroundColor=settings&call :HFunc_Reload_color&goto settings) else (goto leaveDe))
if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% goto surface-skin
if %x% geq %button10_clickX1% if %x% leq %button10_clickX2% if %y% geq %button10_clickY1% if %y% leq %button10_clickY2% (goto surface-darkmode)
if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
if exist "Symbol\mini.fxl" (set x1=0) else set x1=260
set y1=0
if exist "Symbol\DarkMode.fxl" (del Symbol\DarkMode.fxl) else echo.1>Symbol\DarkMode.fxl
set BackgroundColor=settings
echo.1>Symbol\Motionoff_Internal_bus.fxl
call :HFunc_Reload_color
if exist "Symbol\DarkMode.fxl" (set name=tool-surface-dark.png) else (set name=tool-surface.png)
set symbol=head
call :QE_secondary_menu
if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\settings-sidebar.png?0,0,259,700)
goto surface_Widget)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% goto surface-qyul
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% goto surface-higheff
if %x% geq %button9_clickX1% if %x% leq %button9_clickX2% if %y% geq %button9_clickY1% if %y% leq %button9_clickY2% goto surface-multiProcess
::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% (call :QE_secondary_menu-emphasize&goto surface_Widget)
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface_withoutDe

:surface-multiProcess
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-skin>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-schema>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%

::-----------------------------------------------QyulEngine--------
    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

::-----------------------------------------------���������--------
    ::��ť��С�����˿�
    set button9_sizeX=295
	set button9_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button9_clickX1=301
	set button9_clickY1=374
	::����
    if exist "Symbol\mini.fxl" (set /a button9_clickX1=%button9_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button9_clickY1=%button9_clickY1%)
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=settings-surface-MultiWin-dark.png) else (set name=settings-surface-MultiWin.png)
call :QE_secondary_menu

:surface-multiProcess_widget
if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
set position=535
set position2=550
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\mini.fxl" (set /a position2=%position2%-260)
if exist "Symbol\SynWinQC.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,183) else (Plugins\Img Pictures\��%button_mode%.png?%position%,183)
Plugins\Img Pictures\��%button_mode%.png?%position%,234
Plugins\Img Pictures\��%button_mode%.png?%position%,285
call :HFunc_TimeDelay

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-multiProcess_withoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto surface) else (goto leaveDe))
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (goto surface)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
    if exist "Symbol\SynWinQC.fxl" (del Symbol\SynWinQC.fxl) else (echo.1>Symbol\SynWinQC.fxl)
	goto surface-multiProcess_widget
)
::if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% goto skin-adding
::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% goto surface-multiProcess-Func
if %x% geq %button9_clickX1% if %x% leq %button9_clickX2% if %y% geq %button9_clickY1% if %y% leq %button9_clickY2% (
    Plugins\Img Pictures\5.gif?%position2%,386,20,20,1,5
    call Help\Intro_SynMulti.txt
    Plugins\Img Pictures\5.gif?%position2%,386,20,20,1,5
    echo.1>Symbol\Motionoff_Internal_bus.fxl
    goto surface-multiProcess
	)
::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface-multiProcess_withoutDe

:surface-multiProcess-Func
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-qyul-velocity>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
set secon_symbol=?
set symbol=head
if exist "Symbol\DarkMode.fxl" (set name=surface-multiProcess-Func-dark.png) else set name=surface-multiProcess-Func.png
call :QE_secondary_menu
set secon_symbol=:

set symbol=head
:surface-multiProcess-Func_Widget
set position=260
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
Plugins\Img Pictures\%name%?%position%,0
set position=295
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\DarkMode.fxl" (set suffix=-dark) else (set suffix=)
set /p MultiProcessFunc=<Symbol\MultiProcessFunc.data
if "%MultiProcessFunc%"=="Windows" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,171,288,42)
if "%MultiProcessFunc%"=="Function" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,222,288,42)
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-multiProcess-Func_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
set symbol=head
set secon_symbol=:
if exist "Symbol\mini.fxl" (goto surface-qyul) else (goto leaveDe)
)

if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (
set symbol=head
set secon_symbol=:
::echo.1>Symbol\Motionoff_Internal_bus.fxl
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto surface-multiProcess)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
del Symbol\MultiProcessFunc.data>nul 2>nul
echo.Windows>Symbol\MultiProcessFunc.data
goto surface-multiProcess-Func_Widget)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
del Symbol\MultiProcessFunc.data>nul 2>nul
echo.Function>Symbol\MultiProcessFunc.data
goto surface-multiProcess-Func_Widget)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface-multiProcess-Func_withoutDe

:surface-skin
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-skin>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------����--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=147
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------�����--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���������ֽ--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=373
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=surface-skin-dark.png) else set name=surface-skin.png
call :QE_secondary_menu
:surface-skin_widget
set background=background
if exist "Symbol\DarkMode.fxl" (
    if exist "Skin\SkinPackage\dark.fxl" (set background=background-dark))

if exist "Symbol\mini.fxl" (Plugins\Img skin\SkinPackage\%background%.png?158,187,162,114) else (Plugins\Img skin\SkinPackage\%background%.png?418,187,162,114)

::if exist "Symbol\DarkMode.fxl" (
::Plugins\Img Pictures\11.png?420,187,162,114
::Plugins\Img Pictures\11.png?420,187,162,114)
::Plugins\Img Pictures\main.png?420,187,162,114
::Plugins\Img Pictures\main.png?420,187,162,114
::Plugins\Img Pictures\maint.png?420,187,162,114
if exist "Symbol\DarkMode.fxl" (set darkmode=-dark) else set darkmode=
if exist "Symbol\mini.fxl" (Plugins\Img Pictures\mask-angle%darkmode%.png?158,187,162,114) else (Plugins\Img Pictures\mask-angle%darkmode%.png?418,187,162,114)
if exist "Skin\SkinPackage\dark.fxl" (
    if exist "Symbol\mini.fxl" (Plugins\Img Pictures\mask-darklight.png?158,187,162,114) else (Plugins\Img Pictures\mask-darklight.png?418,187,162,114)
)
set position=550
if exist "Symbol\mini.fxl" (set /a position=%position%-260)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-skin_withoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto surface) else (goto leaveDe))
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (goto surface)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% goto skin-adding

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
Plugins\Img Pictures\5.gif?%position%,336,20,20,1,5
call URLs\wallpaper.url
Plugins\Img Pictures\5.gif?%position%,336,20,20,1,5
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto surface-skin)

::if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% goto update
::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface-skin_withoutDe


:skin-adding
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-skin>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=mask-new.png) else set name=mask-new.png
set secon_symbol=?
set symbol=head
SET QE_secondary_menu_DELTA=2
if exist "Symbol\mini.fxl" (Plugins\Img Pictures\11.png?0,0) else (Plugins\Img Pictures\11.png?260,0)
::if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace-dark.png?260,0) else (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace.png?260,0)
if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace-dark.png?260,0)

call :QE_secondary_menu
set secon_symbol=:
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:skin-adding_withoutDe
set X1=377&set X2=692&set Y1=183&set Y2=411
if exist "Symbol\mini.fxl" (set X1=117)
set symbol=head
set secon_symbol=:


call :HFunc_MouseClick
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set name=settings&call :HFunc_Reload_color&goto settings) else (goto leaveDe))
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (
set symbol=head
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto surface-skin)
if %x% geq %X1% if %x% leq %X2% if %y% geq %Y1% if %y% leq %Y2% (goto skin-adding_nowadding)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
if %x% geq 377 if %x% leq 692 if %y% geq 183 if %y% leq 411 (goto skin-adding_nowadding)
if %x% geq 0 if %x% leq 800 if %y% geq 0 if %y% leq 600 (goto skin-adding_withoutDe)
goto skin-adding_withoutDe

:skin-adding_nowadding
if exist "Symbol\mini.fxl" (Plugins\Img Pictures\15pc-black.png?102,127,337,324) else (Plugins\Img Pictures\15pc-black.png?362,127,337,324)
set path=
set /p path= 
del Skin\SkinPackage\*.png>nul 2>nul
del Skin\SkinPackage\dark.fxl>nul 2>nul
copy %path% %~dp0\Skin\SkinPackage >nul 2>nul
ren %~dp0\Skin\SkinPackage\*.* background.png >nul 2>nul
echo.1>Skin_Active.fxl
set path=c:\windows\system32
set symbol=
set secon_symbol=:

goto surface-skin


:surface-darkmode
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-skin>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------button5--------
    ::��ť��С�����˿�
    set button5_sizeX=322
	set button5_sizeY=89
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=364
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------button6--------
    ::��ť��С�����˿�
    set button6_sizeX=322
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=364
	set button6_clickY1=266
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=tool-surface-darkmode.png) else set name=tool-surface-darkmode.png
set secon_symbol=?
set symbol=head
SET QE_secondary_menu_DELTA=2
if exist "Symbol\mini.fxl" (Plugins\Img Pictures\11.png?0,0) else (Plugins\Img Pictures\11.png?260,0)

::if exist "Symbol\DarkMode.fxl" (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace-dark.png?260,0) else (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace.png?260,0)
if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\old_FluenceDesign_Pics\backspace-dark.png?260,0)

call :QE_secondary_menu
set secon_symbol=:
:surface-darkmode_Widgets
set position=634
if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "symbol\Auto_DarkMode.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,184) else Plugins\Img Pictures\��%button_mode%.png?%position%,184
if exist "symbol\dark_background.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,280) else Plugins\Img Pictures\��%button_mode%.png?%position%,280
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-darkmode_withoutDe
set X1=377&set X2=692&set Y1=183&set Y2=411
if exist "Symbol\mini.fxl" (set X1=117)
set symbol=head
set secon_symbol=:
call :HFunc_TimeDelay
call :HFunc_MouseClick
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set name=settings&call :HFunc_Reload_color&goto settings) else (goto leaveDe))
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (
set symbol=head
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto surface)
if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
if exist "symbol\Auto_DarkMode.fxl" (del symbol\Auto_DarkMode.fxl) else echo.0>symbol\Auto_DarkMode.fxl
goto surface-darkmode_Widgets
)
if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
if exist "symbol\dark_background.fxl" (del symbol\dark_background.fxl) else echo.0>symbol\dark_background.fxl
goto surface-darkmode_Widgets
)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema

goto surface-darkmode_withoutDe
:surface-higheff
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

    ::��ť��С�����˿�
    set button5_sizeX=292
	set button5_sizeY=48
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=304
	set button5_clickY1=211
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

    ::��ť��С�����˿�
    set button6_sizeX=292
	set button6_sizeY=48
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=304
	set button6_clickY1=261
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

    ::��ť��С�����˿�
    set button9_sizeX=295
	set button9_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button9_clickX1=301
	set button9_clickY1=374
	::����
    if exist "Symbol\mini.fxl" (set /a button9_clickX1=%button9_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button9_clickY1=%button9_clickY1%)
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%

    ::��ť��С�����˿�
    set button10_sizeX=295
	set button10_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button10_clickX1=301
	set button10_clickY1=425
	::����
    if exist "Symbol\mini.fxl" (set /a button10_clickX1=%button10_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button10_clickY1=%button10_clickY1%)
    set /a button10_clickX2=%button10_sizeX%+%button10_clickX1%
    set /a button10_clickY2=%button10_sizeY%+%button10_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=tool-surface-higheff-dark.png) else set name=tool-surface-higheff.png
call :QE_secondary_menu
:surface-higheff_Widget
if not exist "Symbol\synergism_off.fxl" (
    set /p DiyStartMenu=<Symbol\DiyStartMenu.data
	if "%DiyStartMenu%" NEQ "main" (echo.list>Symbol\HomeStyle.data)
) 

set /p HomeStyle_flag=<Symbol\HomeStyle.data
set position=295
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\DarkMode.fxl" (set suffix=-dark) else (set suffix=)
if exist "Symbol\HomeStyle.data" (
    if "%HomeStyle_flag%"=="icon" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,212,288,42) 
    if "%HomeStyle_flag%"=="list" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,269,288,42)
)
:surface-higheff_Widget2
set position=535
if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,388) else (Plugins\Img Pictures\��%button_mode%.png?%position%,388)
Plugins\Img Pictures\��%button_mode%.png?%position%,438

set /p DiyStartMenu=<Symbol\DiyStartMenu.data
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-higheff_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (goto surface)
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (
        mode con: cols=65 lines=37) else (
        mode con: cols=100 lines=37
	)
    ::if exist "Symbol\QuickControl.fxl" call :QE_menu_rolled
    set name=settings
    set HUOCHAI_JumpCode=settings
    set x1=0&set y1=0&set x=800&set y=600
    goto MainInterface_leaveWithoutDe
)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto surface) else (goto leaveDe))

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
    del Symbol\HomeStyle.data>nul 2>nul
	echo.0>Symbol\synergism_off.fxl
    echo.icon>Symbol\HomeStyle.data
	echo.main>Symbol\DiyStartMenu.data
	echo.1>Symbol\Motionoff_Internal_bus.fxl
	call :QE_secondary_menu
    goto surface-higheff_Widget
    )
	
if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
    del Symbol\HomeStyle.data>nul 2>nul
	del Symbol\synergism_off.fxl>nul 2>nul
    echo.list>Symbol\HomeStyle.data
	if "%DiyStartMenu%"=="main" (
        echo.add>Symbol\DiyStartMenu.data
	)
	echo.1>Symbol\Motionoff_Internal_bus.fxl
	call :QE_secondary_menu
    goto surface-higheff_Widget
    )

if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (goto surface-higheff-diy)

if %x% geq %button9_clickX1% if %x% leq %button9_clickX2% if %y% geq %button9_clickY1% if %y% leq %button9_clickY2% (
    if exist "Symbol\mini.fxl" (set x1=0) else set x1=260
    if exist "Symbol\synergism_off.fxl" (del Symbol\synergism_off.fxl>nul) else echo.1>Symbol\synergism_off.fxl
    ::if not exist "Symbol\synergism_off.fxl" (Plugins\Img Pictures\QuickControl-Button.png?13,22)
	if not exist "Symbol\synergism_off.fxl" (
        set /p DiyStartMenu=<Symbol\DiyStartMenu.data
	    if "%DiyStartMenu%" NEQ "main" (echo.list>Symbol\HomeStyle.data)
        echo.1>Symbol\Motionoff_Internal_bus.fxl
	    call :QE_secondary_menu
		goto surface-higheff_Widget
    ) 
    goto surface-higheff_Widget2
)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface-higheff_withoutDe

:surface-higheff-diy
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-qyul-velocity>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%
::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%

    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

    ::��ť��С�����˿�
    set button9_sizeX=295
	set button9_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button9_clickX1=301
	set button9_clickY1=374
	::����
    if exist "Symbol\mini.fxl" (set /a button9_clickX1=%button9_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button9_clickY1=%button9_clickY1%)
    set /a button9_clickX2=%button9_sizeX%+%button9_clickX1%
    set /a button9_clickY2=%button9_sizeY%+%button9_clickY1%

    ::��ť��С�����˿�
    set button10_sizeX=295
	set button10_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button10_clickX1=301
	set button10_clickY1=425
	::����
    if exist "Symbol\mini.fxl" (set /a button10_clickX1=%button10_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button10_clickY1=%button10_clickY1%)
    set /a button10_clickX2=%button10_sizeX%+%button10_clickX1%
    set /a button10_clickY2=%button10_sizeY%+%button10_clickY1%

    ::��ť��С�����˿�
    set button11_sizeX=295
	set button11_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button11_clickX1=301
	set button11_clickY1=476
	::����
    if exist "Symbol\mini.fxl" (set /a button11_clickX1=%button11_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button11_clickY1=%button11_clickY1%)
    set /a button11_clickX2=%button11_sizeX%+%button11_clickX1%
    set /a button11_clickY2=%button11_sizeY%+%button11_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
set secon_symbol=?
set symbol=head
if exist "Symbol\DarkMode.fxl" (set name=tool-surface-higheff-diy-dark.png) else set name=tool-surface-higheff-diy.png
call :QE_secondary_menu
set secon_symbol=:

set symbol=head
:surface-higheff-diy_Widget
set position=260
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
Plugins\Img Pictures\%name%?%position%,0
set position=295
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\DarkMode.fxl" (set suffix=-dark) else (set suffix=)
set /p DiyStartMenu=<Symbol\DiyStartMenu.data
if "%DiyStartMenu%"=="main" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,171,288,42)
if "%DiyStartMenu%"=="add" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,222,288,42)
if "%DiyStartMenu%"=="edit" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,273,288,42)
if "%DiyStartMenu%"=="statistic" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,324,288,42)
if "%DiyStartMenu%"=="settings" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,375,288,42)
if "%DiyStartMenu%"=="output" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,426,288,42)
if "%DiyStartMenu%"=="elect" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,477,288,42)
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-higheff-diy_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
set symbol=head
set secon_symbol=:
if exist "Symbol\mini.fxl" (goto surface-higheff) else (goto leaveDe)
)

if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (
set symbol=head
set secon_symbol=:
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto surface-higheff)
if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
    del Symbol\DiyStartMenu.data>nul 2>nul
    echo.main>Symbol\DiyStartMenu.data
    goto surface-higheff-diy_Widget
    )
	
if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
    del Symbol\DiyStartMenu.data>nul 2>nul
    echo.add>Symbol\DiyStartMenu.data
    goto surface-higheff-diy_Widget
    )

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
    del Symbol\DiyStartMenu.data>nul 2>nul
    echo.edit>Symbol\DiyStartMenu.data
    goto surface-higheff-diy_Widget
    )

if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (
    del Symbol\DiyStartMenu.data>nul 2>nul
    echo.statistic>Symbol\DiyStartMenu.data
    goto surface-higheff-diy_Widget
    )

if %x% geq %button9_clickX1% if %x% leq %button9_clickX2% if %y% geq %button9_clickY1% if %y% leq %button9_clickY2% (
    del Symbol\DiyStartMenu.data>nul 2>nul
    echo.settings>Symbol\DiyStartMenu.data
    goto surface-higheff-diy_Widget
    )

if %x% geq %button10_clickX1% if %x% leq %button10_clickX2% if %y% geq %button10_clickY1% if %y% leq %button10_clickY2% (
    del Symbol\DiyStartMenu.data>nul 2>nul
    echo.output>Symbol\DiyStartMenu.data
    goto surface-higheff-diy_Widget
	)

if %x% geq %button11_clickX1% if %x% leq %button11_clickX2% if %y% geq %button11_clickY1% if %y% leq %button11_clickY2% (
    del Symbol\DiyStartMenu.data>nul 2>nul
    echo.elect>Symbol\DiyStartMenu.data
    goto surface-higheff-diy_Widget
    )

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface-higheff-diy_withoutDe


:surface-qyul
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-qyul>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------Qe--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=tool-surface-qyul-dark.png) else set name=tool-surface-qyul.png
call :QE_secondary_menu
:surface-qyul_widget
if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
set position=535
if exist "Symbol\mini.fxl" (set /a position=%position%-260)

if exist "Motionoff.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,182) else (Plugins\Img Pictures\��%button_mode%.png?%position%,182)
if exist "Symbol\linear_motion.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,235) else (Plugins\Img Pictures\��%button_mode%.png?%position%,235)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-qyul_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto surface) else (goto leaveDe))

if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (goto surface)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
if exist "Motionoff.fxl" (del Motionoff.fxl) else echo.q>Motionoff.fxl
goto surface-qyul_widget)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
if exist "Symbol\linear_motion.fxl" (del Symbol\linear_motion.fxl) else echo.9>Symbol\linear_motion.fxl
goto surface-qyul_widget)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% goto surface-qyul-velocity
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% goto update

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface-qyul_withoutDe


:surface-qyul-velocity
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-qyul-velocity>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
set secon_symbol=?
set symbol=head
if exist "Symbol\DarkMode.fxl" (set name=tool-surface-qyul-velocity-dark.png) else set name=tool-surface-qyul-velocity.png
call :QE_secondary_menu
set secon_symbol=:

set symbol=head
:surface-qyul-velocity_Widget
set position=260
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
Plugins\Img Pictures\%name%?%position%,0
set position=295
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\DarkMode.fxl" (set suffix=-dark) else (set suffix=)
set /p fps=<Symbol\fps.data
if "%fps%"=="10" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,171,288,42)
if "%fps%"=="8" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,222,288,42)
if "%fps%"=="6" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,273,288,42)
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:surface-qyul-velocity_withoutDe
call :HFunc_TimeDelay
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
set symbol=head
set secon_symbol=:
if exist "Symbol\mini.fxl" (goto surface-qyul) else (goto leaveDe)
)

if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (
set symbol=head
set secon_symbol=:
::echo.1>Symbol\Motionoff_Internal_bus.fxl
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto surface-qyul)

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
del Symbol\fps.data>nul 2>nul
echo.10>Symbol\fps.data
goto surface-qyul-velocity_Widget)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
del Symbol\fps.data>nul 2>nul
echo.8>Symbol\fps.data
goto surface-qyul-velocity_Widget)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
del Symbol\fps.data>nul 2>nul
echo.6>Symbol\fps.data
goto surface-qyul-velocity_Widget)
::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto surface-qyul-velocity_withoutDe

:update
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-update>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:update-widget
if exist "Symbol\DarkMode.fxl" (set name=tool-update-night.png) else set name=tool-update.png
call :QE_secondary_menu
set position=550
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
::Plugins\Img Pictures\white.png?217,100,7,11
::Plugins\Img Pictures\white.png?217,177,7,11
::Plugins\Img Pictures\white.png?217,254,7,11
::Plugins\Img Pictures\white.png?217,331,7,11
::Plugins\Img Pictures\arrow.png?217,254

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:update_withoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set name=settings&call :HFunc_Reload_color&goto settings) else (goto leaveDe))

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
Plugins\Img Pictures\5.gif?%position%,182,20,20,1,5
call URLs\update.url
echo.1>Symbol\Motionoff_Internal_bus.fxl
Plugins\Img Pictures\5.gif?%position%,182,20,20,1,5
goto update-widget)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
Plugins\Img Pictures\5.gif?%position%,233,20,20,1,5
call Help\Intro_Update.txt
Plugins\Img Pictures\5.gif?%position%,233,20,20,1,5
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto update-widget)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
if exist "Symbol\DarkMode.fxl" (set name=dashang.png) else set name=dashang.png
set secon_symbol=?
set symbol=head
if exist "Symbol\mini.fxl" (Plugins\Img Pictures\11.png?0,0) else (Plugins\Img Pictures\11.png?260,0)
SET QE_secondary_menu_DELTA=2
call :QE_secondary_menu
set secon_symbol=:
goto update-dashang_withoutDe)

::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% (call :QE_secondary_menu-emphasize&goto update_withoutDe)
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto update_withoutDe

:update-dashang_withoutDe
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

if exist "Symbol\mini.fxl" (set X1=0) else (set X1=260)
set symbol=head
set secon_symbol=:


call :HFunc_MouseClick
if %x% geq 339 if %x% leq 724 if %y% geq 106 if %y% leq 475 goto update-dashang_withoutDe
if %x% geq %x1% if %x% leq 800 if %y% geq 0 if %y% leq 600 (
set symbol=head
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto update)
if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto update) else (goto leaveDe))

if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto update-dashang_withoutDe

:xiufu
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-xiufu>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------���ɶ�Ч--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%


::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
if exist "Symbol\DarkMode.fxl" (set name=tool-fixing-night.png) else set name=tool-fixing.png
call :QE_secondary_menu
set position=550
::Plugins\Img Pictures\white.png?217,100,7,11
::Plugins\Img Pictures\white.png?217,177,7,11
::Plugins\Img Pictures\white.png?217,254,7,11
::Plugins\Img Pictures\white.png?217,331,7,11
::Plugins\Img Pictures\arrow.png?217,177


::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>

:xiufu_withoutDe
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)

if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (set name=settings&call :HFunc_Reload_color&goto settings) else (goto leaveDe))

if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (
goto fix-reinstall
::call newprog.bat
::echo.1>Symbol\Motionoff_Internal_bus.fxl
::if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
::set name=settings
::call :HFunc_Reload_color
::if exist "Symbol\DarkMode.fxl" (set name=tool-fixing-night.png) else set name=tool-fixing.png
::set symbol=head
::call :QE_secondary_menu
::if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\settings-sidebar.png?0,0,259,700)
::goto xiufu_withoutDe
)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
call Plugins\Elect_Assistant\Mainprog.bat
echo.1>Symbol\Motionoff_Internal_bus.fxl
if exist "Symbol\mini.fxl" (mode con: cols=65 lines=37) else (mode con: cols=100 lines=37)
set name=settings
call :HFunc_Reload_color
if exist "Symbol\DarkMode.fxl" (set name=tool-fixing-night.png) else set name=tool-fixing.png
set symbol=head
call :QE_secondary_menu
if not exist "Symbol\mini.fxl" (Plugins\Img Pictures\settings-sidebar.png?0,0,259,700)
goto xiufu_withoutDe
)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
Plugins\Img Pictures\5.gif?%position%,284,20,20,1,5
call URLs\QQsupport.url
)
::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (call :QE_secondary_menu-emphasize&goto xiufu_withoutDe)
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto xiufu_withoutDe

:fix-reinstall
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-surface-qyul>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=234
	set button1_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=12) else (set button1_clickX1=12)
	if exist "Symbol\mini.fxl" (set button1_clickY1=70) else (set button1_clickY1=70)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%

::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=234
	set button2_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=12) else (set button2_clickX1=12)
	if exist "Symbol\mini.fxl" (set button2_clickY1=147) else (set button2_clickY1=147)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%

::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=234
	set button3_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=12) else (set button3_clickX1=12)
	if exist "Symbol\mini.fxl" (set button3_clickY1=223) else (set button3_clickY1=223)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::-----------------------------------------------Button4--------
    ::��ť��С�����˿�
    set button4_sizeX=234
	set button4_sizeY=66
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button4_clickX1=12) else (set button4_clickX1=12)
	if exist "Symbol\mini.fxl" (set button4_clickY1=301) else (set button4_clickY1=301)
    ::����
    set /a button4_clickX2=%button4_sizeX%+%button4_clickX1%
    set /a button4_clickY2=%button4_sizeY%+%button4_clickY1%

::-----------------------------------------------��ֽ������--------
    ::��ť��С�����˿�
    set button5_sizeX=295
	set button5_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button5_clickX1=301
	set button5_clickY1=170
	::����
    if exist "Symbol\mini.fxl" (set /a button5_clickX1=%button5_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button5_clickY1=%button5_clickY1%)
    set /a button5_clickX2=%button5_sizeX%+%button5_clickX1%
    set /a button5_clickY2=%button5_sizeY%+%button5_clickY1%

::-----------------------------------------------��ɫģʽ--------
    ::��ť��С�����˿�
    set button6_sizeX=295
	set button6_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button6_clickX1=301
	set button6_clickY1=221
	::����
    if exist "Symbol\mini.fxl" (set /a button6_clickX1=%button6_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button6_clickY1=%button6_clickY1%)
    set /a button6_clickX2=%button6_sizeX%+%button6_clickX1%
    set /a button6_clickY2=%button6_sizeY%+%button6_clickY1%

::-----------------------------------------------Qe--------
    ::��ť��С�����˿�
    set button7_sizeX=295
	set button7_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button7_clickX1=301
	set button7_clickY1=272
	::����
    if exist "Symbol\mini.fxl" (set /a button7_clickX1=%button7_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button7_clickY1=%button7_clickY1%)
    set /a button7_clickX2=%button7_sizeX%+%button7_clickX1%
    set /a button7_clickY2=%button7_sizeY%+%button7_clickY1%


    ::��ť��С�����˿�
    set button8_sizeX=295
	set button8_sizeY=45
    ::��ťλ�ã����϶������꣩
	set button8_clickX1=301
	set button8_clickY1=323
	::����
    if exist "Symbol\mini.fxl" (set /a button8_clickX1=%button8_clickX1%-260)
	if exist "Symbol\mini.fxl" (set /a button8_clickY1=%button8_clickY1%)
    set /a button8_clickX2=%button8_sizeX%+%button8_clickX1%
    set /a button8_clickY2=%button8_sizeY%+%button8_clickY1%

set settingsflag=True
set Docflag=True

:fix-reinstall_widget0
::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
set secon_symbol=?
set symbol=head
if exist "Symbol\DarkMode.fxl" (set name=fix-reinstall-dark.png) else set name=fix-reinstall.png
call :QE_secondary_menu
set secon_symbol=:
set symbol=head
:fix-reinstall_widget
if exist "Symbol\DarkMode.fxl" (set button_mode=-dark) else set button_mode=
set position=535
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
::if exist "Symbol\linear_motion.fxl" (Plugins\Img Pictures\��%button_mode%.png?%position%,182) else Plugins\Img Pictures\��%button_mode%.png?%position%,182

set position=295
if exist "Symbol\mini.fxl" (set /a position=%position%-260)
if exist "Symbol\DarkMode.fxl" (set suffix=-dark) else (set suffix=)
set /p fps=<Symbol\fps.data

if "%settingsflag%"=="True" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,222,288,42) 
if "%Docflag%"=="True" (Plugins\Img Pictures\old_FluenceDesign_Pics\mask%suffix%.png?%position%,273,288,42)

::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:fix-reinstall_withoutDe
Plugins\Img Pictures\5.gif?800,600,2,2,1,5
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
if exist "Symbol\mini.fxl" (
mode con: cols=65 lines=37) else (
mode con: cols=100 lines=37)
set name=settings
set HUOCHAI_JumpCode=settings
set x1=0&set y1=0&set x=800&set y=600
goto MainInterface_leaveWithoutDe)

if %x% geq 12 if %x% leq 63 if %y% geq 12 if %y% leq 55 (
if exist "Symbol\mini.fxl" (goto xiufu) else (goto leaveDe))

if %x% geq 275 if %x% leq 323 if %y% geq 16 if %y% leq 55 (
echo.1>Symbol\Motionoff_Internal_bus.fxl
goto xiufu)

::if %x% geq %button5_clickX1% if %x% leq %button5_clickX2% if %y% geq %button5_clickY1% if %y% leq %button5_clickY2% (pause)

if %x% geq %button6_clickX1% if %x% leq %button6_clickX2% if %y% geq %button6_clickY1% if %y% leq %button6_clickY2% (
    if "%settingsflag%"=="True" (set settingsflag=False) else (set settingsflag=True)
	echo.1>Symbol\Motionoff_Internal_bus.fxl
	goto fix-reinstall_widget0
)

if %x% geq %button7_clickX1% if %x% leq %button7_clickX2% if %y% geq %button7_clickY1% if %y% leq %button7_clickY2% (
    if "%Docflag%"=="True" (set Docflag=False) else (set Docflag=True)
	echo.1>Symbol\Motionoff_Internal_bus.fxl
	goto fix-reinstall_widget0
)
if %x% geq %button8_clickX1% if %x% leq %button8_clickX2% if %y% geq %button8_clickY1% if %y% leq %button8_clickY2% (
    goto fix-reinstall-start
    )
::bar
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% goto surface
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% goto xiufu
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto update
if %x% geq %button4_clickX1% if %x% leq %button4_clickX2% if %y% geq %button4_clickY1% if %y% leq %button4_clickY2% goto schema
goto fix-reinstall_withoutDe

:fix-reinstall-start
::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
set secon_symbol=?
set symbol=head
if exist "Symbol\DarkMode.fxl" (set name=fix-reinstall-start-dark.png) else set name=fix-reinstall-start.png
call :QE_secondary_menu
set secon_symbol=:
set symbol=head
Plugins\Img Pictures\5.gif?307,200,30,30,1,3

if "%settingsflag%"=="False" (call :HFunc_Reset)
if "%Docflag%"=="False" (call :HFunc_ResetDoc)
if exist "setup.exe" (call setup.exe&exit) else (goto fix-reinstall)

:myclean
::--------------------------------------
::Module Version��About5.3.0
::UpdateDate:2023-12-06
::--------------------------------------
::>>>>>>>>>>>>>>>>>>>>>>>>д����־��¼>>>>>>>>>>>>>>>>>>>>>>>>
if not exist "Symbol\LogRecoder_OFF.fxl" echo.%date%%time%-myclean>>RunningData.log

::>>>>>>>>>>>>>>>>>>>>>>>>���ذ�ť��Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
::-----------------------------------------------Button1--------
    ::��ť��С�����˿�
    set button1_sizeX=140
	set button1_sizeY=36
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button1_clickX1=71) else (set button1_clickX1=71)
	if exist "Symbol\mini.fxl" (set button1_clickY1=302) else (set button1_clickY1=302)
    ::����
    set /a button1_clickX2=%button1_sizeX%+%button1_clickX1%
    set /a button1_clickY2=%button1_sizeY%+%button1_clickY1%
::-----------------------------------------------Button2--------
    ::��ť��С�����˿�
    set button2_sizeX=140
	set button2_sizeY=36
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button2_clickX1=71) else (set button2_clickX1=71)
	if exist "Symbol\mini.fxl" (set button2_clickY1=348) else (set button2_clickY1=348)
    ::����
    set /a button2_clickX2=%button2_sizeX%+%button2_clickX1%
    set /a button2_clickY2=%button2_sizeY%+%button2_clickY1%
::-----------------------------------------------Button3--------
    ::��ť��С�����˿�
    set button3_sizeX=140
	set button3_sizeY=36
    ::��ťλ�ã����϶������꣩
    if exist "Symbol\mini.fxl" (set button3_clickX1=71) else (set button3_clickX1=71)
	if exist "Symbol\mini.fxl" (set button3_clickY1=394) else (set button3_clickY1=394)
    ::����
    set /a button3_clickX2=%button3_sizeX%+%button3_clickX1%
    set /a button3_clickY2=%button3_sizeY%+%button3_clickY1%

::>>>>>>>>>>>>>>>>>>>>>>>>���ؽ�����Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
Plugins\img Pictures\15pc-black.png?0,0,800,600
Plugins\img Pictures\15pc-black.png?0,0,800,600
Plugins\img Pictures\15pc-black.png?0,0,800,600
if exist "Symbol\mini.fxl" (set position=271) else (set position=325)
if exist "Symbol\mini.fxl" (set tempname=-mini) else (set tempname=)
if exist "Symbol\DarkMode.fxl" (Plugins\img introduce\about%tempname%-dark.png?0,0) else (Plugins\img introduce\about%tempname%.png?0,0)
if exist "Symbol\DarkMode.fxl" (Plugins\img introduce\about-softver-dark.png?%position%,218) else (Plugins\img introduce\about-softver.png?%position%,218)
if exist "Symbol\DarkMode.fxl" (Plugins\img introduce\about-schever-dark.png?%position%,270) else (Plugins\img introduce\about-schever.png?%position%,270)
Plugins\img introduce\logo.png?71,100,76,76
if exist "Symbol\mini.fxl" (set xx1=515&set xx2=520) else (set xx1=790&set xx2=800)
::>>>>>>>>>>>>>>>>>>>>>>>>���ؿؼ���Ϣ>>>>>>>>>>>>>>>>>>>>>>>>
:myclean_withoutDe
call :HFunc_MouseClick
if %x% geq %xx1% if %x% leq %xx2% if %y% geq 0 if %y% leq 600 (
    if exist "Symbol\mini.fxl" (del Symbol\mini.fxl>nul 2>nul) else (echo.1>Symbol\mini.fxl)
    if exist "Symbol\mini.fxl" (
        mode con: cols=65 lines=37) else (
        mode con: cols=100 lines=37
	)
	set QE_Load_Maininterface_Selection=OnlyBG0&call :QE_Load_Maininterface
    goto MainInterface_WithDe
)
if %x% geq %button1_clickX1% if %x% leq %button1_clickX2% if %y% geq %button1_clickY1% if %y% leq %button1_clickY2% call Help\Intro_Update.txt&goto myclean_withoutDe
if %x% geq %button2_clickX1% if %x% leq %button2_clickX2% if %y% geq %button2_clickY1% if %y% leq %button2_clickY2% (
    call welcome.bat
	call :HFunc_WindowResize
	call :QE_Load_Maininterface
	goto myclean
	)
if %x% geq %button3_clickX1% if %x% leq %button3_clickX2% if %y% geq %button3_clickY1% if %y% leq %button3_clickY2% goto MainInterface_withDe
goto myclean_withoutDe

:verhigh
if exist "Symbol\DarkMode.fxl" (
    if exist "Skin\SkinPackage\dark.fxl" (set background=background-dark)) else (set background=background)
Plugins\Img skin\SkinPackage\%background%.png:0,0,800,592
Plugins\Img Pictures\22.png?0,0,800,600
Plugins\Img Pictures\22.png?0,0,800,600
Plugins\Img Pictures\22.png?0,0,800,600
Plugins\Img Pictures\22.png?0,0,800,600
Plugins\Img introduce\version.png?0,0,800,600

:verhigh_withoutDe
call :HFunc_MouseClick
if %x% geq 650 if %x% leq 750 if %y% geq 505 if %y% leq 548 (call update.url)
if %x% geq 557 if %x% leq 605 if %y% geq 513 if %y% leq 541 (echo.dev>Symbol\developer_mode.fxl&goto Program_Start)
goto verhigh_withoutDe
