// cyril Roudot 25 octobre 2017
// http://violettes.org

dollarFN = 100;

$fn = dollarFN;

module smoothcylinder(rayon)    // cylindre adjacent à la tete de l'humerus
{   minkowski(){
    cylinder(h=rayon/2, r=rayon, center=true,$fn = dollarFN);
    sphere(r = rayon/10,$fn = dollarFN);
    }
    
    }

module duocylinder(hauteur, rayon)    // corps long du cubitus
{   
    translate([0,2*rayon,0])minkowski(){
    cylinder(h=hauteur, r=rayon, center=true,$fn = dollarFN);
    sphere(r = rayon/10,$fn = dollarFN);    };
    
    translate([0,-2*rayon,0])minkowski(){
    cylinder(h=hauteur, r=rayon, center=true,$fn = dollarFN);
    sphere(r = rayon/10,$fn = dollarFN);    };
    
    }


module tete_male(rayon)    // tete de l'humerus, liaison avec l'épaule
{
    translate([rayon/2,0,0]){sphere(r = rayon, $fn = dollarFN);};
    translate([-rayon/2,0,0]) rotate([90,90,90]){smoothcylinder(rayon);};
    }


module coude_male(rayon)    // partie basse de l'humerus
{
    translate([rayon/2,0,0]){sphere(r = rayon, $fn = dollarFN);};
    translate([-rayon/2,0,0]) {sphere(r = rayon, $fn = dollarFN);};
    }


module coude_male_negatif(rayon)  // emporte pièce pour raboter l'extremité basse du du corps long de l'humerus
{
    translate([rayon,0,0]){sphere(r = rayon, $fn = dollarFN);};
    translate([-rayon,0,0]) {sphere(r = rayon, $fn = dollarFN);};
    }

module cheville_male(rayon)    // osselet cheville
{
    translate([rayon/2,0,0]){sphere(r = rayon, $fn = dollarFN);};
    translate([-rayon/2,0,0]) {sphere(r = rayon, $fn = dollarFN);};
    }


module cheville_male_negatif(rayon)  // emporte pièce pour raboter l'osslet de cheville aux deux extrémités
{
    translate([rayon,0,0]){sphere(r = rayon, $fn = dollarFN);};
    translate([-rayon,0,0]) {sphere(r = rayon, $fn = dollarFN);};
    }




module coude_femelle(rayon)   // partie haute du radius
{
    epaisseur_peau = 0;  // millimètres
    jeu = 0.5;  // millimètres, car buse imprimante 3D M200 ZORTRAX 0.4mmm
    difference(){
        
        difference() {sphere(r = 3*rayon/2+epaisseur_peau, $fn = dollarFN);
                      translate([0,0,-2.5*rayon]) cube(5*rayon, center = true );  };
        union()      {translate([rayon/2,0,0]){sphere(r = rayon + jeu , $fn = dollarFN);};
                      translate([-rayon/2,0,0]) {sphere(r = rayon + jeu , $fn = dollarFN);};  };
    }
    
    }

module coude_femelle_negatif(rayon)   // emporte pièce pour raboter l'extremité haute du corps long du radius
{
    epaisseur_peau = 0;  // millimètres
    jeu = 0.5;  // millimètres, car buse imprimante 3D M200 ZORTRAX 0.4mmm
    //difference(){
    
        difference() {sphere(r = 3*rayon/2+epaisseur_peau, $fn = dollarFN);
                      translate([0,0,-2.5*rayon]) cube(5*rayon, center = true );  };
      //  union()      {translate([rayon/2,0,0]){sphere(r = rayon + jeu , $fn = dollarFN);};
      //                translate([-rayon/2,0,0]) {sphere(r = rayon + jeu , $fn = dollarFN);};  };
    //}
    
    }

module cheville_femelle(rayon)   // partie haute du pied
{
    epaisseur_peau = 0;  // millimètres
    jeu = 0.5;  // millimètres, car buse imprimante 3D M200 ZORTRAX 0.4mmm
    difference(){
        
        difference() {sphere(r = 3*rayon/2+epaisseur_peau, $fn = dollarFN);
                      translate([0,0,-2.5*rayon]) cube(5*rayon, center = true );  };
        union()      {translate([rayon/2,0,0]){sphere(r = rayon + jeu , $fn = dollarFN);};
                      translate([-rayon/2,0,0]) {sphere(r = rayon + jeu , $fn = dollarFN);};  };
    }
    
    }

module cheville_femelle_negatif(rayon)   // emporte pièce pour raboter le haut de l'os du pied
{
    epaisseur_peau = 0;  // millimètres
    jeu = 0.5;  // millimètres, car buse imprimante 3D M200 ZORTRAX 0.4mmm
    //difference(){
    
        difference() {sphere(r = 3*rayon/2+epaisseur_peau, $fn = dollarFN);
                      translate([0,0,-2.5*rayon]) cube(5*rayon, center = true );  };
      //  union()      {translate([rayon/2,0,0]){sphere(r = rayon + jeu , $fn = dollarFN);};
      //                translate([-rayon/2,0,0]) {sphere(r = rayon + jeu , $fn = dollarFN);};  };
    //}
    
    }


module corps_long(longueur, largeur, ratio_os_creux) // partie longue des os
    {
    translate([0,0,longueur/2])
    {
                difference()
            {
                    intersection()
                    {
                    cylinder(h=longueur,r=largeur * ratio_os_creux, center = true);
                    cube([largeur,largeur,longueur], center = true);
                    };
                    cylinder(h=longueur,r=largeur * 14/42, center = true);
            }
    };
}

