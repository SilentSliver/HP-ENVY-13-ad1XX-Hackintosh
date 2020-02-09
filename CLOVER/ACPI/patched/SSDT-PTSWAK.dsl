
DefinitionBlock ("", "SSDT", 2, "hack", "PTSWAK", 0x00000000)
{
    External (_SB_.PCI0.RP01.PXSX.OFF, MethodObj)
    External (_SB_.PCI0.RP01.PXSX.ON, MethodObj)
    External (_SB_.PCI0.XHC_.PMEE, FieldUnitObj)
    External (RMCF.DPTS, IntObj)
    External (RMCF.SHUT, IntObj)
    External (RMCF.XPEE, IntObj)
    External (ZPTS, MethodObj)
    External (ZWAK, MethodObj)
    External(_SB.PCI0.XHC, DeviceObj)
    
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

        If (CondRefOf (\RMCF.DPTS))
        {
            \_SB_.PCI0.RP01.PXSX.ON()
        }

        ZPTS(Arg0)

        
        If (5 == Arg0)
        {       
            \_SB.PCI0.XHC.PMXX = 0
        }
    }
    
    Method (_WAK, 1, NotSerialized) //Method (_WAK, 1, Serialized)
    {
        
        If (Arg0 < 1 || Arg0 > 5 )
        {
            Arg0 = 3
        }       
        
        If (CondRefOf (\RMCF.DPTS))
        {
            \_SB_.PCI0.RP01.PXSX.OFF()
        }

        Local0 = ZWAK(Arg0)

        Return (Local0)
    }
}

