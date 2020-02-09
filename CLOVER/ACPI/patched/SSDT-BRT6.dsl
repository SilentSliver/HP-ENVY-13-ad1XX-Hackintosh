/*Rename: _Q13 to XQ13
*Find:5F513133
*Replace:58513133
*Rename:H_EC to EC__
*Find:485F4543
*Replace:45435F5F
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

