// Fix All Sleep Issus
DefinitionBlock ("", "SSDT", 2, "hack", "SLP5", 0x00000000)
{
    External(_SB.PCI0.XHC, DeviceObj)
    External (_SB_.PCI0.RP01.PXSX.OFF, MethodObj)
    External (_SB_.PCI0.RP01.PXSX.ON, MethodObj)
    External (ZPTS, MethodObj)
    External (ZWAK, MethodObj)

    Device (SLPC)
    {
        Name (_ADR, 0)
        Name (DPTS, 1)
    }

    Scope (_SB.PCI0.XHC)
    {
        OperationRegion (PMWX, PCI_Config, 0x00, 0x0100)
        Field (PMWX, AnyAcc, NoLock, Preserve)
        {
            Offset (0x75), 
            PMXX,   1, //PMEE
        }
    }
    
    Method (_PTS, 1, NotSerialized) //Method (_PTS, 1, Serialized)
    {
        // Avoid Wake up black screen with DGPU
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (\SLPC.DPTS))
            {
                \_SB_.PCI0.RP01.PXSX.ON()
            }
        }

        ZPTS(Arg0)
        If (_OSI ("Darwin"))
        {
            If (5 == Arg0)
            {       
                \_SB.PCI0.XHC.PMXX = 0
            }
        }
    }
    
    Method (_WAK, 1, NotSerialized) //Method (_WAK, 1, Serialized)
    {   
        
        If (_OSI ("Darwin"))
        {
            If (Arg0 < 1 || Arg0 > 5 )
            {
                Arg0 = 3
            }
            If (CondRefOf (\SLPC.DPTS))
            {
                \_SB_.PCI0.RP01.PXSX.OFF()
            }
        }

        Local0 = ZWAK(Arg0)
        Return (Local0)
    }
    
    External(XPRW, MethodObj)
    Method (GPRW, 2, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            If ((0x6D == Arg0))
            {
                Return (Package ()
                {
                    0x6D, 
                    Zero
                })
            }

            If ((0x0D == Arg0))
            {
                Return (Package ()
                {
                    0x0D, 
                    Zero
                })
            }
        }
        Return (XPRW (Arg0, Arg1))
    }
}

