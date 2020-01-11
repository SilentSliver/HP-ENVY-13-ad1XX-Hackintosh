/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20190509 (64-bit version)
 * Copyright (c) 2000 - 2019 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLVnhSLn.aml, Sat Jan 11 18:52:27 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x00000113 (275)
 *     Revision         0x02
 *     Checksum         0x66
 *     OEM ID           "hack"
 *     OEM Table ID     "PRW"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20190509 (538510601)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "PRW", 0x00000000)
{
    External (_SB_.PCI0.GLAN, DeviceObj)
    External (_SB_.PCI0.HDAS, DeviceObj)
    External (_SB_.PCI0.XHC_, DeviceObj)

    Scope (_SB)
    {
        Method (PPPW, 0, Serialized)
        {
            Return (Package (0x02)
            {
                0x6D, 
                Zero
            })
        }
    }

    If (CondRefOf (\_SB.PCI0.XHC))
    {
        Scope (_SB.PCI0.XHC)
        {
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PPPW ())
            }
        }
    }

    If (CondRefOf (\_SB.PCI0.HDAS))
    {
        Scope (_SB.PCI0.HDAS)
        {
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PPPW ())
            }
        }
    }

    If (CondRefOf (\_SB.PCI0.GLAN))
    {
        Scope (_SB.PCI0.GLAN)
        {
            Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
            {
                Return (\_SB.PPPW ())
            }
        }
    }
}

