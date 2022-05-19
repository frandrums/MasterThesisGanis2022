// Box to contain the haptuators and the electronics. Should be attached to the iPad cover's back.

use <MCAD/boxes.scad>

$fn = 100;
alpha = 1;

//---------Variables---------
thickness = 2;
tolerance = 0.1;


rSphere = 35; // Radius of the spehere in the shortest side
dMultSphere = 1.5; // Factor of multiplication for the long side of the core

wHaptuator = 20.00 + tolerance;
dHaptuator = 31.44 + tolerance; 
hHaptuator = 20.00 + tolerance;

dExtraSpaceHaptuator = 6; // Extra clearance to allow the membranes to move freely, as recommended on the datasheet

dHaptuatorHole = 5;

//wAmplifier = 15.50 + tolerance;
//dAmplifier = 24 + tolerance;
//hAmplifier = 2 + tolerance;
wAmplifier = 18 + tolerance;
dAmplifier = 20 + tolerance;
hAmplifier = 2 + tolerance;
wFromTheCentre = 22; // Distance of the Amplifier from the centre

diScrew = 2.38;
hScrew = 5;
hScrewTop = 5;

// Datasheet dimensions of the connector
wUSBC = 2.72 + tolerance;
dUSBC = 8.34 + tolerance;
hUSBC = 6.20 + tolerance;

//wUSBC = 5 + tolerance;
//dUSBC = 9.6 + tolerance;
//hUSBC = 6.20 + tolerance;

hAudioJack = 10;
rAudioJack = 3 + tolerance;

hCover = 2;
hGlue = 0.7;


//---------Modules definitions---------

module Shell() { 
   
   color("SteelBlue", alpha)
   difference(){
      scale([dMultSphere, 1, 1]){
         difference(){
            sphere(r = rSphere);
            sphere(r = rSphere - thickness/2);
            translate([0, 0, -50 + thickness]){
               cube([100, 100, 100], center = true);
            }
          }
       }
       
      // Holes in the lid for the screws 
      translate([0, rSphere - (diScrew + thickness), 15]){
       cylinder(h = hScrew * 3, d = diScrew + thickness, center = true);
       }

      translate([0, -rSphere + (diScrew + thickness), 15]){
       cylinder(h = hScrew * 3, d = diScrew + thickness, center = true);
       }

      // USB-C hole
      translate([rSphere * dMultSphere + thickness - dUSBC/2, 0, wUSBC/2 + 5]){
       USBC();
    } 
      // Audio jack hole
      translate([- rSphere * dMultSphere + thickness, 0, 2 + rAudioJack + thickness]){
       AudioJack();
    } 



       }
    // Screw support that connects to the one on the bottom
    translate([0, rSphere - (diScrew + thickness), thickness + hScrew + hScrewTop/2]){
       ScrewSupportHole();
          };
    
    translate([0, - rSphere + (diScrew + thickness), thickness + hScrew + hScrewTop/2]){
       ScrewSupportHole();
            };  
            
            
   // Cover of the side holes for screws
   translate([0, rSphere - (diScrew + thickness), thickness + hScrew + hScrewTop * 1.5]){

   }
}

module Bottom() {
   color("SteelBlue", alpha)
   scale([dMultSphere, 1, 1]){
      difference(){
         sphere(r = rSphere);

         translate([0, 0, -50 - thickness/2]){
            cube([100, 100, 100], center = true);
         }
         
         translate([0, 0, 50]){
            cube([100, 100, 100], center = true);
         }
         
      }
      
      // Second base to fit inside the cover
      translate([0, 0, -thickness/2 - 0.001]){
      difference() {
         sphere(r = rSphere - 10);

         translate([0, 0, -50 - (hCover + hGlue)]){
            cube([100, 100, 100], center = true);
         }
         
         translate([0, 0, 50]){
            cube([100, 100, 100], center = true);
         }
      }
   }
         
   }
}

module Haptuator(){
   color("LightSalmon", alpha = 0.7)
   cube([wHaptuator - tolerance, dHaptuator - tolerance, hHaptuator - tolerance], center = true);
}

module HaptuatorBox() {
   color("LightSteelBlue")
   difference(){
   cube([wHaptuator + thickness, dHaptuator + thickness + dExtraSpaceHaptuator, hHaptuator + thickness], center = true); 
      
   //Cavity
   translate([0, 0 , thickness/2 + 0.1]){
   cube([wHaptuator, dHaptuator + dExtraSpaceHaptuator, hHaptuator + 0.1], center = true);
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


module AmpliferBox() {
   color("IndianRed")
   difference(){
      cube([wAmplifier + thickness + tolerance, dAmplifier + thickness + tolerance, hAmplifier + thickness + tolerance], center = true);
      
      translate([0, 0, thickness]){
      cube([wAmplifier + tolerance, dAmplifier + tolerance, hAmplifier + tolerance + thickness * 2], center = true);
      }
   }
}


module ScrewSupport() {
   color("LightCyan")
   difference(){
      cylinder(h = hScrew, d = diScrew + thickness, center = true);
      translate([0, 0, thickness]){
      cylinder(h = hScrew + thickness, d = diScrew, center = true);
      }
   }
}

module ScrewSupportHole() {
   color("SteelBlue", alpha)
   difference(){
      cylinder(h = hScrewTop, d = diScrew + thickness, center = true);
      translate([0, 0, 0]){
      cylinder(h = hScrewTop + tolerance, d = diScrew, center = true);
      }
   }
}

module USBC(){
   rotate([0, 90, 0]){
      roundedBox(size = [wUSBC, dUSBC, hUSBC + 10], radius = 1.3, sidesonly = true);
   }
}


module AudioJack(){
   rotate([0, 90, 0]){
      cylinder(h = hAudioJack, r = rAudioJack, center = true);
   }
}
//---------Call of the modules---------

Shell();

translate([0, 100, thickness]){
   Bottom();
   
   translate([0, 0, (hHaptuator + thickness) / 2]){
   rotate([0, 0, 180]){ 
      HaptuatorBox();
//      %Haptuator(); // Remove this for printing
      }
   }

//   translate([-wFromTheCentre, 0, (hHaptuator + thickness) / 2]){
//      HaptuatorBox();
//      %Haptuator(); // Remove this for printing
//   }
   
   translate([-wFromTheCentre, 0, thickness]){ AmpliferBox();}
   
   translate([0, rSphere - (diScrew + thickness), hScrew/2]){ScrewSupport();};
   
   translate([0, - rSphere + (diScrew + thickness), hScrew/2]){ScrewSupport();};
}
  