DefinitionBlock ("", "SSDT", 2, "hack", "SLP5", 0x00000000)
{
    External (_SB_.PCI0.GLAN, DeviceObj)
    External (_SB_.PCI0.HDAS, DeviceObj)
    External (_SB_.PCI0.XHC_, DeviceObj)
    External (_SB_.PCI0.XHC.XPRW, MethodObj)
    External (_SB_.PCI0.HDAS.XPRW, MethodObj)
    External (_SB_.PCI0.GLAN.XPRW, MethodObj)
    External (_SB_.PCI0.RP01.PXSX.OFF, MethodObj)
    External (_SB_.PCI0.RP01.PXSX.ON, MethodObj)
    External (ZPTS, MethodObj)
    External (ZWAK, MethodObj)
    
    Method (_PTS, 1, NotSerialized) //Method (_PTS, 1, Serialized)
    {
        // Avoid Wake up black screen with DGPU
        If (_OSI ("Darwin"))
        {
            \_SB_.PCI0.RP01.PXSX.ON()
        }

        ZPTS(Arg0)
        
    }
    
    Method (_WAK, 1, NotSerialized) //Method (_WAK, 1, Serialized)
    {   
        
        If (_OSI ("Darwin"))
        {
            If (Arg0 < 1 || Arg0 > 5 )
            {
                Arg0 = 3
            }    
            \_SB_.PCI0.RP01.PXSX.OFF()
        }

        Local0 = ZWAK(Arg0)
        Return (Local0)
    }

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
    Scope (_SB.PCI0.XHC)
    {
        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
        {
            If (_OSI ("Darwin"))
            {
                Return (\_SB.PPPW ())
            }
            Else
            {
                Return (\_SB.PCI0.XHC.XPRW ())
            }
        }
    }
    Scope (_SB.PCI0.HDAS)
    {
        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
        {
            If (_OSI ("Darwin"))
            {
                Return (\_SB.PPPW ())
            }
            Else
            {
                Return (\_SB.PCI0.HDAS.XPRW ())
            }
        }
    }
 
    Scope (_SB.PCI0.GLAN)
    {
        Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
        {
            If (_OSI ("Darwin"))
            {
                Return (\_SB.PPPW ())
            }
            Else
            {
                Return (\_SB.PCI0.GLAN.XPRW ())
            }
        }
    }
}

