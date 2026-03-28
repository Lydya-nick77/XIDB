# FFXI Atlas (XIDB)

XIDB is an Ashita v4 addon that provides a multi-module FFXI atlas UI:

- Crafting recipe browser
- Item browser (search + details + recipe cross-reference)
- Zone map browser
- List of Notorious Monsters, their location and their drop list (TBD)

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
- For each recipe, shows:
	- Recipe name and level
	- Crystal
	- Main skill and subcraft handling
	- Ingredient list
	- HQ1/HQ2/HQ3 results (when available)

### Items Browser

- Builds/loads an indexed item database for fast local searching.
- Search supports:
	- Exact and partial item name
	- Log names (singular/plural)
	- Description
	- Item ID 
- Left pane: result list with live filter.
- Middle pane: selected item details:
	- ID
	- Level
	- Stack size
	- Type
	- Jobs mask 
	- Slots mask 
	- Names and description
	- If the item is dropped by a NM, it will show the name.
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

## Item Index And Cache

- Item data is scanned from Ashita resource manager when needed.
- Indexed item cache is saved to:
	- `XIDB/items/item_cache.json`
- On load, XIDB attempts to read cache first for faster startup.
- If cache is unavailable/invalid, XIDB rebuilds index from resources.

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


## Notes

- First-time indexing can take longer than cache-backed startup.
- Item fields depend on what the current Ashita resources expose.
