/*
*Bright Function Key Fix
*Rename: _Q13 to XQ13
*Find:5F513133
*Replace:58513133
*/
DefinitionBlock ("", "SSDT", 2, "HPENVY", "BRT6", 0x00000000)
{
    External (_SB_.PCI0.LPCB.H_EC, DeviceObj)
    External (_SB_.PCI0.LPCB.PS2K, DeviceObj)
    External (_SB_.PCI0.LPCB.H_EC.XQ13, MethodObj)
    External (HKNO, FieldUnitObj)
    //Bright Function Key Inject
    Scope (_SB.PCI0.LPCB.H_EC)
    {
        Method (_Q13, 0, Serialized)  // _Qxx: EC Query, xx=0x00-0xFF
        {
            If (_OSI ("Darwin"))
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
                }
            }
            Else
            {
                 \_SB.PCI0.LPCB.H_EC.XQ13 ()
            }
        }
    }
    // Bright Inject
    If (_OSI ("Darwin"))
    {
        Scope(_SB)
        {
            Device(PNLF)
            {
                Name (_ADR, Zero)
                Name (_HID, EisaId ("APP0002"))
                Name (_CID, "backlight")
                Name (_UID, 16)
                Method (_BCL, 0, NotSerialized)
                {
                    Return (Package (0x13)
                    {
                        1388, 
                        252, 
                        0, 
                        24, 
                        39, 
                        58, 
                        82, 
                        113, 
                        150, 
                        196, 
                        252, 
                        320, 
                        403, 
                        502, 
                        622, 
                        766, 
                        938, 
                        1144, 
                        1388
                    })
                }
                Method (_STA, 0, NotSerialized)
                {
                    Return (0x0B)
                }
            }
        }        
    }

}

