$fn = 100;

thickness = 2;

separate = 100; //Gap to print avoid overlaps between the two components.

dSpaceForDAC = 15;

wPoco = 76.8;
dPoco = 165.3 + separate;
hPoco = 9.5;

wMainEnclosure = wPoco + thickness;
dMainEnclosure = dPoco + thickness + dSpaceForDAC;
hMainEnclosure = hPoco + thickness + 2;

wExtRail = 20;
dExtRail = 80;
hExtRail = 8;

wIntRail = wExtRail - thickness;
dIntRail = dExtRail - thickness;
hIntRail = hExtRail - thickness;

wTHook = 7;
dTHook = 5;
hTHook = 5;
dDistTHook = 20;

wTRail = wTHook / 3 + 1;
dTRail = dIntRail - 20;
hTRail = 4;

wCableSpace = 6;
dCableSpace = 25;
hCableSpace = 5;

wHook = 8;
dHook = 8;
hHook = 5;
dHookDistance = 5;

wUsbC = 8.4;
dUsbC = 6.65;
hUsbC = 2.6;
usbCTolerance = 4;

rScrew = 3 / 2 - 0.3;
hLidDACSpace = 1;

wDACSpaceAccess = wPoco - 50;

wVolume = 10;
dVolume = 30;
hVolume = hPoco / 2 + 5;

use <MCAD/boxes.scad>

//-----MODULES DEFINITIONS-----
module Cellphone() {
   color("SteelBlue")
   roundedBox(size = [wPoco, dPoco, hPoco], radius = 3);     
}

module MainEnclosure() {
   color("DimGray")
   roundedBox(size = [wMainEnclosure, dMainEnclosure, hMainEnclosure], radius = 3);
}

module Hook(){   
   difference(){
      cube([wHook, dHook, hHook], center = true);
      
      translate([0, - dHook / 6, - hHook / 2.5 / 2]){ 
      cube([wHook * 1.5, dHook / 1.5, hHook / 1.75], center = true);
      }
   }
}


module THook(){
   difference(){
      cube([wTHook, dTHook, hTHook], center = true);
      
      translate([wTHook / 3,0, -hTHook / 4]){ 
         cube([wTHook / 3, dTHook + 1, hTHook / 2], center = true);
         }
      translate([-wTHook / 3,0, -hTHook / 4]){ 
         cube([wTHook / 3, dTHook + 1, hTHook / 2], center = true);
         }     
   }
}

module ExtRail(){
   color("darkslategrey")
   difference(){
      cube([wExtRail, dExtRail, hExtRail], center = true);
      
      translate([0, thickness, 0]){
         cube([wIntRail, dIntRail, hIntRail], center = true);
      }
      
      translate([0, (dExtRail - dTRail) / 2, - hTRail]){
      cube([wTRail, dTRail, hTRail], center = true);
      }
      
      //Cap to limit the movements of the IntRail inside the ExtRail
      translate([0, - dExtRail / 2 + dDistTHook/2, + thickness]){
         cube([wIntRail - thickness * 2, dDistTHook, hIntRail], center = true);
      }
   }
   
   translate([0, -(dExtRail - thickness)/ 2 + dHook / 3 + dHookDistance, -0.5]){
      Hook();
   }
   

   
}

module IntRail(){
   color("slategrey")
   difference(){
      cube([wIntRail - 1, dIntRail - dDistTHook, hIntRail - 1], center = true);
      translate([0, -2 * thickness, 2 * thickness]){
         cube([wExtRail - 2 * thickness - 1, dIntRail - dDistTHook + thickness * 1.5, hExtRail + 2 * thickness - 1], center = true);
      }
   }
 
   translate([0, (dExtRail - thickness)/ 2 - dHook / 3 - thickness / 2 - dHookDistance - dDistTHook/2, 0]){
      rotate([0, 0, 180]) Hook();
   }
   
   rotate([0, 180, 0]){
   translate([0, - dIntRail / 2 + dTHook / 2 + dDistTHook/2, hIntRail - 1]) THook();
   }
   
   rotate([0, 180, 0]){
   translate([0, + dIntRail / 2 - dTHook / 2 - dDistTHook/2, hIntRail - 1]) THook();
   }
}


module RemovePartEnclosure() {
   translate([0, 0, 0]){
      cube([wMainEnclosure + 1, dExtRail + separate, hMainEnclosure + 1], center = true);
   }
}

module UsbC() {
   color("DimGray")
   roundedBox(size = [wUsbC + usbCTolerance, dUsbC + usbCTolerance, hUsbC + usbCTolerance], radius = 1, sidesonly = false);
};

module DACSpace() {
   roundedBox(size = [wPoco, dSpaceForDAC - thickness, hPoco], radius = 3, sidesonly = true);
}

module ScrewSupport() {
   difference(){
      cylinder(h = hPoco - hLidDACSpace - thickness, r = rScrew + thickness, center = true);
      cylinder(h = hPoco - hLidDACSpace + 2, r = rScrew, center = true);
   }
}

