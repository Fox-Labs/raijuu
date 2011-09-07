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
            byte[] RawData = new byte[6];

            I2CDevice.Configuration con = new I2CDevice.Configuration(0x52, 100);
            I2CDevice Nunchuck = new I2CDevice(con);

            I2CDevice.I2CTransaction[] xActions = new I2CDevice.I2CTransaction[1];
            xActions[0] = I2CDevice.CreateWriteTransaction(new byte[] { 0xF0, 0x55 });
            //xActions[1] = I2CDevice.CreateWriteTransaction(new byte[] { 0x55 });
            Nunchuck.Execute(xActions, 1000);
            Thread.Sleep(5);

            I2CDevice.I2CTransaction[] yActions = new I2CDevice.I2CTransaction[1];
            yActions[0] = I2CDevice.CreateWriteTransaction(new byte[] { 0xFB, 0x00 });
            //yActions[1] = I2CDevice.CreateWriteTransaction(new byte[] { 0x00 });
            Nunchuck.Execute(yActions, 1000);
            Thread.Sleep(5);

            while(true)
            {
                I2CDevice.I2CTransaction[] zActions = new I2CDevice.I2CTransaction[2];
                zActions[0] = I2CDevice.CreateWriteTransaction(new byte[] { 0x00 });
                zActions[1] = I2CDevice.CreateReadTransaction(RawData);
                Nunchuck.Execute(zActions, 1000);
                Thread.Sleep(5);

                Debug.Print("RAW1: " + RawData[0].ToString());
                Debug.Print("RAW2: " + RawData[1].ToString());
                Debug.Print("RAW3: " + RawData[2].ToString());
                Debug.Print("RAW4: " + RawData[3].ToString());
                Debug.Print("RAW5: " + RawData[4].ToString());
                Debug.Print("RAW6: " + RawData[5].ToString());

                Thread.Sleep(1000);
            }
        }
    }
}
