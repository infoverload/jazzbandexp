/*----------------------------------------------------------------------- 
   Title: JazzBandExp_score
   Length: 30 seconds
-------------------------------------------------------------------------*/

// sound chain
TriOsc tri => Pan2 p => dac;

// paths to chuck file
me.dir() + "/JazzBandExp_piano.ck" => string pianoPath;
me.dir() + "/JazzBandExp_drums.ck" => string drumsPath;

// global variables
[46,48,49,51,53,54,56,58] @=> int scale[]; // the Bb Aeolian mode

// set volume
0 => tri.gain;

// timing parameter
0.625 => float beat;


// function - volume sweller
fun void swell( float begin, float end, float grain )
{   
    // swell up
    for ( begin => float j; j < end; j+grain => j )
    {
        j => tri.gain; // set volume
        0.01::second => now;
    }
    
    // swell down
    for ( end => float j; j > begin; j-grain => j )
    {
        j => tri.gain; // set volume
        0.01::second => now;
    }
}

   
// start drums
Machine.add(drumsPath) => int drumsID;
4::second => now;

// start piano
Machine.add(pianoPath) => int pianoID; 
5::second => now;

// loop
now + 13::second => time later;
while( now < later )
{
      for (0 => int i; i < scale.cap(); i++)
      {
         // notes from scale
         swell(0.3, 0.5, 0.05); // calls function to control volume
         Math.random2(0, scale.cap()-1) => int whichnote;
         Std.mtof(scale[whichnote]) => tri.freq;  // MIDI to frequency 
         Math.sin(now/1::second*2*pi) => p.pan; // audio panning in sine pattern 
         <<< "notes from scale" >>>;
         beat::second => now;
      }
}

// remove piano
Machine.remove(pianoID);
1::second => now;

// set volume
0 => tri.gain;

3::second => now;
// remove drums
Machine.remove(drumsID);
