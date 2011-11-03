using System;
using System.Threading;

using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;

using GHIElectronics.NETMF.FEZ;

namespace FEZ_Panda_II_Application1
{
    public class Program
    {

        static OutputPort LED;
        static int i = 0;

        public static void Main()
        {
            LED = new OutputPort((Cpu.Pin)FEZ_Pin.Digital.LED, true);
            // the pin will generate interrupt on high and low edges
            InterruptPort IntEncoder = new InterruptPort((Cpu.Pin)FEZ_Pin.Interrupt.An0, true, Port.ResistorMode.Disabled, Port.InterruptMode.InterruptEdgeHigh);
            InterruptPort IntButton = new InterruptPort((Cpu.Pin)FEZ_Pin.Interrupt.LDR, true, Port.ResistorMode.PullUp, Port.InterruptMode.InterruptEdgeLow);
            // add an interrupt handler to the pin
            IntEncoder.OnInterrupt += new NativeEventHandler(IntEncoder_OnInterrupt);
            IntButton.OnInterrupt += new NativeEventHandler(IntButton_OnInterrupt);
            //do anything you like here
            Thread.Sleep(Timeout.Infinite);
        }
        
        static void IntEncoder_OnInterrupt(uint port, uint state,DateTime time)
        {
            i = i + 1;
            Debug.Print("I = " + (i).ToString());
        }

        static void IntButton_OnInterrupt(uint port, uint state, DateTime time)
        {
            Debug.Print("I = " + (i).ToString());
        }

    }
}
