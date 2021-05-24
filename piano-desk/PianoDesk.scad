$fn=50;

WOOD_THICKNESS = 2;
ALLOWANCE = 1;

module desk(DRAWER_FRONT_DECK_ANGLE = 0, DRAWER_OFFSET_DEPTH = 0, TOP_TOP_OFFSET = 20, PANEL_TOP_ANGLE = 0)
{
    module drawer(width, depth, height, angle = 0, openDepth = 0)
    {
        ratio = 2;
        
        // Planche de droite
        translate([width - WOOD_THICKNESS, WOOD_THICKNESS, height])
            rotate([0, 90, 0])
                cube([height, depth - WOOD_THICKNESS, WOOD_THICKNESS]);
        
        // Planche de gauche
        translate([0, WOOD_THICKNESS, height])
            rotate([0, 90, 0])
                cube([height, depth - WOOD_THICKNESS, WOOD_THICKNESS]);
        
        // Planche du bas
        translate([WOOD_THICKNESS, WOOD_THICKNESS, 0])
            cube([width - 2 * WOOD_THICKNESS, depth - WOOD_THICKNESS, WOOD_THICKNESS]);
        
        // Planche du fond
        translate([WOOD_THICKNESS, depth, WOOD_THICKNESS])
            rotate([90, 0, 0])
                cube([width - 2 * WOOD_THICKNESS, height - WOOD_THICKNESS, WOOD_THICKNESS]);
                
        // Planche du devant
        /* translate([WOOD_THICKNESS, WOOD_THICKNESS, WOOD_THICKNESS])
            rotate([90, 0, 0])
                cube([width - 2 * WOOD_THICKNESS, (height - 2 * WOOD_THICKNESS) / ratio, WOOD_THICKNESS]); */
                
        frontDeckHeight = (height + WOOD_THICKNESS + 2 * RAIL_THICKNESS - 2 * ALLOWANCE) / ratio;
        
        module frontDeck(angle)
        {
            translate([- RAIL_THICKNESS + ALLOWANCE, WOOD_THICKNESS, - WOOD_THICKNESS - RAIL_THICKNESS + ALLOWANCE])
                rotate([90, 0, 0])
                    cube([width + 2 * RAIL_THICKNESS - 2 * ALLOWANCE, frontDeckHeight, WOOD_THICKNESS]);
            translate([-RAIL_THICKNESS + ALLOWANCE, 0, frontDeckHeight - WOOD_THICKNESS - RAIL_THICKNESS])
                rotate([180 + angle, 0, 0])
                    translate([0, 0, -frontDeckHeight - ALLOWANCE])
                        rotate([90, 0, 0])
                            cube([width + 2 * RAIL_THICKNESS - 2 * ALLOWANCE, frontDeckHeight, WOOD_THICKNESS]);
        }
        
        frontDeck(angle);
    }

    module rail(width, depth, height)
    {
        color([0, 1, 0])
            cube([width, depth, height]);
    }


    HEIGHT = 100;
    DESK_DEPTH = 60;

    DRAWER_WIDTH = 100;
    DRAWER_DEPTH = 30;
    DRAWER_HEIGHT = 10;

    RAIL_THICKNESS = 1;

    DEPTH = DRAWER_DEPTH + RAIL_THICKNESS + WOOD_THICKNESS;
    WIDTH = DRAWER_WIDTH + 2 * RAIL_THICKNESS + 2 * WOOD_THICKNESS;


    PANEL_TOP_HEIGHT = DESK_DEPTH - DEPTH;

    // Planche de gauche
    translate([0, 0, HEIGHT])
        rotate([0, 90, 0])
            cube([HEIGHT, DEPTH, WOOD_THICKNESS]);

    // Planche de droite
    translate([WIDTH - WOOD_THICKNESS, 0, HEIGHT])
        rotate([0, 90, 0])
            cube([HEIGHT, DEPTH, WOOD_THICKNESS]);

    // Planche du bas
    translate([WOOD_THICKNESS, WOOD_THICKNESS, 0])
        cube([WIDTH - 2 * WOOD_THICKNESS, DEPTH - WOOD_THICKNESS, WOOD_THICKNESS]);
        
    // Planche du haut
    translate([WOOD_THICKNESS, WOOD_THICKNESS, DRAWER_HEIGHT + 2 * RAIL_THICKNESS + WOOD_THICKNESS])
        cube([WIDTH - 2 * WOOD_THICKNESS, DEPTH - WOOD_THICKNESS, WOOD_THICKNESS]);

