/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20190509 (64-bit version)
 * Copyright (c) 2000 - 2019 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLkw2YhK.aml, Sat Jan 11 18:54:42 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000FE (254)
 *     Revision         0x02
 *     Checksum         0xFA
 *     OEM ID           "hack"
 *     OEM Table ID     "NDGP"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20190509 (538510601)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "NDGP", 0x00000000)
{
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C0.XSTA, MethodObj)
    External (_SB_.PCI0.I2C1.XSTA, MethodObj)
    External (_SB_.PCI0.RP01.PXSX._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP05.PXSX._OFF, MethodObj)    // 0 Arguments

    Device (RMDC)
    {
        Name (_HID, "DGPU1000")  // _HID: Hardware ID
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                 \_SB.PCI0.RP01.PXSX._OFF ()
                 \_SB.PCI0.RP05.PXSX._OFF ()
            }          
        }
    }

    Scope (_SB.PCI0.I2C0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x00)
            }
            Else
            {
                Return (\_SB.PCI0.I2C0.XSTA ())
            }   
        }
    }

    Scope (_SB.PCI0.I2C1)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x00)
            }
            Else
            {
                Return (\_SB.PCI0.I2C1.XSTA ())
            }   
        }
    }
}

