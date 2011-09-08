﻿using System;
using System.Threading;

using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

using GHIElectronics.NETMF.FEZ;
using GHIElectronics.NETMF.Hardware;

namespace FEZ_Panda_II_Application1
{
    public class Program
    {
        public static void Main()
        {
            PWM servo = new PWM((PWM.Pin)FEZ_Pin.PWM.Di5);
            while (true)
            {
                // 0 degrees. 20ms period and 1.00ms high pulse
                Debug.Print("1.00");
                servo.SetPulse(20 * 1000 * 1000, 1000 * 1000);
                Thread.Sleep(5000);

                // 90 degrees. 20ms period and 1.50ms high pulse
                Debug.Print("1.50");
                servo.SetPulse(20 * 1000 * 1000, 1500 * 1000);
                Thread.Sleep(5000);

                // 180 degrees. 20ms period and 2.00ms high pulse
                Debug.Print("2.10");
                servo.SetPulse(20 * 1000 * 1000, 2100 * 1000);
                Thread.Sleep(5000);
            }
        }

    }
}
