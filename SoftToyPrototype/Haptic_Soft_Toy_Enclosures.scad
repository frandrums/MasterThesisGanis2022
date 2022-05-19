
use <MCAD/boxes.scad>

$fn = 100;
alpha = 1;

//---------Variables---------
thickness = 3;
tolerance = 0.1;

radRoundBox = 3;

wHaptuator = 20.00 + tolerance;
dHaptuator = 31.44 + tolerance; 
hHaptuator = 20.00 + tolerance;

dExtraSpaceHaptuator = 6; // Extra clearance to allow the membranes to move freely, as recommended on the datasheet

dHaptuatorHole = 5;

diScrew = 2.38;
hScrew = 5;
hScrewTop = 5;

// Datasheet dimensions of the connector
wUSBC = 2.72 + tolerance;
dUSBC = 8.34 + tolerance;
hUSBC = 6.20 + tolerance;

hAudioJack = 10;
rAudioJack = 3 + tolerance;

hCover = 2;
hGlue = 0.7;

//----------------MODULES----------------


module Haptuator(){
   color("LightSalmon", alpha = 0.7)
   cube([wHaptuator - tolerance, dHaptuator - tolerance, hHaptuator - tolerance], center = true);
}

module HaptuatorBox() {
   color("LightSteelBlue")
   difference(){ 
    roundedBox(size = [wHaptuator + thickness, dHaptuator + thickness + dExtraSpaceHaptuator, hHaptuator + thickness], radius = radRoundBox, sidesonly = false);
      
   //Cavity
   translate([0, 0 , thickness/2 + 0.1]){
   roundedBox(size = [wHaptuator, dHaptuator + dExtraSpaceHaptuator, hHaptuator + 0.1], radius = radRoundBox, sidesonly = true);
   };
   
   //Access for removing the haptuator
   translate([-wHaptuator / 2, dHaptuator / 2 - dHaptuatorHole / 2, thickness/2 + 0.1]){
   cube([thickness * 1.2, dHaptuatorHole, hHaptuator + 0.1], center = true);
}
   translate([+wHaptuator / 2, - dHaptuator / 2 + dHaptuatorHole / 2, thickness/2 + 0.1]){
   cube([thickness * 1.2, dHaptuatorHole, hHaptuator + 0.1], center = true);
}
   };
};


//----------------CALL_OBJECTS----------------

//Haptuator();

HaptuatorBox();
