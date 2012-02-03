using System;
using System.Threading;

using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

using GHIElectronics.NETMF.FEZ;
using GHIElectronics.NETMF.Hardware;
using GHIElectronics.NETMF.System;

namespace FEZ_Panda_II_Application1
{
    public class Program
    {
        public static void Main()
        {
            PWM pwm = new PWM((PWM.Pin)FEZ_Pin.PWM.Di5);
            pwm.Set(38000,50);


            OutputPort pwm2;
            pwm2 = new OutputPort((Cpu.Pin)FEZ_Pin.Digital.Di6, true);
            
            while (true)
            {
                pwm2.Write(true);
                Thread.Sleep(50);
                pwm2.Write(false);
                Thread.Sleep(50);
            }
        }
    }
}
