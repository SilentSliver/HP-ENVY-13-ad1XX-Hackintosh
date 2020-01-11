/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20190509 (64-bit version)
 * Copyright (c) 2000 - 2019 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASL2Clkn3.aml, Sat Jan 11 18:50:55 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000FC (252)
 *     Revision         0x02
 *     Checksum         0x89
 *     OEM ID           "hack"
 *     OEM Table ID     "BRT6"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20190509 (538510601)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "BRT6", 0x00000000)
{
    External (_SB_.PCI0.LPCB.EC__, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (HKNO, FieldUnitObj)

    Scope (_SB.PCI0.LPCB.EC)
    {
        Method (_Q13, 0, Serialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            Switch (HKNO)
            {
                Case (0x07)
                {
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x0405)
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x10) // Reserved
                }
                Case (0x08)
                {
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x0406)
                    Notify (\_SB.PCI0.LPCB.PS2K, 0x20) // Reserved
                }
                Default
                {
                }

            }
        }
    }
}

