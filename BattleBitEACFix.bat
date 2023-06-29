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
echo Hi. This batch will reinstall EAC and install vcredist if needed. 
pause
cls

echo Closing EAC and game...

taskkill /f /im BattleBit.exe 2>nul 1>nul
taskkill /f /im BattleBitEAC.exe 2>nul 1>nul
taskkill /f /im EasyAntiCheat.exe 2>nul 1>nul
taskkill /f /im EasyAntiCheat_EOS_Setup.exe 2>nul 1>nul
taskkill /f /im UnityCrashHandler64.exe 2>nul 1>nul

echo Removing EAC Service...

FOR /F "tokens=2* skip=2" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 671860" /v "InstallLocation"') do %%b\EasyAntiCheat\EasyAntiCheat_EOS_Setup.exe uninstall 43ed9a4620fa486994c0b368cce73b5d
FOR /F "tokens=2* skip=2" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 671860" /v "InstallLocation"') do %%b\EasyAntiCheat\EasyAntiCheat_EOS_Setup.exe qa-factory-reset

sc delete EasyAntiCheat_EOS 2>nul 1>nul
sc delete EasyAntiCheat 2>nul 1>nul

echo Removing EAC_EOS folder...

rmdir /q /s "C:\Program Files (x86)\EasyAntiCheat_EOS" 2>nul 1>nul

echo Installing EAC...

FOR /F "tokens=2* skip=2" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Steam App 671860" /v "InstallLocation"') do %%b\EasyAntiCheat\EasyAntiCheat_EOS_Setup.exe install 43ed9a4620fa486994c0b368cce73b5d

echo Switching EAC service mode to automatic...
echo.
sc config EasyAntiCheat_EOS start=Auto 2>nul 1>nul

echo EAC reinstall completed.
echo.

echo Testing EAC Connection...
echo download.eac-cdn.com:
curl download.eac-cdn.com
echo.
echo download-alt.easyanticheat.net:
curl download-alt.easyanticheat.net
echo.

echo.
echo Installing VCRedist 2015-2022 x86-64
echo.

echo Downloading VC_redist.x64...
curl -L https://aka.ms/vs/17/release/vc_redist.x64.exe --output %temp%"VC_redist.x64.exe" --progress-bar
if ERRORLEVEL 0 (
   echo Installing VC_redist.x64.exe ^(might take a bit^)...
   %temp%VC_redist.x64.exe /install /quiet /norestart
   if ERRORLEVEL 0 (
      echo VC_redist.x64.exe installed successful!
   ) else (
      echo VC_redist.x64.exe install failed with code: %ERRORLEVEL%
   )
   del %temp%VC_redist.x64.exe
) else (
   echo VC_redist.x64 - download failed ^:^(
)

echo.
echo Downloading VC_redist.x86...
curl -L https://aka.ms/vs/17/release/vc_redist.x86.exe --output %temp%"VC_redist.x86.exe" --progress-bar
if ERRORLEVEL 0 (   
   echo Installing VC_redist.x86.exe ^(might take a bit^)...
   %temp%VC_redist.x86.exe /install /quiet /norestart
   if ERRORLEVEL 0 (
      echo VC_redist.x86.exe installed successful!
   ) else (
      echo VC_redist.x86.exe install failed with code: %ERRORLEVEL%
   )
   del %temp%VC_redist.x86.exe
) else (
   echo VC_redist.x86.exe - download failed ^:^(
)

echo.
echo Finished!

CHOICE /C YN /M "Do you want to reboot your PC (recommended)"

IF %ERRORLEVEL% EQU 1 (
    shutdown /s /f /t 0
) ELSE IF %ERRORLEVEL% EQU 2 (
    echo.
    echo Rebooting your PC is highly recommended, do it before opening your game.
)

echo.
pause