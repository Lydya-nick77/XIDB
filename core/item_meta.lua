local helpers = require('core.helpers')

local M = {}

local ORDERED_EQUIP_BITS = {
    0x0001, 0x0002, 0x0004, 0x0008, 0x0010, 0x0020, 0x0040, 0x0080,
    0x0100, 0x0200, 0x0400, 0x0800, 0x1000, 0x2000, 0x4000, 0x8000,
}

local EQUIP_SLOT_MASKS = {
    [0x0001] = 'Main',
    [0x0002] = 'Sub',
    [0x0004] = 'Range',
    [0x0008] = 'Ammo',
    [0x0010] = 'Head',
    [0x0020] = 'Body',
    [0x0040] = 'Hands',
    [0x0080] = 'Legs',
    [0x0100] = 'Feet',
    [0x0200] = 'Neck',
    [0x0400] = 'Waist',
    [0x0800] = 'Ear1',
    [0x1000] = 'Ear2',
    [0x2000] = 'Ring1',
    [0x4000] = 'Ring2',
    [0x8000] = 'Back',
}

local JOB_NAMES = {
    ' ', 'WAR', 'MNK', 'WHM', 'BLM', 'RDM', 'THF', 'PLD', 'DRK',
    'BST', 'BRD', 'RNG', 'SAM', 'NIN', 'DRG', 'SMN', 'BLU',
    'COR', 'PUP', 'DNC', 'SCH', 'GEO', 'RUN',
}

local ITEM_FLAG_NAMES = {
    [0x00000001] = 'Flag00',
    [0x00000002] = 'Flag01',
    [0x00000004] = 'Flag02',
    [0x00000008] = 'Flag03',
    [0x00000010] = 'Flag04',
    [0x00000020] = 'Inscribable',
    [0x00000040] = 'No Auction',
    [0x00000080] = 'Scroll',
    [0x00000100] = 'Linkshell',
    [0x00000200] = 'Can Use',
    [0x00000400] = 'Can trade NPC',
    [0x00000800] = 'Can Equip',
    [0x00001000] = 'No Sale',
    [0x00002000] = 'No Delivery',
    [0x00004000] = 'No Trade Player',
    [0x00008000] = 'Rare',
    [0x00010000] = 'Can Mog Garden',
    [0x00020000] = 'Is Furniture',
    [0x00040000] = 'Is Key Item',
    [0x00080000] = 'Is Currencies',
    [0x00100000] = 'Is Mount',
    [0x00200000] = 'Is Trust',
    [0x00400000] = 'Is Costume',
    [0x00800000] = 'Is Special',
    [0x01000000] = 'Is Mog Pell',
    [0x02000000] = 'Is Scripted',
    [0x04000000] = 'Is Technical',
    [0x08000000] = 'Reserved/Internal',
    [0x10000000] = 'RUN',
    [0x20000000] = 'GEO',
    [0x40000000] = 'Reserved/Expansion',
    [0x80000000] = 'Reserved/Expansion',
}

local ITEM_TYPE_NAMES = {
    [0] = 'None',
    [1] = 'Item',
    [2] = '2 ??',
    [3] = '3 ??',
    [4] = 'Weapon',
    [5] = 'Armor',
    [6] = '6 ??',
    [7] = 'Item / Consummable',
    [8] = '8 ??',
    [9] = '9 ??',
    [10] = 'Furniture',
    [11] = '11 ??',
    [12] = '12 ??',
    [13] = '13 ??',
    [14] = '14 ??',
    [15] = '15 ??',
    [16] = '16 ??',
    [17] = '17 ??',
    [18] = '18 ??',
    [19] = '19 ??',
    [20] = '20 ??',
}

local function has_bit(mask, bit_value)
    if bit and bit.band then
        return bit.band(mask, bit_value) ~= 0
    end

    return (mask % (bit_value * 2)) >= bit_value
end

function M.format_item_type(item_type)
    item_type = helpers.to_number(item_type, -1)
    if ITEM_TYPE_NAMES[item_type] then
        return ITEM_TYPE_NAMES[item_type]
    end

    return ('Type_%d'):fmt(item_type)
end

function M.format_slots_mask(mask)
    mask = helpers.to_number(mask, 0)
    if mask == 0 then
        return 'None'
    end

    local parts = {}
    for _, bit_value in ipairs(ORDERED_EQUIP_BITS) do
        local slot_name = EQUIP_SLOT_MASKS[bit_value]
        if slot_name and has_bit(mask, bit_value) then
            parts[#parts + 1] = slot_name
        end
    end

    if #parts == 0 then
        return 'None'
    end

    return table.concat(parts, ', ')
end

function M.format_jobs_mask(mask)
    mask = helpers.to_number(mask, 0)
    if mask == 0 then
        return 'None'
    end

    local parts = {}
    for i = 1, #JOB_NAMES do
        local bit_value = 2 ^ (i - 1)
        if has_bit(mask, bit_value) then
            parts[#parts + 1] = JOB_NAMES[i]
        end
    end

    if #parts == 0 then
        return 'None'
    end

    return table.concat(parts, ', ')
end

function M.format_flags_mask(mask)
    mask = helpers.to_number(mask, 0)
    if mask == 0 then
        return 'None'
    end

    local parts = {}
    local bit_value = 1

    for i = 0, 31 do
        if has_bit(mask, bit_value) then
            local name = ITEM_FLAG_NAMES[bit_value] or ('Bit' .. tostring(i))
            parts[#parts + 1] = name
        end
        bit_value = bit_value * 2
    end

    if #parts == 0 then
        return 'None'
    end

    return table.concat(parts, ', ')
end

return M
