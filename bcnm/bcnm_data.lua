-- BCNM Database for XIDB
-- Category: BCNM
-- Total BCNMs: 43

local M = {}

M.bcnm_list = {
    {
        name = '3, 2, 1...',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Waughroon Shrine',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Time Bomb x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Bomb',
            },
        },
        note = 'Countdown begins at 60 seconds. | The bomb has 9999HP, and must be killed before it self-destructs, doing 9999 damage to everyone. | During the countdown it doesn\'t attack at all.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'Petrified Log (20%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Kageboshi (50%)',
                    'Odenta (50%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Ocean Belt (20%)',
                    'Forest Belt (20%)',
                    'Steppe Belt (20%)',
                    'Jungle Belt (20%)',
                    'Desert Belt (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Freeze (12.5%)',
                    'Quake (12.5%)',
                    'Raise II (12.5%)',
                    'Regen III (12.5%)',
                    'Fire Spirit Pact (12.5%)',
                    'Light Spirit Pact (12.5%)',
                },
            },
        },    },
    {
        name = 'Amphibian Assault',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Sacrificial Chamber',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Hyohh the Conchblower',
                level = 'Unknown',
                job = 'Bard',
                type = 'Sahagin',
            },
            {
                name = 'Pevv the Riverleaper',
                level = 'Unknown',
                job = 'Dragoon',
                type = 'Sahagin',
            },
            {
                name = 'Qull the Fallstopper',
                level = 'Unknown',
                job = 'Monk',
                type = 'Sahagin',
            },
            {
                name = 'Rauu the Whaleswooner',
                level = 'Unknown',
                job = 'White Mage',
                type = 'Sahagin',
            },
        },
        note = 'All have the Sahagin special attacks. | Hyohh the Conchblowe has Soul Voice. | Pevv the Riverleaper has Call Wyvern. | Qull the Fallstropper has Hundred Fists. | Rauu the Whaleswooner has Benediction. | All are susceptible to Lullaby and Sleep.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'Summoning Torque (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Enfeebling Torque (25%)',
                    'Divine Torque (25%)',
                    'Shield Torque (25%)',
                    'String Torque (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Elemental Torque (25%)',
                    'Evasion Torque (25%)',
                    'Guarding Torque (25%)',
                    'Enhancing Torque (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Platinum Beastcoin (50%)',
                    'Coral Fragment (22.2%)',
                    'Malboro Fiber (1%)',
                    'Steel Ingot (11.1%)',
                    'Ebony Log (5.6%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Vile Elixir +1 (5.6%)',
                    'Hi-Reraiser (5.6%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Fire Spirit Pact (12.5%)',
                    'Absorb-STR (12.5%)',
                    'Erase (12.5%)',
                    'Phalanx (12.5%)',
                    'Raise II (12.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Water Ore (12.5%)',
                    'Wind Ore (12.5%)',
                    'Ice Ore (12.5%)',
                    'Lightning Ore (12.5%)',
                    'Light Ore (12.5%)',
                    'Fire Ore (12.5%)',
                    'Dark Ore (12.5%)',
                    'Earth Ore (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Platinum Beastcoin (80%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Fluorite (1%)',
                    'Painite (5%)',
                    'Sunstone (1%)',
                    'Jadeite (15%)',
                    'Aquamarine (5%)',
                    'Moonstone (15%)',
                    'Yellow Rock (5%)',
                    'Red Rock (5%)',
                    'White Rock (10%)',
                    'Green Rock (5%)',
                    'Translucent Rock (10%)',
                    'Chrysoberyl (15%)',
                    'Black Rock (5%)',
                    'Purple Rock (5%)',
                },
            },
        },
    },
    {
        name = 'An Awful Autopsy',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Chahnameed\'s Stomach',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Doomed',
            },
            {
                name = 'Chahnameed\'s Intestines',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Doomed',
            },
            {
                name = 'Chahnameed\'s Liver',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Doomed',
            },
        },
        note = 'All use Doomed special attacks. It also uses a special attack called Infernal Pestilence which cause diseased and minor damage. It is the equivalent of Undead Mold. | At first there is only Chahnameed\'s Stomach. | At 50% health Chahnameed\'s Intestines will spawn and at 33% Chahnameed\'s Liver. These two are weaker than Chahnameed\'s Stomach. | It is possible to sleep the organs.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Undead Skin',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Quake (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Darksteel Ingot (20%)',
                    'Ebony Log (20%)',
                    'Petrified Log (20%)',
                    'Gold Ingot (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Rival Ribbon (25%)',
                    'Super Ribbon (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Hateful Collar (20%)',
                    'Storm Gorget (20%)',
                    'Intellect Torque (20%)',
                    'Benign Necklace (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Ivory Mitts (25%)',
                    'Rush Gloves (25%)',
                    'Sly Gauntlets (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Heavy Mantle (20%)',
                    'Esoteric Mantle (20%)',
                    'Sniper\'s Mantle (20%)',
                    'Templar\'s Mantle (20%)',
                },
            },
        },
    },
    {
        name = 'Birds of a Feather',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Waughroon Shrine',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Macha x 1',
                level = 'Unknown',
                job = 'Red Mage',
                type = 'Bird',
            },
            {
                name = 'Neman x 2',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Bird',
            },
        },
        note = 'All have the Bird special attacks. | Macha is the brown bird, the 2 Nemans are the pink birds. | Macha also casts Sleepga and Dispelga. | It is possible to Charm the Nemans but may take a few tries. | Sleep will land, but probably won\'t last very long.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Bird Feather (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Avatar Belt (12.5%)',
                    'HorizonXI specific changes Pilferer\'s Belt (12.5%)',
                    'HorizonXI specific changes Wyvern Belt (12.5%)',
                    'HorizonXI specific changes Warlock\'s Belt (12.5%)',
                    'Sarashi (12.5%)',
                    'Scythe Belt (12.5%)',
                    'Shield Belt (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Dispel (12.5%)',
                    'Erase (12.5%)',
                    'Magic Finale (12.5%)',
                    'Utsusemi: Ni (12.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Ashigaru Earring (12.5%)',
                    'Trimmer\'s Earring (12.5%)',
                    'Beater\'s Earring (12.5%)',
                    'Healer\'s Earring (12.5%)',
                    'Mercenary\'s Earring (12.5%)',
                    'Singer\'s Earring (12.5%)',
                    'Wizard\'s Earring (12.5%)',
                    'Wrestler\'s Earring (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Bird Egg (12.5%)',
                    'Bird Feather (5%)',
                    'Chestnut Log (12.5%)',
                    'Elm Log (18.8%)',
                    'Hi-Ether (6.3%)',
                    'Horn Quiver (31.3%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Iron Ingot (6.3%)',
                    'Lapis Lazuli (12.5%)',
                    'Light Opal (12.5%)',
                    'Mythril Ingot (6.3%)',
                    'Mythril Ore (6.3%)',
                    'Onyx (25%)',
                    'Silver Ore (6.3%)',
                    'Silver Ingot (12.5%)',
                },
            },
        },
    },
    {
        name = 'Brothers D\'Aurphe',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Disfaurit B D\'Aurphe',
                level = 'Unknown',
                job = 'Thief',
                type = 'Shadow',
            },
            {
                name = 'Jeumouque B D\'Aurphe',
                level = 'Unknown',
                job = 'Ranger',
                type = 'Shadow',
            },
            {
                name = 'Maldaramet B D\'Aurphe',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Shadow',
            },
            {
                name = 'Vaicoliaux B D\'Aurphe',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Shadow',
            },
        },
        note = 'Vaicoliaux B D\'Aurphe has Mighty Strikes. | Maldaramet B D\'Aurphe has Manafont. | Disfaurit B D\'Aurphe has Perfect Dodge. (Can Counter) | Jeumouque B D\'Aurphe has Eagle Eye Shot. | All are susceptible to Gravity and Bind (Sleep will be resisted somewhat, but not with Elemental Seal). | Lullaby has very high resistance. | All are able to use Shadow AND Fomor TP moves',
        rewards = {
            {
                group = 'One of',
                items = {
                    'Mythril Ingot (30.2%)',
                    'Blue Chip (1.9%)',
                    'Black Chip (3.8%)',
                    'Purple Chip (1%)',
                    'Green Chip (1.9%)',
                    'Mahogany Log (1%)',
                    'Red Rock (1%)',
                    'Black Rock (1%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Creek M Clomps (12.5%)',
                    'Creek F Clomps (12.5%)',
                    'Marine M Boots (12.5%)',
                    'Marine F Boots (12.5%)',
                    'Wood M Ledelsens (12.5%)',
                    'Wood F Ledelsens (12.5%)',
                    'Dune Sandals (12.5%)',
                    'River Gaiters (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'HorizonXI specific changes Vali\'s Bow (4.3%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Flare (28.3%)',
                    'Valor Minuet IV (35.8%)',
                    'Reraise II (26.4%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'HorizonXI specific changes Retaliators (4.3%)',
                    'Chrysoberyl (1%)',
                    'Jadeite (9.4%)',
                    'Sunstone (11.3%)',
                    'Zircon (7.5%)',
                    'Clear Chip (1%)',
                    'Red Chip (3.8%)',
                    'Yellow Chip (3.8%)',
                    'Gold Ingot (15.1%)',
                    'Purple Rock (1.9%)',
                    'White Rock (1.9%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Hi-Potion (11.3%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Steel Ingot (13.2%)',
                    'Translucent Rock (11.3%)',
                    'Darksteel Ingot (11.3%)',
                    'Painite (5%)',
                    'Ebony Log (13.2%)',
                    'White Chip (1%)',
                    'Moonstone (15.1%)',
                    'Zircon (7.5%)',
                    'Fluorite (5.7%)',
                    'Chrysoberyl (5.7%)',
                    'Green Rock (3.8%)',
                    'Hi-reraiser (3.8%)',
                    'Vile Elixir +1 (3.8%)',
                },
            },
        },
    },
    {
        name = 'Carapace Combatants',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Horlais Peak',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Pilwiz',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Beetle',
            },
            {
                name = 'Bisan',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Beetle',
            },
        },
        note = 'All have the Beetle special attacks. | Bisan is the green Beetle on the right, Pilwiz is the brown Beetle on the left. | Bisan uses physical attacks and Beetle special attacks. | Pilwiz uses magical attacks, such as Stonega II. Pilwiz is susceptible to Silence.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Beetle Jaw (100%)',
                    'Beetle Shell (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Scarlet Sap (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Scarlet Sap (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Dispel (12.5%)',
                    'Utsusemi: Ni (12.5%)',
                    'Fire II (12.5%)',
                    'Magic Finale (12.5%)',
                    'Absorb-AGI (12.5%)',
                    'Absorb-INT (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Darksteel Ore (14%)',
                    'Mythril Ingot (14%)',
                    'Silver Ingot (14%)',
                    'Steel Ingot (14%)',
                    'Mythril Ore (14%)',
                    'Sardonyx (14%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Katana Obi (15%)',
                    'HorizonXI specific changes Wizard\'s Belt (15%)',
                    'Song Belt (15%)',
                    'Cestus Belt (15%)',
                    'Pick Belt (15%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Hi-Ether (10%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Genin Earring (12.5%)',
                    'Magician\'s Earring (12.5%)',
                    'Pilferer\'s Earring (12.5%)',
                    'Warlock\'s Earring (12.5%)',
                    'Wrestler\'s Earring (12.5%)',
                    'Wyvern Earring (12.5%)',
                    'Killer Earring (12.5%)',
                },
            },
        },
    },
    {
        name = 'Celery',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Annihilated Anthony x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Ghost',
            },
            {
                name = 'Shredded Samson x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Ghost',
            },
            {
                name = 'Punctured Percy x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Ghost',
            },
            {
                name = 'Mauled Murdock x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Ghost',
            },
        },
        note = '',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Libation Abjuration',
                    'Oblation Abjuration',
                    'Rainbow Cloth',
                    'Silk Cloth x3',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Walkure Mask (5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Dem Ring (25%)',
                    'Mea Ring (25%)',
                    'Nursemaid\'s Harp (25%)',
                    'Trailer\'s Kukri (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Elusive Earring (25%)',
                    'Hi-Ether Tank (25%)',
                    'Hi-Potion Tank (25%)',
                    'Knightly Mantle (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Aquamarine (5%)',
                    'Chrysoberyl (5%)',
                    'Darksteel Ingot (10%)',
                    'Ebony Log (5%)',
                    'Fluorite (5%)',
                    'Gold Ingot (5%)',
                    'Hi-Reraiser (5%)',
                    'Jadeite (5%)',
                    'Mahogany Log (5%)',
                    'Moonstone (5%)',
                    'Mythril Ingot (5%)',
                    'Painite (5%)',
                    'Red Rock (5%)',
                    'Steel Ingot (5%)',
                    'Sunstone (5%)',
                    'Translucent Rock (5%)',
                    'White Rock (5%)',
                    'Vile Elixir +1 (5%)',
                    'Zircon (5%)',
                },
            },
        },
    },
    {
        name = 'Creeping Doom',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Balga\'s Dais',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Bitoso x 1',
                level = '38',
                job = 'White Mage',
                type = 'Crawler',
            },
        },
        note = 'Bitoso has all the Crawler special attacks. | Can cast Paralyga and will frequently Cure III himself. | Very high resistance to Silence. Elemental Seal is advised. | Has limited MP, will be unable to cast Cure III after several Aspirs',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Silk Thread (100%)',
                    '3,000 Gil (100%)',
                },
            },
            {
                group = 'Unknown Grouping',
                items = {
                    'HorizonXI specific changes Shepherd\'s Hose (???%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Bast Parchment (40%)',
                    'Hi-Potion (10%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Chestnut Log (25%)',
                    'Hi-Ether (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Erase (15%)',
                    'Dispel (20%)',
                    'Magic Finale (25%)',
                    'Utsusemi: Ni (15%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Silk Thread (30%)',
                },
            },
            {
                group = 'Zero to Two of',
                items = {
                    'Singer\'s Earring (4%) / (2%)',
                    'Ashigaru Earring (5%) / (2%)',
                    'Magician\'s Earring (5%) / (2%)',
                    'Warlock\'s Earring (5%) / (2%)',
                    'Healer\'s Earring (4%) / (2%)',
                    'Esquire\'s Earring (4.5%) / (2%)',
                    'Wizard\'s Earring (5%) / (2%)',
                    'Wyvern Earring (4%) / (2%)',
                    'Mercenary\'s Earring (5%) / (2%)',
                    'Killer Earring (4.5%) / (2%)',
                    'Wrestler\'s Earring (4.5%) / (2%)',
                    'Genin Earring (5%) / (2%)',
                    'Beater\'s Earring (5%) / (2%)',
                    'Pilferer\'s Earring (4.5%) / (2%)',
                    'Trimmer\'s Earring (5%) / (2%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Silk Thread (10%)',
                },
            },
            {
                group = 'Zero to Zwo of',
                items = {
                    'Amber (5%)',
                    'Darksteel Ore (5%)',
                    'Elm Log (5%)',
                    'Iron Ingot (5%)',
                    'Iron Ore (5%)',
                    'Lapis Lazuli (5%)',
                    'Mythril Ingot (5%)',
                    'Mythril Ore (5%)',
                    'Onyx (5%)',
                    'Sardonyx (5%)',
                    'Silver Ingot (5%)',
                    'Silver Ore (5%)',
                    'Steel Ingot (5%)',
                    'Tourmaline (5%)',
                    'Light Opal (5%)',
                },
            },
        },
    },
    {
        name = 'Crustacean Conundrum',
        level = '20',
        orb_required = 'Cloudy Orb',
        zone = 'Waughroon Shrine',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Heavy Metal Crab x 1',
                level = 'Unknown',
                job = 'Red Mage',
                type = 'Crab',
            },
            {
                name = 'Metal Crab x 2',
                level = 'Unknown',
                job = 'Paladin',
                type = 'Crab',
            },
        },
        note = 'You can only do 0-1 damage no matter what your attack is. | ::Heavy Metal Crab has 35 HP. | ::Metal Crabs have 25 HP. | All have the Crab special attacks. | Heavy Metal Crab casts Waterga, Bio and Blind. | Their physical attacks sometimes have additional effect Drain that takes ~30 HP. | All are susceptible to Bind; the Heavy Metal Crab can be Silenced. | Crabs are immune to charm. | Crabs seem to have massive regen during Watersday.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Land Crab Meat (100%)',
                    'Mannequin Body (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Crab Shell (66.6%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Brass Ingot (10%)',
                    'Bronze Sheet (15%)',
                    'Bronze Ingot (30%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mythril Beastcoin (50%)',
                    'Mannequin Hands (10%)',
                    'Mannequin Head (10%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Beetle Quiver (44.4%)',
                    'Fish Oil Broth (55.6%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Platoon Cesti (10%)',
                    'Platoon Dagger (10%)',
                    'Platoon Axe (10%)',
                    'Platoon Bow (10%)',
                    'Platoon Lance (10%)',
                    'Platoon Sword (10%)',
                    'Platoon Mace (10%)',
                    'Platoon Zaghnal (10%)',
                },
            },
        },
    },
    {
        name = 'Demolition Squad',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Nephiyl Keepcollapser',
                level = 'Unknown',
                job = 'Monk',
                type = 'Gigas',
            },
            {
                name = 'Nephiyl Moatfiller',
                level = 'Unknown',
                job = 'Beastmaster',
                type = 'Gigas',
            },
            {
                name = 'Nephiyl Pinnacletosser',
                level = 'Unknown',
                job = 'Ranger',
                type = 'Gigas',
            },
            {
                name = 'Nephiyl Rampartbreacher',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Gigas',
            },
        },
        note = 'All have the Gigas special attacks. | Nephiyl MoatFiller has Familiar. | Nephiyl Pinnacletosser has Eagle Eye Shot. | Nephiyl Rampartbreacher has Mighty Strikes. | Nephiyl Keepcollapser has Hundred Fists. | All are susceptible to Gravity and Bind, and all except Nephiyl Moatfiller are susceptible to Lullaby.',
        rewards = {
            {
                group = 'One of',
                items = {
                    'Marine M Gloves (12.5%)',
                    'Marine F Gloves (12.5%)',
                    'Wood Gauntlets (12.5%)',
                    'Wood Gloves (12.5%)',
                    'Creek M Mitts (12.5%)',
                    'Creek F Mitts (12.5%)',
                    'River Gauntlets (12.5%)',
                    'Dune Bracers (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Hi-Potion +3 (7.5%)',
                    'Hi-Reraiser (15%)',
                    'Vile Elixir (5%)',
                    'Vile Elixir +1 (2.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mythril Ingot (12.5%)%',
                    'Ebony Log (12.5%)',
                    'Petrified Log (12.5%)',
                    'Aquamarine (12.5%)',
                    'Painite (12.5%)',
                    'Chrysoberyl (12.5%)',
                    'Moonstone (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Reraise II (12.5%)',
                    'Flare (12.5%)',
                    'Valor Minuet IV (12.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Red Chip (12.5%)',
                    'Blue Chip (12.5%)',
                    'Yellow Chip (12.5%)',
                    'Green Chip (12.5%)',
                    'Clear Chip (12.5%)',
                    'Purple Chip (12.5%)',
                    'White Chip (12.5%)',
                    'Black Chip (12.5%)',
                },
            },
        },
    },
    {
        name = 'Die by the Sword',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Gladiatorial Weapon x 3',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Evil Weapons',
            },
        },
        note = 'Each Gladiatorial Weapon monster has 3 weapons floating above it; either 3 spears, 3 swords, or 3 clubs. These weapons represent the only damage which the Gladiatorial Weapon is vulnerable to at any given time. If the weapons above the monster are swords, only slashing weapons can damage the monster; all attacks from blunt and piercing sources will be zero. Similarly clubs represent vulnerability to blunt damage and absolute immunity to piercing and slashing, and spears represent vulnerability to piercing. | After each use of TP, the monster that used TP will display a 2-hour animation and the weapons floating above its head will change types, indicating a shift in vulnerabilities. | The monsters are immune to sleep, charm, lullaby, and elemental magic damage at all times. They are vulnerable to bind and gravity. | Weapons all have the following attacks: | Smite of Rage (single-target single-hit damage; can be blocked by shadows) | Whirl of Rage (AoE Stun + damage; can be blocked by shadows, shoots 2 shadows) | Furious Flurry (single-target multi-hit low damage; can be blocked by shadows) | Smite of Fury (single-target single-hit damage; can be blocked by shadows) | Whispers of Ire (AoE drain 3 stats; can be blocked by shadows)',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Rusty Pick (100%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Erase (20%)',
                    'Dispel (20%)',
                    'Magic Finale (20%)',
                    'Utsusemi: Ni (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Gold Ingot (5%)',
                    'Platinum Ingot (5%)',
                    'Petrified Log (5%)',
                    'Rusty Greatsword (7.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mannequin Head (25%)',
                    'Mannequin Body (25%)',
                    'Mannequin Hands (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Avatar Belt (7.1%)',
                    'Axe Belt (7.1%)',
                    'Cestus Belt (7.1%)',
                    'HorizonXI specific changes Pilferer\'s Belt (7.2%)',
                    'Gun Belt (7.2%)',
                    'Katana Obi (7.1%)',
                    'HorizonXI specific changes Wyvern Belt (7.1%)',
                    'Sarashi (7.2%)',
                    'Scythe Belt (7.2%)',
                    'Shield Belt (7.2%)',
                    'Song Belt (7.1%)',
                    'HorizonXI specific changes Wizard\'s Belt (7.1%)',
                    'Pick Belt (7.1%)',
                    'HorizonXI specific changes Warlock\'s Belt (7.1%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Ashigaru Earring (7.1%)',
                    'Esquire\'s Earring (7.1%)',
                    'Magician\'s Earring (7.2%)',
                    'Mercenary\'s Earring (7.2%)',
                    'Pilferer\'s Earring (7.2%)',
                    'Singer\'s Earring (7.1%)',
                    'Trimmer\'s Earring (7.1%)',
                    'Warlock\'s Earring (7.2%)',
                    'Wizard\'s Earring (7.2%)',
                    'Wrestler\'s Earring (7.2%)',
                    'Wyvern Earring (7.1%)',
                    'Beater\'s Earring (7.1%)',
                    'Genin Earring (7.1%)',
                    'Killer Earring (7.1%)',
                },
            },
        },
    },
    {
        name = 'Dismemberment Brigade',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Horlais Peak',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Armsmaster Dekbuk',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Orc',
            },
            {
                name = 'Invulnerable Mazzgozz',
                level = 'Unknown',
                job = 'Paladin',
                type = 'Orc',
            },
            {
                name = 'Keeneyed Aufwuf',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Orc',
            },
            {
                name = 'Longarmed Gottditt',
                level = 'Unknown',
                job = 'Monk',
                type = 'Orc',
            },
            {
                name = 'Mind\'s-eyed Klugwug',
                level = 'Unknown',
                job = 'Ranger',
                type = 'Orc',
            },
            {
                name = 'Undefeatable Sappdapp',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Orc',
            },
        },
        note = 'All have the Orc special attacks. | Armsmaster Dekbuk has Mighty Strikes. | Invulnerable Mazzgozz has Invincible and casts Cure IV, Protect III and Banish III. | Keeneyed Aufwuf has Manafont. | Longarmed Gottditt has Hundred Fists. | Mind\'s-eyed Klugwug has Eagle Eye Shot. | Undefeatable Sappdapp has Blood Weapon and casts Bio II and Fire II. | All are susceptible to Lullaby and Sleep.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'Vile Elixir +1 (10%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Kabrakan\'s Axe (25%)',
                    'Sarnga (25%)',
                    'Dragvandil (25%)',
                    'Hamelin Flute (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Translucent Rock (20%)',
                    'Green Rock (20%)',
                    'Yellow Rock (20%)',
                    'Purple Rock (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Spectacles (20%)',
                    'Assault Earring (20%)',
                    'Peace Ring (20%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Painite (10%)',
                    'Jadeite (10%)',
                    'Mythril Ingot (10%)',
                    'Steel Ingot (10%)',
                    'Fluorite (10%)',
                    'Gold Ingot (10%)',
                    'Zircon (10%)',
                    'Chrysoberyl (10%)',
                    'Darksteel Ingot (10%)',
                    'Moonstone (10%)',
                },
            },
        },
    },
    {
        name = 'Divine Punishers',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Balga\'s Dais',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Aa Nawu the Thunderblade',
                level = 'Unknown',
                job = 'Samurai',
                type = 'Yagudo',
            },
            {
                name = 'Cuu Doko the Blizzard',
                level = 'Unknown',
                job = 'White Mage',
                type = 'Yagudo',
            },
            {
                name = 'Yoo Mihi the Haze',
                level = 'Unknown',
                job = 'Ninja',
                type = 'Yagudo',
            },
            {
                name = 'Voo Tolu the Ghostfist',
                level = 'Unknown',
                job = 'Monk',
                type = 'Yagudo',
            },
            {
                name = 'Gii Jaha the Raucous',
                level = 'Unknown',
                job = 'Bard',
                type = 'Yagudo',
            },
            {
                name = 'Zuu Xowu the Darksmoke',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Yagudo',
            },
        },
        note = 'All have the Yagudo special attacks. | Aa Nawu the Thunderblade has Meikyo Shisui. | Cuu Doko the Blizzard has Benediction. | Gii Jaha the Raucous has Soul Voice. | Voo Tolu the Ghostfist has Hundred Fists. | Yoo Mihi the Haze has Mijin Gakure. | Zuu Xowu the Darksmoke has Manafont.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'HorizonXI specific changes Sarutobi Kyahan (10%)',
                    'Peace Ring (20%)',
                    'Enhancing Mantle (20%)',
                    'Master Belt (15%)',
                    'HorizonXI specific changes Ochimusha Kote (10%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Hi-Reraiser (10%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Forseti\'s Axe (25%)',
                    'Aramis\'s Rapier (25%)',
                    'Spartan Cesti (25%)',
                    'Dominion Mace (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Steel Ingot (35%)',
                    'Mythril Ingot (15%)',
                    'Darksteel Ingot (15%)',
                    'Gold Ingot (35%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Purple Rock (16.6%)',
                    'Translucent Rock (16.6%)',
                    'Red Rock (16.7%)',
                    'Black Rock (16.7%)',
                    'Yellow Rock (16.7%)',
                    'White Rock (16.7%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mahogany Log (33.3%)',
                    'Ebony Log (15%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Painite (12.5%)',
                    'Aquamarine (12.5%)',
                    'Fluorite (12.5%)',
                    'Zircon (12.5%)',
                    'Sunstone (12.5%)',
                    'Chrysoberyl (12.5%)',
                    'Moonstone (12.5%)',
                    'Jadeite (12.5%)',
                },
            },
        },
    },
    {
        name = 'Dropping Like Flies',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Horlais Peak',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Huntfly x 1',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Fly',
            },
            {
                name = 'Houndfly x 8',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Fly',
            },
        },
        note = 'Houndflies only use Venom. | Houndflies are resistant to Horde Lullaby, but can be slept with Sleep. | Huntfly uses Cursed Sphere, and Somersault (single target damage). | Huntfly casts Aero, Gravity, and Choke. | Huntfly can be Gravitied, Bound, and Silenced. | Huntfly cannot be slept. | Sleepga being level 31, it is unavailable for this fight. Diabolos\' Nightmare should be able to land, but it has not been tested. Sheep Song seems to have no effect. | Houndflies have around 900HP, Huntfly has about 1800. | The Huntfly and Houndflies have shared hate. Actions taken against one will generate hate from the others at a reduced rate.',
        rewards = {
            {
                group = 'All of',
                items = {
                    '4,000 gil',
                    'Insect Wing',
                    'Mannequin Head',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mercenary Mantle (25%)',
                    'Singer\'s Mantle (25%)',
                    'Wizard\'s Mantle (25%)',
                    'Wyvern Mantle (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'HorizonXI specific changes Empress Hairpin (36.4%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Ashigaru Targe (17.5%)',
                    'Beater\'s Aspis (17.5%)',
                    'Varlet\'s Targe (17.5%)',
                    'Wrestler\'s Aspis (17.5%)',
                    'Clear Topaz (10%)',
                    'Lapis Lazuli (10%)',
                    'Light Opal (10%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Utsusemi: Ni (7%)',
                    'Magic Finale (7%)',
                    'Quadav Bug Broth (15%)',
                    'Onyx (10%)',
                    'Lapis Lazuli (10%)',
                    'Light Opal (10%)',
                    'Dispel (15%)',
                    'Erase (10%)',
                    'Elm Log (9%)',
                    'Mannequin Body (7%)',
                },
            },
        },
    },
    {
        name = 'Eye of the Tiger',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Horlais Peak',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Gerjis',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Tiger',
            },
        },
        note = 'Gerjis uses Tiger special attacks, Crossthrash (high damage and knock-back), and a debuff attack. | It has extremely high melee evasion, but can be debuffed. | Roar - AoE Paralyze | Gerjis\' Grip - Stun - seems to be gaze attack never got hit with back turned. | Crossthrash - AOE Damage skill.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Black Tiger Fang x2',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Nue Fang (30%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Gold Ingot (12.5%)',
                    'Ram Horn (12.5%)',
                    'Wyvern Skin (12.5%)',
                    'Ebony Log (12.5%)',
                    'Mythril Ingot (12.5%)',
                    'Ram Skin (12.5%)',
                    'Coral Fragment (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Buffalo Meat (20%)',
                    'Dragon Meat (20%)',
                    'Coeurl Meat (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Ivory Mitts (12.5%)',
                    'Super Ribbon (12.5%)',
                    'Mana Circlet (12.5%)',
                    'Rival Ribbon (12.5%)',
                    'Sly Gauntlets (12.5%)',
                    'Shock Mask (12.5%)',
                    'Spiked Finger Gauntlets (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Freeze (12.5%)',
                    'Raise II (12.5%)',
                    'Quake (12.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Intellect Torque (12.5%)',
                    'Esoteric Mantle (12.5%)',
                    'Templar\'s Mantle (12.5%)',
                    'Sniper\'s Mantle (12.5%)',
                    'Hateful Collar (12.5%)',
                    'Storm Gorget (12.5%)',
                    'Heavy Mantle (12.5%)',
                    'Benign Necklace (12.5%)',
                },
            },
        },
    },
    {
        name = 'Factory Rejects',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Doll Factory',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Doll',
            },
            {
                name = 'Generic Doll x 5',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Doll',
            },
        },
        note = 'All have the Doll special attacks. | The Generic Doll is summoned one at a time by the Doll Factory | The Generic Doll is susceptible to Gravity and Bind. | The Generic Doll will spawn one at a time, the Doll Factory must be kept alive until all Generic Dolls have been killed.',
        rewards = {
            {
                group = 'Unknown Groupings',
                items = {
                    'HorizonXI specific changes Shepherd\'s Bracers (???%)',
                    'HorizonXI specific changes Enlight (15%)',
                },
            },
            {
                group = 'All of',
                items = {
                    'Doll Shard',
                    'Mercury',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Rearguard Mantle (40%)',
                    'Agile Mantle (40%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Utsusemi: Ni (12.5%)',
                    'Phalanx (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Gold Beastcoin (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Raifu (25%)',
                    'Buzzard Tuck (25%)',
                    'Jongleur\'s Dagger (25%)',
                },
            },
        },
    },
    {
        name = 'Grove Guardians',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Waughroon Shrine',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Metsanhaltija x 2',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Sapling',
            },
            {
                name = 'Metsanneitsyt x 1',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Sapling',
            },
        },
        note = 'All have the Sapling\'s special attacks and are resistant to sleep. | Metsanneitsyt also casts Stonega, Stone II, Drain and Aspir. | All are susceptible to Bind and Gravity. | Saplings have a tendency to cast Slumber Powder.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Mannequin Body',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mannequin Hands (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Scorpion Quiver (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Wrestler\'s Mantle (25%)',
                    'Magician\'s Mantle (25%)',
                    'Pilferer\'s Mantle (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Healer\'s Shield (20%)',
                    'Genin Aspis (20%)',
                    'Killer Targe (20%)',
                    'HorizonXI specific changes Wizard\'s Belt (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Herb Seeds (25%)',
                    'Vegetable Seeds (25%)',
                    'Grain Seeds (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Dispel (12.5%)',
                    'Utsusemi: Ni (12.5%)',
                    'Magic Finale (12.5%)',
                    'Erase (12.5%)',
                },
            },
        },
    },
    {
        name = 'Harem Scarem',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Balga\'s Dais',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Nenaunir x 1',
                level = 'Unknown',
                job = 'Red Mage',
                type = 'Dhalmel',
            },
            {
                name = 'Nenaunir\'s Wife x 5',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Dhalmel',
            },
        },
        note = 'All have the Dhalmel special attacks. | Nenaunir can cast Diaga, Bind and Stone II. | All are immune to Charm and Lullaby. | Nenaunir is immune to Sleep and Silence. | Nenaunir\'s Wife is susceptible to Sleep, Silence, and Soporific. | All are susceptible to Bind and Gravity.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Dhalmel Hide (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Giant Femur (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Dhalmel Meat (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Velvet Cloth (25%)',
                    'Linen Cloth (25%)',
                    'Wool Cloth (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Wizard\'s Shield (20%)',
                    'Trimmer\'s Aspis (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mercenary Mantle (15%)',
                    'Beater\'s Mantle (15%)',
                    'Esquire\'s Mantle (15%)',
                    'Healer\'s Mantle (15%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mannequin Head (20%)',
                    'Mannequin Hands (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Erase (20%)',
                    'Dispel (20%)',
                    'Magic Finale (20%)',
                    'Utsusemi: Ni (20%)',
                },
            },
        },
    },
    {
        name = 'Hostile Herbivores',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Horlais Peak',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Fighting Sheep x 3',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Sheep',
            },
        },
        note = 'All have the Sheep special attacks. All are susceptible to Gravity, and partially resistant to Bind. | The Sheep\'s melee attacks cause knockback. | All are highly resistant to Ice elemental magic (including Freeze and Bind). | Sheep are not Charmable. | Immune to sleep. | Poison Pots highly recomended for Sheep Song | Sheep can attack very fast. | Sheep seem to build resistance to spells over time.',
        rewards = {
            {
                group = 'Zero to Two of',
                items = {
                    'Quake (17.6%)',
                    'Light Spirit Pact (1%)',
                    'Freeze (17.6%)',
                    'Regen III (17.6%)',
                    'Reraiser (6%)',
                    'Vile Elixir (6%)',
                    'Raise II (17.6%)',
                },
            },
            {
                group = 'Zero to Two of',
                items = {
                    'Ram Horn (5.9%)',
                    'Mahogany Log (5.9%)',
                    'Mythril Ingot (200%)',
                    'Manticore Hide (5.9%)',
                    'Wyvern Scales (9%)',
                    'Wyvern Skin (9%)',
                    'Petrified Log (17.6%)',
                    'Darksteel Ingot (5.9%)',
                    'Ram Skin (5.9%)',
                    'Platinum Ingot (9%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Ocean Belt (9.5%)',
                    'Jungle Belt (9.5%)',
                    'Steppe Belt (9.5%)',
                    'Desert Belt (9.5%)',
                    'Forest Belt (9.5%)',
                    'Ocean Stone (9.5%)',
                    'Jungle Stone (9.5%)',
                    'Steppe Stone (9.5%)',
                    'Desert Stone (9.5%)',
                    'Forest Stone (9.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Guardian\'s Ring (6.4%)',
                    'Kampfer Ring (6.5%)',
                    'Conjurer\'s Ring (6.5%)',
                    'Shinobi Ring (6.5%)',
                    'Slayer\'s Ring (6.5%)',
                    'Sorcerer\'s Ring (6.5%)',
                    'Soldier\'s Ring (6.4%)',
                    'Tamer\'s Ring (6.5%)',
                    'Tracker\'s Ring (6.4%)',
                    'Drake Ring (6.5%)',
                    'Fencer\'s Ring (6.5%)',
                    'Minstrel\'s Ring (6.5%)',
                    'Medicine Ring (6.4%)',
                    'Rogue\'s Ring (6.5%)',
                    'Ronin Ring (6.5%)',
                    'Platinum Ring (3%)',
                },
            },
        },
    },
    {
        name = 'Idol Thoughts',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Earth Golem x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Golems',
            },
            {
                name = 'Fire Golem x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Golems',
            },
            {
                name = 'Water Golem x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Golems',
            },
            {
                name = 'Wind Golem x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Golems',
            },
        },
        note = 'All have the Golem special attacks. All are susceptible to Gravity.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Golem Shard',
                    'Granite',
                },
            },
            {
                group = 'One of',
                items = {
                    'Libation Abjuration (50%)',
                    'Oblation Abjuration (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Libation Abjuration (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mythril Ore (30%)',
                    'Gold Ingot (30%)',
                    'Platinum Ingot (30%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Optical Needle (20%)',
                    'Kakanpu (20%)',
                    'Mantra Coin (20%)',
                    'Nazar Bonjuk (20%)',
                },
            },
        },
    },
    {
        name = 'Jungle Boogymen',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Sacrificial Chamber',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Cyaneous-toed Yallberry',
                level = 'Unknown',
                job = 'Ninja',
                type = 'Tonberry',
            },
            {
                name = 'Sable-tongued Gonberry',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Tonberry',
            },
            {
                name = 'Virid-faced Shanberry',
                level = 'Unknown',
                job = 'Thief',
                type = 'Tonberry',
            },
            {
                name = 'Vermilion-eared Noberry',
                level = 'Unknown',
                job = 'Summoner',
                type = 'Tonberry',
            },
        },
        note = 'All use the Tonberry special attacks | Cyaneous-toed Yallberry has Mijin Gakure, Sable-tounged Gonberry has Manafont, Vermillion-eared Noberry has Astral Flow, and Virid-faced Shanberry has Perfect Dodge. | All are susceptible to Sleep; Lullaby is possible, but difficult. | Both Astral Flow and Mijin Gakure can inflict heavy damage on the party. It\'s possible for weaker mages to run back towards door to get out of range.',
        rewards = {
            {
                group = 'One of',
                items = {
                    'Dark Torque (25%)',
                    'Elemental Torque (25%)',
                    'Healing Torque (25%)',
                    'Wind Torque (25%)',
                },
            },
            {
                group = 'One of:',
                items = {
                    'Platinum Beastcoin (50%)',
                    'Scroll of Absorb-STR (2.8%)',
                    'Scroll of Erase (14.3%)',
                    'Scroll of Phalanx (11.9%)',
                    'Fire Spirit Pact (4.8%)',
                    'Dark Ore (4.8%)',
                    'Fire Ore (4.8%)',
                    'Ice Ore (4.8%)',
                    'Light Ore (4.8%)',
                    'Lightning Ore (4.8%)',
                    'Earth Ore (4.8%)',
                    'Water Ore (4.8%)',
                    'Wind Ore (4.6%)',
                },
            },
            {
                group = 'One of:',
                items = {
                    'Enfeebling Torque (25%)',
                    'Evasion Torque (25%)',
                    'Guarding Torque (25%)',
                    'Summoning Torque (0%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Darksteel Ingot (15.4%)',
                    'Painite (15.4%)',
                    'Gold Ingot (15.4%)',
                    'Aquamarine (7.7%)',
                    'Vile Elixir +1 (7.7%)',
                    'Mythril Ingot (15.3%)',
                    'Chrysoberyl (3%)',
                    'Sunstone (3%)',
                    'Moonstone (3%)',
                    'Zircon (0%)',
                    'Aquamarine (3%)',
                    'Ebony Log (3%)',
                    'Mahogany Log (3%)',
                    'Philosopher\'s Stone (3%)',
                },
            },
            {
                group = 'One of:',
                items = {
                    'Platinum Beastcoin (83.3%)',
                    'Ice Ore (16.7%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Darksteel Ingot (7.7%)',
                    'Moonstone (13.4%)',
                    'Steel Ingot (15.4%)',
                    'Chrysoberyl (5%)',
                    'Hi-Reraiser (15.4%)',
                    'Jadeite (12.1%)',
                    'Malboro Fiber (1%)',
                    'Beetle Blood (1%)',
                    'Blue Rock (3%)',
                    'Green Rock (3%)',
                    'Purple Rock (3%)',
                    'Red Rock (3%)',
                    'White Rock (3%)',
                    'Yellow Rock (3%)',
                    'Black Rock (3%)',
                    'Translucent Rock (3%)',
                    'Fluorite (5%)',
                },
            },
        },
    },
    {
        name = 'Kindred Spirits',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Throne Room',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Count Andromalius',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Demon',
            },
            {
                name = 'Duke Amduscias',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Demon',
            },
            {
                name = 'Grand Marquis Chomiel',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Demon',
            },
            {
                name = 'Duke Dantalian',
                level = 'Unknown',
                job = 'Summoner',
                type = 'Demon',
            },
            {
                name = 'Demon\'s Avatar x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Avatar',
            },
            {
                name = 'Demon\'s Elemental x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Elemental',
            },
        },
        note = 'Demons have the Demon special attacks. | Duke Amduscias has Flood, Bind, Stonega III. | Count Andromalius uses Absorb spells. | All are susceptible to Gravity and Bind; Lullaby and Sleep work very rarely.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Demon Horn',
                },
            },
            {
                group = 'One of',
                items = {
                    'Forseti\'s Axe (20%)',
                    'Aramis\'s Rapier (20%)',
                    'Spartan Cesti (20%)',
                    'Sairen (20%)',
                    'Archalaus\'s Pole (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Carnage Elegy (29%)',
                    'Ice Spirit Pact (29%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Vassago\'s Scythe (25%)',
                    'Kabrakan\'s Axe (25%)',
                    'Dragvandil (25%)',
                    'Hamelin Flute (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Light Boomerang (20%)',
                    'Armbrust (20%)',
                    'Schwarz Lance (20%)',
                    'Omokage (20%)',
                    'Archalaus\'s Pole (20%)',
                },
            },
        },
    },
    {
        name = 'Legion XI Comitatensis',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Chamber of Oracles',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Centurio XI-I',
                level = 'Unknown',
                job = 'Ranger',
                type = 'Antica',
            },
            {
                name = 'Hoplomachus XI-XXVI',
                level = 'Unknown',
                job = 'Paladin',
                type = 'Antica',
            },
            {
                name = 'Retiarius XI-XIX',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Antica',
            },
            {
                name = 'Secutor XI-XXXII',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Antica',
            },
        },
        note = 'All have the Antican special attacks. | Centurio XI-I has Eagle Eye Shot. | Hoplomachus XI-XXVI has Invincible. | Retiarius XI-XIX has Manafont. | Secutor XI-XXXII has Mighty Strikes.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'Divine Torque (5%)',
                    'Dark Torque (5%)',
                    'Enhancing Torque (5%)',
                    'Enfeebling Torque (5%)',
                    'Elemental Torque (5%)',
                    'Healing Torque (5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Chunk of Water Ore (5%)',
                    'Ice Ore (5%)',
                    'Lightning Ore (5%)',
                    'Earth Ore (5%)',
                    'Fire Ore (5%)',
                    'Light Ore (5%)',
                    'Dark Ore (5%)',
                    'Wind Ore (5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Raise II (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Vile Elixir +1 (5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Evasion Torque (15%)',
                    'Parrying Torque (15%)',
                    'Guarding Torque (15%)',
                    'Ninjutsu Torque (15%)',
                    'Wind Torque (15%)',
                    'Summoning Torque (15%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Yellow Rock (5%)',
                    'White Rock (5%)',
                    'Ebony Log (12.5%)',
                    'Platinum Beastcoin (77.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Sunstone (10%)',
                    'Gold Ore (10%)',
                    'Jadeite (10%)',
                    'Fluorite (10%)',
                    'Darksteel Ingot (10%)',
                    'Zircon (10%)',
                    'Chrysoberyl (10%)',
                    'Moonstone (10%)',
                    'Painite (10%)',
                    'Steel Ingot (10%)',
                },
            },
        },
    },
    {
        name = 'Let Sleeping Dogs Die',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Capelthwaite',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Hound',
            },
            {
                name = 'Guytrash',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Hound',
            },
            {
                name = 'Freybug',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Hound',
            },
            {
                name = 'Rongeur D\'os',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Hound',
            },
        },
        note = 'All have the Hound special attacks. | All appear to be immune or highly resistant to Sleep and Lullaby.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Wolf Hide (100%)',
                    'Revival Tree Root (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mannequin Head (30%)',
                    'Mannequin Body (30%)',
                    'Mannequin Hands (30%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Absorb-AGI (12.5%)',
                    'Absorb-INT (12.5%)',
                    'Absorb-VIT (12.5%)',
                    'Erase (12.5%)',
                    'Utsusemi: Ni (12.5%)',
                    'Dispel (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Singer\'s Shield (15%)',
                    'Warlock\'s Shield (15%)',
                    'Magician\'s Shield (15%)',
                    'Ashigaru Mantle (15%)',
                    'Wizard\'s Mantle (15%)',
                    'Killer Mantle (15%)',
                },
            },
        },
    },
    {
        name = 'Petrifying Pair',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Ghelsba Outpost',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Kilioa x 1',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Lizard',
            },
            {
                name = 'Kalamainu x 1',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Lizard',
            },
        },
        note = 'The lizards will use Secretion at the beginning of the fight. | They will use Baleful Gaze frequently at full TP. | Baleful Gaze can be stunned, or avoided by turning your back to it in time. | They are immune to Sleep, Lullaby, Sheep Song & Soporific. | The lizards attack much faster than normal lizards. | Kalamainu \'\'may\'\' gain resistance to Gravity and Bind with each spell resulting in a shorter duration each time. | Kilioa is much stronger then Kalamainu which is why it is suggested to be taken out first while the healer or kiter has a larger MP pool.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Lizard Skin',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Bounding Boots HorizonXI specific changes',
                },
            },
            {
                group = 'Zero to Two of',
                items = {
                    'Steel Ingot (10%)',
                    'Elm Log (35%)',
                    'Chestnut Log (17.5%)',
                    'HorizonXI specific changes Warlock\'s Belt (7.5%)',
                    'Scythe Belt (17.5%)',
                    'Katana Obi (5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Iron Ore (13.1%)',
                    'Mythril Ore (7.9%)',
                    'Iron Ingot (13.1%)',
                    'Silver Ore (7.9%)',
                    'Lapis Lazuli (13.1%)',
                    'Pick Belt (10.5%)',
                    'Avatar Belt (10.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Erase (7.9%)',
                    'Dispel (10.5%)',
                    'Absorb-VIT (28.9%)',
                    'Absorb-AGI (26.3%)',
                    'Absorb-INT (21%)',
                    'Utsusemi: Ni (7.9%)',
                    'Magic Finale (42.1%)',
                    'Cold Carrion Broth (55.2%)',
                },
            },
            {
                group = 'Zero to Two of',
                items = {
                    'Mythril Ingot (20%)',
                    'Darksteel Ore (10%)',
                    'Silver Ingot (10%)',
                    'Light Opal (7.5%)',
                    'Onyx (2.5%)',
                    'Tourmaline (12.5%)',
                    'Clear Topaz (1%)',
                    'Hi-Ether (17.5%)',
                    'HorizonXI specific changes Healer\'s Belt (17.5%)',
                    'Axe Belt (20%)',
                    'Cestus Belt (12.5%)',
                    'HorizonXI specific changes Wizard\'s Belt (15%)',
                    'HorizonXI specific changes Pilferer\'s Belt (7.5%)',
                    'Shield Belt (10%)',
                    'Song Belt (10%)',
                    'Gun Belt (2.5%)',
                    'Sarashi (25%)',
                    'HorizonXI specific changes Wyvern Belt (20%)',
                },
            },
        },
    },
    {
        name = 'Rapid Raptors',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Balga\'s Dais',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Dromiceiomimus x 2',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Raptor',
            },
        },
        note = 'The Dromiceiomimus have Raptor special attacks.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Raptor Skin',
                    'Adaman Ingot',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Reraiser (44%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mythril Ingot (20%)',
                    'Iron Ore (20%)',
                    'Petrified Log (37%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Sly Gauntlets (1%)',
                    'Spiked Finger Gauntlets (12%)',
                    'Rush Gloves (14%)',
                    'Rival Ribbon (14%)',
                    'Mana Circlet (15%)',
                    'Ivory Mitts (15%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Storm Gorget (10%)',
                    'Intellect Torque (10%)',
                    'Benign Necklace (12%)',
                    'Heavy Mantle (13%)',
                    'Hateful Collar (17%)',
                    'Esoteric Mantle (17%)',
                    'Templar\'s Mantle (18%)',
                },
            },
        },
    },
    {
        name = 'Royal Jelly',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Waughroon Shrine',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Queen Jelly x 1 (Possible)',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Slime',
            },
            {
                name = 'Princess Jelly x 8',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Slime',
            },
        },
        note = 'Do not cast Bind or Gravity in this fight due to certain issues with the fight, It is still do-able but enter at your own risk. Confirmed 7/22/2025. | When you enter the battlefield, the eight Princess Jellies will be in a large circle, far apart from each other. | When combat starts, the Jellies slowly move to the center of the battlefield. They cannot be aggroed or Provoked from their paths. The Princess Jellies who are allowed to reach the center will merge into a far more powerful Queen Jelly. This Jelly\'s HP will be directly dependent on the number of jellies allowed to reach the center; a Queen Jelly formed from one Princess Jelly will have much less HP than one formed from all eight. | All enemies encountered in this fight possess Slime special attacks. | Each Princess Jelly is representative of one element. Each will cast magic dependent on her element, and will be weak to that element\'s opposite element. \'\'\'Note:\'\'\' There can be more than one jelly of the same element. | One of the following pairs of magic will be assigned to each Princess Jelly: | :*Burn/Fire | :*Drown/Water | :*Shock/Thunder | :*Rasp/Stone | :*Choke/Aero | :*Frost/Blizzard | :*Dia/Banish | :*Bio/Drain | :In addition, all Princess Jellies are capable of using Bind. They Use Bind frequently. | All Jellies in this battle are immune to Sleep and all related forms of Sleep effect (such as Lullaby). They are highly susceptible, however, to Gravity, Bind, and Silence. | When a jelly gets to the center it becomes invulnerable until it morphs into the Queen Jelly. | Each Princess Jelly has about 600hp.',
        rewards = {
            {
                group = 'Unknown Groupings',
                items = {
                    'HorizonXI specific changes Enlight (15%)',
                    'HorizonXI specific changes Buffalo Helm (???%)',
                },
            },
            {
                group = 'All of',
                items = {
                    'Slime Oil x2',
                },
            },
            {
                group = 'One of',
                items = {
                    'Archer\'s Ring (9.1%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mana Ring (46.9%)',
                    'Grudge Sword (15.2%)',
                    'De Saintre\'s Axe (12%)',
                    'Buzzard Tuck (11.8%)',
                    'Utsusemi: Ni (10.6%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Marksman\'s Ring (25.8%)',
                    'Dusky Staff (15.2%)',
                    'Himmel Stock (10.1%)',
                    'Sealed Mace (9.8%)',
                    'Shikar Bow (9.8%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Absorb-STR (12.3%)',
                    'Erase (16.5%)',
                    'Phalanx (14%)',
                    'Fire Spirit Pact (14.5%)',
                    'Steel Sheet (22.9%)',
                    'Steel Ingot (23.8%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Refresh (12.6%)',
                    'Ice Spikes (24.6%)',
                    'Utsusemi: Ni (17.1%)',
                    'Gold Beastcoin (18.2%)',
                    'Mythril Beastcoin (13.3%)',
                    'Peridot (2.7%)',
                    'Turquoise (2%)',
                    'Black Pearl (1.5%)',
                    'Goshenite (1.5%)',
                    'Sphene (1.5%)',
                    'Ametrine (1%)',
                    'Garnet (0.7%)',
                    'Black Rock (1.2%)',
                    'Green Rock (0.7%)',
                    'White Rock (0.7%)',
                    'Blue Rock (0.2%)',
                    'Translucent Rock (0.2%)',
                    'Oak Log (0.5%)',
                    'Rosewood Log (0.5%)',
                    'Vile Elixir (1%)',
                    'Reraiser (0.2%)',
                },
            },
        },
    },
    {
        name = 'Royal Succession',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Balga\'s Dais',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Opo-opo Monarch',
                level = 'Unknown',
                job = 'Red Mage',
                type = 'Opo-opo',
            },
            {
                name = 'Opo-opo Heir',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Opo-opo',
            },
            {
                name = 'Myrmidon Apu-apu',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Opo-opo',
            },
            {
                name = 'Myrmidon Epa-epa',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Opo-opo',
            },
            {
                name = 'Myrmidon Spo-spo',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Opo-opo',
            },
        },
        note = 'All have the Opo-opo special attacks. | Opo-opo Monarch can cast Hastega, Slowga and Stonega. | Opo-opo Monarch and Opo-opo Heir have 2300 HP each; Myrmidon Apu-apu, Myrmidon Epa-epa, and Myrmidon Spo-spo each have approximately 1200 HP. | Myrmidon Apu-apu, Myrmidon Epa-epa, and Myrmidon Spo-spo are resistant to sleep. Opo-opo Monarch and Opo-opo Heir are immune to sleep. | Opo-opo Monarch and Opo-opo Heir \'\'\'must\'\'\' be killed at the \'\'exact\'\' same time, such as with an AoE attack or spell. Otherwise, the surviving one will regain 50% of his HP, receive a massive attack boost, and become invulnerable to either physical or magical damage. | Opo-opo Heir will follow players, but not use any attacks (even when he is attacked) until the Opo-opo Monarch is killed.',
        rewards = {
            {
                group = 'Unknown Groupings',
                items = {
                    'HorizonXI specific changes Enlight (15%)',
                },
            },
            {
                group = 'All of',
                items = {
                    'Wild Pamamas',
                },
            },
            {
                group = 'One of',
                items = {
                    'Phalanx (25%)',
                    'Absorb-INT (25%)',
                    'Refresh (25%)',
                    'Erase (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Genin Earring (30%)',
                    'Agile Gorget (30%)',
                    'Jagd Gorget (30%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Turquoise (10%)',
                    'Pamamas (10%)',
                    'Silk Cloth (11%)',
                    'Rosewood Log (14%)',
                    'Pearl (18%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Gold Beastcoin (40%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Dusky Staff (10%)',
                    'Jongleur\'s Dagger (10%)',
                    'Calveley\'s Dagger (10%)',
                    'Sealed Mace (10%)',
                    'Himmel Stock (10%)',
                    'Kagehide (10%)',
                    'Ohaguro (10%)',
                },
            },
        },
    },
    {
        name = 'Shooting Fish',
        level = '20',
        orb_required = 'Cloudy Orb',
        zone = 'Horlais Peak',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Sniper Pugil x 1',
                level = 'Unknown',
                job = 'Ranger',
                type = 'Pugil',
            },
            {
                name = 'Archer Pugil x 2',
                level = 'Unknown',
                job = 'Ranger',
                type = 'Pugil',
            },
        },
        note = 'The Pugils in this BCNM are equipped with a ranged bubble attack (that they will use like a regular attack). This attack causes knock-back and makes the Pugils hard to kill with a traditional party of a Tank, a Healer, and a Damage Dealer. This attack is not affected by Perfect Dodge.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'Shepherd\'s Bonnet HorizonXI specific changes (???%)',
                },
            },
            {
                group = 'All of',
                items = {
                    'Mannequin Head (100%)',
                    'Shall Shell (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mannequin Body (7%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Scroll of Blaze Spikes (18%)',
                    'Scroll of Horde Lullaby (51%)',
                    'Thunder Spirit Pact (28%)',
                    'Scroll of Warp (3%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Pugil Scales (19%)',
                    'Shall Shell (14%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mythril Beastcoin (30%)',
                    'Black Rock (7%)',
                    'Purple Rock (3%)',
                    'White Rock (10%)',
                    'Platoon Bow (10%)',
                    'Platoon Disc (10%)',
                    'Platoon Gun (15%)',
                    'Platoon Mace (15%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mythril Beastcoin (31%)',
                    'Green Rock (5%)',
                    'Yellow Rock (4%)',
                    'Blue Rock (4%)',
                    'Red Rock (4%)',
                    'Translucent Rock (11%)',
                    'Platoon Cesti (13%)',
                    'Platoon Cutter (10%)',
                    'Platoon Spatha (8%)',
                    'Platoon Zaghnal (10%)',
                },
            },
        },
    },
    {
        name = 'Shots in the Dark',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Horlais Peak',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Orcish Onager',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Warmachine',
            },
        },
        note = 'Orcish Onager uses Warmachine special attacks. | Can cast Bindga. | Uses ranged Warmachine Special Attacks at approximately a regular attack rate. Blind and Paralyze, though they land, will not stop these attacks. They have the regular effect on Shadows for whatever the attack is. If approached, it will cast Bindga and flee to a distance, then continue the attack. | Most if not all attacks appear to be fire based, and hit for 150-220 on a Ninja in \'regular\' defensive gear. Evasion does not seem to be taken into account, or alternately it could simply be extremely accurate.',
        rewards = {
            {
                group = 'One of',
                items = {
                    'Gold Beastcoin (50%)',
                    'Mythril Beastcoin (50%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Steel Ingot (50%)',
                    'Aquamarine (50%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Sapient Cape (25%)',
                    'Trainer\'s Wristbands (25%)',
                    'Demon Quiver (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Holla Ring (40%)',
                    'Vahzl Ring (40%)',
                },
            },
        },
    },
    {
        name = 'Steamed Sprouts',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Balga\'s Dais',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
        },
        note = 'All have the Mandragora special attacks. | Dvorovoi is the Black Mandragora, the Domovois are the White Mandragora. | Dvorovoi can cast Paralyga, Blindga and Flood. | Domovoi are susceptible to Charm, Sleep, Lullaby, Bind, Paralyze.',
        rewards = {
            {
                group = 'Unknown Groupings',
                items = {
                    'HorizonXI specific changes Enlight (15%)',
                    'HorizonXI specific changes Morbolger Vine (???%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Gold Beastcoin (50%)',
                    'Mythril Beastcoin (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Refresh (12.5%)',
                    'Erase (12.5%)',
                    'Absorb-INT (12.5%)',
                    'Phalanx (12.5%)',
                    'Ice Spikes (12.5%)',
                    'Utsusemi: Ni (12.5%)',
                    'Fire Spirit Pact (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Survival Belt (10%)',
                    'Guarding Gorget (10%)',
                    'Enhancing Earring (10%)',
                    'Balance Buckler (10%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'White Rock (12.5%)',
                    'Translucent Rock (12.5%)',
                    'Purple Rock (12.5%)',
                    'Red Rock (12.5%)',
                    'Blue Rock (12.5%)',
                    'Yellow Rock (12.5%)',
                    'Green Rock (12.5%)',
                    'Black Rock (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Vile Elixir (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Garnet (5%)',
                    'Black Pearl (5%)',
                    'Ametrine (5%)',
                    'Painite (5%)',
                    'Pearl (5%)',
                    'Oak Log (10%)',
                    'Goshenite (10%)',
                    'Sphene (10%)',
                    'Rosewood Log (10%)',
                    'Turquoise (10%)',
                    'Sapphire (10%)',
                    'Peridot (15%)',
                },
            },
        },
    },
    {
        name = 'Tails of Woe',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Horlais Peak',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Helltail Harry',
                level = '45',
                job = 'Red Mage',
                type = 'Rabbit',
            },
            {
                name = 'Cottontail x 7',
                level = '38-39',
                job = 'Unknown',
                type = 'Rabbit',
            },
        },
        note = 'All have Rabbit special attacks | Helltail Harry casts Blizzard II, Slowga, Hastega. | Helltail Harry is immune to Sleep and Lullaby. | The Cottontail are susceptible to Lullaby, Sleep, and Charm.',
        rewards = {
            {
                group = 'Unknown Groupings',
                items = {
                    'HorizonXI specific changes Buffalo Helm (???%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Blitz Ring (15%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Aegis Ring (30%)',
                    'Tundra Mantle (20%)',
                    'Druid\'s Rope (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Phalanx (8.7%)',
                    'Refresh (7.5%)',
                    'Utsusemi: Ni (7.5%)',
                    'Oak Log (8%)',
                    'Rosewood Log (9.7%)',
                    'Pearl (8.6%)',
                    'Turquoise (8.8%)',
                    'Goshenite (7.9%)',
                    'Black Pearl (9.3%)',
                    'Sphene (7.9%)',
                    'Garnet (7.1%)',
                    'Ametrine (9%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Fire Spirit (14.5%)',
                    'Erase (16.5%)',
                    'Phalanx (14%)',
                    'Absorb-STR (12.3%)',
                    'Peridot (9.4%)',
                    'Pearl (9.4%)',
                    'Green Rock (1.3%)',
                    'Ametrine (5.3%)',
                    'Gold Beastcoin (7%)',
                    'Mythril Beastcoin (5%)',
                    'Yellow Rock (5.3%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Erase (12.5%)',
                    'Phalanx (11%)',
                    'Absorb-STR (10.4%)',
                    'Peridot (9.4%)',
                    'Pearl (9.4%)',
                    'Green Rock (5.3%)',
                    'Ametrine (7.3%)',
                    'Gold Beastcoin (7%)',
                    'Mythril Beastcoin (7%)',
                    'Yellow Rock (7.3%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Fire Spirit (17.4%)',
                    'Vile Elixir (1.6%)',
                    'Ice Spikes (11.4%)',
                    'Refresh (17.4%)',
                    'Utsusemi: Ni (13.8%)',
                    'Green Rock (1.8%)',
                    'Black Rock (1.8%)',
                    'Blue Rock (1.7%)',
                    'Red Rock (1.6%)',
                    'Purple Rock (1.6%)',
                    'White Rock (1.6%)',
                    'Yellow Rock (1.7%)',
                    'Translucent Rock (1.7%)',
                    'Reraiser (2.1%)',
                    'Oak Log (2.2%)',
                    'Rosewood Log (1.8%)',
                    'Gold Beastcoin (12%)',
                    'Mythril Beastcoin (10.2%)',
                    'Pearl (2.1%)',
                    'Turquoise (2.3%)',
                    'Goshenite (1.9%)',
                    'Black Pearl (1.8%)',
                    'Sphene (1.7%)',
                    'Garnet (2%)',
                    'Ametrine (1.8%)',
                },
            },
        },
    },
    {
        name = 'The Final Bout',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Waughroon Shrine',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'The Waughroon Kid x 1',
                level = 'Unknown',
                job = 'Monk',
                type = 'Goobbue',
            },
        },
        note = 'This battle has an unusual time limit, only 3 minutes. | The Waughroon Kid can gain TP \'\'very\'\' fast and can kill players fairly fast with a combination of physical attacks and Goobbue specials like Big Blow and Counterstance.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Tree Cuttings x2',
                    'Boyahda Moss',
                },
            },
            {
                group = 'One of',
                items = {
                    'Quake (10%)',
                    'Wisteria Lumber (10%)',
                    'Mahogany Log (10%)',
                    'Ebony Log (10%)',
                    'Freeze (10%)',
                    'Darksteel Ingot (10%)',
                    'Raise II (10%)',
                    'Petrified Log (10%)',
                    'Gold Ingot (10%)',
                    'Coral Fragment (10%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Shock Mask (6.2%)',
                    'Super Ribbon (6.2%)',
                    'Rival Ribbon (6.2%)',
                    'Ivory Mitts (6.2%)',
                    'Spiked Finger Gauntlets (7%)',
                    'Sly Gauntlets (6.2%)',
                    'Rush Gloves (6.2%)',
                    'Mana Circlet (6.2%)',
                    'Hateful Collar (6.2%)',
                    'Esoteric Mantle (6.2%)',
                    'Templar\'s Mantle (6.2%)',
                    'Heavy Mantle (6.2%)',
                    'Intellect Torque (6.2%)',
                    'Storm Gorget (6.2%)',
                    'Benign Necklace (6.2%)',
                    'Sniper\'s Mantle (6.2%)',
                },
            },
        },
    },
    {
        name = 'The Worm\'s Turn',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Waughroon Shrine',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
        },
        note = 'All have the Worm special attacks: | ::Bind, Rasp, Stone II, Stonega and Stonega II. | Flayer Franz does Draw In. | The Flesh Eaters are susceptible to Sleep, Lullaby, and Charm.',
        rewards = {
            {
                group = 'Unknown Groupings',
                items = {
                    'HorizonXI specific changes Buffalo Helm (???%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Black Pearl (20%)',
                    'Ametrine (20%)',
                    'Yellow Rock (20%)',
                    'Peridot (20%)',
                    'Turquoise (20%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'HorizonXI specific changes Enlight (15%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Gold Beastcoin (50%)',
                    'Mythril Beastcoin (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Fire Spirit Pact (12.5%)',
                    'Phalanx (12.5%)',
                    'Utsusemi: Ni (12.5%)',
                    'Erase (12.5%)',
                    'Ice Spikes (12.5%)',
                    'Absorb-STR (12.5%)',
                    'Refresh (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Reraiser (15%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Oak Log (50%)',
                    'Rosewood Log (50%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Enhancing Earring (12.5%)',
                    'Spirit Torque (12.5%)',
                    'Guarding Gorget (12.5%)',
                    'Nemesis Earring (12.5%)',
                    'Earth Mantle (12.5%)',
                    'Strike Shield (12.5%)',
                    'Shikar Bow (12.5%)',
                },
            },
        },
    },
    {
        name = 'Toadal Recall',
        level = '30',
        orb_required = 'Sky Orb',
        zone = 'Ghelsba Outpost',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Toadbolster',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Funguar',
            },
            {
                name = 'Toadcushion',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Funguar',
            },
            {
                name = 'Toadpillow',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Funguar',
            },
            {
                name = 'Toadsquab',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Funguar',
            },
        },
        note = 'All Funguar can use Queasyshroom (Poison effect), Shakeshroom (Disease effect), and Numbshroom (Paralyze effect) provided they have the proper shroom in the cap on their head. They do not need to build TP to use these. | May cause a dust cloud effect when they recharge the shrooms on their head. Will not happen all the time. | Each Funguar have their own special attack that they use. | Toadcushion will use Dark Spore: Cone Blind and damage. | Toadsquab will use Spore: Single target Paralyze. | Toadpillow will use Frog Kick: Single target damage. | Toadbolster will use Silence Gas: Cone Silence and damage. | Dark Spore and Silence Gas are breath attacks and can cause extreme damage if their users are still at high levels of HP. | White Mage or a White Mage Support Job for at least 2 jobs is recommended due to all the status effects. | Immune to Sleep, including from Lullaby and Sheep Song. Can be bound and weighed down. | Echo Drops are highly recommended.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'King Truffle (100%)',
                    'Seedbed Soil (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Mannequin Head (25%)',
                    'Mannequin Body (25%)',
                    'Mannequin Hands (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Utsusemi: Ni (12.5%)',
                    'Phalanx (12.5%)',
                    'Erase (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Trimmer\'s Mantle (25%)',
                    'Genin Mantle (25%)',
                    'Warlock\'s Mantle (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'HorizonXI specific changes Shepherd\'s Boots (20%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Magician\'s Shield (20%)',
                    'Mercenary\'s Targe (20%)',
                    'Beater\'s Aspis (20%)',
                    'Pilferer\'s Aspis (20%)',
                },
            },
        },
    },
    {
        name = 'Treasure and Tribulations',
        level = '50',
        orb_required = 'Comet Orb',
        zone = 'Balga\'s Dais',
        max_members = '6',
        time_limit = '30 minutes',
        mobs = {
            {
                name = 'Large Box x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Mimic',
            },
            {
                name = 'Medium Box x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Mimic',
            },
            {
                name = 'Small Box x 1',
                level = 'Unknown',
                job = 'Unknown',
                type = 'Mimic',
            },
        },
        note = 'The BC starts with all three boxes spawned in a line in the middle of the arena. One of the three boxes (At random each time you enter the BC) is an actual treasure chest. | Once a hostile action is performed on a Box, the other two boxes will despawn. If the selected box is the real one, it will turn into the Armory Crate and you win without a fight. If it is not, it will attack you and must be defeated to win. | All boxes use standard Mimic TP moves and have Draw In. | The stats of the Mimic vary by which box was selected. The Large Box will attack slower and hit harder and has higher defense/lower evasion; the Small Box attacks faster for less damage and has lower defense/higher evasion; The Medium Box has balanced stats.',
        rewards = {
            {
                group = 'One of',
                items = {
                    'Astral Ring (37.6%)',
                    'Platinum Ring (2.2%)',
                    'Quake (6.5%)',
                    'Ram Skin (1%)',
                    'Reraiser (1.1%)',
                    'Mythril Ingot (2.2%)',
                    'Light Spirit Pact (1%)',
                    'Freeze (3.2%)',
                    'Regen III (4.2%)',
                    'Raise II (3.2%)',
                    'Petrified Log (1.1%)',
                    'Coral Fragment (1.1%)',
                    'Mahogany Log (1.1%)',
                    'Platinum Ore (4.3%)',
                    'Gold Ore (10.8%)',
                    'Darksteel Ore (3.2%)',
                    'Mythril Ore (6.5%)',
                    'Gold Ingot (1.1%)',
                    'Darksteel Ingot (1.1%)',
                    'Platinum Ingot (1.1%)',
                    'Ebony Log (1.1%)',
                    'Ram Horn (1.1%)',
                    'Demon Horn (1.1%)',
                    'Manticore Hide (0.9%)',
                    'Wyvern Skin (1.1%)',
                    'Wyvern Scales (1.1%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Guardian\'s Ring (7.5%)',
                    'Kampfer Ring (3.2%)',
                    'Conjurer\'s Ring (5.4%)',
                    'Shinobi Ring (3.2%)',
                    'Slayer\'s Ring (9.5%)',
                    'Sorcerer\'s Ring (7.5%)',
                    'Soldier\'s Ring (10.8%)',
                    'Tamer\'s Ring (2.2%)',
                    'Tracker\'s Ring (6.5%)',
                    'Drake Ring (3.2%)',
                    'Fencer\'s Ring (3.2%)',
                    'Minstrel\'s Ring (8.6%)',
                    'Medicine Ring (8.6%)',
                    'Rogue\'s Ring (7.5%)',
                    'Ronin Ring (1.1%)',
                    'Platinum Ring (3.2%)',
                },
            },
        },
    },
    {
        name = 'Under Observation',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Horlais Peak',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
        },
        note = 'The most common tactic for this battle is to have one party member pull and kite the Sobbing Eyes away while the other two party members deal with the two Compound Eyes. | Due to the prevalence and danger of Hex Eye, attackers that can deal damage without facing their enemies are ideal in this battle, including jobs like NIN, BLU, and BLM. | Have wiped due to all three Eyes hitting Death Ray at the start of the fight on the same person, one-shotting them. | All enemies have an incredibly potent TP Regain effect and can use the standard specials, Hex Eye and Death Ray. Hex Eye has a tendency to be spammed repeatedly if its intended target is not already paralyzed. | :*It is highly recommended for players to always remain faced away from the enemies to avoid the incredibly potent gaze paralysis effect that Hex Eye inflicts, as well as Petrification from Petro Gaze. | Sobbing Eyes casts Firaga, Bindga, Breakga, and Stun. It can also use Petro Gaze and the self-targeted heal Catharsis when it reaches lower HP. Catharsis combined with its potent Regain effect can cause the fight to be dangerously prolonged if it is not quickly finished off when its HP is low. | :*Breakga is one of the biggest potential threats in the battle. If it is allowed to strike the entire party they will most likely suffer heavy damage or even wipe if all of the enemies are still alive. If kiting the Sobbing Eyes, ensure that distance is kept from the other party members until they have defeated the two Compound Eyes. | :*Breakga and Bindga both have large areas of effect (larger than Firaga). | Compound Eyes casts Fire II and Drain. | All enemies are susceptible to Bind and Gravity. | Sobbing Eyes is highly resistant to Silence but NOT immune. Managed to stick as a RDM/WHM. Also managed to stick it as NIN/RDM when messing around.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'HorizonXI specific changes Peacock Amulet (9%)',
                },
            },
            {
                group = 'All of',
                items = {
                    '|Hecteyes Eye',
                    'Mercury',
                    'HorizonXI specific changes Oxblood',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'Buzzard Tuck (4.2%)',
                    'De Saintre\'s Axe (7.7%)',
                    'Grudge Sword (7.3%)',
                    'Mantra Belt (25.8%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Behourd Lance (4.8%)',
                    'Mutilator (6.1%)',
                    'Raifu (4.6%)',
                    'Tilt Belt (30.2%)',
                    'Tourney Patas (7.6%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'Ametrine (5.8%)',
                    'Black Pearl (5.2%)',
                    'Garnet (5.1%)',
                    'Goshenite (6.5%)',
                    'Pearl (6.1%)',
                    'Peridot (6.3%)',
                    'Sphene (5.5%)',
                    'Turquoise (6.2%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'HorizonXI specific changes ??? TBC (???%)',
                    'Red Rock (1.6%)',
                    'Blue Rock (1.7%)',
                    'Yellow Rock (1.7%)',
                    'Green Rock (1.7%)',
                    'Translucent Rock (1.7%)',
                    'Purple Rock (1.6%)',
                    'Black Rock (1.8%)',
                    'White Rock (1.6%)',
                    'Mythril Beastcoin (10.2%)',
                    'Gold Beastcoin (12%)',
                    'Oak Log (2.2%)',
                    'Ametrine (1.8%)',
                    'Black Pearl (1.8%)',
                    'Garnet (2%)',
                    'Goshenite (1.9%)',
                    'Pearl (2.1%)',
                    'Peridot (3.5%)',
                    'Sphene (1.7%)',
                    'Turquoise (2.3%)',
                    'Reraiser (2.1%)',
                    'Vile Elixir (1.6%)',
                },
            },
        },
    },
    {
        name = 'Undying Promise',
        level = '40',
        orb_required = 'Star Orb',
        zone = 'Qu\'Bia Arena',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Ghul-I-Beaban x 3',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Skeleton',
            },
            {
                name = 'Ghul-I-Beaban x 2',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Skeleton',
            },
        },
        note = 'All have the Skeleton special attacks. | The 3 Dark Knight incarnations cast Fire, Thunder and Absorb Magic | The 2 Black Mage incarnations cast Firaga, Blizzaga, Fire II and Blizzard II. | Despite how it may appear in the index of monsters found in this BCNM, there are not 5 Skeletons. There is just 1 Skeleton which uses reraise 4 times, meaning it has to be fought 5 times in a row. The first 3 times, Ghul-I-Beaban is a DRK, the last 2 times, it is a BLM. | Each time the Skeleton reraises, it starts out with 10% less HP than the one before it, starting at 100% with the original Skeleton. | The melee attack power of the NM, along with it\'s size, increases with each new incarnation. | Can be Silenced',
        rewards = {
            {
                group = 'Unknown Groupings',
                items = {
                    'HorizonXI specific changes Enlight (15%)',
                    'HorizonXI specific changes Shepherd\'s Doublet (???%)',
                },
            },
            {
                group = 'All of',
                items = {
                    'Bone Chip x2',
                },
            },
            {
                group = 'One of',
                items = {
                    'Calveley\'s Dagger (17.5%)',
                    'Jennet Shield (17.5%)',
                    'Jongleur\'s Dagger (17.5%)',
                    'Kagehide (17.5%)',
                    'Ohaguro (17.5%)',
                    'Ebony Log (12.5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Behourd Lance (20%)',
                    'Elegant Shield (20%)',
                    'Mutilator (20%)',
                    'Raifu (20%)',
                    'Tourney Patas (20%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Coral Fragment (7.8%)',
                    'Darksteel Ingot (7.8%)',
                    'Demon Horn (7.8%)',
                    'Fire Spirit Pact (12.5%)',
                    'Gold Ore (7.8%)',
                    'Mythril Ingot (7.8%)',
                    'Petrified Log (7.8%)',
                    'Ram Horn (7.8%)',
                    'Absorb-STR (12.5%)',
                    'Erase (12.5%)',
                    'Phalanx (12.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Ram Skin (5%)',
                    'Mahogany Log (5%)',
                    'Mahogany Log (5%)',
                    'Platinum Ore (5%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Darksteel Ore (6%)',
                    'Gold Ingot (6%)',
                    'Gold Beastcoin (6%)',
                    'Mythril Beastcoin (6%)',
                    'Mythril Ingot (6%)',
                    'Platinum Ingot (6%)',
                    'Ram Horn (6%)',
                    'Refresh (12.5%)',
                    'Reraiser (14.5%)',
                    'Utsusemi: Ni (12.5%)',
                    'Ice Spikes (12.5%)',
                    'Wyvern Scales (6%)',
                },
            },
        },
    },
    {
        name = 'Charming Trio',
        level = '20',
        orb_required = 'Cloudy Orb',
        zone = 'Balga\'s Dais',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Prune x 1',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Leech',
            },
            {
                name = 'Phoedme x 1',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Leech',
            },
            {
                name = 'Pepper x 1',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Leech',
            },
        },
        note = 'Each enemy can use Leech, Drain and Aspir. | Each one has a unique TP move. Pepper uses Absorbing Kiss (Attribute Drain), Prune uses Random Kiss (randomly varies between HP, TP, or MP Drain), and Phoedme uses Deep Kiss (Status Effect Drain). | The three leeches are not charmable. | Sheep Song from a BLU/WHM was resisted by the 3 leeches.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Mannequin Hands',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mythril Beastcoin (25%)',
                    'Ganko (19%)',
                    'Wool Cloth (27%)',
                    'Platoon Disc (15%)',
                    'Grass Cloth (29.5%)',
                    'Linen Cloth (26%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Platoon Cutter (16.7%)',
                },
            },
            {
                group = 'Zero to Two of',
                items = {
                    'Fiend Blood (50%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Toad Oil (25%)',
                    'Potion (30%)',
                    'Air Spirit Pact (13%)',
                    'Cotton Cloth (28%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Platoon Edge (23.5%)',
                    'Platoon Gun (23.5%)',
                    'Platoon Spatha (23.5%)',
                    'Platoon Pole (23.5%)',
                    'Gunromaru (25.5%)',
                    'Mannequin Head (26%)',
                    'Scroll of Drain (25%)',
                    'Beastman Blood (19%)',
                },
            },
        },
    },
    {
        name = 'Grimshell Shocktroopers',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Waughroon Shrine',
        max_members = '6',
        time_limit = '30',
        mobs = {
            {
                name = 'Bi\'Fho Jestergrin',
                level = 'Unknown',
                job = 'Thief',
                type = 'Quadav',
            },
            {
                name = 'Ea\'Tho Cruelheart',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Quadav',
            },
            {
                name = 'Ka\'Nha Jabbertongue',
                level = 'Unknown',
                job = 'Black Mage',
                type = 'Quadav',
            },
            {
                name = 'Ku\'Tya Hotblood',
                level = 'Unknown',
                job = 'Paladin',
                type = 'Quadav',
            },
            {
                name = 'Yo\'Bhu Hideousmask',
                level = 'Unknown',
                job = 'Warrior',
                type = 'Quadav',
            },
            {
                name = 'Zo\'Dha Legslicer',
                level = 'Unknown',
                job = 'White Mage',
                type = 'Quadav',
            },
        },
        note = 'All have the Quadav special attacks. | Bi\'Fho Jestergrin has Perfect Dodge. | Ea\'Tho Cruelheart has Blood Weapon. | Ka\'Nha Jabbertongue has Manafont. | Ku\'Tya Hotblood has Invincible. | Yo\'Bhu Hideousmask has Mighty Strikes. | Zo\'Dha Legslicer has Benediction and casts Curaga and Curaga II. | All are susceptible to Lulluby, Sleep, and Silence.',
        rewards = {
            {
                group = 'Zero to Two of',
                items = {
                    'Raise II (12.5%)/ (20%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Ebony Log (25%)',
                    'Chrysoberyl (25%)',
                    'Fluorite (25%)',
                    'Jadeite (25%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mythril Ingot (25%)',
                    'Steel Ingot (25%)',
                    'Gold Ingot (25%)',
                    'Darksteel Ingot (25%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Assault Earring (12.5%)',
                    'Vassago\'s Scythe (12.5%)',
                    'Chicken Knife (12.5%)',
                    'Fey Wand (12.5%)',
                    'Astral Shield (12.5%)',
                    'Enhancing Mantle (12.5%)',
                },
            },
        },
    },
    {
        name = 'Up in Arms',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Waughroon Shrine',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Fe\'e',
                level = '62',
                job = 'Monk',
                type = 'Sea Monk',
            },
        },
        note = 'Fe\'e uses Sea Monk special attacks. It is susceptible to Lullaby, Bind, Blind, Gravity, Repose, and Sleep but builds resistance over time. | Lullaby only sticks 3-5 times, and will last for 2 to 15 seconds. | :*I found this to be false. With decent CHR+ gear (75 gear synced down) and an Apollo\'s staff, I was able to land 9 Lullaby before my first resist, and only the 7th and 8th had reduced time. | Has around 7000 to 7500 HP. | As damage is dealt to Fe\'e, its tentacles start to break. This happens six times, and the chat log will notify you about it in the following manner: \'\'"One of the sea creature\'s tentacles has been wounded."\'\' When the last tentacle is wounded, it will say \'\'"All of the sea creature\'s tentacles have been wounded."\'\' | :*At first, Fe\'e will attack you with weak hits, though it\'s capable of hitting many times in one turn. As its tentacles become wounded, his attacks become less numerous, but capable of inflicting more damage per hit. | :*When all of its tentacles are wounded, it will replace its standard physical attack with an attack that has the same animation that Ink Jet uses. This new attack is recorded in the log as a standard attack ("Fe\'e hits Player for X points of damage"), but it will be treated as magical damage (it will bypass things like Invincible, Perfect Dodge, and Utsusemi) and also has a knockback effect. This new attack can hit for upwards to approximately 200-300 damage. By this point, its TP regeneration rate will skyrocket, so beware. | Beware of getting hit by its attacks, especially if you\'re working with a mage-based strategy. Critical hits can cause more than 750 damage. | A Bibiki Seashell can intimidate it frequently. Having one will most likely intimidate Fe\'e about 3-5 times, and POSSIBLY up to 10-15 times per battle. Extremely useful if you\'re using a straight tanking method. (This of course, depends on how well the person holds hate, and how long the battle lasts). | If you plan to use the Sleep-Nuke-Strategy, be aware to fight it on Darksday, so your Sleep spells stick better. A Dark Staff / Pluto\'s Staff or Light Staff / Apollo\'s Staff also helps quite a bit in this battle.',
        rewards = {
            {
                group = 'Zero to One of',
                items = {
                    'Walkure Mask (5.5%)',
                    'HorizonXI specific changes Octave Club (1.3%)',
                },
            },
            {
                group = 'All of',
                items = {
                    'Black Pearl',
                    'Pearl x2',
                    'Oxblood x3',
                    '15,000 gil',
                },
            },
            {
                group = 'One of',
                items = {
                    'Altep Ring (44.7%)',
                    'Dem Ring (48.7%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Ajari Necklace (49.4%)',
                    'Philomath Stole (44.9%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Aquamarine (5.1%)',
                    'Chrysoberyl (3.2%)',
                    'Darksteel Ingot (3.9%)',
                    'Ebony Log (2.1%)',
                    'Hi-Reraiser (3.2%)',
                    'Gold Ingot (5.5%)',
                    'Jadeite (6.2%)',
                    'Mythril Ingot (8.1%)',
                    'Moonstone (5.6%)',
                    'Painite (19.5%)',
                    'Steel Ingot (5.8%)',
                    'Sunstone (3.8%)',
                    'Translucent Rock (1.1%)',
                    'Vile Elixir +1 (2.1%)',
                    'Yellow Rock (1.5%)',
                    'Zircon (2.6%)',
                    'Red Rock (2.1%)',
                    'Mahogany Log (1.7%)',
                    'Blue Rock (0.9%)',
                    'Fluorite (6.2%)',
                    'Purple Rock (1.1%)',
                    'Black Rock (1.1%)',
                    'Green Rock (1.1%)',
                    'White Rock (0.9%)',
                },
            },
        },
    },
    {
        name = 'Wild Wild Whiskers',
        level = '60',
        orb_required = 'Moon Orb',
        zone = 'Balga\'s Dais',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Macan Gadangan',
                level = '62',
                job = 'Black Mage',
                type = 'Coeurl',
            },
        },
        note = 'Macan Gadangan can use all Coeurl special attacks, Thunder, Thunder II, Thunder III, Thundaga, Thundaga II and Burst. Before casting any spell, a message will be displayed indicating "The Macan Gadangan\'s whiskers begin to twitch violently." In addition, he has a move called Petrificative Breath which is a petrify Cone Attack, this is by far his favorite special attack. | Can use a thunder-based AoE attack called Charged Whisker that deals 300-400 damage. | Uses Frenzied Rage (Attack Boost) when casting is interrupted.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'High-Quality Coeurl Hide x3',
                    'Adaman Ore',
                    'Hermes Quencher',
                    'Icarus Wing',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mea Ring (42.6%)',
                    'Yhoat Ring (57.4%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Gleeman\'s Belt (36.5%)',
                    'Penitent\'s Rope (63.5%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Walkure Mask (5.8%)',
                    'Hi-Reraiser (7.8%)',
                    'Ebony Log (1.6%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Yellow Rock (0.9%)',
                    'Black Rock (0.9%)',
                    'Aquamarine (1.6%)',
                    'Red Rock (1.6%)',
                    'Blue Rock (1.6%)',
                    'Purple Rock (1.6%)',
                    'Mahogany Log (3.3%)',
                    'Chrysoberyl (3.3%)',
                    'Zircon (3.3%)',
                    'Steel Ingot (4.9%)',
                    'Darksteel Ingot (4.9%)',
                    'Translucent Rock (4.9%)',
                    'Sunstone (4.9%)',
                    'Moonstone (6.6%)',
                    'Mythril Ingot (8.2%)',
                    'Fluorite (8.2%)',
                    'Gold Ingot (9.8%)',
                    'Jadeite (9.8%)',
                    'Painite (9.8%)',
                },
            },
        },
    },
    {
        name = 'Wings of Fury',
        level = '20',
        orb_required = 'Cloudy Orb',
        zone = 'Ghelsba Outpost',
        max_members = '3',
        time_limit = '15 minutes',
        mobs = {
            {
                name = 'Colo-colo x 1',
                level = 'Unknown',
                job = 'Dark Knight',
                type = 'Giant Bat',
            },
            {
                name = 'Furies x 2',
                level = 'Unknown',
                job = 'Thief',
                type = 'Bat Trios',
            },
        },
        note = ';Colo-colo (Giant Bat) | : Uses Drain, Poisonga, Marrow Drain, Subsonics, and regular Giant Bat attacks. | ;Furies (Bat Triplet) | : Uses Drain, Slipstream, Turbulence, and regular Bat Triplet attacks.',
        rewards = {
            {
                group = 'All of',
                items = {
                    'Bat Fang (100%)',
                },
            },
            {
                group = 'Zero to One of',
                items = {
                    'Bat Wing (44.4%)',
                    'Astral Ring (16.7%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Invisible (31.9%)',
                    'Sneak (12.5%)',
                    'Deodorize (22.2%)',
                    'Thunder Spirit Pact (30.6%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Mythril Beastcoin (44.4%)',
                    'Translucent Rock (5.6%)',
                    'Platoon Axe (8.3%)',
                    'Platoon Pole (9.7%)',
                    'Ganko (15.3%)',
                    'Platoon Dagger (12.5%)',
                    'Platoon Edge (13.9%)',
                },
            },
            {
                group = 'One of',
                items = {
                    'Blue Rock (6.9%)',
                    'Yellow Rock (1.4%)',
                    'Green Rock (2.8%)',
                    'Black Rock (2.8%)',
                    'White Rock (1.4%)',
                    'Red Rock (6.9%)',
                    'Purple Rock (9.7%)',
                    'Platoon Sword (18.1%)',
                    'Platoon Dagger (13.9%)',
                    'Gunromaru (11.1%)',
                    'Platoon Lance (4.2%)',
                    'Platoon Edge (13.9%)',
                },
            },
        },
    },
}

return M
