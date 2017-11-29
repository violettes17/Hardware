// cyril Roudot 25 octobre 2017
// http://violettes.org

$fn=100;

r_colonette = 4;  // column height
axe_trou = (42-31)/2;  // distance between external sides of the square and holes axis   
diam_ext = sqrt(2)*31/2 +r_colonette;  // cuting external angles by a circle



module smoothcylinder(rayon)    // cylindre adajacent à la tete de l'humerus
{   minkowski(){
    cylinder(h=rayon/2, r=rayon, center=true,$fn=100);
    sphere(r = rayon/10,$fn=100);
    }
    
    }

module tete_male(rayon)
{
    translate([rayon/2,0,0]){sphere(r = rayon, $fn=100);};
    translate([-rayon/2,0,0]) rotate([90,90,90]){smoothcylinder(rayon);};
    }


module coude_male(rayon)
{
    translate([rayon/2,0,0]){sphere(r = rayon, $fn=100);};
    translate([-rayon/2,0,0]) {sphere(r = rayon, $fn=100);};
    }

module coude_femelle(rayon)
{
    epaisseur_peau = 0;  // millimètres
    jeu = 0.5;  // millimètres, car buse imprimante 3D M200 ZORTRAX 0.4mmm
    difference(){
        
        difference() {sphere(r = 3*rayon/2+epaisseur_peau, $fn=100);
                      translate([0,0,-2.5*rayon]) cube(5*rayon, center = true );  };
        union()      {translate([rayon/2,0,0]){sphere(r = rayon + jeu , $fn=100);};
                      translate([-rayon/2,0,0]) {sphere(r = rayon + jeu , $fn=100);};  };
    }
    
    }

module coude_femelle_negatif(rayon)
{
    epaisseur_peau = 0;  // millimètres
    jeu = 0.5;  // millimètres, car buse imprimante 3D M200 ZORTRAX 0.4mmm
    //difference(){
    
        difference() {sphere(r = 3*rayon/2+epaisseur_peau, $fn=100);
                      translate([0,0,-2.5*rayon]) cube(5*rayon, center = true );  };
      //  union()      {translate([rayon/2,0,0]){sphere(r = rayon + jeu , $fn=100);};
      //                translate([-rayon/2,0,0]) {sphere(r = rayon + jeu , $fn=100);};  };
    //}
    
    }


module coude_male_negatif(rayon)
{
    translate([rayon,0,0]){sphere(r = rayon, $fn=100);};
    translate([-rayon,0,0]) {sphere(r = rayon, $fn=100);};
    }


module corps_long(longueur, largeur, ratio_os_creux)
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
    
       
    //translate([0,0,longueur*(1-0.95*ratio_coude_negatif*ratio_coude)]) rotate([0,0,90]) {coude_male_negatif(rayon = longueur * ratio_coude *ratio_coude_negatif);};
    //};
    //tete_male(rayon = longueur * ratio_tete );
    translate([0,0,0]) coude_femelle(rayon = longueur_humerus * ratio_coude);
    translate([0,0,longueur+longueur_humerus * ratio_coude]) rotate ([180,0,0]) coude_femelle(rayon = longueur_humerus * ratio_coude);    
}


//humerus(longueur = 112, largeur = 19);
translate([0,0,112]) radius(longueur = 140, largeur = 19, longueur_humerus = 112);  // le rayon du coude est proportionnel à la longueur de l'humerus



