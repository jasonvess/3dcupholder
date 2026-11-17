// =====================================================================
//  Cup holder adapter
//  Car:     VW Polo 6th gen (AW / 2G), pre-facelift 2017-2021
//  Cup:     Nespresso Travel Tumbler "Samra Origins" (540 ml)
//
//  The tumbler body is ~92.7 mm wide, too big for the Polo's centre
//  console cup holders. This adapter plugs into one of them and gives
//  the tumbler a wide, deep cup with spring tabs that stop it rattling.
//
//  Print upright (plug on the bed). No supports needed.
//  Material: PETG or ASA. Do NOT use PLA, it softens in a hot car.
//
//  Open in OpenSCAD (or the MakerWorld customizer), set the values in
//  the first two sections to YOUR measurements, press F6, export STL.
// =====================================================================

/* [What to print] */
// holder = the adapter. fit_test = quick gauges to check both diameters first.
part = "holder"; // [holder, fit_test]

/* [Car cup holder (measure yours!)] */
// Inside diameter of the Polo's cup holder at the top rim (mm)
car_hole_top_d = 74;
// Inside diameter of the cup holder at its floor (mm)
car_hole_bottom_d = 71;
// Depth of the cup holder from rim to floor (mm)
car_hole_depth = 50;
// Total diametral clearance on the plug (mm). Smaller = tighter fit.
plug_clearance = 0.5;

/* [Tumbler (Nespresso Travel Tumbler)] */
// Body diameter just below the lid (mm). Nespresso spec: 92.7
tumbler_top_d = 92.7;
// Body diameter at the very bottom (mm). Same as top if the sides are straight.
tumbler_bottom_d = 92.7;
// Body height without lid (mm). Nespresso spec: 119-122
tumbler_body_h = 120;
// Total diametral clearance in the cup (mm). The spring tabs take up the slack.
cup_clearance = 2.0;
// How deep the cup is, i.e. how much of the body it holds (mm)
cup_depth = 65;

/* [Spring grip tabs] */
// Number of flexible tabs pressing on the tumbler (0 = rigid cup)
tab_count = 3;
// Width of each tab (mm)
tab_width = 16;
// Length of each tab (mm). Longer = softer.
tab_length = 32;
// How far the bump on each tab sticks into the cup (mm)
tab_bump = 2.0;
// Width of the slot cut around each tab (mm)
tab_slot = 1.6;

/* [Placement] */
// Shift the cup off-centre from the plug (mm), e.g. away from the gear lever
cup_offset = 0;
// Direction of that shift (degrees; 0 = +X)
cup_offset_angle = 0;
// Extra straight neck between plug and cup (mm). Raise if the wide cup hits console trim.
cup_lift = 0;

/* [Construction] */
// Wall thickness of the cup (mm). Also the thickness of the spring tabs.
wall = 2.4;
// Hollow out the plug from below (saves ~40 g of filament and an hour of printing)
hollow_plug = true;
// Wall thickness of the hollow plug (mm)
plug_wall = 3.2;
// Drain hole for condensation (mm, 0 = none)
drain_d = 8;
// Lead-in chamfer on the plug bottom and the cup rim (mm)
chamfer = 1.0;

/* [Hidden] */
$fn = 128;
eps = 0.01;

// ---------------------------------------------------------------------
//  Derived dimensions
// ---------------------------------------------------------------------
plug_h      = car_hole_depth - 1;               // stop 1 mm short of the floor
plug_r_top  = (car_hole_top_d    - plug_clearance) / 2;
plug_r_bot  = (car_hole_bottom_d - plug_clearance) / 2;

// tumbler diameter at height h above its base (linear taper model)
function tumbler_d_at(h) =
    tumbler_bottom_d + (tumbler_top_d - tumbler_bottom_d) * min(h, tumbler_body_h) / tumbler_body_h;

