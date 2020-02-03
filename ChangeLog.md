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

## 更新日志
### 2020-02-03
1. 更新AirportBrcmFixup至2.0.6（这版据说给了点对1820a的优化）
2. 更新AppleALC至1.4.6
3. 更新BrcmPatchRAM至2.5.1
4. 更新CPUFriend至1.2.0
5. 更新Lilu至1.4.1
6. 更新WhatEverGreen至1.3.6
7. 更新VoodooPS2至2.1.1（修复了大写锁定灯的问题）
8. 添加VirtualSMC 1.1.1 至Post-Install，以供选择

### 2020-01-11
1. 放弃驱动DW1820A；
2. 修复了之前电池百分比显示问题；
3. 驱动了原生亮度快捷键；
4. 更新`FakeSMC`套件至3.5.3；
5. 调整了待机功耗，现在待机时间应该更长了；
6. 将屏蔽或者禁用的设备合并到一个`SSDT`的`AML`文件中了；
7. 声卡ID换至`03`以获得更好的声音表现；
8. 还有什么其他乱七八糟的我想不起来的更新。