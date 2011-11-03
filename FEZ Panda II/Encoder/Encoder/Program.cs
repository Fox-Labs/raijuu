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

        static OutputPort LED;
        static int i = 0;
        static int j = 0;

        public static void Main()
        {
            PWM servo = new PWM((PWM.Pin)FEZ_Pin.PWM.Di5);

            LED = new OutputPort((Cpu.Pin)FEZ_Pin.Digital.LED, true);
            // the pin will generate interrupt on high and low edges
            InterruptPort IntEncoderA = new InterruptPort((Cpu.Pin)FEZ_Pin.Interrupt.An0, true, Port.ResistorMode.Disabled, Port.InterruptMode.InterruptEdgeBoth);
            InterruptPort IntEncoderB = new InterruptPort((Cpu.Pin)FEZ_Pin.Interrupt.An1, true, Port.ResistorMode.Disabled, Port.InterruptMode.InterruptEdgeBoth);


            // add an interrupt handler to the pin
            IntEncoderA.OnInterrupt += new NativeEventHandler(IntEncoderA_OnInterrupt);
            IntEncoderB.OnInterrupt += new NativeEventHandler(IntEncoderB_OnInterrupt);

            InputPort Button;
            bool button_state;
            Button = new InputPort((Cpu.Pin)FEZ_Pin.Digital.LDR, false, Port.ResistorMode.PullUp);


            while (true)
            {
                button_state = Button.Read();

                if (button_state == false) servo.SetPulse(20 * 1000 * 1000, 1450 * 1000);
                if (button_state == true) servo.SetPulse(20 * 1000 * 1000, 1500 * 1000);

                if (i > 1024) Debug.Print("I > 1024");
            }

        }
        
        static void IntEncoderA_OnInterrupt(uint port, uint state,DateTime time)
        {
            i = i + 1;
        }

        static void IntEncoderB_OnInterrupt(uint port, uint state, DateTime time)
        {
            i = i + 1;
        }

    }
}
