// cyril Roudot 20 aout 2017
// http://violettes.org

$fn=100;

r_colonette = 4;  // column radius
h_colonette = 42;  // column height
r_trou_colonette = 1.7;  // column radius internal, suitable to freely introduce a M3 screw

//column
module colonette ()
{
    difference(){
            cylinder(h=h_colonette,r=r_colonette,center= false);
            cylinder(h=h_colonette,r=r_trou_colonette,center= false);
};
}
 



//final part


                colonette();

//end



