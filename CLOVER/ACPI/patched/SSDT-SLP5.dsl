// Fix All Sleep Issus
DefinitionBlock ("", "SSDT", 2, "HPENVY", "SLP5", 0x00000000)
{
    External (RMDC.DOFF, MethodObj)
    External (RMDC.DON, MethodObj)
    External (ZPTS, MethodObj)
    External (ZWAK, MethodObj)

    Device (SLPC)
    {
        Name (_ADR, 0)
        Name (DPTS, 1)
    }
    
    Method (_PTS, 1, NotSerialized) //Method (_PTS, 1, Serialized)
    {
        // Avoid Wake up black screen with DGPU
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (\SLPC.DPTS)||CondRefOf (\RMDC.DON))
            {
                \RMDC.DON()
            }
        }

        ZPTS(Arg0)
    }
    
    Method (_WAK, 1, NotSerialized) //Method (_WAK, 1, Serialized)
    {   
        
        If (_OSI ("Darwin"))
        {
            If (CondRefOf (\SLPC.DPTS)||CondRefOf (\RMDC.DOFF))
            {
                \RMDC.DOFF()
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