bore_r_bot  = (tumbler_bottom_d          + cup_clearance) / 2;
bore_r_top  = (tumbler_d_at(cup_depth)   + cup_clearance) / 2;
bore_slope  = (bore_r_top - bore_r_bot) / cup_depth;   // dr/dz
function bore_r(z) = bore_r_bot + bore_slope * (z - floor_z);

cup_r_out_bot = bore_r_bot + wall;
cup_r_out_top = bore_r_top + wall;

off = [cup_offset * cos(cup_offset_angle), cup_offset * sin(cup_offset_angle), 0];

// 45-degree transition from plug to cup: height = largest radial step
trans_h = max(cup_r_out_bot + cup_offset - plug_r_top, 1);
neck_z  = plug_h + cup_lift;    // top of the plug + optional neck
cup_z0  = neck_z + trans_h;     // where the straight cup wall begins
floor_z = cup_z0 + 1;           // top surface of the cup floor
top_z   = floor_z + cup_depth;  // rim

// spring tabs: free end near the rim, root lower down
tab_tip_z  = top_z - 8;
tab_len    = min(tab_length, tab_tip_z - (floor_z + 3));
tab_root_z = tab_tip_z - tab_len;
bump_flat  = 4;

// hollow plug: cylinder cavity with a 45-degree conical roof (no supports)
cav_r     = plug_r_top - plug_wall;
cav_apex  = floor_z - 3;                     // keep >= 3 mm of floor at the centre
cav_cyl_h = min(plug_h - plug_wall, cav_apex - cav_r);

echo(str("Overall height: ", top_z, " mm  (", top_z - plug_h, " mm above the console)"));
echo(str("Tumbler base sits ", floor_z - plug_h, " mm above the console, cup holds ", cup_depth, " of ", tumbler_body_h, " mm"));
echo(str("Plug: ", 2*plug_r_bot, " -> ", 2*plug_r_top, " mm, ", plug_h, " mm long"));
echo(str("Cup bore: ", 2*bore_r_bot, " -> ", 2*bore_r_top, " mm, outer ", 2*cup_r_out_top, " mm"));

// ---------------------------------------------------------------------
//  Parts
// ---------------------------------------------------------------------
module plug_solid(r_bot = plug_r_bot, r_top = plug_r_top, h = plug_h, c = chamfer) {
    hull() {
        cylinder(r = r_bot - c, h = eps);
        translate([0, 0, c]) cylinder(r = r_bot, h = eps);
        translate([0, 0, h - eps]) cylinder(r = r_top, h = eps);
    }
}

module outer_body() {
    plug_solid();
    if (cup_lift > 0)
        translate([0, 0, plug_h - eps]) cylinder(r = plug_r_top, h = cup_lift + 2 * eps);
    // plug -> cup transition (45 degrees, prints without supports)
    hull() {
        translate([0, 0, neck_z - eps]) cylinder(r = plug_r_top, h = eps);
        translate(off + [0, 0, cup_z0]) cylinder(r = cup_r_out_bot, h = eps);
    }
    translate(off + [0, 0, cup_z0])
        cylinder(r1 = cup_r_out_bot, r2 = cup_r_out_top, h = top_z - cup_z0);
}

module bore() {
    translate(off + [0, 0, floor_z])
        cylinder(r1 = bore_r_bot, r2 = bore_r_top + bore_slope, h = cup_depth + 1);
    // lead-in chamfer on the inner rim
    translate(off + [0, 0, top_z - chamfer])
        cylinder(r1 = bore_r_top, r2 = bore_r_top + chamfer + 0.5, h = chamfer + 0.5);
}

module outer_rim_chamfer() {
    c = chamfer * 0.6;
    translate(off + [0, 0, top_z - c])
        difference() {
            cylinder(r = cup_r_out_top + 1, h = c + 1);
            cylinder(r1 = cup_r_out_top, r2 = cup_r_out_top - c - 1, h = c + 1);
        }
}

