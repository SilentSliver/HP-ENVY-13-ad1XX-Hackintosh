DefinitionBlock ("", "SSDT", 2, "APPLE ", "SSDT-Bro", 0x00001000)
{
    External (_SB_.PCI0.RP06, DeviceObj)
    External (_SB_.PCI0.RP06.PXSX, DeviceObj)
    Scope (\_SB.PCI0.RP06)
    {
        Scope (PXSX)
        {
            Name (_STA, Zero)  // _STA: Status
        }

        Device (ARPT)
        {
            Name (_ADR, Zero)  // _ADR: Address
            Name (_PRW, Package (0x02)  // _PRW: Power Resources for Wake
            {
                0x09, 
                0x04
            })
            Method (_DSM, 4, NotSerialized)
            {
            If (LEqual(Arg2, Zero)) { Return (Buffer() { 0x03 } ) }
            Return (Package()
            {
                "vendor-id", Buffer() { 0xe4, 0x14, 0x00, 0x00 },
                "device-id", Buffer() { 0x53, 0x43, 0x00, 0x00 },
                "subsystem-vendor-id", Buffer() { 0x6b, 0x10, 0x00, 0x00 },
                "subsystem-id", Buffer() { 0x34, 0x01, 0x00, 0x00 },
                "IOName", "pci14e4,4353",
                "AAPL,slot-name",      // Optional
                Buffer ()
                {
                    "WLAN"
                }, 
                "device_type",         // Optional
                Buffer ()
                {
                    "Airport Extreme"
                }, 
                "name",                // Optional
                Buffer ()
                {
                    "Airport"
                }, 
                "model",               // Optional
                Buffer ()
                {
                    "Dell DW1820A 802.11ac wireless"
                }, 
                "compatible",          // Mandatory
                Buffer ()
                {
                    "pci14e4,4353"     // Declares compatibility with BCM94331; "pci14e4:4353" for BCM43224 may also be used
                }

                })
            }
        }
    }
}


