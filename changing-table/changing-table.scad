THICKNESS = 1;
WIDTH = 60;
DEPTH = 30;


module table() {
    cube([WIDTH, DEPTH, THICKNESS]);

    color([1, 0, 0]) {
        rotate([90, 0, 0])
            cube([WIDTH, 5 * THICKNESS, THICKNESS]);

        translate([0, DEPTH + THICKNESS, 0])  
            rotate([90, 0, 0])
                cube([WIDTH, 5 * THICKNESS, THICKNESS]);
                
        translate([-THICKNESS, -THICKNESS, 0])
            rotate([90, 0, 90])
                cube([DEPTH + 2 * THICKNESS, 5 * THICKNESS, THICKNESS]);
    }
}

// table();

// 48 (50)
// 74 (70)

TABLE_DEPTH = 30;
TABLE_WIDTH = 60;
SMALL_STORAGE_DEPTH = 10;
SMALL_STORAGE_WIDTH = 20;


cube([TABLE_WIDTH, TABLE_DEPTH, THICKNESS]);

translate([TABLE_WIDTH - SMALL_STORAGE_WIDTH, TABLE_DEPTH, 0])
    cube([SMALL_STORAGE_WIDTH, SMALL_STORAGE_DEPTH, THICKNESS]);


color([1, 0, 0])
    translate([0, THICKNESS, THICKNESS])
        rotate([90, 0, 0])
            cube([TABLE_WIDTH, 5 * THICKNESS, THICKNESS]);

color([1, 0, 0])
    translate([0, TABLE_DEPTH, THICKNESS])
        rotate([90, 0, 0])
            cube([TABLE_WIDTH, 5 * THICKNESS, THICKNESS]);
            

color([1, 0, 0])
    translate([THICKNESS, THICKNESS, THICKNESS])
        rotate([0, -90, 0])
            cube([5 * THICKNESS, TABLE_DEPTH - 2 * THICKNESS, THICKNESS]);
            
color([0, 1, 0]) {
    translate([TABLE_WIDTH - SMALL_STORAGE_WIDTH + THICKNESS, TABLE_DEPTH, THICKNESS])
        rotate([0, -90, 0])
            cube([5 * THICKNESS, SMALL_STORAGE_DEPTH, THICKNESS]);
        
    translate([TABLE_WIDTH, TABLE_DEPTH, THICKNESS])
        rotate([0, -90, 0])
            cube([5 * THICKNESS, SMALL_STORAGE_DEPTH, THICKNESS]);
    
    translate([TABLE_DEPTH + SMALL_STORAGE_DEPTH + THICKNESS, TABLE_DEPTH + SMALL_STORAGE_DEPTH, THICKNESS])
        rotate([90, 0, 0])
            cube([SMALL_STORAGE_WIDTH - 2 * THICKNESS, 5 * THICKNESS, THICKNESS]);
}

color([0, 0, 1])
{
    translate([TABLE_WIDTH - THICKNESS, 0, 0])
        rotate([0, 90, 0])
            cube([(5 + 1) * THICKNESS, TABLE_DEPTH + SMALL_STORAGE_DEPTH, THICKNESS]);
    
    rotate([0, 90, 0])
        cube([5 * THICKNESS, TABLE_DEPTH, THICKNESS]);
    
}

LARGE_STORAGE_WIDTH = 10 * THICKNESS;

/* color([1, 1, 0]) {
    translate([TABLE_WIDTH + LARGE_STORAGE_WIDTH, 0, (5+ 1) * THICKNESS])
        rotate([0, 90, 90])
            cube([(5 * 2 + 1) * THICKNESS, LARGE_STORAGE_WIDTH, THICKNESS]);
    
    translate([TABLE_WIDTH + LARGE_STORAGE_WIDTH, TABLE_DEPTH + SMALL_STORAGE_DEPTH - THICKNESS, (5+ 1) * THICKNESS])
        rotate([0, 90, 90])
            cube([(5 * 2 + 1) * THICKNESS, LARGE_STORAGE_WIDTH, THICKNESS]);
    
    
    translate([TABLE_WIDTH, 0, - (5 + 1) * THICKNESS])
        cube([LARGE_STORAGE_WIDTH, TABLE_DEPTH + SMALL_STORAGE_DEPTH, THICKNESS]);
    
    translate([TABLE_WIDTH + LARGE_STORAGE_WIDTH, 0, (5 + 1) * THICKNESS])
        rotate([0, 90, 0])
            cube([(5 * 2 + 2) * THICKNESS, TABLE_DEPTH + SMALL_STORAGE_DEPTH, THICKNESS]);
} */