:: battlebit EAC repairing + vcredist installing by omniz, edited by livingflore
:: if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit ) 
@echo off
if _%1_==_payload_  goto :payload
:getadmin
    echo %~nx0: elevating self
    set vbs=%temp%\getadmin.vbs
    echo Set UAC = CreateObject^("Shell.Application"^)                >> "%vbs%"
    echo UAC.ShellExecute "%~s0", "payload %~sdp0 %*", "", "runas", 1 >> "%vbs%"
    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
goto :eof
:payload

echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@PPPP@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@^&G    G^&@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@P      P@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@?^^      ^^?@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@^^        ^^@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@^^        ^^@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@^^        ^^@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@5          5@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@J          J@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@Y          Y@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@B:        :B@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@5~~~~~~~~~~5@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
echo.
echo Hi. This batch will reinstall EAC and install VCRedist 2015-2022 x86-64. 
pause
cls

SET GamePath=
FOR /F "tokens=2* skip=2" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 671860" /v "InstallLocation"') do SET GamePath="%%b"
:: echo %GamePath%
echo Closing EAC and BattleBit...
taskkill /f /im BattleBit.exe 2>nul 1>nul
taskkill /f /im BattleBitEAC.exe 2>nul 1>nul
taskkill /f /im EasyAntiCheat.exe 2>nul 1>nul
taskkill /f /im EasyAntiCheat_EOS_Setup.exe 2>nul 1>nul
taskkill /f /im UnityCrashHandler64.exe 2>nul 1>nul

echo Removing EAC Service...
%GamePath%\EasyAntiCheat\EasyAntiCheat_EOS_Setup.exe uninstall 43ed9a4620fa486994c0b368cce73b5d
%GamePath%\EasyAntiCheat\EasyAntiCheat_EOS_Setup.exe qa-factory-reset
sc delete EasyAntiCheat_EOS 2>nul 1>nul
sc delete EasyAntiCheat 2>nul 1>nul

echo Removing EAC folders...
rmdir /q /s "C:\Program Files (x86)\EasyAntiCheat_EOS" 2>nul 1>nul
rmdir /s /q "%temp%/../../Roaming/EasyAntiCheat" 2>nul 1>nul
rmdir /s /q "%temp%/../../Roaming/EasyAntiCheat" 2>nul 1>nul
rmdir /s /q "%temp%/../../LocalLow/BattleBitDevTeam" 2>nul 1>nul

Echo Removing EAC registry entries...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\EasyAntiCheat_EOS" /f 2>nul 1>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\EasyAntiCheat" /f 2>nul 1>nul

echo Installing EAC...
%GamePath%\EasyAntiCheat\EasyAntiCheat_EOS_Setup.exe install 43ed9a4620fa486994c0b368cce73b5d

echo Switching EAC service mode to automatic...
sc config EasyAntiCheat_EOS start=Auto 2>nul 1>nul

echo Adding EAC ^& BattleBit Folder to Windows Defender exclusions...
powershell -Command Add-MpPreference -ExclusionPath %GamePath% > nul
powershell -Command Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\EasyAntiCheat' > nul
powershell -Command Add-MpPreference -ExclusionPath 'C:\Program Files (x86)\EasyAntiCheat_EOS' > nul

echo.
echo EAC reinstall completed.
echo.

echo Flushing DNS...
ipconfig /flushdns 2>nul 1>nul
echo Testing EAC Connection...
echo download.eac-cdn.com:
curl download.eac-cdn.com --max-time 10
echo.
echo download-alt.easyanticheat.net:
curl download-alt.easyanticheat.net --max-time 10
echo.

echo.
echo Installing VCRedist 2015-2022 x86-64
echo.

echo Downloading VC_redist.x64...
curl -L https://aka.ms/vs/17/release/vc_redist.x64.exe --output %temp%"VC_redist.x64.exe" --write-out "%errorlevel%" --progress-bar 1>nul
if %errorlevel% EQU 00 (
   echo Installing VC_redist.x64.exe ^(might take a bit^)...
   %temp%VC_redist.x64.exe /install /quiet /norestart
   if ERRORLEVEL 0 (
      echo VC_redist.x64.exe installed successfully!
   ) else (
      echo VC_redist.x64.exe install failed with code: %ERRORLEVEL%
   )
   del %temp%VC_redist.x64.exe
) else (
   echo VC_redist.x64 - download failed ^:^(
)

echo.
echo Downloading VC_redist.x86...
curl -L https://aka.ms/vs/17/release/vc_redist.x86.exe --output %temp%"VC_redist.x86.exe" --write-out "%errorlevel%" --progress-bar 1>nul
if %errorlevel% EQU 00 (   
   echo Installing VC_redist.x86.exe ^(might take a bit^)...
   %temp%VC_redist.x86.exe /install /quiet /norestart
   if ERRORLEVEL 0 (
      echo VC_redist.x86.exe installed successfully!
   ) else (
      echo VC_redist.x86.exe install failed with code: %ERRORLEVEL%
   )
   del %temp%VC_redist.x86.exe
) else (
   echo VC_redist.x86.exe - download failed ^:^(
)

echo.
echo Finished!
echo.
echo =================================================================================
echo NOTICE: If there's any errors above, screenshot them and send to #anti-cheat-help.
echo You might also need to select "Install & Repair Easy Anti Cheat" launch option
echo before actually launching the game.  
echo =================================================================================
echo.
CHOICE /C YN /M "Do you want to reboot your PC (recommended)"

IF %ERRORLEVEL% EQU 1 (
    shutdown /s /f /t 0
) ELSE IF %ERRORLEVEL% EQU 2 (
    echo.
    echo Rebooting your PC is highly recommended, do it before opening BattleBit.
)

echo.
pause