//humerus
module humerus(longueur, largeur)    // longueur largeur exprimées en millimètres
{
    ratio_os_creux = (sqrt(2)*31/2 + 4)/42;
    ratio_tete = 33/112/2;
    ratio_coude = 21/112/2;
    ratio_coude_negatif =3/4;
    
    difference(){
    corps_long(longueur, largeur, ratio_os_creux);
    translate([0,0,longueur*(1-0.95*ratio_coude_negatif*ratio_coude)]) rotate([0,0,90]) {coude_male_negatif(rayon = longueur * ratio_coude *ratio_coude_negatif);};
    };
    tete_male(rayon = longueur * ratio_tete );
    translate([0,0,longueur]) coude_male(rayon = longueur * ratio_coude);
}
//radius
module radius(longueur, largeur, longueur_humerus)    // longueur largeur exprimées en millimètres
{
    ratio_os_creux = (sqrt(2)*31/2 + 4)/42;
    ratio_tete = 33/112/2;
    ratio_coude = 21/112/2;
    ratio_coude_negatif =3/4;
    
    
    difference(){
    corps_long(longueur, largeur, ratio_os_creux);
    translate([0,0,-0.1]) coude_femelle_negatif(rayon= longueur_humerus * ratio_coude);// tendance à laisser une face de l'os corrigée par ce 0.1
    translate([0,0,longueur+longueur_humerus * ratio_coude + 0.1]) rotate ([180,0,0]) coude_femelle_negatif(rayon= longueur_humerus * ratio_coude);// tendance à laisser une face de l'os corrigée par ce 0.1   
        };
    
    translate([0,0,0]) coude_femelle(rayon = longueur_humerus * ratio_coude);
    translate([0,0,longueur+longueur_humerus * ratio_coude]) rotate ([180,0,0]) coude_femelle(rayon = longueur_humerus * ratio_coude);    
}

module cubitus(longueur, largeur, longueur_humerus, longueur_radius)    // longueur largeur exprimées en millimètres
{
    offset = longueur - longueur_radius;
    jeu = 0.5;
    // pour avoir rotation autour de l'axe du coude, le corps_long du cubitus est crée symétriquement, roté, puis emputé de la moitié à l'aide d'un cube emporte pièce roté également. 
    translate([0,0,0])  difference()
            {rotate([15,0,0]) translate([0,0,0]) duocylinder(hauteur = longueur, rayon = rayon_ext_coude/2);
            translate([0,0,0]) rotate ([180,0,0]) coude_male(rayon = jeu + longueur_humerus * ratio_coude);
            rotate([15,0,0])  {translate ([0,-rayon_ext_coude,0]) cube([rayon_ext_coude+10,rayon_ext_coude+10,longueur+10],center = true);};  // cube emporte pièce
                
                };   
}

//cheville
module cheville(longueur, largeur, longueur_humerus)    // longueur largeur exprimées en millimètres
{
    translate([0,0,0]) cheville_male(rayon = longueur_humerus * ratio_coude) ;  
    translate([0,0,longueur]) rotate ([180,0,0]) cheville_male(rayon = longueur_humerus * ratio_coude) ;  
}

//pied
module pied(longueur, largeur, longueur_humerus)    // longueur largeur exprimées en millimètres
{


    translate([0,0,0]) cheville_femelle(rayon = longueur_humerus * ratio_coude) ;
    difference(){ 
        translate([0,23,largeur/2]) { rotate ([90,0,0]) corps_long(longueur, largeur, ratio_os_creux);}; //longueur_pied = 23+54 ;23 derrière la cheville, 54 devant
        translate([0,0,0]) cheville_femelle_negatif(rayon = longueur_humerus * ratio_coude) ;    
        }
    
    }

ratio_os_creux = (sqrt(2)*31/2 + 4)/42;
ratio_tete = 33/112/2;
ratio_coude = 21/112/2;
ratio_coude_negatif =3/4;
ratio_cubitus_radius = 184/140;
    
L_humerus = 112;
largeur_humerus =19;
L_radius = 140;
L_cubitus = 2 * (184-140);    // la longueur du cubitus est deux fois l'extrémité à axe du coude
L_cheville = 16;
longueur_pied = 23+54 ; // 23 derrière la cheville, 54 devant
rayon_ext_coude = L_humerus * ratio_coude *3/2;
    
//humerus, radius, cheville, pied : 

//humerus(longueur = L_humerus  , largeur = largeur_humerus);

translate([0,0,0*L_humerus ]) radius(longueur = L_radius, largeur = largeur_humerus, longueur_humerus = L_humerus );   // Le rayon du coude du coude est proportionnel à la longueur de l'humerus

translate([0,0,0*L_humerus ]) cubitus(longueur = L_cubitus, largeur = largeur_humerus, longueur_humerus = L_humerus, longueur_radius = L_radius );   //  Le rayon du coude du coude est proportionnel à la longueur de l'humerus.
 
  
//translate([0,0,L_humerus +L_radius+L_humerus * ratio_coude]) cheville(longueur = L_cheville, largeur = largeur_humerus, longueur_humerus = L_humerus );// le rayon de la cheville est proportionnel à la longueur de l'humerus

//translate([0,0,L_humerus+L_radius+L_humerus * ratio_coude+L_cheville]) pied(longueur = longueur_pied, largeur = largeur_humerus, longueur_humerus = L_humerus);// le rayon de la cheville est proportionnel à la longueur de l'humerus


import("humerus.stl", convexity=3);
//import("radius_cubitus.stl", convexity=3);
import("cheville.stl", convexity=3);
import("pied.stl", convexity=3); 


