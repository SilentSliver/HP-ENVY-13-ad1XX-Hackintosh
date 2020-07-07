# HP-ENVY-13-ad1XX-Hackintosh

A Configuration of Hackintosh for HP Envy 13
**Please Read `ReadME` carefully before you try it**

[中文](README.md) | [English](README_EN.md)

## Species

| Specs | Detail | Specs | Detail |
| :---: | :--- | :---: | :--- |
| Board | HP 83A8 | Platform | Clover Or Opencore Tested |
| CPU | Intel Core i5-8250U | Display | BOE070E |
| GPU | Intel Graphics UHD 620 | Shared VRAM | 128M |
| Audio | Realtec ALC295 | SMC | VirtualSMC |
| Network | Dell Wireless 1560 | TrackPad | VoodooPS2(Acidanthera Ver.) |
| Storage | WD SN750 | Bios | F18-F29 Tested |

## Update Log

### 2020-05-07

1. Update `Clover` to 5118

**Support `macOS 10.15.4`**
For more details, please visit [ChangeLog.md](./ChangeLog.md)

## 1. Abstract

**DO NOT TURN ON `FileValue Encryption`!!**
**Especially after OTA Update!!**
My Hackintosh works fine with the latest configuration on `10.15`. It might common to both `HP-ENVY 13 ad1XX` and `ad0XX`, but I don't try it. The repo was created by [daliansky](https://github.com/daliansky/), and I rewrite it to support `10.15`. 

## 2. Installation(This part need some time to translate)

