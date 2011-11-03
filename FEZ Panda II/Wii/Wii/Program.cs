using System;
using System.Threading;

using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

using GHIElectronics.NETMF.FEZ;
using GHIElectronics.NETMF.Hardware;

namespace FEZ_Panda_II_Application1
{
    public class Program
    {

        public static void Wii()
        {
            byte[] Raw = new byte[6];

            int Acell_X;
            int Acell_Y;
            int Acell_Z;

            int Stick_X;
            int Stick_Y;

            int Button_C;
            int Button_Z;

            int Mode_Roll;
            int Mode_Pitch;
            int Mode_Yaw;

            double Speed_Roll;
            double Speed_Pitch;
            double Speed_Yaw;

            double Calib_Roll = 8125 ;
            double Calib_Pitch = 7736;
            double Calib_Yaw = 7520;

            double Deg_Roll;
            double Deg_Pitch;
            double Deg_Yaw;

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

                /*************************************************************************/
                /* Magicas malucas, qualquer duvida ver seguinte pagina:                 */
                /* http://wiibrew.org/wiki/Wiimote/Extension_Controllers/Wii_Motion_Plus */
                /*************************************************************************/
                if (Raw[5] % 4 == 0)
                {   
                    /***********/
                    /* NUNCHUK */
                    /***********/

                    Stick_X = Raw[0];
                    Stick_Y = Raw[1];

                    Acell_X = (Raw[2] << 2) + ((Raw[5] & 16) >> 4) - 512;
                    Acell_Y = (Raw[3] << 2) + ((Raw[5] & 32) >> 5) - 512;
                    Acell_Z = (Raw[4]/2 << 3) + ((Raw[5] & 192) >> 6) - 512;

                    Button_C = ((Raw[5] & 8) >> 3);
                    Button_Z = ((Raw[5] & 4) >> 2);
                }

                if (Raw[5] % 4 == 2)
                {
                    /***************/
                    /* Motion Plus */
                    /***************/

                    Mode_Roll = ((Raw[4] & 2) >> 1);
                    Mode_Pitch = ((Raw[3] & 1) >> 0);
                    Mode_Yaw = ((Raw[3] & 2) >> 1);

                    Speed_Roll = ((Raw[4] & 252) << 6) + Raw[1];
                    Speed_Pitch = ((Raw[5] & 252) << 6) + Raw[2];
                    Speed_Yaw = ((Raw[3] & 252) << 6) + Raw[0];

                    if (Mode_Roll == 0) Deg_Roll = (Speed_Roll - Calib_Roll) / (float)(13.768) * (float)(4.545);
                    else Deg_Roll = (Speed_Roll - Calib_Roll) / (float)(13.768);

                    if (Mode_Pitch == 0) Deg_Pitch = (Speed_Pitch - Calib_Pitch) / (float) (13.768) * (float) (4.545);
                    else Deg_Pitch = (Speed_Pitch - Calib_Pitch) / (float) (13.768);

                    if (Mode_Yaw == 0) Deg_Yaw = (Speed_Yaw - Calib_Yaw) / (float)(13.768) * (float)(4.545);
                    else Deg_Yaw = (Speed_Yaw - Calib_Yaw) / (float)(13.768);

                    Debug.Print("Deg Roll: " + Deg_Roll);
                    Debug.Print("Deg Pitch: " + Deg_Pitch);
                    Debug.Print("Deg Yaw: " + Deg_Yaw);
                    Debug.Print("");
                }
            }
        }

        public static void Main()
        {
            Thread Handler;
            Handler = new Thread(Wii);
            Handler.Start();
            Thread.Sleep(Timeout.Infinite);
        }
    }
}