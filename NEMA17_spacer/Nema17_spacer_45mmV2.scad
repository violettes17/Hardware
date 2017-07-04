// cyril Roudot 4 juillet 2017
// http://violettes.org

$fn=100;

r_colonette = 4;  // column height
axe_trou = (42-31)/2;  // distance between external sides of the square and holes axis   
diam_ext = sqrt(2)*31/2 +r_colonette;  // cuting external angles by a circle


//le moteur est un carré de 42mm elevé de 47mm, avec 4 M3 sur un carré de 31mm
// the motor is a 42mm square  47 mm height, with 4 M3 aligned on a 31mm internal square

//baseplate
module Nema17()
{
    translate([21,21,1])
    {
                difference()
            {
                    intersection()
                    {
                    cylinder(h=2,r=diam_ext, center = true);
                    cube([42,42,2], center = true);
                    };
                    cylinder(h=2,r=14, center = true);
            }
    
    };
}



//column
module colonette ()
{
    difference(){
            cylinder(h=45,r=r_colonette,center= false);
            cylinder(h=45,r=1.7,center= false);
};
}
 



//final part


difference()
{
    union()
    {
        Nema17();
    
        for(j=[0:1]){
            
            for(i=[0:1])
            {
            translate([axe_trou+31*i,axe_trou+31*j,0])
                {
                colonette();
                }
             }
            };
      };
      union()
      {
          for(j=[0:1]){
                        
                        for(i=[0:1])
                        {
                        translate([axe_trou+31*i,axe_trou+31*j,0]) {cylinder(h=45,r=1.7,center= false);}
                        }
                        }
      }     

 }
        
    

//end



