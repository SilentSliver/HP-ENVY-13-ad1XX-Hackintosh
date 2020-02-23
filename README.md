# HP-ENVY-13-ad1XX-Hackintosh

惠普 ENVY 13 黑苹果

## 配置

| Specs | Model |
| --- | --- |
| Board | HP 83A8 |
| CPU | Intel Core i5-8250U |
| GPU | Intel Graphics UHD 620 |
| Audio | Realtec ALC298 |
| Network | Dell Wireless ~~1820a~~ 1560 |
| Storage | ~~Intel 600P 360G~~ WD SN750 |

## 上次更新

### 2020-02-23

1. 更新`Clover`至5104
2. 修改目录结构
3. 更新说明

[往期更新](./ChangeLog.md)

## 说明

**不要开启文件保险箱（FileVault）！！！开了就得重装！！！**
**尤其是OTA更新系统的时候！！！更新完都看看窗口里是让你干嘛的！！！**
1. 目前10.15.3没有问题，原则上ad0XX与ad1XX系列是通用，具体是否通用还需要进一步测试；
2. 该配置是最早[daliansky](https://github.com/daliansky/)所写的，我对其进行了大量的更新；
3. 如果你想使用FakeSMC，请将`CLOVER\Kext\Other`中所有带`SMC`字样的文件删掉，并`POST-Install/FakeSMC`中的所有`Kext`后缀文件放至`CLOVER\Kexts\Other`中，并将`POST-Install/FakeSMC`中`efi`后缀文件放至`CLOVER\drivers\UEFI`中，并删掉原先其中的`VirtualSMC.efi`。如果先前已经进入过系统，则还需重置`NVRAM`（Clover界面按`F11`即可）；
4. 显卡FakeID `56160000`，仿冒的`HD 620`；
5. 声卡LayoutID `03`，注入的ID `03`，驱动的是底面的扬声器；
6. 原生网卡Intel AC7265，暂时用不了，这里我用的网卡~~DW1820A~~ DW1560（只推荐这张，1820A问题很多，1830可能因大小问题不能安装）；
7. 触控板使用的白果手势，但四指捏合和张开并不能使用，为驱动本身限制，~~似乎~~无解，其余手势都可以正常使用；
8. 如果使用的是DW1820A，Airdrop和HandOff没有问题，但是Sidecar可能不能用。其他网卡没有数据，自行测试；
9. 亮度调节可用，原生亮度快捷键可用，现在亮度档位存在一点问题：调节档位间隔不是很大。大家自行体会，如果有人有更好的方案，欢迎提交；按键大部分更接近百苹果的方式（这里专指CapsLock键，mac下是短按切换中英，长按是开启Capslock，可在`系统偏好设置`中修改）
10. 电池百分比正常；
11. 在`POST-Install\DisplayFile`中有我为AD1XX系列准备的显示文件，使用方式很简单，扔到`Clover\Kexts\Other`中就可以了。AD0XX系列请使用`Hackintool`自行生成，理论上可解决色深问题；
12. 如果您有独显，并尝试驱动他，这边建议您直接放弃`Hackintosh`；
13. 如果您对SD卡口有刚需，请自备读卡器；
14. 如果你爱好折腾，并觉得系统时不时会卡，这边建议换根固态比较好，这是原装固态的性能较差导致的；同样的可能会遇到睡眠或者关机会自动重启并弹出`您的电脑遇到问题重启`，这是因为原装固态Intel 600P对`macOS`兼容性有问题导致的，我上网查了在别的社区`Rehabman`评价过这个问题，基本无解，如果有解决方案欢迎PR。


## 2. 安装

1. 下载macOS原版镜像（或者其他人提供带引导的也可以），文件格式为`dmg`；
2. 使用[`etcher`](https://www.balena.io/etcher/)等工具刻录镜像至U盘；
3. 将提供的`CLOVER`文件夹通过各种手段（不一一列举）放在硬盘的`EFI`分区中的`EFI`文件夹下，并使用`bootice`等工具添加引导项；
4. 重启在HP logo还未出现时按`F10`进入`BIOS`，；
5. 在`CLOVER`中选择`macOS Install from XXX(表示移动设备名称)`进入安装界面；
6. 这步和白果一样，分区啊什么乱七八糟的。这里需要记下自己安装macOS的分区名称；
7. 安装中间会重启一次，重启后在`CLOVER`中选择`macOS Install from XXX(这次是你的分区名称)`，这步安装完成后会再次重启。如果在这步出现问题请参考下面的问题部分1；
8. 待第七步结束之后你的`CLOVER`中应该会出现一个`macOS`的选项，回车键进入就可以基本正常使用了~~，如果不能正常使用的话请参考问题部分2~~，恭喜你已经迈出进入macOS大门的第一脚！！！
9. 请使用Clover Configurator或者其他什么工具都行，**注入自己的三码！！！注入自己的三码！！注入自己的三码！！！**，然后在`系统偏好设置-节能`中关掉**所有**`电能小憩`和`唤醒以供网络访问`的选项，然后基本上就算**大功告成**啦！！！

## 3. 问题

1. 如果你尝试使用1820a，那么我祝你好运，但我本人因技术有限不再提供任何与1820a有关的技术支持，如果有需要，请移步[小兵的blog](https://blog.daliansky.net)查看对应问题的解决方案。
2. 全套配置已经由我本人亲自调试，并没有过多问题，安装按照上文提到的教程就不会有差错。如果还是不行，你可以问一下你的电脑为什么不行；
3. ~~目前PS2驱动存在大写灯不正常/禁用触控板有可能打不开的情况，大家先将就一下，等等VoodooPS2项目更新；~~大写灯现在正常了；
4. 如果在使用过程中出现颜色断层，请看说明第11条；
5. 如果有什么改进或者其他建议欢迎PR。

## 4.写在最后


我是`XPS 15 9560`用户，这个配置写下来最主要还是为了我女朋友，`ENVY 13 ad1XX`是她的电脑，执笔时她刚刚买了一台`iPad Air 3`，本着折腾的精神以及更好的体验苹果生态，我决定为她做这么一份引导，驱动的更新不会太差，但是可能很多情况下对问题的修复会有些不及时。<br />

2020-01-11续<br />

这台机子奉劝大家千万不要用1820A，按照小兵的方法，原则上是不能驱动的，但是可以通过固件保留的方式（启动Windows后重启到Mac）使用网卡，但代价是不能睡眠，一睡网卡必定掉，整个系统直接卡死。

## 鸣谢

以下排名不分先后：<br>
[Acidanthera](https://github.com/acidanthera)提供的各种驱动、[Clover团队](https://github.com/CloverHackyColor)提供的引导及部分驱动、[Daliansky（黑果小兵）](https://github.com/daliansky/)及其[博客](https://blog.daliansky.net/)提供的首版引导和DW1820A驱动方式及睡眠修复方法、[Bat.bat](https://github.com/williambj1)提供的Envy13亮度快捷键以及电池补丁、[Aris](https://ariser.cn)提供的10.14.5以及HDMI补丁、[JardenLiu](https://github.com/jardenliu)提供的XPS15教程以及一系列讲解以供深入学习Hackintosh、[Rehabman](https://bitbucket.org/%7Be26fb9ce-5cc2-4e36-8576-7a8faae8e194%7D/)提供的一系列补丁、以及很多朋友提供的问题反馈！



请勿使用此项目用作商业目的<br>
惠普电脑装Mac交流群：543758684<br>
ENVY13(2017)交流群：247548827<br>