1. Download your macOS image with suffix `dmg`;
2. Use tools like [`etcher`](https://www.balena.io/etcher/) to flash the OS image you have downloaded to SD card & USB drive;
3. Cope `CLOVER` folder from my repo to `EFI` folder in `EFI` partition at your hard drive, then add Clover to your boot options by tools like `bootice`;
4. Reboot your Computer and press `F10` before HP logo showing on screen to boot in `BIOS`, then select `CLOVER`  at `System Configutation`-`Boot Sequence`-`Operation System Boot Manager` and press `F6` to make it at the head of list, finally press twice `F10` to save your config and exit `BIOS`;
5. In `CLOVER` select `macOS Install from XXX(Your SD card & USB drive label)` to boot in macOS Install;
6. This step is same as real Mac, you can re-part your disk and so on. You need remember disk label you decide to install your macOS on;
7. Your device will reboot after install, then select `macOS Install from XXX (Disk label from Step 6)` in `CLOVER`, and reboot several times (you can take off your SD card & USB drive now). 
8. After Step 7 there will be a `macOS` option in `CLOVER`, select it and press `Enter`;
9. 请使用Clover Configurator或者其他什么工具都行，**注入自己的三码！！！注入自己的三码！！注入自己的三码！！！**，然后在`系统偏好设置-节能`中关掉**所有**`电能小憩`和`唤醒以供网络访问`的选项，然后基本上就算**大功告成**啦！！！

## 3. Customization

Before you try all parts with `NOT NEED` tag, please make sure you have ability to fix some unknown error.

### 1. Display

If you are using a 1080P(FHD) screen, please notice：
1. （not need）Use [xzhih/one-key-hidpi](https://github.com/xzhih/one-key-hidpi) to enable HiDPI；

If you are using a 4K(UHD) screen, please notice：
1. Use `Clover Configurator` to edit `CLOVER\Config.plist`, and change `UIScale` and `EFILoginHiDPI` to `2` in `Boot Graphics`；
2. Use `Clover Configurator` to edit `CLOVER\Config.plist`, and change the `Theme` part to `Outlines1080` in `GUI` part, or use `Other Text Editor (Such as NotePad)` to replace `Outlines` to `Outlines4k`;

如果你的显示器显示色深（色彩有明显断层），请尝试使用`Hackintool`定制`Display`。AD1系列1080P可尝试在`POST-Install\DisplayFile`中我准备的显示文件，使用方式很简单，扔到`Clover\Kexts\Other`中就可以了。AD0系列如遇到此问题使用`Clover Configurator`修改`CLOVER\config.plist`中`设备设置`-`属性`-`PciRoot(0x0)/Pci(0x2,0x0)`中所有`16590000`或`00001659`无差别修改成`16190000`或`00001619`，保存并重启电脑以查看效果。
如果你遇到开机第二阶段苹果闪烁出现8个并迅速恢复正常的情况，可以尝试用`Clover Configurator`在`显卡设置`部分的`水平同步脉冲宽度`中填入100以解决这个问题；
如果你两边有一侧（应该是左侧）的Type-C口不能外接显示，请降级Bios至F18。

### 2. CPU Frequence

If you are **not** using i5-8250U，please notice：
1. (**Must**)Please Insure you have already boot in your macOS normally；
2. (**Must**)Delete `CLOVER\Kexts\Other\CPUFriendDataProvider.kext`;
3. (**Must**)Use [stevezhengshiqi/one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend/blob/master/README_CN.md) to generate a new `CPUFriendDataProvider.kext` and place it in `CLOVER\Kexts\Other`;

Please make sure you are using the latest bios if you think your hackintosh has some issues about performence.

### 3.BackLight（Not Need）

The Backlight Level has been customized and no modification required. If you still need adjust backlight level, please edit Method `_BCL` from Device `PNLF` in `CLOVER\ACPI\patched\SSDT-BRT6.dsl`. Method `_BCL` returns a Package with 19 numbers, then the first and the last one are maximum level (and it's not a good idea to change these two number). The second one controls the backlight level which will be used when macOS is going to sleep. 中间的4-18位自由发挥即可（均为10进制），修改好后保存并编译为`SSDT-BRT6.aml`，重启即可见效。

### 4. Discrete Graphic（MX150）and SD Card reader

Impossible for now.

### 5. Audio

当前驱动的扬声器为底面的扬声器，因为ENVY节点问题四扬声器可能不能同时进行输出。如果有好的解决办法欢迎PR。如果想要尝试C面扬声器，需使用`Clover Configurator`修改`CLOVER\config.plist`中`设备设置`-`属性`-`PciRoot(0x0)/Pci(0x14,0x3)`中`layout-id`部分修改为`1C0000000`。

### 6. Wireless Card

网卡部分其实对于`macOS`没什么好说的，原生网卡`Intel AC7265`，暂时用不了，这里我用的网卡DW1560（只推荐这张，1820A几乎不可用，1830可能因大小问题不能安装），或者使用安卓热点开热点共享；
如果你使用的是`DW1560`，在使用`Windows`时不要安装DELL官网提供的驱动，请使用通过`Windows更新`获取最新的网卡驱动，蓝牙部分驱动则无所谓；
如果你尝试使用`DW1820a`，那么我祝你好运，但我本人因技术有限不再提供任何与`DW1820a`有关的技术支持，如果有需要，请移步[小兵的blog](https://blog.daliansky.net)查看对应问题的解决方案。

### 7. Hard Drive

Due to HP, the SSD works not very perfect. I have tried to fix it but I failed. I suggest using other high performance SSD. 

### 8. SMC(Not Need)

项目中默认使用的是VirtualSMC，由[Acidanthera](https://github.com/acidanthera)维护，目前效果很好，如无必要无需替换。但如果有调试需要，仍可尝试由[Clover团队](https://github.com/CloverHackyColor)维护的FakeSMC，所需文件均在`POST-Install/FakeSMC`中。

| 序号 | 路径 | 删除| 添加 |
| :---: | :--- | :--- | :--- |
| 1 | `CLOVER\Kext\Other` | 原先所有带SMC字样的Kext文件（夹） | `POST-Install/FakeSMC`中所有`Kext`文件（夹） |
| 2 | `CLOVER\drivers\UEFI` | VirtualSMC.efi | SMCHelper.efi |

如果先前已经使用`VirtualSMC`进入过系统，则还需重置`NVRAM`（Clover界面按`F11`即可）。

### 9. Battery(Not Need)

电池百分比读数使用`VirtualSMC`及其组件实现，无需修改。但如果想使用`FakeSMC`或者认为电池读数有明显严重问题可使用定制SSDT的方法，所需文件均在`POST-Install/Battery`中。将其中的`SSDT-BAT0.aml`移至`CLOVER\ACPI\patched`中，并在`CLOVER\config.plist`中的`SortedOrder`部分按照模式添加行`SSDT-BAT0.aml`

### 10. Trackpad(Not Need)

Trackpad Kext comes from [Acidanthera](https://github.com/acidanthera), and it's the best `ps2 trackpad` kext in hackintosh I think. If you need, you can replace it to `ApplePS2SmartTouchPad`or the [Rehabman](https://bitbucket.org/%7Be26fb9ce-5cc2-4e36-8576-7a8faae8e194%7D/) version.

## 4. Issues

1. All things except external display have been tested；
2. If you find some issues or bugs, Please PR.

## 5. And more... 

`ENVY 13 ad1XX` is my girlfriend's pc. She bought a `iPad Air 3` before I made this configuration(Yes, for her). I will update `Kexts` but for some issues and bugs will need some time. <br />

2020-01-11续<br />

这台机子奉劝大家千万不要用1820A，按照小兵的方法，原则上是不能驱动的，但是可以通过固件保留的方式（启动Windows后重启到Mac）使用网卡，但代价是不能睡眠，一睡网卡必定掉，整个系统直接卡死。

## Thanks

All (names are arranged) in no particular order: <br>
[Acidanthera](https://github.com/acidanthera) for lots of kexts,[Clover Team](https://github.com/CloverHackyColor) for bootloader and FakeSMC kexts, [Daliansky](https://github.com/daliansky/) and his [blog](https://blog.daliansky.net/) for his configuration and sleep fix, [Bat.bat](https://github.com/williambj1) for Envy 13 bright function key and Battery hotpatch, [Aris](https://ariser.cn) for HDMI patch, [JardenLiu](https://github.com/jardenliu) for XPS15 and taught me a lot in Hackintosh, [Rehabman](https://bitbucket.org/%7Be26fb9ce-5cc2-4e36-8576-7a8faae8e194%7D/) for series of hotpatches, and lots of friends test and suggestions. 



Do NOT use this project for commercial purposes<br />
QQ Group:
惠普电脑装Mac交流群：543758684<br>
ENVY13(2017)交流群：247548827<br>
