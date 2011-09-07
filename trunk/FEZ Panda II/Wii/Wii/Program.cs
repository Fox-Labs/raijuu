using System;
using System.Threading;

using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

using GHIElectronics.NETMF.FEZ;

namespace FEZ_Panda_II_Application1
{
    public class Program
    {
        public static void Main()
        {
            byte[] Raw = new byte[6];

            I2CDevice.Configuration before = new I2CDevice.Configuration(0x53, 100);
            I2CDevice.Configuration after = new I2CDevice.Configuration(0x52, 100);

            I2CDevice Wii = new I2CDevice(before);

            Wii.Config = before;

            I2CDevice.I2CTransaction[] xActions = new I2CDevice.I2CTransaction[1];
            xActions[0] = I2CDevice.CreateWriteTransaction(new byte[] { 0xF0, 0x55 });
            Wii.Execute(xActions, 1000);

            Thread.Sleep(100);

            xActions[0] = I2CDevice.CreateWriteTransaction(new byte[] { 0xFE, 0x05 });
            Wii.Execute(xActions, 1000);

            Thread.Sleep(100);

            Wii.Config = after;

            while (true)
            {
                I2CDevice.I2CTransaction[] yActions = new I2CDevice.I2CTransaction[2];
                yActions[0] = I2CDevice.CreateWriteTransaction(new byte[] { 0x00 });
                yActions[1] = I2CDevice.CreateReadTransaction(Raw);
                Wii.Execute(yActions, 1000);

                if (Raw[5] % 4 == 0)
                {
                    Debug.Print("Nunchuk");
                    Debug.Print("Stick X: " + (Raw[0]).ToString());
                    Debug.Print("Stick Y: " + (Raw[1]).ToString());
                    Debug.Print("Acell X: " + ((Raw[2] * 4) + (Raw[5] & 0x10)/16).ToString());
                    Debug.Print("Acell Y: " + ((Raw[3] * 4) + (Raw[5] & 0x20)/32).ToString());
                    Debug.Print("Acell Z: " + (((Raw[4]/2) * 8) + (Raw[5] & 0xC0)/64).ToString());
                    Debug.Print("Button C: " + ((Raw[5] & 0x8) / 8).ToString());
                    Debug.Print("Button Z: " + ((Raw[5] & 0x4) / 4).ToString());
                    Debug.Print("");
                }

                if (Raw[5] % 4 == 2)
                {
                    Debug.Print("Mote+");

                    Debug.Print("Extension connected: " + (Raw[4] % 2).ToString());
                    Raw[4] = (byte)(Raw[4] / 2);
                    Debug.Print("Roll slow mode: " + (Raw[4] % 2).ToString());
                    Raw[4] = (byte)(Raw[4] / 2);

                    Debug.Print("Pitch slow mode: " + (Raw[3] % 2).ToString());
                    Raw[3] = (byte)(Raw[3] / 2);
                    Debug.Print("Yaw slow mode: " + (Raw[3] % 2).ToString());
                    Raw[3] = (byte)(Raw[3] / 2);

                    Debug.Print("Roll left speed: " + (Raw[4] * 256 + Raw[1]).ToString());

                    Raw[5] = (byte)(Raw[5] / 4);
                    Debug.Print("Pitch left speed: " + (Raw[5] * 256 + Raw[2]).ToString());

                    Debug.Print("Yaw down speed: " + (Raw[3] * 256 + Raw[0]).ToString());

                    Debug.Print("");
                }

                Thread.Sleep(100);
            }
        }
    }
}