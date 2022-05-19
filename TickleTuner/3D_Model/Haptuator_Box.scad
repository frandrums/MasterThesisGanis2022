$fn = 100;

wHaptuator = 11.96 + 0.1;
dHaptuator = 37.69 + 0.1;
hHaptuator = 11.45 + 0.1;

dHole = 5;

thickness = 2;

module haptuatorBox() {
   color("DimGray")
   difference(){
   cube([wHaptuator + thickness, dHaptuator + thickness + 30, hHaptuator + thickness], center = true);
   
   //Cavity
   translate([0, 0 , thickness]){
   cube([wHaptuator, dHaptuator, hHaptuator], center = true);
   };
   
   //Access for removing the haptuator
   translate([-wHaptuator / 2, dHaptuator / 2 - dHole / 2, thickness]){
   cube([thickness * 1.2, dHole, hHaptuator], center = true);
}
   };
};



haptuatorBox();