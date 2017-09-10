// cyril Roudot 27 aout 2017
// http://violettes.org

$fn=100;

r_colonette = 1.7;  // column radius
h_colonette = 10;  // column height
r_trou_colonette = 1.7/2;  // column radius internal, suitable to freely introduce a M3 screw
xmax = 100; // extremité du modèle (symétrique)
//column
module colonette ()
{
    difference(){
            cylinder(h=h_colonette,r=r_colonette,center= false);
            cylinder(h=h_colonette,r=r_trou_colonette,center= false);
};
}
 
// y = 100-x^2/100


//surface.scad
//surface(file = "surface.dat", center = true, convexity = 5);
//%translate([0,0,5])cube([10,10,10], center =true);

//"a" is a rotation about the X axis, from the +Y axis, toward the +Z axis.
//"b" is a rotation about the Y axis, from the +Z axis, toward the +X axis.
//"c" is a rotation about the Z axis, from the +X axis, toward the +Y axis.

a = 90;  // orientation de la colonnette dans le plan x y
a = a + atan(-2*100/xmax);  //   y = 100-x^2/100 donc y'= -2x/100   tan(a) = y'/x avec xmax = 100
    
//for(i=[0:3])
//            {
            translate([xmax-h_colonette,0,0])
  //              {
                rotate ([a, b, c]) colonette();
    //            }
//             }


intersection() {
   surface(file = "example010.dat", center = true, convexity = 5);
   rotate(45, [0, 0, 1]) surface(file = "example010.dat", center = true, convexity = 5); 
 }

//final part


              //  colonette();

//end



