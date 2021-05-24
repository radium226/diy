$fn=150;

WIRE_DIAMETER = 2;
BRACE_WIDTH = 10;
BRACE_HEIGHT = 10;
BRACE_DEPTH = 10;

OFFSET = 4;

module brace(width, depth, height, wireDiameter = 2, wireOffset = 4)
{
    
    difference()
    {
        cube([width, depth, height]);
            
        color([1, 0, 0])
            translate([1 / wireOffset * width, depth + 1, height / wireOffset])
                rotate([90, 0, 0])
                    cylinder(depth + 2, wireDiameter / 2, wireDiameter / 2);
                    
        color([1, 0, 0])
            translate([(wireOffset - 1) / wireOffset * width, depth + 1, height / wireOffset])
                rotate([90, 0, 0])
                    cylinder(depth + 2, wireDiameter / 2, wireDiameter / 2);
                          
        color([0, 1, 0])
            translate([-1, 1 / wireOffset * depth, 3 / wireOffset * height])
                rotate([0, 90, 0])
                    cylinder(width + 2, wireDiameter / 2, wireDiameter / 2);
                    
        color([0, 1, 0])
            translate([-1, (wireOffset - 1) / wireOffset * depth, 3 / wireOffset * height])
                rotate([0, 90, 0])
                    cylinder(width + 2, wireDiameter / 2, wireDiameter / 2);
    }
}

// brace(10, 10, 10);



CLIP_DIAMETER = 30;
CLIP_THICKNESS = 5;
CLIP_HEIGHT= 30;

CLIP_ANGLE_OFFSET = 15;

CLIP_WIDTH = 50;

module sector(radius, angles, fn = 24) {
    r = radius / cos(180 / fn);
    step = -360 / fn;

    points = concat([[0, 0]],
        [for(a = [angles[0] : step : angles[1] - 360]) 
            [r * cos(a), r * sin(a)]
        ],
        [[r * cos(angles[1]), r * sin(angles[1])]]
    );

    difference() {
        circle(radius, $fn = fn);
        polygon(points);
    }
}

module arc(radius, angles, width = 1, fn = 24) {
    difference() {
        sector(radius + width, angles, fn);
        sector(radius, angles, fn);
    }
} 


module leg(width, thickness, height, offsetTeeth) {
    cube([width, thickness, height]);
    for(i = [1 : 4])
        translate([2 * i * (sqrt(2 * pow(thickness, 2)) / 2) - (offsetTeeth ? (sqrt(2 * pow(thickness, 2)) / 2) : 0), 0, 0])
            rotate([0, 0, 45])
                translate([- thickness / 2, - thickness / 2, 0])
                    cube([thickness, thickness, height]);
}

module legBraceWireStand(width, depth, height, wireDiameter) {
    difference() {
        cube([width, depth, height]);
        
        translate([width / OFFSET, depth + 1, height / OFFSET])
            rotate([90, 0, 0])
                cylinder(depth + 2, wireDiameter / 2, wireDiameter / 2);
        
        translate([width / OFFSET, depth + 1, (OFFSET - 1) / OFFSET * height])
            rotate([90, 0, 0])
                cylinder(depth + 2, wireDiameter / 2, wireDiameter / 2);
    }
}

module legBrace(width, thickness, height, braceWidth = BRACE_WIDTH, wireDiameter = WIRE_DIAMETER) {
    {
        difference() {
            cube([braceWidth, thickness, height]);
            rotate([90, 90, 90])
                color([1, 0, 0])
                    translate([- thickness, 0, 0])
                        #cylinder(width + 2, wireDiameter / 2, wireDiameter / 2);
        }
    }
}

LEG_BRACE_WIRE_STAND_DEPTH = 10;

module clip(height, depth, width, diameter, thickness = BRACE_HEIGHT / 2, wireDiameter = WIRE_DIAMETER, angleOffset = 15)
{
    linear_extrude(height) 
        arc(diameter / 2, [0 - angleOffset, 180 + angleOffset], thickness, fn=$fn);


rotate([0, 0, 90 + angleOffset])
    translate([-width, diameter / 2, 0]) {
        leg(width, thickness, height, false);
translate([depth, thickness * 2, 0])
    mirror([0, 90, 0])
        rotate([0, 0, 90])
            legBraceWireStand(thickness * 2, depth, height, wireDiameter);

    }

    rotate([0, 0, 90 - angleOffset])
        translate([-width, -diameter/ 2, 0])
            mirror([0, 90, 0])
                leg(width, thickness, height, true);
}



SIZE = 10;
DIAMETER = 20;
DEPTH = 31;

for (i = [0 : 0]) {
    for (j = [0 : 1]) {
        translate([i * 3 / 2 * DIAMETER, j * 2 * DEPTH, 0])
            clip(SIZE, SIZE, DEPTH, DIAMETER);
    }
    translate([i * 3 / 2 * DIAMETER, 3 * DEPTH, 0])
        brace(SIZE, SIZE, SIZE);
}


    


