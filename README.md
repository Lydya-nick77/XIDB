# XIDB

XIDB is an Ashita v4 addon that builds a searchable item database from the client item resources already exposed by Ashita.

## What it does

- Scans Ashita item resources and indexes all discovered items.
- Opens an ImGui browser with a live search field.
- Searches item names, descriptions, and item ids.
- Shows per-item details including level, stack size, flags, job, and slot.

## Commands

- `/xidb` toggles the database window.
- `/xidb help` shows command help.
- `/xidb scan` rebuilds the item index.
- `/xidb clear` clears the current search filter.
- `/xidb find <text>` searches the index.
- `/xidb id <itemid>` jumps directly to an item by id.

## Notes

- The database is currently backed by Ashita resource data, not a bundled external item dump.
- Because of that, the visible fields depend on what the Ashita resource manager exposes for your client resources.
- The first scan may take a moment, especially if auto-scan is enabled.