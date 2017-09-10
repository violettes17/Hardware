// cyril Roudot 27 aout 2017
// http://violettes.org

$fn=100;

r_colonette = 1.7;  // column radius
h_colonette = 10;  // column height
r_trou_colonette = 1.7/2;  // column radius internal, suitable to freely introduce a M3 screw
xmax = 100; // extremité du modèle (symétrique)
//a = 90;  // orientation de la colonnette dans le plan x y
a = 90  ;  //   y = 100-x^2/100 donc y'= -2x/100   tan(a) = y'/x avec xmax = 100
b = 0;
c = 90+atan(-2)+180;
cc = 90+atan(-1)+180;
//column
module colonette ()
{
    difference(){
            cylinder(h=h_colonette,r=r_colonette,center= false);
            //cylinder(h=h_colonette,r=r_trou_colonette,center= false);
};
}

module arc_extra()
{
            translate([ xmax,0,0])  rotate ([90, b, c]) color("black") colonette();
            translate([-xmax,0,0])   rotate ([90, b, -c]) color("black") colonette();
}

module arc_intra()
{
            translate([ xmax,0,0])  rotate ([90, b, cc]) color("gray") colonette();
            translate([-xmax,0,0])   rotate ([90, b, -cc]) color("gray") colonette();
}

//"a" is a rotation about the X axis, from the +Y axis, toward the +Z axis.
//"b" is a rotation about the Y axis, from the +Z axis, toward the +X axis.
//"c" is a rotation about the Z axis, from the +X axis, toward the +Y axis.


for(i=[0:6])
            {
            rotate ([i * 30 , 0, 0]) arc_extra();
            rotate ([-i * 30 , 0, 0]) arc_intra();
                };



  //rotate(90, [-1, 0, 0]) scale([2,1,1]) color("aqua") surface(file = "example010.dat", center = true, convexity = 5); 

//final part

              //  colonette();

//end