    // Tiroir
    color([1, 1, 0.5])
        translate([WOOD_THICKNESS + RAIL_THICKNESS, - DRAWER_OFFSET_DEPTH, WOOD_THICKNESS + RAIL_THICKNESS])
            drawer(DRAWER_WIDTH, DRAWER_DEPTH, DRAWER_HEIGHT, DRAWER_FRONT_DECK_ANGLE);
            
    /* color([0.9, 1, 0.9])
        translate([WOOD_THICKNESS, -PANEL_TOP_HEIGHT + WOOD_THICKNESS, DRAWER_HEIGHT + 2 * RAIL_THICKNESS + WOOD_THICKNESS])
                cube([WIDTH - 2 * WOOD_THICKNESS, PANEL_TOP_HEIGHT, WOOD_THICKNESS]); */

    color([0, 1, 0])
    translate([WOOD_THICKNESS + ALLOWANCE, WOOD_THICKNESS, DRAWER_HEIGHT + 2 * WOOD_THICKNESS + 2 * RAIL_THICKNESS])
        rotate([-PANEL_TOP_ANGLE, 0, 0])
            translate([0, -PANEL_TOP_HEIGHT, -WOOD_THICKNESS])
                cube([WIDTH - 2 * WOOD_THICKNESS - 2 * ALLOWANCE, PANEL_TOP_HEIGHT, WOOD_THICKNESS]);

    translate([0, -TOP_TOP_OFFSET / 2, TOP_TOP_OFFSET])
        translate([WOOD_THICKNESS + ALLOWANCE, WOOD_THICKNESS, WOOD_THICKNESS + (DRAWER_HEIGHT + WOOD_THICKNESS + 2 * RAIL_THICKNESS + WOOD_THICKNESS) + PANEL_TOP_HEIGHT])
            rotate([90, 0, 0])
                cube([WIDTH - 2 * WOOD_THICKNESS - 2 * ALLOWANCE, HEIGHT - (DRAWER_HEIGHT + 2 * WOOD_THICKNESS + 2 * RAIL_THICKNESS + WOOD_THICKNESS) - PANEL_TOP_HEIGHT, WOOD_THICKNESS]);
                
    translate([0, -TOP_TOP_OFFSET / 2, TOP_TOP_OFFSET])
        translate([WOOD_THICKNESS + ALLOWANCE, 2 * WOOD_THICKNESS, WOOD_THICKNESS + (DRAWER_HEIGHT + WOOD_THICKNESS + 2 * RAIL_THICKNESS + WOOD_THICKNESS) + PANEL_TOP_HEIGHT - 2 * WOOD_THICKNESS])
            rotate([90, 0, 0])
                cube([WIDTH - 2 * WOOD_THICKNESS - 2 * ALLOWANCE, 4 * WOOD_THICKNESS, WOOD_THICKNESS]);
    
    translate([WOOD_THICKNESS, WOOD_THICKNESS, HEIGHT - WOOD_THICKNESS])
        cube([WIDTH - 2 * WOOD_THICKNESS, DEPTH - WOOD_THICKNESS, WOOD_THICKNESS]);

}

// https://www.leroymerlin.fr/produits/quincaillerie/quincaillerie-du-meuble/equerre-et-assemblage-du-meuble/equerre-assemblage/1-raccord-assemblage-acier-zingue-hettich-l-70-mm-70207592.html

module bracket(width = 1.50, depth=5, height=10, thickness = 0.20)
{   
    module triangle(width, depth, height)
    {
        translate([width, 0, 0])
            rotate([0, 270, 0])
                linear_extrude(width)
                    polygon([[0, 0], [0, depth], [height, depth]]);
    }
    
    difference()
    {
        triangle(width, depth, height);
        
        translate([thickness, -thickness, thickness])
            triangle(width, depth, height);
        
        holeDiameter = width - 5 * thickness;
        
        depthOffsets = [
            holeDiameter / 2 + 2 * thickness, 
            depth - holeDiameter - thickness
        ];
        for(depthOffset = depthOffsets)
        {
            translate([holeDiameter / 2 + 3 * thickness, depthOffset, - thickness])
                cylinder(d=holeDiameter, h=3*thickness);
        }
    }
}

//bracket();

// Tout fermé
desk(0, 0, 0, 90);

// En mode piano
//desk(90 + 80, 30, 0, 90);

// En mode bureau
//desk(0, 0, 20, 0);