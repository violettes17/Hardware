// cyril Roudot 4 juillet 2017
// http://violettes.org
// 05janvier :  plongeant1 4 fraisages F90 à ajouter
// 05janvier : plongeant1/espace_pour_coupleur reduction de 10mm, 47->37mm : devrait etre ok our M3x40.
// 05janvier :  plongeant1/Nema17B cylindre de biseau angle 26.35->27.5
// 05janvier : encoche pour les fils H7 L5

$fn=60;

r_colonette = 5;  // column height

axe_trou = (42-31)/2;  // distance between external sides of the square and holes axis   
diam_ext = sqrt(2)*31/2 +r_colonette;  // cuting external angles by a circle

jeu = 0.5;


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


//le moteur est un carré de 42mm elevé de 47mm, avec 4 M3 sur un carré de 31mm
// the motor is a 42mm square  47 mm height, with 4 M3 aligned on a 31mm internal square

//baseplate


module Nema17()
{   Ep = 8 ;
    translate([21,21,Ep/2])
    {
                difference()
            {
                    intersection()
                    {
                    cylinder(h=Ep,r=diam_ext, center = true);
                    cube([42,42,Ep], center = true);
                    };
                    cylinder(h=Ep,r=14, center = true);
            }
    
    };
}

module encoche_fils()
{    cube ([5,5,7]);
    }


module Nema17B()
{   Ep = 47 ;
    diam_exterieur = 27.5;
    union(){
    translate([21.5,21.5,Ep/2])
       {
        
                difference()
            {
                    intersection()
                    {
                    cylinder(h=Ep,r=diam_exterieur, center = true);
                    cube([43,43,Ep], center = true);
                    };
                    //cylinder(h=Ep,r=14, center = true);
            }
        
       };
    translate ([-5,43/2-2.5,0]) encoche_fils();
            }
}



module espace_pour_coupleur()
{   Ep = 37 ;
    diam_exterieur = sqrt(2)*31/2 +4.5;
    translate([21.5,21.5,Ep/2])
    {
            cylinder(h=Ep,r=14, center = true);
            };
    
    
}


//column
module colonette (hauteur,r_ext, r_int)
{
    difference(){
            cylinder(hauteur,r=r_ext,center= false);
            cylinder(hauteur,r=r_int,center= false);
};
}
 



//final part


module spacer(H_hauteur, r_exterieur, r_interieur)
{

difference()
{
    union()
    {
        Nema17B();
    
        for(j=[0:1]){
            
            for(i=[0:1])
            {
            translate([axe_trou+31*i,axe_trou+31*j,0])
                {
                //colonette(hauteur = H_hauteur, r_ext= r_exterieur , r_int = r_interieur);
                }
             }
            };
      };
      union()
      {
          for(j=[0:1]){
                        
                        for(i=[0:1])
                        {
                        translate([axe_trou+31*i,axe_trou+31*j,0]) {cylinder(h=47,r=1.7,center= false);}
                        }
                        }
      }     
 }
//end
}


module inner()
{
    Nema17B();
    translate([0,0,47]) espace_pour_coupleur();
    }


module plongeant1()
{    
    difference(){
    translate([25-3.5,25-3.5,(47+37)/2]) cube_8bords_ronds(50,50,47+37);
    inner();
    union()
      {
          for(j=[0:1]){
                        
                        for(i=[0:1])
                        {
                        translate([axe_trou+31*i,axe_trou+31*j,0]) 
                            {union(){
                                cylinder(h=47*2,r=1.7,center= false);
                                translate([0,0,47+37-3]) cylinder(h = 6, r1 = 0, r2 = 3, center = true);}                      }
                        }
                        }
      };
};
}

module plongeant2()
{   jeu = 0.5 ;
    
    difference(){
    union()
        {cube_8bords_ronds(57,57,180);
         translate([57/2+(3.5+14.5)/2,0,+90-10]) rotate([0,0,0])cube_8bords_ronds(3.5+14.5,9,20);
            
      
            
        };
    translate([0,0,3.5]) cube([50+jeu,50+jeu,180], center = true);
    union()
      {
          for(j=[0:1]){
                        
                        for(i=[0:1])
                        {
                        translate([-6+12*i,-6+12*j,-95]) {cube([8,8,18],center = true);}
                        }
                        }
      };
};
}

module ancrage()
{
    difference(){
    cube_8bords_ronds(10,64,45);
    translate([2.5,0,-5]) cube([5,64,35], center = true);
    };
}


module ancrage_ressort_negatif()
{
    translate([64/2-3.5/2,0,0]) cube([3.5,10,180], center = true);
         
    }
module ancrage_ressort_positif()
{
    difference()
    {
    translate([64/2+10,0,0]) cube_8bords_ronds(20,20,180);//cube([20,20,200], center = true);    
    translate([64/2+15/2,0,5]) cube([15,15,180], center = true); 
    };
        }


module plongeant3()
{   jeu = 0.5 ;
    translate([-64/2-5,0,-90+45/2]) ancrage();
    
    ancrage_ressort_positif();
    
    difference(){
    cube_8bords_ronds(64,64,180);
    ancrage_ressort_negatif();
    translate([0,0,0]) cube([57+jeu,57+jeu,180], center = true);
     
    union()
      {
          for(j=[0:1]){
                        
                        for(i=[0:1])
                        {
                        translate([axe_trou+31*i,axe_trou+31*j,0]) {cylinder(h=47*2,r=1.7,center= false);}
                        }
                        }
      };
};
}

plongeant1();


//plongeant2();
//plongeant3();
//translate([-64/2-2.5,0,-90+45/2-6]) cube([3,64,33], center = true);
    
    

//spacer(H_hauteur = 120,r_exterieur = r_colonette, r_interieur = 1.7 );

//translate ([50,0,0]) rotate([0,0,0]) spacer(H_hauteur = 120,r_exterieur = 2*r_colonette, r_interieur = r_colonette+jeu );


