<p align="center"><img width="320" src="https://i.imgur.com/9ORteWj.png" /></p>
<h1 align="center">
  BattleBit EAC Fix</h1>
  
[![Download batch](https://custom-icon-badges.herokuapp.com/badge/-Download-black?style=for-the-badge&logo=download&logoColor=white)](https://livingflore.me/eacfix)
[![Discord](https://custom-icon-badges.herokuapp.com/badge/-Discord-black?style=for-the-badge&logo=discord&logoColor=white)](https://discord.gg/battlebit)


This batch script reinstalls EAC completely and also installs VCRedist x86-64 2015-2022 to fix [this](https://i.imgur.com/tKGFam6.png) and other issues.


<h2 align="center">
  Further Troubleshooting</h2>

### [•](https://i.imgur.com/tKGFam6.png) Make sure you have installed EasyAntiCheat and run the game with it.
1) Run the batch (download button above).
2) Ensure that **BOTH** VCRedists installed properly - [x86](https://aka.ms/vs/17/release/vc_redist.x86.exe) and [x64](https://aka.ms/vs/17/release/vc_redist.x64.exe).
When running installers you should see 3 buttons - repair, uninstall and cancel. If you can't see it - proceed with installation.
3) Try running BattlebitEAC.exe or EasyAntiCheat.exe from admin located in installed files (right click on game > properties > installed files > browse)
4) You might experience some issues with connection and therefore EAC can't reach its servers. Try using [Cloudflare WARP](https://1.1.1.1) or any private VPN on this matter.

### [•](https://i.imgur.com/ADtyLmM.png) Launch Error - Easy Anti-Cheat is not installed.
Run the ["Install & Repair Easy Anti Cheat"](https://i.imgur.com/466AXn8.png) launch option.

If you can't reach launch options, [right click on the game > Properties](https://i.imgur.com/16aeGuw.png) [> Launch Options > Ask when starting game](https://i.imgur.com/QsnQtsz.png).

### [•](https://i.imgur.com/yzxejzh.png) CreateFile failed with 32.
1) Reboot your PC.
2) Remove `EasyAntiCheat_EOS.sys` file located in `C:\Program Files (x86)\EasyAntiCheat_EOS`.
3) Run the batch (download button above).

### [•](https://i.imgur.com/tDRxBLb.png) Untrusted System File 
Depending on what driver causes this, you may need to [reinstall](https://support.nzxt.com/hc/en-us/articles/4403882406555-Reinstalling-Graphic-Drivers)/update your GPU drivers
or run `sfc /scannow` and `dism /online /cleanup-image /restorehealth` in command prompt as admininstrator (Press Win+R, type `cmd`, then press Ctrl+Shift+Enter).

### [•](https://i.imgur.com/mePC8z1.png) StartService EasyAntiCheat_EOSSys failed with 5.
1) Run the batch (download button above).
2) Press Win+R, type `regedit.exe`, then go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EasyAntiCheat_EOS`,
right click on `EasyAntiCheat_EOS`, and grant full access for all application packages.

### [•](https://i.imgur.com/rR0rDnB.png) You were kicked by anti cheat. Make sure...
0) if you using custom lang file - get rid of it and you're fine.
1) If you're on linux - make sure that you don't have EAC entries in `/etc/hosts` (which was needed for Star Citizen for example).
2) Run the batch (download button above).
3) Ensure that absolutely **NOTHING** blocks EAC connection (antivirus/firewall/ISP).
4) Delete `Certificates folder` located in [Installed Files](https://i.imgur.com/t8Pocyo.png) > `EasyAntiCheat` folder and 
[verify game files](https://cdn.discordapp.com/attachments/1109901924314140732/1124030888276132000/BBR_Validation.gif). 
5) Change your IP by restarting modem/router or use private VPN/[Cloudflare WARP](https://1.1.1.1).
6) If anything above won't help you, then you are on your own. Good luck.

### [•](https://i.imgur.com/N8Zyr47.jpg) The application was unable to start correctly (0xc0000005).
This error code means access violation => could be anything.
1) If you use third-party antivirus (if it is trend micro - **DELETE IT**) make sure it's not interfering with the game and add BattleBit and EAC folder to exclusions.
2) Try running BattlebitEAC.exe or EasyAntiCheat.exe as admin ([right click on executable > run as administrator](https://i.imgur.com/l4kF2o3.png)) located in installed files ([right click on the game > Properties](https://i.imgur.com/16aeGuw.png) [> installed files > browse](https://i.imgur.com/t8Pocyo.png)).
3) Press Win+R, type `cmd`, then press Ctrl+Shift+Enter and run `sfc /scannow` (might take a bit) and `dism /online /cleanup-image /restorehealth`.
4) Disable overclocking software if you have any.
5) [Verify game files](https://cdn.discordapp.com/attachments/1109901924314140732/1124030888276132000/BBR_Validation.gif).
6) Reinstall the game on other drive/partition. 

### • I can't find my problem above...
Reach out to [#anti-cheat-help](https://discord.com/channels/303681520202285057/1023557300214050968) in BattleBit Discord server (button above) for assistance.
