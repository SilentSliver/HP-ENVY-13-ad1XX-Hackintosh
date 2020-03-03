// Disable Devices Like DGPU SDCard I2C0 and I2C1
DefinitionBlock ("", "SSDT", 2, "hack", "RMDC", 0x00000000)
{
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C0.XSTA, MethodObj)
    External (_SB_.PCI0.I2C1.XSTA, MethodObj)
    External (_SB_.PCI0.RP01.PXSX._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP05.PXSX._OFF, MethodObj)    // 0 Arguments

    Device (RMDC)
    {
        Name (_HID, "RMDC1000")  // _HID: Hardware ID
        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            If (_OSI ("Darwin"))
            {
                 \_SB.PCI0.RP01.PXSX._OFF ()
                 \_SB.PCI0.RP05.PXSX._OFF ()
            }          
        }
    }

    // Disable I2C0 Device
    Scope (_SB.PCI0.I2C0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x00)
            }
            Else
            {
                Return (\_SB.PCI0.I2C0.XSTA ())
            }   
        }
    }

    //Disable I2C1 Device
    Scope (_SB.PCI0.I2C1)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            If (_OSI ("Darwin"))
            {
                Return (0x00)
            }
            Else
            {
                Return (\_SB.PCI0.I2C1.XSTA ())
            }   
        }
    }
}

