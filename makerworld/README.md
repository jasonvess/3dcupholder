# MakerWorld upload kit

Everything you need to publish the V2 holder on MakerWorld so others can print it. Uploading needs your own MakerWorld account, so you do the clicks. This kit has the files and the text.

| Folder | What's in it |
|---|---|
| `files/` | `polo-aw-tumbler-holder-v2.stl`, `polo-aw-tumbler-holder-v2-fit-test.stl`, and `polo_aw_nespresso_cupholder.scad` (the parametric source) |
| `images/` | `1-cover.png` (use as the cover) and four gallery images, 1408 × 1056 px |

## Part A: publish the model page (about 10 minutes)

1. Sign in at [makerworld.com](https://makerworld.com) and click **Upload**.
2. Add the three files from `files/` as model files.
   The `.scad` file is what gives the page a **Customize** button. MakerWorld checks the script when you upload it. If it parses, anyone can type in their own cup holder measurements and get a matching model.
3. Add the images from `images/`, with `1-cover.png` as the cover.
4. Copy the title, summary, description and tags from below.
5. Pick a category (a car or automotive one, if offered), a license and the visibility.
6. Publish.

Once the page is up, your colleague can open it and either:
- download the STLs and print them in Bambu Studio with the settings in the description, or
- use **Customize** to enter their own measurements first.

## Part B: add a print profile (after your first print)

A print profile is what gives the page MakerWorld's one-click **Print** option. MakerWorld requires a Bambu Studio project file and **at least one real photo of a part printed with it**, so this step comes after you've printed one.

1. In Bambu Studio (a release version, not a beta), select your printer (P2S, 0.4 mm nozzle) and a PETG filament.
2. Put the fit test on plate 1. Add a plate and put the holder on plate 2.
3. Set: wall loops **4**, top/bottom shell layers **5**, sparse infill **15 % gyroid**, supports **off**.
4. Slice and print. Take a photo of the printed part, ideally in the car.
5. Save the project (`.3mf`). On the model page, click **Add Print Profile**, then upload the `.3mf` and the photo.

If MakerWorld's slicing check rejects the profile, try uploading only one plate.

---

## Listing text (copy and paste)

**Title**

```
VW Polo AW Cup Holder Adapter for Nespresso Travel Tumbler
```

**Summary**

```
Plugs into the octagonal centre-console cup holder of a VW Polo 6 (AW, 2017-2021) and holds the 92.7 mm Nespresso Travel Tumbler. Spring tabs, no supports, customizable.
```

**Description**

```
The Nespresso Travel Tumbler (Samra Origins, 540 ml) is 92.7 mm wide, too big for the VW Polo's centre-console cup holders. This adapter plugs into one of the Polo's octagonal holders and gives the tumbler a wide, deep cup.

FEATURES
- Octagonal plug that matches the Polo's cup holder, so it can't spin
- 3 spring tabs grip the tumbler so it doesn't rattle (they take up about +/- 1 mm)
- Drain hole for condensation from iced drinks
- Prints upright with no supports (all overhangs 45 degrees)
- Hollow plug to save filament

FITS
- Car: VW Polo 6 (AW / 2G), pre-facelift 2017-2021, centre-console cup holders
- Cup: Nespresso Travel Tumbler 540 ml (body 92.7 x 120 mm). Any cup or bottle about 90-94 mm wide should work.

IMPORTANT: MEASURE FIRST
VW doesn't publish the cup holder size. The plug assumes 74 mm across two opposite flat sides at the rim, 71 mm at the floor, and 50 mm deep. Print the fit test first (about 40 min, 25 g):
- the octagonal gauge should go all the way into the cup holder without wobbling
- the ring should slide over the tumbler's base with about 1 mm of play
If yours differs, click Customize and enter your own measurements.

SIZE
Holder: 99.5 x 99.5 x 128 mm. It stands 79 mm above the console and holds the bottom 65 mm of the tumbler.

PRINT SETTINGS
- Material: PETG or ASA. Not PLA: a parked car gets hot enough to soften it.
- Orientation: as exported, plug on the bed. No supports.
- Layer height 0.2 mm, 4 walls, 5 top/bottom layers, 15 % gyroid infill
- About 120-150 g and 4-7 hours

CUSTOMIZE OPTIONS
Cup holder size and depth, plug clearance, round or octagonal plug, tumbler diameter (including tapered cups), cup depth, spring tab strength, cup offset (to clear the handbrake) and cup lift (to clear console trim).

IF IT DOESN'T FIT
- Plug wobbles: lower plug_clearance, or add 1 mm felt tape
- Plug won't go in: raise plug_clearance
- Tumbler rattles: raise tab_bump to 2.5
- Cup hits the handbrake: set cup_offset and turn the adapter so the offset points away from the lever
```

**Tags**

```
Volkswagen, VW Polo, Polo AW, Polo 6, cup holder, cup holder adapter, Nespresso, travel tumbler, car accessory, car interior
```
