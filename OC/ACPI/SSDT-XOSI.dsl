//
// Override OS Identify Method
// Rename in Config:
// _INI to XINI
// Find:     5F4F5349
// Replace:  584F5349
//

DefinitionBlock("", "SSDT", 2, "HPENVY", "XOSI", 0)
{
    External (TBPE, IntObj)
    External (WFEV, EventObj)
    External (OSUM, MutexObj)
    External (TBMP, FieldUnitObj)
    External (TBS1, FieldUnitObj)
    External (TBSE, FieldUnitObj)
    External (TBTS, FieldUnitObj)
    External (OSYS, FieldUnitObj)
    External (_SB.PCI0, DeviceObj)
    External (_GPE.TINI, MethodObj)
    External (_PR_.DTSE, UnknownObj)
    External (_PR_.DSAE, UnknownObj)
    Scope (_SB.PCI0)
    {
        Method (_INI, 0, Serialized)  // _INI: Initialize
        {
            TBPE = One
            OSYS = 0x07D0
            If (CondRefOf (\_OSI))
            {
                If (_OSI ("Linux"))
                {
                    OSYS = 0x03E8
                }

                If (_OSI ("Windows 2001"))
                {
                    OSYS = 0x07D1
                }

                If (_OSI ("Windows 2001 SP1"))
                {
                    OSYS = 0x07D1
                }

                If (_OSI ("Windows 2001 SP2"))
                {
                    OSYS = 0x07D2
                }

                If (_OSI ("Windows 2001.1"))
                {
                    OSYS = 0x07D3
                }

                If (_OSI ("Windows 2006"))
                {
                    OSYS = 0x07D6
                }

                If (_OSI ("Windows 2009"))
                {
                    OSYS = 0x07D9
                }

                If (_OSI ("Windows 2012"))
                {
                    OSYS = 0x07DC
                }

                If (_OSI ("Windows 2013"))
                {
                    OSYS = 0x07DD
                }

                If (_OSI ("Windows 2015") || _OSI("Darwin"))
                {
                    OSYS = 0x07DF
                }
            }

            If (CondRefOf (\_PR.DTSE))
            {
                If ((\_PR.DTSE >= One))
                {
                    \_PR.DSAE = One
                }
            }

            If ((TBTS == One))
            {
                Acquire (OSUM, 0xFFFF)
                \_GPE.TINI (TBSE)
                Release (OSUM)
                If ((TBMP == One))
                {
                    Acquire (OSUM, 0xFFFF)
                    \_GPE.TINI (TBS1)
                    Release (OSUM)
                }

                Signal (WFEV)
            }
        }
    }
}
//EOF
