

//translate([-40,1,-2]) import("hotshoe_a.stl", convexity=3);


rotate([0,0,90]) translate([-8,-9,4]) union(){
    difference(){
      cube([16,18,8],center = true);
      cube([12,18,4],center = true);
    };

    translate([2,0,2]) {rotate([90,0,0]) cylinder($fn=50, h=18,r=0.5,center = true);};
    translate([-2,0,2]) {rotate([90,0,0]) cylinder($fn=50, h=18,r=0.5,center = true);};
    
}
