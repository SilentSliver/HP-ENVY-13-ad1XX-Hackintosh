// Fix All Sleep Issus
DefinitionBlock ("", "SSDT", 2, "HPENVY", "SLP5", 0x00000000)
{
    External (H2OP, MethodObj)
    External (ZPTS, MethodObj)
    External (ZWAK, MethodObj)
    External (S5WL, FieldUnitObj)
    External (RMDC.DGOF, MethodObj)
    External (_SB_.PCI0.LPCB.H_EC.LWKE, FieldUnitObj)
    
    If (_OSI ("Darwin"))
    {
        Device (SLPC)
        {
            Name (_ADR, 0)
            Name (DIDE, 0)
            Name (DPTS, 1)
            Method (_STA, 0)  // _STA: Status
            {
                Return (0x0F)
            }
        }
    }
    
    Method (_PTS, 1)
    {
        ZPTS(Arg0)
        If (_OSI ("Darwin")&&(Arg0 == 0x05)&&S5WL)
        {
            \_SB.PCI0.LPCB.H_EC.LWKE = 0
        }
    }
    
    Method (_WAK, 1, Serialized) 
    {   
        Local0 = ZWAK(Arg0)
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (\SLPC.DPTS)&& CondRefOf (\RMDC.DOFF))
            {
                \RMDC.DGOF()
            }
        }
        Return (Local0)
    }
    
    External(XPRW, MethodObj)
    Method (GPRW, 2)
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
    
    If (_OSI ("Darwin")&&(\SLPC.DIDE == 1))
    {

        Scope (\_SB)
        {
            Method (LPS0, 0)
            {
                Return (1)
            }
        }

        Scope (\_GPE)
        {
            Method (LXEN, 0)
            {
                Return (1)
            }
        }

        Scope (\)
        {
            Name (SLTP, 0)
            Method (_TTS, 1)  // _TTS: Transition To State
            {
            SLTP = Arg0
            }
        }
    }
}

