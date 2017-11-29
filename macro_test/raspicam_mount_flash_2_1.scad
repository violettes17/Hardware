
//Boitier pour  arducam OV5647 revC avec embase S
//2 prises de montages de montage type flash d'appareil photo
// Dispositif conçu pour vérifier la netteté en macro photographie à 10 cm de distance
// Cyril ROUDOT 06/11/2017
// http://violettes.org
// http://violettes.org/wiki/doku.php?id=camera
//  version 2.1 : - ouverture débouchante D15 ald D14 pour la camera
//  version 2.1 : - écartement des colonnettes 29  ald 28.5 mm
//  version 2.1 : - vis de R1...1.3- ald R1.3...1.5  et sans fente
//  version 2.1 : - arrondi 1mm ald 0.5mm
//  version 2.1 : - capot 3mm ald 2mm
//  version 2.1 : - fente plus basse de 4mm


module colonnette()
{   translate([0,0,2]) 
    difference(){
        cylinder (h = 6,r1 = 1.3, r2 = 1,center = true, $fn=50);
        //translate([0,0,2]) cube([0.5,3,4],center = true);
        };
    difference()
    {cylinder (h = 2,r = 2,center = true, $fn=50);
    cylinder (h = 2,r1 = 0, r2 = 0.5, center = true, $fn=50); };
    }


module obturateur_colonnette()
{   rotate([0,180,0]) 
    difference(){
        translate([0,0,2]) cylinder (h = 6,r = 2,center = true, $fn=50);
        rotate([0,0,0]) colonnette();
        };
    
        
    }

module cube_8bords_ronds(xx,yy,zz)
{
    arrondi =1;
    //translate([0,0,zz/2]) cube([xx,yy,zz/2],center = true);
    translate([0,0,zz/2]) difference()
        {
        translate([-xx/2,-yy/2,-zz/2]) minkowski(){
               cube([xx-2*arrondi,yy-2*arrondi,2*zz-2*arrondi],center = true);
               translate([xx/2,yy/2,zz/2]) rotate([0,90,0]) sphere(r=arrondi,$fn=50);
               };
    
        translate([0,0,zz/2]) cube([xx,yy,zz],center = true);
        };
}


module boitier()
{
    difference(){
    cube_8bords_ronds(40,40,10);//cube([40,40,10],center = true);  // enveloppe extérieure
    translate([0,0,0.5]) cube([38,38,9],center = true);    //enveloppe intérieure
    translate([0,19.5,-1.5]) cube ([18,1,1],center = true);   //fente pour le cable raspberry
    };


    translate ([29/2,29/2,-5+1]) colonnette();
    translate ([-29/2,-29/2,-5+1]) colonnette();
    translate ([-29/2,29/2,-5+1]) colonnette();
    translate ([29/2,-29/2,-5+1]) colonnette();
}

module capot()
{

    translate ([29/2,29/2,6.5]) obturateur_colonnette();
    translate ([-29/2,-29/2,6.5]) obturateur_colonnette();
    translate ([-29/2,29/2,6.5]) obturateur_colonnette();
    translate ([29/2,-29/2,6.5]) obturateur_colonnette();

difference()
{           union(){
            cube_8bords_ronds(40,40,2);//cube([40,40,1],center = true);  // extérieur
            translate([0,0,1]) cube([37.8,37.8,1],center = true);    //intérieur
            };
            cylinder (h = 6,r = 7.5,center = true, $fn=50);
            translate([0,0,0]) cylinder (h = 2,r = 10,center = true, $fn=50);
            translate([15,12,0]) rotate([0,180,0]) linear_extrude(height = 2) { text("violettes.org", size = 4);};
  };
}

translate ([0,0,5]) boitier();
//rotate([0,180, 0]) translate ([20,0,-10+0.5]) capot();   // visualisation du capot monté a demi sur le coté
translate([-45,0,1]) capot();
        


translate([24,0,9]) rotate([0,0,180]) difference() {cube([8,18,18],center = true);
            translate([1,7.5,0]) cube([6,3,18],center = true) ;
            translate([1,-7.5,0]) cube([6,3,18],center = true) ;};



