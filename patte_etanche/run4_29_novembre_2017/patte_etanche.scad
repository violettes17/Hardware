// cyril Roudot 15 novembre 2017
// http://violettes.org

// 15 nov 2017 : humerus, axe cylindre D6 sur l'interieur du coude, avec bague circlip
// 15 nov 2017 : radius, axe cylindre D6 sur l'interieur du coude, avec bague circlip 
// 15 nov 2017 : toutes les pièces, fermeture des articulations
// 29 nov 2017 : erreur jeu tore corrigée : nouvelle fct tore_plein_negatif

dollarFN = 40;

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
    
    // symétrie de coupleur de biele
    translate([0,2*rayon,(rayon-hauteur/2)]) coupleur_coude(rayon = rayon_coupleur_coude, longueur= longueur_coupleur_coude);
    
    translate([0,-2*rayon,(rayon-hauteur/2)]) coupleur_coude(rayon = rayon_coupleur_coude, longueur= longueur_coupleur_coude);
    }


module circlip_ext_negatif(rayon_gorge)
    {    // c'est une pièce que est soustraite à un axe de coupleur pour former une gorge periphérique  de l'epaisseur du circlip
        rotate([90,90,90]){
            degagement_au_dessus_gorge = 5;
            epaisseur_circlip = 1;
            difference() {
            cylinder(h=epaisseur_circlip, r=rayon_gorge+degagement_au_dessus_gorge, center=true,$fn = dollarFN);
            cylinder(h=epaisseur_circlip, r=rayon_gorge, center=true,$fn = dollarFN);
            };
            }
        }
        
/*module coupleur_tete(rayon, longueur)
    {
     
    translate([longueur/2,0,0]) rotate([90,90,90]){cylinder(h=longueur, r=rayon, center=true,$fn = dollarFN);};
        }
*/

module coupleur_tete(rayon, longueur)
    {
    epaulement_apres_circlip = 3;
    profondeur_gorge_circlip = 1;    
    difference(){     // soustraction d'un cylindre et d'un anneau de circlip 
        translate([longueur/2,0,0]) rotate([90,90,90]){cylinder(h=longueur, r=rayon, center=true,$fn = dollarFN);};
        translate([longueur-epaulement_apres_circlip,0,0]) circlip_ext_negatif(rayon_gorge=rayon-profondeur_gorge_circlip);
    };
    // enlever le commentaire suivant pour faire apparaitre le circlip
    //translate([longueur-epaulement_apres_circlip,0,0]) circlip_ext_negatif(rayon_gorge=rayon-profondeur_gorge_circlip);
    
    //  réaliser l'epaulement de la roue moteur
     translate([longueur/2,0,0]) rotate([90,90,90]){smoothcylinder(rayon+1);};  // la hauteur de ce cylinder est rayon/2
    }
        
module coupleur_coude(rayon, longueur)
    {
    epaulement_apres_circlip = 3;
    profondeur_gorge_circlip = 1;    
    difference(){     // soustraction d'un cylindre et d'un anneau de circlip 
        translate([longueur/2,0,0]) rotate([90,90,90]){cylinder(h=longueur, r=rayon, center=true,$fn = dollarFN);};
        translate([longueur-epaulement_apres_circlip,0,0]) circlip_ext_negatif(rayon_gorge=rayon-profondeur_gorge_circlip);
    };
    // enlever le commentaire suivant pour faire apparaitre le circlip
    //translate([longueur-epaulement_apres_circlip,0,0]) circlip_ext_negatif(rayon_gorge=rayon-profondeur_gorge_circlip);
    
    //  réaliser un epaulement de biele
     translate([longueur/2,0,0]) rotate([90,90,90]){smoothcylinder(rayon+1);};  // la hauteur de ce cylinder est rayon/2
    }

