$fn = 25;

DEPTH = 10;
WIDTH = 10;
HEIGHT = 6;

THICKNESS = 1; // height / 6;

module joinBottom(depth, width, height, thickness, offset, letter)
{
    difference()
    {
        cube([depth, width, 4 / 6 * height]);
        translate([thickness, thickness, thickness])
            cube([depth, width - 2 * thickness, 4 / 6 * height - 2 * thickness]);
        
        translate([3 * thickness, 3 * thickness, 4 / 6 * height - 2 * thickness])
            cube([depth, width - 6 * thickness, 3 * thickness]);
        
        translate([3 / 2 * thickness, 3 / 2 * thickness, 4 / 6 * height + thickness / 4])
            sphere(d = thickness);
        
        translate([3 / 2 * thickness, width - 3 / 2 * thickness, 4 / 6 * height + thickness / 4])
            sphere(d = thickness);
        
        /* translate([depth - thickness, width - thickness, - 3 / 4 * thickness])
            mirror([0, 90, 0])
                rotate([0, 0, 90])
                    linear_extrude(height = thickness)
                        text(letter, size = width - 2 * thickness); */
        
        translate([thickness / 2, 2 / 6 * width, 1 / 6 * height])
            rotate([90, 0, 90])
                linear_extrude(height = thickness)
                    text(letter, size = 2 / 6 * height);
    }
}

module joinTop(depth, width, height, thickness, offset, letter)
{
    translate([0, 0, - thickness - offset])
    {
        difference()
        {
            union()
            {
                translate([thickness + offset, thickness + offset, thickness + offset])
                    cube([depth - thickness - offset, width - 2 * thickness - 2 * offset, 4 / 6 * height - 2 * thickness - 2 * offset]);
                
                translate([3 * thickness + offset, 3 * thickness + offset, 4 / 6 * height - 2 * thickness])
                    cube([depth - 3 * thickness - offset, width - 6 * thickness - 2 * offset, 3 * thickness]);
                
                translate([0, 0, 4 / 6 * height + offset])
                    cube([depth, width, 2 / 6 * height - offset]);
                
                translate([3 / 2 * thickness, 3 / 2 * thickness, 4 / 6 * height + offset + thickness / 4])
                    sphere(d = thickness);

                translate([3 / 2 * thickness, width - 3 / 2 * thickness, 4 / 6 * height + offset + thickness / 4])
                    sphere(d = thickness);
            }
        
            /*translate([depth - thickness, thickness, height - 1 / 4 * thickness])
                rotate([0, 0, 90])
                    linear_extrude(height = thickness)
                        text(letter, size = width - 2 * thickness);*/
            translate([6 / 2 * thickness, 3 / 6 * width, 3 / 6 * height])
                rotate([90, 0, 90])
                    linear_extrude(thickness)
                        mirror([180, 0, 0])
                            text(letter, size = 1 / 6 * height);
        }
    }
}

items = [
    ["A", 0.05],
    ["B", 0.10],
    ["C", 0.15],
    ["D", 0.20],
    ["E", 0.25],
    ["F", 0.30]
];

//joinTop(DEPTH, WIDTH, HEIGHT, THICKNESS, 0.3, "C");
//joinBottom(DEPTH, WIDTH, HEIGHT, THICKNESS, 0.3, "C");

for(i = [0 : len(items) - 1])
{
    letter = items[i][0];
    offset = items[i][1];
    
    translate([4 / 6 * HEIGHT, i * (WIDTH + 4 * THICKNESS), 0])
        rotate([0, 3 * 90, 0])
            joinBottom(DEPTH, WIDTH, HEIGHT, THICKNESS, offset, letter);
    
    translate([DEPTH + 4 * THICKNESS, i * (WIDTH + 4 * THICKNESS), WIDTH])
        rotate([0, 90, 0])
            joinTop(DEPTH, WIDTH, HEIGHT, THICKNESS, offset, letter);
    
}