// Disable Devices Like DGPU SDCard I2C0 and I2C1
DefinitionBlock ("", "SSDT", 2, "HPENVY", "RMDC", 0x00000000)
{
    External (_SB_.PCI0.I2C0, DeviceObj)
    External (_SB_.PCI0.I2C1, DeviceObj)
    External (_SB_.PCI0.I2C0.XSTA, MethodObj)
    External (_SB_.PCI0.I2C1.XSTA, MethodObj)
    External (_SB_.PCI0.RP01.PXSX._ON, MethodObj) 
    External (_SB_.PCI0.RP01.PXSX._OFF, MethodObj)    // 0 Arguments
    External (_SB_.PCI0.RP05.PXSX._OFF, MethodObj)    // 0 Arguments
    If (_OSI ("Darwin"))
    { 
        Device (RMDC)
        {
            Name (_HID, "RMDC1000")  // _HID: Hardware ID
            Method (_INI, 0, NotSerialized)  // _INI: Initialize
            {
                DGOF()
                SDOF()
            }
            
            
            Method (DGOF, 0, NotSerialized)
            {
                //path:
                If (CondRefOf (\_SB.PCI0.RP01.PXSX._OFF))
                {
                    \_SB.PCI0.RP01.PXSX._OFF()
                }
            }   
            
            Method (SDOF, 0, NotSerialized)
            {
                //path:
                If (CondRefOf (\_SB.PCI0.RP05.PXSX._OFF))
                {
                    \_SB.PCI0.RP05.PXSX._OFF()
                }
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
            Return (\_SB.PCI0.I2C0.XSTA ())
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
            Return (\_SB.PCI0.I2C1.XSTA ()) 
        }
    }
}