module tete_male(rayon)    // tete de l'humerus, liaison avec l'épaule
{
    translate([rayon/2,0,0]){sphere(r = rayon, $fn = dollarFN);};
    translate([-rayon/2,0,0]) rotate([90,90,90]){smoothcylinder(rayon);};
    coupleur_tete(rayon = rayon_coupleur_tete, longueur= longueur_coupleur_tete);
    }


module coude_male(rayon)    // partie basse de l'humerus
{
    translate([rayon/2,0,0]){sphere(r = rayon, $fn = dollarFN);};
    translate([-rayon/2,0,0]) {sphere(r = rayon, $fn = dollarFN);};
    coupleur_coude(rayon = rayon_coupleur_coude, longueur= longueur_coupleur_coude);
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


module tore(rayon)
{
    rayon_tore = 3;
    // tore pour fermer l'articulation
    rotate([90,90,90]) rotate_extrude () translate([rayon,0,0]) circle (rayon_tore, $fn=dollarFN);
    }

module tore_plein(rayon)
{
    rayon_tore = 3;
    // tore pour fermer l'articulation
    rotate([90,90,90]) rotate_extrude () 
    {translate([rayon,0,0]) circle (rayon_tore, $fn=dollarFN);
    translate([rayon_tore/2,0,0]) square(rayon_tore);    
        };
    }

module tore_plein_negatif(rayon,jeu)
{
    rayon_tore = 3+jeu;
    // tore pour fermer l'articulation
    rotate([90,90,90]) rotate_extrude () 
    {translate([rayon,0,0]) circle (rayon_tore, $fn=dollarFN);
    translate([rayon_tore/2,0,0]) square(rayon_tore);    
        };
    }

module coude_femelle(rayon)   // partie haute du radius
{
    epaisseur_peau = 2;  // millimètres
    jeu = 0.5;  // millimètres, car buse imprimante 3D M200 ZORTRAX 0.4mmm
    rayon_tore = 3;
    
    //rotate([90,90,90]) rotate_extrude () translate([3*rayon/2+epaisseur_peau-rayon_tore,0,0]) circle (rayon_tore, $fn=dollarFN);
     
// le coude est une sphere, emputé de 180° par un cube
// puis complétée d'un tore
// puis soulagée de deux petites spheres écartées    
    
