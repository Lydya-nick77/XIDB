# FFXI Atlas (XIDB)

XIDB is an Ashita v4 addon that provides a multi-module FFXI atlas UI:

- Crafting recipe browser
- Item browser (search + details + recipe cross-reference)
- Zone map browser
- List of Notorious Monsters, their location and their drop list (TBD)
- BCNM / KSNM browser (TBD)
- HENM browser (TBD)

## Modules

### Crafting

- Browse recipes by craft skill and ranks.
- Supports skill subcategory selection:
	- Alchemy
	- Bonecrafting
	- Clothcraft
	- Cooking
	- Goldsmithing
	- Leathercraft
	- Smithing
	- Woodworking

### Items Browser

- Builds/loads an indexed item database for fast local searching.
- Search supports:
	- Exact and partial item name
	- Log names (singular/plural)
	- Description
	- Item ID 
	- Dropped by
- Left pane: result list with live filter.
- Right pane: Crafting Recipes split into two columns:
	- Created By
	- Used As Ingredient
- Recipe ingredient/result entries are clickable when a matching indexed item is found.

### Maps

- Area-based zone browser.
- Zone list on the left, map preview on the right.
- Supports multiple map variants per zone via a dropdown (`Map 1`, `Map 2`, etc.).

### NM

- Zone search or use the search bar to search the NM by name.
- Display information on the NM with the drops.

### BCNM

- List the BCNM per level
- Provide the description of the selected BCNM and drops. 

### KSNM

- List the BCNM per level
- Provide the description of the selected BCNM and drops.

### HENM

- Provide all the informations about each HENM fights

### EXP Camps

- List of Experience, Merit and Mana burn camps per level

## Commands

Current slash command support:

- `/xidb` toggles the main window.

Note: Scan and filter actions are currently performed in the Item Browser UI (buttons/inputs).

## Data Sources

- Item/resource data: Ashita resource manager
- Crafting recipes: `recipes/*.lua`
- Craft rank ranges: `ranks.lua`
- Zones and areas: `zones.lua`
- Map images: `assets/maps/*`
- BCNM data: `bcnm/*.lua`
- KSNM data: `ksnm/*.lua`
- HENM data: `henm/*.lua`

