local zones = {
    { name = 'Aht Urhgan Whitegate',  expansion = 'Treasures of Aht Urhgan', area = 'West Aht Urhgan' },
    { name = 'Al Zahbi',              expansion = 'Treasures of Aht Urhgan', area = 'West Aht Urhgan' },
    { name = 'Al\'Taieu',             expansion = 'Chain of Promathia', area = 'Lumoria' },
    { name = 'Altar Room',            expansion = 'Classic', area = 'Aragoneu' },
    { name = 'Alzadaal Undersea Ruins', expansion = 'Treasures of Aht Urhgan', area = 'Ruins of Alzadaal' },
    { name = 'Arrapago Reef',         expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Arrapago Remnants',     expansion = 'Treasures of Aht Urhgan', area = 'Ruins of Alzadaal' },
    { name = 'Attohwa Chasm',         expansion = 'Chain of Promathia', area = 'Aragoneu' },
    { name = 'Aydeewa Subterrane',    expansion = 'Treasures of Aht Urhgan', area = 'Mamool Ja Savagelands' },
    { name = 'Bastok Markets',        expansion = 'Classic', area = 'Bastok' },
    { name = 'Bastok Mines',          expansion = 'Classic', area = 'Bastok' },
    { name = 'Batallia Downs',        expansion = 'Classic', area = 'Norvallen' },
    { name = 'Beadeaux',              expansion = 'Classic', area = 'Derfland' },
    { name = 'Bearclaw Pinnacle',     expansion = 'Chain of Promathia', area = 'Valdeaunia' },
    { name = 'Beaucedine Glacier',    expansion = 'Classic', area = 'Fauregandi' },
    { name = 'Behemoth\'s Dominion',  expansion = 'Classic', area = 'Qufim' },
    { name = 'Bhaflau Remnants',      expansion = 'Treasures of Aht Urhgan', area = 'Ruins of Alzadaal' },
    { name = 'Bhaflau Thickets',      expansion = 'Treasures of Aht Urhgan', area = 'West Aht Urhgan' },
    { name = 'Boneyard Gully',        expansion = 'Chain of Promathia', area = 'Aragoneu' },
    { name = 'Caedarva Mire',         expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Cape Teriggan',         expansion = 'Classic', area = 'Vollbow' },
    { name = 'Carpenters\' Landing',  expansion = 'Chain of Promathia', area = 'Norvallen' },
    { name = 'Castle Oztroja',        expansion = 'Classic', area = 'Aragoneu' },
    { name = 'Castle Zvahl Baileys',  expansion = 'Classic', area = 'Valdeaunia' },
    { name = 'Castle Zvahl Keep',     expansion = 'Classic', area = 'Valdeaunia' },
    { name = 'Celestial Nexus',       expansion = 'Rise of the Zilart', area = 'Tu\'Lia' },
    { name = 'Chamber of Oracles',    expansion = 'Classic', area = 'Kuzotz' },
    { name = 'Chateau d\'Oraguille',  expansion = 'Classic', area = 'San d\'Oria' },
    { name = 'Cloister of Flames',    expansion = 'Rise of the Zilart', area = 'Elshimo Uplands' },
    { name = 'Cloister of Frost',     expansion = 'Rise of the Zilart', area = 'Fauregandi' },
    { name = 'Cloister of Gales',     expansion = 'Rise of the Zilart', area = 'Vollbow' },
    { name = 'Cloister of Storms',    expansion = 'Rise of the Zilart', area = 'Li\'Telor' },
    { name = 'Cloister of Tides',     expansion = 'Rise of the Zilart', area = 'Elshimo Uplands' },
    { name = 'Cloister of Tremors',   expansion = 'Rise of the Zilart', area = 'Kuzotz' },
    { name = 'Crawlers\' Nest',       expansion = 'Classic', area = 'Derfland' },
    { name = 'Dangruf Wadi',          expansion = 'Classic', area = 'Gustaberg' },
    { name = 'Davoi',                 expansion = 'Classic', area = 'Norvallen' },
    { name = 'Den of Rancor',         expansion = 'Classic', area = 'Elshimo Uplands' },
    { name = 'Dragon\'s Aery',        expansion = 'Classic', area = 'Li\'Telor' },
    { name = 'Dynamis - Bastok',      expansion = 'Rise of the Zilart', area = 'Dynamis' },
    { name = 'Dynamis - Beaucedine',  expansion = 'Rise of the Zilart', area = 'Dynamis' },
    { name = 'Dynamis - Buburimu',    expansion = 'Chain of Promathia', area = 'Dynamis' }, 
    { name = 'Dynamis - Jeuno',       expansion = 'Rise of the Zilart', area = 'Dynamis' },
    { name = 'Dynamis - Qufim',       expansion = 'Chain of Promathia', area = 'Dynamis' },
    { name = 'Dynamis - San d\'Oria', expansion = 'Rise of the Zilart', area = 'Dynamis' },
    { name = 'Dynamis - Tavnazia',    expansion = 'Chain of Promathia', area = 'Dynamis' },
    { name = 'Dynamis - Valkurm',     expansion = 'Chain of Promathia', area = 'Dynamis' },
    { name = 'Dynamis - Windurst',    expansion = 'Rise of the Zilart', area = 'Dynamis' },
    { name = 'Dynamis - Xarcabard',   expansion = 'Rise of the Zilart', area = 'Dynamis' },
    { name = 'Eastern Altepa Desert', expansion = 'Classic', area = 'Kuzotz' },
    { name = 'Empyreal Paradox',      expansion = 'Chain of Promathia', area = 'Lumoria' },
    { name = 'Fei\'Yin',              expansion = 'Classic', area = 'Fauregandi' },
    { name = 'Garlaige Citadel',      expansion = 'Classic', area = 'Aragoneu' },
    { name = 'Grand Palace of Hu\'Xzoi', expansion = 'Chain of Promathia', area = 'Lumoria' },
    { name = 'Gusgen Mines',             expansion = 'Classic', area = 'Zulkheim' },
    { name = 'Gustav Tunnel',         expansion = 'Classic', area = 'Vollbow' },
    { name = 'Hall of the Gods',      expansion = 'Rise of the Zilart', area = 'Li\'Telor' },
    { name = 'Halvung',               expansion = 'Treasures of Aht Urhgan', area = 'Halvung Territory' },
    { name = 'Hazhalm Testing Grounds', expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Heavens Tower',         expansion = 'Classic', area = 'Windurst' },
    { name = 'Ifrit\'s Cauldron',     expansion = 'Classic', area = 'Elshimo Uplands' },
    { name = 'Ilrusi Atoll',          expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Jade Sepulcher',        expansion = 'Treasures of Aht Urhgan', area = 'Mamool Ja Savagelands' },
    { name = 'Jugner Forest',         expansion = 'Classic', area = 'Norvallen' },
    { name = 'Kazham',                expansion = 'Classic', area = 'Elshimo Lowlands' },
    { name = 'Konschtat Highlands',   expansion = 'Classic', area = 'Zulkheim' },
    { name = 'Korroloka Tunnel',      expansion = 'Classic', area = 'Gustaberg' },
    { name = 'Kuftal Tunnel',         expansion = 'Classic', area = 'Vollbow' },
    { name = 'La\'Loff Amphitheater', expansion = 'Rise of the Zilart', area = 'Tu\'Lia' },
    { name = 'La Theine Plateau',     expansion = 'Classic', area = 'Zulkheim' },
    { name = 'Lebros Cavern',         expansion = 'Treasures of Aht Urhgan', area = 'Halvung Territory' },
    { name = 'Leujaoam Sanctum',      expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Lower Delkfutt\'s Tower', expansion = 'Classic', area = 'Qufim' },
    { name = 'Lower Jeuno',           expansion = 'Classic', area = 'Jeuno' },
    { name = 'Lufaise Meadows',       expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Mamook',                expansion = 'Treasures of Aht Urhgan', area = 'Mamool Ja Savagelands' },
    { name = 'Mamool Ja Training Grounds', expansion = 'Treasures of Aht Urhgan', area = 'Mamool Ja Savagelands' },
    { name = 'Meriphataud Mountains', expansion = 'Classic', area = 'Aragoneu' },
    { name = 'Metalworks',            expansion = 'Classic', area = 'Bastok' },
    { name = 'Middle Delkfutt\'s Tower', expansion = 'Classic', area = 'Qufim' },
    { name = 'Mine Shaft #2716',    expansion = 'Chain of Promathia', area = 'Movalpolos' },
    { name = 'Misareaux Coast',       expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Monarch Linn',          expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Monastic Cavern',       expansion = 'Classic', area = 'Norvallen' },
    { name = 'Mount Zhayolm',         expansion = 'Treasures of Aht Urhgan', area = 'Halvung Territory' },
    { name = 'Nashmau',               expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Navukgo Execution Chamber', expansion = 'Treasures of Aht Urhgan', area = 'Halvung Territory' },
    { name = 'Newton Movalpolos',     expansion = 'Chain of Promathia', area = 'Movalpolos' },
    { name = 'Norg',                  expansion = 'Rise of the Zilart', area = 'Elshimo Lowlands' },
    { name = 'North Gustaberg',       expansion = 'Classic', area = 'Gustaberg' },
    { name = 'Northern San d\'Oria',  expansion = 'Classic', area = 'San d\'Oria' },
    { name = 'Nyzul Isle',            expansion = 'Treasures of Aht Urhgan', area = 'Ruins of Alzadaal' },
    { name = 'Oldton Movalpolos',     expansion = 'Chain of Promathia', area = 'Movalpolos' },
    { name = 'Ordelle\'s Caves',        expansion = 'Classic', area = 'Zulkheim' },
    { name = 'Palborough Mines',      expansion = 'Classic', area = 'Gustaberg' },
    { name = 'Pashhow Marshlands',    expansion = 'Classic', area = 'Derfland' },
    { name = 'Periqia',               expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Phomiuna Aqueducts',    expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Port Bastok',           expansion = 'Classic', area = 'Bastok' },
    { name = 'Port Jeuno',            expansion = 'Classic', area = 'Jeuno' },
    { name = 'Port San d\'Oria',      expansion = 'Classic', area = 'San d\'Oria' },
    { name = 'Port Windurst',         expansion = 'Classic', area = 'Windurst' },
    { name = 'Pso\'Xja',              expansion = 'Chain of Promathia', area = 'Fauregandi' },
    { name = 'Qu\'Bia Arena',         expansion = 'Classic', area = 'Fauregandi' },
    { name = 'Qufim Island',          expansion = 'Classic', area = 'Qufim' },
    { name = 'Quicksand Caves',       expansion = 'Classic', area = 'Kuzotz' },
    { name = 'Qulun Dome',            expansion = 'Classic', area = 'Derfland' },
    { name = 'Rabao',                 expansion = 'Classic', area = 'Kuzotz' },
    { name = 'Ranguemont Pass',       expansion = 'Classic', area = 'Fauregandi' },
    { name = 'Riverne Site A01',      expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Riverne Site B01',      expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Ro\'Maeve',             expansion = 'Rise of the Zilart', area = 'Li\'Telor' },
    { name = 'Rolanberry Fields',     expansion = 'Classic', area = 'Derfland' },
    { name = 'Ru\'Aun Gardens',       expansion = 'Rise of the Zilart', area = 'Tu\'Lia' },
    { name = 'Ru\'Lude Gardens',      expansion = 'Classic', area = 'Jeuno' },
    { name = 'Sacrarium',             expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Sacrificial Chamber',   expansion = 'Classic', area = 'Elshimo Uplands' },
    { name = 'Sauromugue Champaign',  expansion = 'Classic', area = 'Aragoneu' },
    { name = 'Sea Serpent Grotto',    expansion = 'Rise of the Zilart', area = 'Elshimo Lowlands' },
    { name = 'Sealion\'s Den',        expansion = 'Chain of Promathia', area = 'Tavnazian Archipelago' },
    { name = 'Silver Sea Remnants',   expansion = 'Treasures of Aht Urhgan', area = 'Ruins of Alzadaal' },
    { name = 'South Gustaberg',       expansion = 'Classic', area = 'Gustaberg' },
    { name = 'Southern San d\'Oria',  expansion = 'Classic', area = 'San d\'Oria' },
    { name = 'Stellar Fulcrum',       expansion = 'Rise of the Zilart', area = 'Qufim' },
    { name = 'Talacca Cove',          expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'Tavnazian Safehold',    expansion = 'Chain of Promathia', area = 'Tavnazian Marquisate' },
    { name = 'Temple of Uggalepih',   expansion = 'Classic', area = 'Elshimo Uplands' },
    { name = 'The Ashu Talif',        expansion = 'Treasures of Aht Urhgan', area = 'Arrapago Islands' },
    { name = 'The Boyahda Tree',      expansion = 'Rise of the Zilart', area = 'Li\'Telor' },
    { name = 'The Colosseum',         expansion = 'Treasures of Aht Urhgan', area = 'West Aht Urhgan' },
    { name = 'The Eldieme Necropolis', expansion = 'Classic', area = 'Norvallen' },
    { name = 'The Garden of Ru\'Hmet', expansion = 'Chain of Promathia', area = 'Lumoria' },
    { name = 'The Sanctuary of Zi\'Tah', expansion = 'Rise of the Zilart', area = 'Li\'Telor' },
    { name = 'The Shrine of Ru\'Avitau', expansion = 'Rise of the Zilart', area = 'Tu\'Lia' },
    { name = 'The Shrouded Maw',      expansion = 'Chain of Promathia', area = 'Fauregandi' },
    { name = 'Throne Room',           expansion = 'Classic', area = 'Valdeaunia' },
    { name = 'Uleguerand Range',      expansion = 'Chain of Promathia', area = 'Valdeaunia' },
    { name = 'Upper Delkfutt\'s Tower', expansion = 'Classic', area = 'Qufim' },
    { name = 'Upper Jeuno',           expansion = 'Classic', area = 'Jeuno' },
    { name = 'Valkurm Dunes',          expansion = 'Classic', area = 'Zulkheim' },
    { name = 'Valley of Sorrows',     expansion = 'Classic', area = 'Vollbow' },
    { name = 'Ve\'Lugannon Palace',   expansion = 'Rise of the Zilart', area = 'Tu\'Lia' },
    { name = 'Wajaom Woodlands',      expansion = 'Treasures of Aht Urhgan', area = 'Mamool Ja Savagelands' },
    { name = 'Waughroon Shrine',      expansion = 'Classic', area = 'Gustaberg' },
    { name = 'Western Altepa Desert', expansion = 'Classic', area = 'Kuzotz' },
    { name = 'Windurst Walls',        expansion = 'Classic', area = 'Windurst' },
    { name = 'Windurst Waters',       expansion = 'Classic', area = 'Windurst' },
    { name = 'Windurst Woods',        expansion = 'Classic', area = 'Windurst' },
    { name = 'Xarcabard',             expansion = 'Classic', area = 'Valdeaunia' },
    { name = 'Yhoator Jungle',        expansion = 'Classic', area = 'Elshimo Uplands' },
    { name = 'Yuhtunga Jungle',       expansion = 'Classic', area = 'Elshimo Lowlands' },
    { name = 'Zeruhn Mines',          expansion = 'Classic', area = 'Gustaberg' },
    { name = 'Zhayolm Remnants',      expansion = 'Treasures of Aht Urhgan', area = 'Ruins of Alzadaal' },    
};

-- Returns the expansion name for a given zone.
local function get_expansion(zone_name)
    for _, zone in ipairs(zones) do
        if zone.name:lower() == zone_name:lower() then
            return zone.expansion;
        end
    end
    return nil;
end

-- Returns the area name for a given zone.
local function get_area(zone_name)
    for _, zone in ipairs(zones) do
        if zone.name:lower() == zone_name:lower() then
            return zone.area;
        end
    end
    return nil;
end

-- Returns a filtered list of zones for a given expansion.
local function get_zones_by_expansion(expansion_name)
    local result = {};
    for _, zone in ipairs(zones) do
        if zone.expansion:lower() == expansion_name:lower() then
            table.insert(result, zone.name);
        end
    end
    return result;
end

-- Returns a filtered list of zones for a given area.
local function get_zones_by_area(area_name)
    local result = {};
    for _, zone in ipairs(zones) do
        if zone.area:lower() == area_name:lower() then
            table.insert(result, zone.name);
        end
    end
    return result;
end

return {
    list                    = zones,
    get_expansion           = get_expansion,
    get_area                = get_area,
    get_zones_by_expansion  = get_zones_by_expansion,
    get_zones_by_area       = get_zones_by_area,
};