    difference(){    
             union()
                   {
                   difference() {
                            
                            sphere(r = 3*rayon/2+epaisseur_peau, $fn = dollarFN);
                            translate([0,0,-2.5*rayon]) cube(5*rayon, center = true );                 };
                   tore(rayon = 3*rayon/2+epaisseur_peau-rayon_tore);     // tore pour fermer l'articulation
                   };
                   union() {translate([rayon/2,0,0]){sphere(r = rayon + jeu , $fn = dollarFN);};
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
    epaisseur_peau = 2;
    jeu = 0.5;
    difference(){
    corps_long(longueur, largeur, ratio_os_creux);
         
    translate([0,0,longueur]) tore_plein_negatif(rayon = 3*rayon_coude/2+epaisseur_peau-rayon_tore,jeu = jeu);   };  // tore pour fermer l'articulation    
    
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
    angle_coude = -42;  //en degré
    jeu = 0.5;
    difference()
    {
    union(){
        difference(){
        corps_long(longueur, largeur, ratio_os_creux);
        translate([0,0,-0.1]) coude_femelle_negatif(rayon= longueur_humerus * ratio_coude);// tendance à laisser une face de l'os corrigée par ce 0.1
        translate([0,0,longueur+longueur_humerus * ratio_coude + 0.1]) rotate ([180,0,0]) coude_femelle_negatif(rayon= longueur_humerus * ratio_coude);// tendance à laisser une face de l'os corrigée par ce 0.1   
            };
        
        translate([0,0,0]) rotate ([angle_coude,0,0]) coude_femelle(rayon = longueur_humerus * ratio_coude);  // c'est le coude
        translate([0,0,longueur+longueur_humerus * ratio_coude]) rotate ([180,0,0]) coude_femelle(rayon = longueur_humerus * ratio_coude);    // c'est la cheville
        };
     coupleur_coude(rayon = rayon_coupleur_coude + jeu , longueur = longueur_coupleur_coude);  };//29 novembre 2017   
   
        
}

module cubitus(longueur, largeur, longueur_humerus, longueur_radius)    // longueur largeur exprimées en millimètres
{
    jeu = 0.5;
    // pour avoir rotation autour de l'axe du coude, le corps_long du cubitus est crée symétriquement, roté, puis emputé de la moitié à l'aide d'un cube emporte pièce roté également. 
    translate([0,0,0])  difference()
            {rotate([15,0,0]) translate([0,0,0]) duocylinder(hauteur = longueur, rayon = rayon_ext_coude);
            translate([0,0,0]) rotate ([180,0,0]) coude_male(rayon = jeu + longueur_humerus * ratio_coude);
            rotate([15,0,0])  {translate ([0,-2*rayon_ext_coude,0]) cube([rayon_ext_coude+10+2*longueur_coupleur_coude,rayon_ext_coude+10,longueur+10],center = true);};  // cube emporte pièce
                
                };   
}

//cheville
module cheville(longueur, largeur, longueur_humerus)    // longueur largeur exprimées en millimètres
{
    epaisseur_peau = 2;
    jeu = 0.5;
    difference()
    {
        union()
        {
        translate([0,0,0]) cheville_male(rayon = longueur_humerus * ratio_coude) ;  
        translate([0,0,longueur]) rotate ([180,0,0]) cheville_male(rayon = longueur_humerus * ratio_coude) ;  
        };
        
        translate([0,0,0*longueur]) tore_plein(rayon = 3*rayon_coude/2+epaisseur_peau-rayon_tore+jeu);   };  // tore pour fermer l'articulation    

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

//trou traversant de D4 pour passer un fil jusqu'à l'extrémité du pied
module    passe_fil()
    {
        translate([0,0,(L_humerus+L_radius+L_humerus * ratio_coude+L_cheville)/2]) cylinder(h=(L_humerus+L_radius+L_humerus * ratio_coude+L_cheville)*2, r=2, center=true,$fn = dollarFN);
        }


module roue_moteur(rayon)
        {

difference() {            
    translate([0,0,0]) rotate([90,90,90]){smoothcylinder(rayon);};  // la hauteur de ce cylinder est rayon/2         
    ajustement = 1.5;
    translate([ajustement+rayon/4,-jansen_m,0]) rotate([90,90,90]){smoothcylinder(rayon/3);};  // degagement pour acceder au circlip sur le coupleur moteur 
    //montage servo disc
    translate([0,0,0]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN);
    translate([0,7,7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN); 
    translate([0,-7,-7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN);
    translate([0,7,-7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN); 
   translate([0,-7,7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN);  
};
            
            }



module roue_servo(rayon)
        {

difference() {            
    union()
    {translate([0,0,0]) rotate([90,90,90]){smoothcylinder(rayon);};  // la hauteur de ce cylinder est rayon/2         
    alignement_bielles = -10;
    translate([alignement_bielles,0,0]) rotate([0,0,180]) coupleur_coude(rayon = rayon_coupleur_coude, longueur= longueur_coupleur_coude);
    translate([alignement_bielles,-jansen_d,0]) rotate([0,0,180]) coupleur_coude(rayon = rayon_coupleur_coude, longueur= longueur_coupleur_coude);
    translate([0,-(rayon+rayon_coupleur_coude),0]) rotate([-90,0,0]) linear_extrude(height = jansen_d, center = true) square(24, center= true );
    };
    ajustement = 1.5;
    //translate([ajustement+rayon/4,-jansen_m,0]) rotate([90,90,90]){smoothcylinder(rayon/3);};  // degagement pour acceder au circlip sur le coupleur moteur 
    //montage servo disc
    translate([0,0,0]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN);
    translate([0,7,7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN); 
    translate([0,-7,-7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN);
    translate([0,7,-7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN); 
   translate([0,-7,7]) rotate([90,0,90]) cylinder(h=rayon, r=1.7, center=true,$fn = dollarFN);  
};
            
            }



ratio_os_creux = (sqrt(2)*31/2 + 4)/42;
ratio_tete = 33/112/2;
ratio_coude = 21/112/2;
ratio_coude_negatif =3/4;
ratio_cubitus_radius = 184/140;

herisson_echelle = 0.5;
    
L_humerus = 112 * herisson_echelle;
largeur_humerus =19 * herisson_echelle;
L_radius = 140 * herisson_echelle;
L_cubitus = 2 * (184-140) * herisson_echelle;    // la longueur du cubitus est deux fois l'extrémité à axe du coude
L_cheville = 16* herisson_echelle;
longueur_pied = 23+54 * herisson_echelle; // 23 derrière la cheville, 54 devant
rayon_ext_coude = L_humerus * ratio_coude *(3/2) * herisson_echelle;
rayon_coude = L_humerus * ratio_coude  ; 
rayon_coupleur_tete = 6;
longueur_coupleur_tete = 50;
rayon_coupleur_coude = 4;
longueur_coupleur_coude = 20;  
rayon_tore = 3;  
echelle_jansen = 25/15;
jansen_a = 38 * echelle_jansen;
jansen_b = 41.5 * echelle_jansen;
jansen_d = 40.1 * echelle_jansen;
jansen_m = 15 * echelle_jansen;
souplesse = 5;
rayon_roue_moteur = jansen_m + rayon_coupleur_coude + souplesse;
//humerus, radius, cheville, pied : 
difference(){
 union(){
        humerus(longueur = L_humerus  , largeur = largeur_humerus);

        translate([0,0,L_humerus ]) radius(longueur = L_radius, largeur = largeur_humerus, longueur_humerus = L_humerus );   // Le rayon du coude du coude est proportionnel à la longueur de l'humerus

        translate([0,0,L_humerus ]) cubitus(longueur = L_cubitus, largeur = largeur_humerus, longueur_humerus = L_humerus, longueur_radius = L_radius );   //  Le rayon du coude du coude est proportionnel à la longueur de l'humerus.
         
          
        //translate([0,0,L_humerus +L_radius+L_humerus * ratio_coude]) cheville(longueur = L_cheville, largeur = largeur_humerus, longueur_humerus = L_humerus );// le rayon de la cheville est proportionnel à la longueur de l'humerus

       // translate([0,0,L_humerus+L_radius+L_humerus * ratio_coude+L_cheville]) rotate([0,0,180]) pied(longueur = longueur_pied, largeur = largeur_humerus, longueur_humerus = L_humerus);// le rayon de la cheville est proportionnel à la longueur de l'humerus
      };
//passe_fil();
        

    };
    // placement de la roue moteur : 
    // l'abcisse droite de l'épaulement sur le coupleur tete + H roue
    // le rayon de l'épaulement est un millimetre de diam de plus que le diam coupleur. sa hauteur est la moitie du rayon
    Xplus_epaulement = longueur_coupleur_tete/2 + (rayon_coupleur_tete+1)/2;
    // il faut ensuite tabuler à droite la roue moteur : decalage de Hroue = rayon_roue_moteur/4
    // et encore rajouter les minkowski qui débordent de rayon/10 a améliorer donc ajustement
    ajustementX_moteur = 3;
    ajustementX_servo = 3;
//translate([Xplus_epaulement+rayon_roue_moteur/4+ajustementX_moteur,jansen_m,0]) roue_moteur(rayon = rayon_roue_moteur);

//translate([Xplus_epaulement+rayon_roue_moteur/4+ajustementX_servo,-jansen_a,0]) roue_servo(rayon = rayon_roue_moteur);
    
//import("humerus.stl", convexity=3);
//import("radius_cubitus.stl", convexity=3);
//import("cheville.stl", convexity=3);
//import("pied.stl", convexity=3); 


