local ranks = {
    { name = 'Amateur',    min = 1,  max = 10  },
    { name = 'Recruit',    min = 11, max = 20  },
    { name = 'Initiate',   min = 21, max = 30  },
    { name = 'Novice',     min = 31, max = 40  },
    { name = 'Apprentice', min = 41, max = 50  },
    { name = 'Journeyman', min = 51, max = 60  },
    { name = 'Craftsman',  min = 61, max = 70  },
    { name = 'Artisan',    min = 71, max = 80  },
    { name = 'Adept',      min = 81, max = 90  },
    { name = 'Veteran',    min = 91, max = 100 },
};

-- Returns the rank name for a given skill level.
local function get_rank(level)
    for _, rank in ipairs(ranks) do
        if level >= rank.min and level <= rank.max then
            return rank.name;
        end
    end
    return nil;
end

return {
    list     = ranks,
    get_rank = get_rank,
};
