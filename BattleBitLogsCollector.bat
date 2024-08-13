
@echo off & setlocal
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
title BattleBit Logs Collector >nul
:: i hate onedrive
SET Logs=C:\Users\Public\Desktop\BattleBit Logs
if not exist "%Logs%" ( if not exist "%Logs%.zip" goto :start )
echo [91m[X][0m BattleBit Logs folder or BattleBit Logs.zip already exists on your desktop. 
echo Please send it to BattleBit representative in order to get support.
echo.
pause
goto :eof
:start
echo [94m[...][0m Creating BattleBit Logs folder on your desktop
mkdir "%Logs%" >nul
mkdir "%Logs%\Dumps" >nul
mkdir "%Logs%\EAC" >nul
echo [94m[...][0m Copying game logs
xcopy /i "C:\Users\%username%\AppData\LocalLow\BattleBitDevTeam\BattleBit\" "%Logs%\" >nul
echo [94m[...][0m Copying EAC logs
copy /y "%appdata%\EasyAntiCheat\anticheatlauncher.log" "%Logs%\EAC" >nul
copy /y "%appdata%\EasyAntiCheat\service.log" "%Logs%\EAC" >nul
copy /y "%appdata%\EasyAntiCheat\43ed9a4620fa486994c0b368cce73b5d\315826d981f4480aa6155e32d71b0d3b\loader.log" "%Logs%\EAC" >nul
echo [94m[...][0m Creating msinfo32 dump
msinfo32 /report "%Logs%\msinfo32.txt" >nul
echo [94m[...][0m Creating dxdiag dump
dxdiag /dontskip /t "%Logs%\dxdiag.txt" >nul
echo [94m[...][0m Copying crash dumps
for /R "C:\Users\%username%\AppData\Local\CrashDumps" %%F in (*BattleBit*.dmp *EasyAntiCheat*.dmp) do (
  copy /y %%F "%Logs%\Dumps" >nul
)
echo [94m[...][0m Creating BattleBit Logs.zip
powershell Compress-Archive '%Logs%' '%Logs%.zip' >nul
echo.
echo [32m[+][0m Finished!
echo.
echo [93mPlease copy BattleBit Logs folder from your desktop 
echo and send it to BattleBit representative in order to get support.[0m
echo.
pause
