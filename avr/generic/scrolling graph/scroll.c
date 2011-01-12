/***********************************************************************/
/*                                                                     */
/*  ___   ___   ______        _  _                                _    */
/* (___) (___)  | ___ \      (_)(_)                              | |   */
/*  ___   ___   | |_/ / __ _  _  _  _   _  _   _     _ __    ___ | |_  */
/* (___) (___)  |    / / _` || || || | | || | | |   | '_ \  / _ \| __| */
/*  _________   | |\ \| (_| || || || |_| || |_| | _ | | | ||  __/| |_  */
/* (_________)  \_| \_|\__,_||_|| | \__,_| \__,_|(_)|_| |_| \___| \__| */
/*                             _/ |                                    */
/*                            |__/                                     */
/*                                                                     */
/* code written by Marcelo Pesse                                       */
/***********************************************************************/


/***********************************/
/* Scrolling Visual Graph Function */
/***********************************/

/* ----------------------------------------------------------------------
 
An idea stolen from sparkfun.

Creates a scrolling graph.
Something like this:

x----------------------|22
x--------------------------------------------|44
x------------------|18

So basically, a simple way to demonstrate some values.
Probably inefficient when it comes to code.

---------------------------------------------------------------------- */

int MAX_VALUE = 1024;
int MIN_VALUE = 0;
int MAX_DASH = 10;

void config_graph(int max, int min, int dash){
    MAX_VALUE = max;
    MIN_VALUE = min;
    MAX_DASH = dash;
}

void print_graph(int value){
    int i;
    
    if (value < MAX_VALUE && value > MIN_VALUE){
        printf("x");
        for (i=0; i++; i > (value * MAX_DASH/(MAX_VALUE - MIN_VALUE) ) )
            printf("-");
        }
        printf("| %d", value);
    }
}
