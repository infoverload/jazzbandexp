/*----------------------------------------------------------------------- 
   Title: JazzBandExp_initialize
   Length: 30 seconds
-------------------------------------------------------------------------*/

// print title
<<< "JazzBandExp" >>>;

// add JazzBandExp_score.ck
me.dir() + "/JazzBandExp_score.ck" => string scorePath;
Machine.add(scorePath);