module LidDACSpace() {
   difference(){
      roundedBox(size = [wPoco - 1, dSpaceForDAC - thickness, hPoco + hLidDACSpace], radius = 3, sidesonly = true);
      
      translate([0, 0, -hLidDACSpace / 2 - thickness]) cube([wPoco + 1, dSpaceForDAC - thickness + 1, hPoco + thickness], center = true);
      
      translate([-wPoco/2 + rScrew + thickness, 0, 0]) cylinder(h = hPoco + hLidDACSpace + 0.1, r = rScrew, center = true);
      
      translate([+wPoco/2 - rScrew - thickness, 0, 0]) cylinder(h = hPoco + hLidDACSpace + 0.1, r = rScrew, center = true);
   }
}

module SpaceAccessL(){
   roundedBox(size = [wPoco - thickness * 2, 30, hPoco], radius = 3, sidesonly = true);   
}

module SpaceAccessR(){
   roundedBox(size = [wPoco - thickness * 2, 20, hPoco], radius = 3, sidesonly = true);   
}

module DACSpaceAccess() {
   roundedBox(size = [wDACSpaceAccess, dSpaceForDAC - thickness * 2, hPoco], radius = 3, sidesonly = true);
}

module CableSpace() {
   cube([wCableSpace, dCableSpace, hCableSpace], center = true);
}

module VolumeButtonSpace() {
   cube([wVolume, dVolume, hVolume], center = true);
}

//-----BULD MODULES-----
difference(){
   MainEnclosure();
   
   RemovePartEnclosure();
   
   //Cavity for the cellphone
   translate([0, dSpaceForDAC/2, thickness]) {
      Cellphone();
   }
   
   //DAC box
   translate([0, -(dPoco) / 2, thickness]) {
      DACSpace();
   }
   
   //Access to handles 
   translate([-wPoco/2 + (wPoco - 36)/2, -(dPoco) / 2, -5]) DACSpaceAccess();
   
   translate([+wPoco/2 - (wPoco - 36)/2, -(dPoco) / 2, -5]) DACSpaceAccess();
   
   translate([0, (dPoco)/2 - 15, -5]) SpaceAccessL();

   translate([0, -(dPoco)/2 + 25, -5]) SpaceAccessR();
   
   
   //Holes for USB C etc
   translate([0, - dPoco / 2 + dSpaceForDAC / 2, 1]) {
      UsbC();
      
      translate([-20, 0, 0]) UsbC();
      
      translate([20, 0, 0]) UsbC();
      
   }
   
   //Cable space traces
   translate([(-wIntRail + wHook + 1)/2, (dIntRail + separate + dCableSpace) / 2, -thickness]) CableSpace();

   translate([(wIntRail - wHook - 1)/2, (dIntRail + separate + dCableSpace) / 2, -thickness]) CableSpace();

   translate([(-wExtRail + wHook + thickness)/2, -(dIntRail + separate + dCableSpace) / 2, -thickness]) CableSpace();

   translate([(wExtRail - wHook - thickness)/2, -(dIntRail + separate + dCableSpace) / 2, -thickness]) CableSpace();

   translate([wPoco / 2, dPoco/2 - dVolume, (hVolume + thickness) / 2 ]){
    VolumeButtonSpace();
   }
}



//Lid for DAC
//translate([100,  -(dPoco) / 2, (hPoco - hLidDACSpace) / 2 ]) LidDACSpace();
//translate([0, 0, -10]) LidDACSpace();

//Screws supports
translate([-wPoco/2 + rScrew + thickness,  -(dPoco) / 2, 0]) ScrewSupport();

translate([+wPoco/2 - rScrew - thickness,  -(dPoco) / 2, 0]) ScrewSupport();

//External rail
difference(){
   translate([0, -separate/2, -hExtRail/2 - hPoco / 2 + thickness]){
      ExtRail();
   }

   //Cable traces
   translate([(-wExtRail + wHook + thickness)/2, -(dIntRail + separate + dCableSpace + thickness) / 2, -thickness]) CableSpace();

   translate([(wExtRail - wHook - thickness)/2, -(dIntRail + separate + dCableSpace + thickness) / 2, -thickness]) CableSpace();
}

//Internal rail
difference(){
   translate([0, separate/2 + thickness/2 + dDistTHook/2, -hExtRail/2 - hPoco / 2 + thickness]){
      IntRail();
   }

   //Cable traces
   translate([(-wIntRail + wHook + 1)/2, (dIntRail + separate + dCableSpace - 3) / 2, -thickness]) CableSpace();

   translate([(wIntRail - wHook - 1)/2, (dIntRail + separate + dCableSpace - 3) / 2, -thickness]) CableSpace();
}

//translate([-100, dSpaceForDAC / 2, 0]) Cellphone();