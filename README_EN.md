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

1. 下载macOS原版镜像（或者其他人提供带引导的也可以），文件格式为`dmg`；
2. 使用[`etcher`](https://www.balena.io/etcher/)等工具刻录镜像至U盘；
3. 将提供的`CLOVER`文件夹通过各种手段（不一一列举）放在硬盘的`EFI`分区中的`EFI`文件夹下，并使用`bootice`等工具添加引导项；
4. 重启在HP logo还未出现时按`F10`进入`BIOS`，然后在`系统设置`-`启动选项`-`操作系统的启动管理员`中选中`CLOVER`并按`F6`调整至第一个并按两次`F10`保存退出`BIOS`；
5. 在`CLOVER`中选择`macOS Install from XXX(表示移动设备名称)`进入安装界面；
6. 这步和白果一样，分区啊什么乱七八糟的。这里需要记下自己安装macOS的分区名称；
7. 安装中间会重启一次，重启后在`CLOVER`中选择`macOS Install from XXX(这次是你的分区名称)`，这步安装完成后会再次重启。如果在这步出现问题请参考下面的问题部分1；
8. 待第七步结束之后你的`CLOVER`中应该会出现一个`macOS`的选项，回车键进入就可以基本正常使用了~~，如果不能正常使用的话请参考问题部分2~~，恭喜你已经迈出进入macOS大门的第一脚！！！
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

The Backlight Level has been customized and no modification required. If you still need adjust backlight level, please edit Method `_BCL` from Device `PNLF` in `CLOVER\ACPI\patched\SSDT-BRT6.dsl`. Method `_BCL` returns a Package with 19 numbers, then the first and the last one are maximum level (and it's not a good idea to change these two number). The second one controls the backlight level which will be used when macOS is going to sleep. a中间的4-18位自由发挥即可（均为10进制），修改好后保存并编译为`SSDT-BRT6.aml`，重启即可见效。

### 4. Discrete Graphic（MX150）and SD Card reader

Impossible for now.

### 5. Audio

当前驱动的扬声器为底面的扬声器，因为ENVY节点问题四扬声器可能不能同时进行输出。如果有好的解决办法欢迎PR。如果想要尝试C面扬声器，需使用`Clover Configurator`修改`CLOVER\config.plist`中`设备设置`-`属性`-`PciRoot(0x0)/Pci(0x14,0x3)`中`layout-id`部分修改为`1C0000000`。

### 6. Wireless Card

网卡部分其实对于`macOS`没什么好说的，原生网卡`Intel AC7265`，暂时用不了，这里我用的网卡DW1560（只推荐这张，1820A几乎不可用，1830可能因大小问题不能安装），或者使用安卓热点开热点共享；
如果你使用的是`DW1560`，在使用`Windows`时不要安装DELL官网提供的驱动，请使用通过`Windows更新`获取最新的网卡驱动，蓝牙部分驱动则无所谓；
如果你尝试使用`DW1820a`，那么我祝你好运，但我本人因技术有限不再提供任何与`DW1820a`有关的技术支持，如果有需要，请移步[小兵的blog](https://blog.daliansky.net)查看对应问题的解决方案。

### 7. Hard Drive

如果你爱好折腾，并觉得系统时不时会卡，建议换根固态，这是原装固态的性能与对`macOS`兼容差导致的；同样的可能会遇到睡眠或者关机会自动重启并弹出`您的电脑遇到问题重启`，这是因为原装Intel固态对`macOS`兼容性有问题导致的，我上网查了在别的社区`Rehabman`评价过这个问题，基本无解，如果有解决方案欢迎PR。
Due to Hp, the SSD

### 8. SMC（Not Need）

项目中默认使用的是VirtualSMC，由[Acidanthera](https://github.com/acidanthera)维护，目前效果很好，如无必要无需替换。但如果有调试需要，仍可尝试由[Clover团队](https://github.com/CloverHackyColor)维护的FakeSMC，所需文件均在`POST-Install/FakeSMC`中。

| 序号 | 路径 | 删除| 添加 |
| :---: | :--- | :--- | :--- |
| 1 | `CLOVER\Kext\Other` | 原先所有带SMC字样的Kext文件（夹） | `POST-Install/FakeSMC`中所有`Kext`文件（夹） |
| 2 | `CLOVER\drivers\UEFI` | VirtualSMC.efi | SMCHelper.efi |

如果先前已经使用`VirtualSMC`进入过系统，则还需重置`NVRAM`（Clover界面按`F11`即可）。

### 9. Battery（无需）

电池百分比读数使用`VirtualSMC`及其组件实现，无需修改。但如果想使用`FakeSMC`或者认为电池读数有明显严重问题可使用定制SSDT的方法，所需文件均在`POST-Install/Battery`中。将其中的`SSDT-BAT0.aml`移至`CLOVER\ACPI\patched`中，并在`CLOVER\config.plist`中的`SortedOrder`部分按照模式添加行`SSDT-BAT0.aml`

### 10. Trackpad（无需）

触控板使用由[Acidanthera](https://github.com/acidanthera)所维护的`VoodooPS2`项目驱动，已经是支持白果手势支持的最好的`PS2触控板`驱动了。如果有需要请自行寻找并替换`ApplePS2SmartTouchPad`驱动或者最开始由[Rehabman](https://bitbucket.org/%7Be26fb9ce-5cc2-4e36-8576-7a8faae8e194%7D/)维护的`VoodooPS2`驱动。

## 4. Issues

1. 全套配置已经由我本人亲自调试，并没有过多问题，安装按照上文提到的教程就不会有差错。如果还是不行，你可以问一下你的电脑为什么不行；
2. 如果有什么改进或者其他建议欢迎PR。

## 5. And more... 


我是`XPS 15 9560`用户，这个配置写下来最主要还是为了我女朋友，`ENVY 13 ad1XX`是她的电脑，执笔时她刚刚买了一台`iPad Air 3`，本着折腾的精神以及更好的体验苹果生态，我决定为她做这么一份引导，驱动的更新不会太差，但是可能很多情况下对问题的修复会有些不及时。<br />

2020-01-11续<br />

这台机子奉劝大家千万不要用1820A，按照小兵的方法，原则上是不能驱动的，但是可以通过固件保留的方式（启动Windows后重启到Mac）使用网卡，但代价是不能睡眠，一睡网卡必定掉，整个系统直接卡死。

2020-02-24续<br />

基本上我已经把能填的坑都填了，oc暂无计划但难度不大，迁移的话其实很简单，但短期内没有计划，所以项目会进入大概半年的维护期。仅更新驱动但问题修复会延期。（原则上讲也没什么问题了）<br />

2020-04-11 续<br />

Hotpatch补丁基本已经趋近于完善了，Error该修的都修了，改做操作系统判断的也都做了，基本上这套Hotpatch转OC是没有什么大的问题的。

2020-05-05 续<br />

OC坑已填，剩下一个月不更新，抓紧补论文。

## 鸣谢

以下排名不分先后：<br>
[Acidanthera](https://github.com/acidanthera)提供的各种驱动、[Clover团队](https://github.com/CloverHackyColor)提供的引导及部分驱动、[Daliansky（黑果小兵）](https://github.com/daliansky/)及其[博客](https://blog.daliansky.net/)提供的首版引导和DW1820A驱动方式及睡眠修复方法、[Bat.bat](https://github.com/williambj1)提供的Envy13亮度快捷键以及电池补丁、[Aris](https://ariser.cn)提供的10.14.5以及HDMI补丁、[JardenLiu](https://github.com/jardenliu)提供的XPS15教程以及一系列讲解以供深入学习Hackintosh、[Rehabman](https://bitbucket.org/%7Be26fb9ce-5cc2-4e36-8576-7a8faae8e194%7D/)提供的一系列补丁、以及很多朋友提供的问题反馈！



请勿使用此项目用作商业目的<br>
惠普电脑装Mac交流群：543758684<br>
ENVY13(2017)交流群：247548827<br>
