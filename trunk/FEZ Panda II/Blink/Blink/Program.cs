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
            // Blink board LED

            bool ledState = false;

            OutputPort led = new OutputPort((Cpu.Pin)FEZ_Pin.Digital.LED, ledState);

            while (true)
            {
                // Sleep for 500 milliseconds
                Thread.Sleep(2000);

                // toggle LED state
                ledState = !ledState;
                led.Write(ledState);
            }
        }

    }
}
