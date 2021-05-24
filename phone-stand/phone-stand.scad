$fn = 100;

module basis(width, height, thickness)
{
    depth = 4;
    
    difference()
    {
        cube([width, height, depth * thickness]);
        translate([thickness, thickness, - thickness])
            cube([width - 2 * thickness, height - (2 * thickness), (depth + 2)* thickness]);
        translate([thickness, - thickness, thickness])
            cube([width - 2 * thickness, height + 2 * thickness, (depth - 2) * thickness]);
        translate([- thickness, thickness, thickness])
            cube([width + 2 * thickness, height - 2 * thickness, (depth - 2) * thickness]);
    }
    
    module corner()
    {
        cube([thickness, depth * thickness, depth * thickness]);
        cube([depth * thickness, depth * thickness, thickness]);
        cube([depth * thickness, thickness, depth * thickness]);
    }
    
    translate([0, 0, 0])
        mirror([0, 0, 0])
             difference() {
                union() {
                    cube([depth * thickness, (depth - 1) * thickness, 2 * thickness]);
                    corner();
                }
                translate([3 / 2 * thickness - 1 / 5 * thickness, 3 / 2 * thickness, 5 / 2 * thickness])
                    sphere(r = thickness / 2);
            }
    
    translate([width, 0, 0])
        mirror([90, 0, 0])
            difference() {
                union()
                {
                    cube([depth * thickness, (depth - 1) * thickness, 2 * thickness]);
                    corner();
                }
                translate([3 / 2 * thickness - 1 / 5 * thickness, 3 / 2 * thickness, 5 / 2 * thickness])
                    sphere(r = thickness / 2);
            }
    
    translate([0, height, 0])
        mirror([0, 90, 0])
            difference()
            {
                corner();
                translate([thickness + 1 / 2 * thickness - 1 / 5 * thickness, 3 / 2 * thickness, 3 / 2 * thickness])
                    sphere(r = thickness / 2);
            }
    
    translate([width, height, 0])
        mirror([90, 90, 0])
            difference()
            {
                corner();
                translate([3 / 2 * thickness, thickness + 1 / 2 * thickness - 1 / 5 * thickness, 3 / 2 * thickness])
                    sphere(r = thickness / 2);
            }
    
}

module blocker(phoneStrandWidth, phoneStrandHeight, thickness, margin)
{
    width = phoneStrandWidth - 2 * thickness - margin;
    height = phoneStrandHeight- 4 * thickness - margin;
    
    union()
    {
        translate([1 / 5 * thickness, thickness / 2, thickness / 2])
            sphere(r = thickness / 2);
        
        translate([width - (1 / 5) * thickness, thickness / 2, , thickness / 2])
            sphere(r = thickness / 2);
        
        translate([ 0,thickness / 2,  thickness / 2])
        rotate([0, 90, 0])
            cylinder(r = thickness / 2, h = width);
        
        translate([0, thickness / 2, 0])
            cube([width, thickness / 2, thickness]);
        
        translate([0, thickness, 0])
            difference()
            {
                cube([width, height - thickness, thickness]);
                translate([thickness, 0, - thickness])
                    cube([width - 2 * thickness, height - 2 * thickness, 3 * thickness]);
            }
    }
    
    translate([0, height - 8 * thickness, 0])
        cube([width, thickness, thickness]);
}


module phoneStand(width, height, thickness, margin, standRotate = 67, blockerRotate = 40, flipRotate = 0)
{
    basis(width, height, thickness);
    
    translate([thickness + margin / 2, height - (thickness + margin / 2), thickness])
        mirror([0, 90, 0])
            translate([0, (thickness + margin) / 2, (thickness + margin) / 2])
                rotate([blockerRotate, 0, 0])
                    translate([0, - (thickness + margin) / 2, - (thickness + margin) / 2])
                        color([1, 0, 0])
                            blocker(width, height, thickness, margin);

    translate([thickness + margin / 2, thickness + margin / 2, 2 * thickness])
        translate([0, thickness / 2, thickness / 2])
            rotate([standRotate, 0, 0])
                translate([0, -thickness / 2, -thickness / 2])
                    translate([0, 0, thickness])
                        mirror([0, 0, 90])
                            union()
                            {
                                color([0, 0, 1])
                                    support(width, height, thickness, margin);
                                translate([thickness + margin / 2, 4 * thickness + margin, 0])
                                    translate([0, thickness / 2, thickness / 2])
                                        rotate([-flipRotate, 0, 0])
                                            translate([0, -thickness / 2, -thickness / 2])
                                                color([1, 0, 1])
                                                    flip(width, height, thickness, margin);
                            }
        
}

