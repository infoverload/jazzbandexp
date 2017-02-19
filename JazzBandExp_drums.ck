/*----------------------------------------------------------------------- 
   Title: JazzBandExp_drums
   Length: 30 seconds
-------------------------------------------------------------------------*/

// sound chain
SndBuf hihat => dac;
SndBuf snare => dac;
Shakers shakers => JCRev reverb => dac;

// set reverb mix
0.1 => reverb.mix;

// shakers parameters
7 => shakers.preset;  // sleigh bells

// me.dirUp 
me.dir(-1) + "/audio/hihat_03.wav" => hihat.read;
me.dir(-1) + "/audio/snare_01.wav" => snare.read;

// set volume
0.5 => hihat.gain;
0.5 => snare.gain;

// function shaker
fun void shaker()
{
    while (true) 
    {
       Math.random2f(0.0, 128.0) => shakers.objects;
       Math.random2f(0.0, 1.0) => shakers.decay; 
       1.0 => shakers.energy;
       2.5 => shakers.noteOn;
       <<< "shaker" >>>; 
       0.625::second => now;
    }
}

// spork shaker() as a child shred
spork ~ shaker();

0 => int counter;
// loop 
while( true )  
{
    counter % 8 => int beat;

    // hihat
    if ( (beat == 0) || (beat == 4) ) 
    {
        Math.random2f(0.3,0.5) => hihat.gain;
        Math.random2f(0.9,1.2) => hihat.rate;
        <<< "hihat" >>>;
       (Math.random2(1,2) * 0.2) :: second => now;
        0 => hihat.pos;
    }
    
    // snare
    if ( (beat == 3) || (beat == 7) ) 
    {
        Math.random2f(0.3,0.5) => snare.gain;
        Math.random2f(0.9,1.2) => snare.rate;
        <<< "snare" >>>;
       (Math.random2(1,2) * 0.2) :: second => now;
        0 => snare.pos;
    }
    
    counter++;  
}
