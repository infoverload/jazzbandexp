/*----------------------------------------------------------------------- 
   Title: JazzBandExp_piano
   Length: 30 seconds
-------------------------------------------------------------------------*/

// sound chain
Wurley piano[4];
piano[0] => dac.left;
piano[1] => dac.right; 
piano[2] => dac.left;
piano[3] => dac.right; 

// chord 2D array
[[46,48,49,51],[53,54,56,58]] @=> int chords[][];  // notes from Bb Aeolian mode

// function octavehigh
fun float octavehigh( float originalFreq )
{
    // calculate octave of input frequency
    return (originalFreq + 12);
}

// function octavelow
fun float octavelow( float originalFreq )
{
    // calculate octave of input frequency
    return (originalFreq - 12);
}

// loop 
while( true )  
{   
    Math.random2(0,1) => int j;
    Math.random2(0,1) => int k;
    
    // build first chord
    for( 0 => int i; i < 4; i++ )  
    {
        Std.mtof(chords[j][i]) => piano[i].freq;
        0.3 => piano[i].noteOn;
    }
    <<< "piano chord 1" >>>;
    0.625::second => now;

    // note!
    Std.mtof(53) => piano[3].freq;
    0.2 => piano[0].noteOn;
    // wait
    300::ms => now;    
    
    // build second chord
    for( 0 => int i; i < 4; i++ )  
    {
        octavehigh( Math.mtof(chords[k][i]) ) => piano[i].freq;
        0.2 => piano[i].noteOn;
    }
    <<< "piano chord 2" >>>;
    1::second => now;
    
    // note!
    Std.mtof(octavelow(58)) => piano[3].freq;
    0.3 => piano[0].noteOn;
    // wait
    300::ms => now;
    
}