module support(standWidth, standHeight, thickness, margin) {
    supportHeight = standHeight - 4 * thickness - 1 * margin;
    supportWidth = standWidth - 2 * thickness - margin;
    
    difference()
    {
        union()
        {
            translate([0, 0, thickness])
                mirror([0, 0, 90])
                {
                    translate([1 / 5 * thickness, thickness / 2, thickness / 2])
                        sphere(r = thickness / 2);
                    
                    translate([supportWidth - 1 / 5 * thickness, thickness / 2, thickness / 2])
                        sphere(r = thickness / 2);
                    
                    translate([0, thickness / 2, thickness / 2])
                        rotate([0, 90, 0])
                            cylinder(r = thickness / 2, h = supportWidth);
                    difference()
                    {
                        translate([0, thickness / 2, 0])
                        cube([
                            standWidth - 2 * thickness - margin,
                            supportHeight - thickness / 2,
                            thickness,
                        ]);
                        
                        translate([
                            thickness, 
                            thickness, 
                            -thickness
                        ])
                            cube([
                                standWidth - 4 * thickness - margin,
                                supportHeight - 2 * thickness,
                                3 * thickness,
                            ]);
                    }
                    
                    numberOfBlockers = 6;
                    
                    for(i = [0 : numberOfBlockers - 1]) {
                        offset = i * ((supportHeight - 2 * thickness) / 2 / (numberOfBlockers - 1));
                        translate([0, offset + (supportHeight / 2), 0]) 
                            union() {
                                cube([
                                    supportWidth, 
                                    thickness, 
                                    thickness, 
                                ]);
                                translate([
                                    thickness + margin / 2,
                                    0,
                                    - thickness
                                ])
                                    color([1, 0, 1])
                                    cube([
                                        supportWidth - 2 * thickness - margin, 
                                        thickness, 
                                        2 * thickness,
                                    ]);
                            }
                    }
                }
               
            
                translate([0, 3 * thickness + margin / 2, -thickness])
                    cube([supportWidth, thickness, 2 * thickness]);
        }
   
        translate([- 1 / 5 * thickness, 0, 0])
            translate([thickness, 4 * thickness + margin / 2, 0])
                translate([thickness / 2, thickness / 2, thickness / 2])
                sphere(r = thickness / 2);
        
        translate([+ 1 / 5 * thickness, 0, 0])
            translate([supportWidth - 2 * thickness, 4 * thickness + margin / 2, 0])
                translate([thickness / 2, thickness / 2, thickness / 2])
                sphere(r = thickness / 2);
    } 
        
}

module flip(totalWidth, totalHeight, thickness, margin)
{
    flipWidth = totalWidth - 4 * thickness - 2 * margin;
    flipHeight = 10 * thickness;
    
    translate([0, flipHeight, 0])
        mirror([0, 90, 0])
        {
            translate([0, flipHeight - thickness, 0])
                translate([0, thickness / 2, thickness / 2])
                    rotate([0, 90, 0])
                        cylinder(r = thickness / 2, h = flipWidth);
            
            difference()
            {
                union()
                {
                    cube([flipWidth, flipHeight - thickness / 2, thickness]);
                    cube([flipWidth, thickness, 3 * thickness]);
                }
                translate([thickness, 2 * thickness, -thickness])
                {
                    cube([flipWidth - 2 * thickness, flipHeight - 4 * thickness, 3 * thickness]);
                }
            }
            
            translate([- 1 / 3 * thickness, flipHeight - thickness, 0])
                translate([thickness / 2, thickness / 2, thickness / 2])
                    sphere(r = thickness / 2);
            
            translate([flipWidth - thickness + 1 / 3 * thickness, flipHeight - thickness, 2 * 0])
                translate([thickness / 2, thickness / 2, thickness / 2])
                    sphere(r = thickness / 2);
        }
}



THICKNESS = 3;
WIDTH = 50;
HEIGHT = ceil(100 / THICKNESS / 6) * THICKNESS * 6 + THICKNESS;
MARGIN = 1;

phoneStand(WIDTH, HEIGHT, THICKNESS, MARGIN, 0, 0, 0);

/*
basis(WIDTH, HEIGHT, THICKNESS);

translate([1.5 * WIDTH, 0, 0])
    blocker(WIDTH, HEIGHT, THICKNESS, MARGIN);

translate([0, 1.5 * HEIGHT, 2 * THICKNESS])
    mirror([0, 0, 90])
        support(WIDTH, HEIGHT, THICKNESS, MARGIN);

translate([1.5 * WIDTH, 1.5 * HEIGHT, 0])
    flip(WIDTH, HEIGHT, THICKNESS, MARGIN);
*/