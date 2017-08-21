

/*
 * 
 * 
 * RedOhm
 * 
 * Programme enchaînement de divers sous programme 
 * 
 * Initialisation spider
 * Petit bonjour 
 * Position d'attaque de Spider 
 * Rotation de Spider 
 * 
 * Le 18/02/2017
 * H-Mazelin
 * 
 */

 



// Cette librairie permet à une carte Arduino de contrôler des servomoteurs
#include <Servo.h>


//Crée un objet de type "Servo", nommé -> servo_d1
  Servo servo_d1; 
//Crée un objet de type "Servo", nommé -> servo_d2
  Servo servo_d2;
//Crée un objet de type "Servo", nommé -> servo_d3
  Servo servo_d3;  
//Crée un objet de type "Servo", nommé -> servo_d4
  Servo servo_d4;
//Crée un objet de type "Servo", nommé -> servo_d5
  Servo servo_d5;
//Crée un objet de type "Servo", nommé -> servo_d6
  Servo servo_d6;
//Crée un objet de type "Servo", nommé -> servo_d7
   Servo servo_d7;
//Crée un objet de type "Servo", nommé -> servo_d8
   Servo servo_d8;      
//Crée un objet de type "Servo", nommé -> servo_d9
   Servo servo_d9;
//Crée un objet de type "Servo", nommé -> servo_d10
   Servo servo_d10;   
//Crée un objet de type "Servo", nommé -> servo_d11
   Servo servo_d11;
//Crée un objet de type "Servo", nommé -> servo_d12
   Servo servo_d12;

// variable du type int pour les deplacement des servomoteurs
// a droite 
 int initd=5;
// variable du type int pour les deplacement des servomoteurs
// a gauche 
  int initg=5;
// variable du type int pour les boucle for   
  int x;
// variable du type int pour le deplacement arriere
int arriere =90;


// Un programme Arduino doit impérativement contenir la fonction "setup"
// Elle ne sera exécuter une seule fois au démarrage du microcontroleur
// Elle sert à configurer globalement les entrées sorties 
void setup() {

// associe le servomoteur a la broche 2  
  servo_d1.attach(2,700,2000);
// associe le servomoteur a la broche 3  
  servo_d2.attach(3,700,2000);
// associe le servomoteur a la broche 4  
  servo_d3.attach(4,700,2000);
// associe le servomoteur a la broche 5  
  servo_d4.attach(5,700,2000);  
// associe le servomoteur a la broche 6  
  servo_d5.attach(6,700,2000);  
// associe le servomoteur a la broche 7  
  servo_d6.attach(7,700,2000);  
    
//associe le servomoteur a la broche 8  
  servo_d7.attach(8,700,2000);
//associe le servomoteur a la broche 9  
  servo_d8.attach(9,700,2000);
//associe le servomoteur a la broche 10  
  servo_d9.attach(10,700,2000);
//associe le servomoteur a la broche 11  
  servo_d10.attach(11,700,2000);  
//associe le servomoteur a la broche 12 
  servo_d11.attach(12,700,2000);  
//associe le servomoteur a la broche 13 
  servo_d12.attach(13,700,2000);   



// Appel de la fonction -> initialisation 
initialisation(); 
// pause pour le positionnement des servomoteurs 
delay(1500);


  








   
}
 












//Le programme principal s’exécute par une boucle infinie appelée Loop () 
 
void loop() {

// appel du sous programme un petit bonjour 
  petit_bonjour();
// temporisation 
  delay(500);
// appel du sous programme attaque 
  attaque_spider();
 // Appel de la fonction -> initialisation 
initialisation(); 
// pause pour le positionnement des servomoteurs 
delay(500);
  
  
// temporisation 
  delay(2000); 



// realisation de 5 pas de rotation 
for (x=0;x<5;x++){
// appel du sous programme rotation
  rotation_spider(); 
  delay(300);
}  

   

  
}


/* 
 * =============================================
 *      
 *         ensemble de sous programme 
 *      
 * =============================================     
 */

// Initialisation spider

void initialisation()
 {
  
  // position des pattes en bas 
  initd=5;
  initg=175;
    
  servo_d1.write (initd);
   servo_d9.write (initd);
    servo_d11.write (initd); 
 
  servo_d5.write (initg);
    servo_d3.write (initg);  
      servo_d7.write (initg);
  
  
  // position des pattes au centre 
  servo_d2.write (90);
     servo_d4.write (90);
       servo_d6.write (90);
        servo_d8.write (90);   
         servo_d10.write (90);    
          servo_d12.write (90);    
  

 }



//========== sous programme petit bonjour ==========

void petit_bonjour()

{

 
   servo_d1.write (175);
    for (x=0;x<2;x++){
     servo_d2.write (30);
      delay(500);
     servo_d2.write (150); 
      delay(500); 
 }
   
   servo_d2.write (90);
   delay(200);
   servo_d1.write (5);
   delay(500);
   servo_d1.write (175);
    for (x=0;x<2;x++){
     servo_d2.write (30);
      delay(500);
     servo_d2.write (150); 
      delay(500);    
 
    } 
    servo_d2.write (90);
    servo_d1.write (5);



}

//==================fin du bonjour ======================





//========= position d'attaque de Spider ================

void attaque_spider()

{ 

  initd=55;
  initg=125;
    
  servo_d1.write (initd);
   servo_d9.write (initd);
    servo_d11.write (initd); 
 
  servo_d5.write (initg);
    servo_d3.write (initg);  
      servo_d7.write (initg);
  
  
  // position des pattes au centre 
  servo_d2.write (90);
     servo_d4.write (90);
       servo_d6.write (90);
        servo_d8.write (90);   
         servo_d10.write (90);    
          servo_d12.write (90);  

  delay(1000);
  servo_d8.write (40);   
  servo_d10.write (140); 
  delay(1000);
  initd=175;
  servo_d1.write (initd);
  servo_d11.write (initd); 
  delay(1000); 

  for (x=0;x<5;x++){
     initd=135;
  servo_d1.write (initd);
  servo_d11.write (initd); 
  delay(300);
    initd=175;
  servo_d1.write (initd);
  servo_d11.write (initd); 
  delay(300);
 } 

 }

 //====== position d'attaque de Spider =======



void rotation_spider()
{
 

 //===== rotation de spider ==================

//patte 1
 servo_d1.write (25);
  delay (200);
 servo_d2.write (50);
  delay (200);
 servo_d1.write (5);
  delay (200); 
//patte 2  
 servo_d11.write (25);
  delay (200);
 servo_d12.write (50);
  delay (200);
 servo_d11.write (5);
  delay (200); 
//patte3
servo_d9.write (25);
  delay (200);
 servo_d10.write (50);
  delay (200);
 servo_d9.write (5);
  delay (200); 
//patte4
servo_d3.write (150);
  delay (200);
 servo_d4.write (50);
  delay (200);
 servo_d3.write (175);
  delay (200); 
//patte 5
servo_d5.write (150);
  delay (200);
 servo_d6.write (50);
  delay (200);
 servo_d5.write (175);
  delay (200); 
 //patte6
 servo_d7.write (150);
  delay (200);
 servo_d8.write (50);
  delay (200);
 servo_d7.write (175);
  delay (200);  

// position des pattes en arriere 
 arriere=130;
// position des pattes au centre 
  servo_d2.write (arriere);
     servo_d4.write (arriere);
       servo_d6.write (arriere);
        servo_d8.write (arriere);   
         servo_d10.write (arriere);    
          servo_d12.write (arriere);  

 delay(500);

}

 //=====Fin de rotation de spider =====================

