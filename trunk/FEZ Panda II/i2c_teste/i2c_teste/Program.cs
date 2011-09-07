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
            //create I2C object
            I2CDevice.Configuration con = new I2CDevice.Configuration(0x50, 100);
            I2CDevice MyI2C = new I2CDevice(con);

            byte[] Data = new byte[1];
            I2CDevice.I2CTransaction[] xActions = new I2CDevice.I2CTransaction[1];
            xActions[0] = I2CDevice.CreateWriteTransaction(new byte[2] { 0, 55 });
            MyI2C.Execute(xActions, 1000);

            Thread.Sleep(5);   // Mandatory after each Write transaction !!!
            I2CDevice.I2CTransaction[] yActions = new I2CDevice.I2CTransaction[2];
            yActions[0] = I2CDevice.CreateWriteTransaction(new byte[] { 0x00 });
            yActions[1] = I2CDevice.CreateReadTransaction(Data);
            MyI2C.Execute(yActions, 1000);
 
            Thread.Sleep(5);
            Debug.Print("Data: " + Data[0].ToString());
        }

    }
}