// U-shaped slot through the wall; the tongue stays attached at the bottom
module tab_slot_cutter() {
    r_in = bore_r_bot - 2;
    depth = (bore_r_top - bore_r_bot) + wall + 6;
    difference() {
        translate([r_in, -(tab_width / 2 + tab_slot), tab_root_z])
            cube([depth, tab_width + 2 * tab_slot, tab_len + tab_slot]);
        translate([r_in - 1, -tab_width / 2, tab_root_z - 1])
            cube([depth + 2, tab_width, tab_len + 1]);
    }
}

// Wedge-shaped bump on the inside of the tongue, 45-degree ramps both ways
module tab_bump_shape() {
    zb = tab_tip_z - 2 - (2 * tab_bump + bump_flat);
    r  = bore_r(zb + tab_bump + bump_flat / 2);
    rotate([90, 0, 0])
        linear_extrude(height = tab_width - 3, center = true)
            polygon([
                [r + 1,          zb],
                [r,              zb],
                [r - tab_bump,   zb + tab_bump],
                [r - tab_bump,   zb + tab_bump + bump_flat],
                [r,              zb + 2 * tab_bump + bump_flat],
                [r + 1,          zb + 2 * tab_bump + bump_flat]
            ]);
}

module tab_positions() {
    for (i = [0 : tab_count - 1])
        translate(off) rotate([0, 0, 90 + i * 360 / tab_count]) children();
}

module plug_cavity() {
    // the plug tapers, so follow the taper to keep the wall even
    r_b = plug_r_bot - plug_wall;
    translate([0, 0, -1]) cylinder(r1 = r_b, r2 = r_b + (cav_r - r_b) * (cav_cyl_h + 1) / plug_h, h = cav_cyl_h + 1 + eps);
    r_c = r_b + (cav_r - r_b) * cav_cyl_h / plug_h;
    translate([0, 0, cav_cyl_h]) cylinder(r1 = r_c, r2 = 0.5, h = r_c - 0.5);  // 45-degree roof
}

module holder() {
    difference() {
        outer_body();
        bore();
        outer_rim_chamfer();
        if (hollow_plug && cav_cyl_h > 2)
            plug_cavity();
        if (drain_d > 0)
            translate([0, 0, -1]) cylinder(d = drain_d, h = floor_z + 2, $fn = 48);
        if (tab_count > 0) tab_positions() tab_slot_cutter();
    }
    if (tab_count > 0) tab_positions() tab_bump_shape();
}

// ---------------------------------------------------------------------
//  Fit test: print this first (~40 min, ~25 g)
//   - inner piece: hollow copy of the plug, printed upside down on a lip.
//     Push it into the car's cup holder: it should go in fully, snug, no rattle.
//   - outer ring: same diameter as the bottom of the cup. Slide it over the
//     tumbler's base: it should slide on with ~1 mm of play all round.
// ---------------------------------------------------------------------
module fit_test() {
    g = 1.2;   // gauge wall (3 lines with a 0.4 mm nozzle)
    // plug gauge (upside down: wide end on the bed)
    difference() {
        union() {
            cylinder(r = plug_r_top + 4, h = 2);
            translate([0, 0, 2]) cylinder(r1 = plug_r_top, r2 = plug_r_bot, h = plug_h);
        }
        translate([0, 0, -1]) cylinder(r1 = plug_r_top - g, r2 = plug_r_bot - g, h = plug_h + 4);
    }
    // cup gauge ring (bottom of cup), nested around the plug gauge
    difference() {
        cylinder(r = bore_r_bot + 1.6, h = 10);
        translate([0, 0, -1]) cylinder(r = bore_r_bot, h = 12);
    }
    // if the tumbler is tapered, a second ring for the top of the cup
    if (bore_r_top - bore_r_bot > 0.3)
        translate([bore_r_bot + bore_r_top + 3.2 + 5, 0, 0])
            difference() {
                cylinder(r = bore_r_top + 1.6, h = 10);
                translate([0, 0, -1]) cylinder(r = bore_r_top, h = 12);
            }
}

if (part == "fit_test") fit_test();
else holder();
