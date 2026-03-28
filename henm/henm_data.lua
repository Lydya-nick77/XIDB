-- HENM Database for XIDB
-- Source: HorizonXI Wiki (horizonffxi.wiki)
-- Category: HENM
-- Total HENMs: 6

local M = {}

M.henm_list = {
    {
        name = 'Despotic Decapod',
        level = '88',
        tier = 'Tier I',
        area = 'Jugner Forest',
        spawn_type = 'Forced Spawn',
        spawn_time = 'Spawn positions: (F-8) / (H-9) / (I-5) | Entry item: Faded Stone | Members: 18 | Time limit: 60 minutes',
        drops = { 'Deflecting Band', 'Overlord\'s Ring', 'Sprinter\'s Belt', 'Duality Loop', 'Damascene Cloth', 'Reraiser', 'Hi-Elixir' },
        other_conditions = 'Mobs: Overlord Arthro, Lord\'s Bruiser, Lord\'s Wizard, Poisonous Crab. | Overlord Arthro spawns a Poisonous Crab every 90 seconds. | Poisonous Crabs have a poison aura that deals about 50 HP per tick. | Overlord Arthro spawns a Lord\'s Bruiser and a Lord\'s Wizard every 20% HP. | At about 30% HP it enters a rage mode with Hundred Fists-like attack speed and increased damage. | Have stuns ready for -ga spells from the encounter. | Kill Lord\'s Wizard first when Bruiser and Wizard spawn together. | Poisonous Crabs are not limited and continue spawning while Overlord Arthro is alive. | Wiki source: Category:HENM and Despotic Decapod page.',
    },
    {
        name = 'Ruinous Rocs',
        level = '88',
        tier = 'Tier I',
        area = 'Rolanberry Fields',
        spawn_type = 'Forced Spawn',
        spawn_time = 'Spawn positions: (E-10) / (F-10) / (J-8) | Entry item: Faded Stone | Members: 18 | Time limit: 60 minutes',
        drops = { 'Damascus Ingot', 'Dilation Ring', 'Luftpause Mark', 'Trotter Boots', 'Rucke\'s Rung', 'Vaulter\'s Ring', 'Protectra V', 'Reraiser', 'Hi-Elixir' },
        other_conditions = 'Mobs: Teratornis (RDM Roc), Argentavis (BRD Roc), Kelenken (WHM Roc). | All three use native Roc TP moves including Stormwind, Dread Dive, Blind Vortex, Giga Scream, and Feather Barrier. | The WHM and BRD use normal spells for their jobs. | Teratornis uses AoE magic up to Thundaga III and can Chainspell AoE black magic. | When one Roc is killed, the others use their two-hour abilities; Argentavis can also gain Hundred Fists through a rage mechanic. | Recommended kill order on the wiki is WHM, then RDM, then BRD to avoid Benediction. | The last Roc must die only after the other two bodies have fully despawned or no drops are awarded. | Treasure Hunter is noted on the wiki as affecting drop rates. | Wiki source: Category:HENM and Ruinous Rocs page.',
    },
    {
        name = 'Sacred Scorpions',
        level = '88',
        tier = 'Tier I',
        area = 'Sauromugue Champaign',
        spawn_type = 'Forced Spawn',
        spawn_time = 'Spawn positions: (F-5) / (H-8) / (K-9) | Entry item: Faded Stone | Members: 18 | Time limit: 60 minutes',
        drops = { 'Venomous Claw', 'Dilation Ring', 'Carapace Bullet', 'Horus\'s Helm', 'Opuntia Hoop', 'Reraiser', 'Hi-Elixir' },
        other_conditions = 'Mobs: Batcheh (WHM), Sefedsepu (WAR), Ifdet (RDM). | Each Scorpion uses Draw In before TP moves and has Petrification on auto-attacks. | Each TP move has an additional effect and about a 40-yalm range. | Earthbreaker is a heavy AoE with Stun. | Venom Storm applies about 100 HP per tick Poison; bring Antidotes. | Each Scorpion uses its respective two-hour ability at around 20% HP. | Ifdet can use AoE Silence, Blind, and Paralyze. | All three can be stunned. | The wiki strategy is to kill them in reverse spawn order, with the spawn order being random. | Tank them roughly 45 yalms apart in a triangle to create a safe center for mages. | Wiki source: Category:HENM and Sacred Scorpions page.',
    },
    {
        name = 'Mammet-9999',
        level = 'Unknown',
        tier = 'Tier II',
        area = 'Misareaux Coast',
        spawn_type = 'Forced Spawn',
        spawn_time = 'Spawn positions: (I-6) / (F-8) / (I-11) | Entry item: Faded Gem | Members: 18 | Time limit: 60 minutes | Requires 1 Tier I clear',
        drops = { 'Balladeer\'s Harp', 'Virology Ring', 'Mammet Fiber', 'Sharpshooter\'s Ring', '9999\'s Broken Collar', 'Ageist (Hard Mode Only)' },
        other_conditions = 'Mobs: Mammet-9999. | Hard Mode can be activated by using a Yellow Liquid on Mammet-9999 before any actions are taken. | The fight has four phases: Hand-to-Hand from 100% to 75%, Sword from 75% to 50%, Polearm from 50% to 25%, and Staff from 25% to death. | TP moves from earlier phases carry forward into later phases. | Transitions are triggered by specific actions: auto-attack damage at 75%, weapon skill damage at 50%, and magic damage at 25%. | Transmogrification absorbs physical damage and converts it to HP for roughly 30 seconds. | In Staff phase, Mind Wall absorbs offensive magic and converts it to HP for roughly 30 seconds. | In Staff phase the Mammet also begins casting tier-two ancient magic AoEs. | The wiki notes this fight is straightforward if transitions are triggered correctly and damage is paused before each threshold. | Wiki source: Category:HENM and Mammet-9999 (HENM) page.',
    },
    {
        name = 'Tonberry Sovereign',
        level = 'Unknown',
        tier = 'Tier II',
        area = 'Yhoator Jungle',
        spawn_type = 'Forced Spawn',
        spawn_time = 'Spawn positions: (F-10) / (H-10) / (I-11) | Entry item: Faded Gem | Members: 18 | Time limit: 60 minutes | Requires 1 Tier I clear',
        drops = { 'Begrudging Ring', 'Hangeki Ring', 'Maledictor\'s Shawl', 'Obscured Ring', 'Montiont Silverpiece', 'One Hundred Byne Bill', 'Sovereign Coat', 'Nihility (Hard Mode Only)' },
        other_conditions = 'Mobs: Tonberry Sovereign, Tonberry Shinobi, Tonberry Sorcerer, Tonberry Raider. | The boss uses normal Tonberry TP moves and spawns BLM, THF, or NIN adds every 30 seconds; the number of adds increases after each completed phase. | At each 20% threshold the boss becomes nearly immune to damage, one random player is terrorized and teleported, and the boss walks back toward that target. If it reaches the player, that player dies and cannot be raised, then the process repeats. | To end each threshold phase, players must skillchain the boss and land magic bursts to make the lantern flicker. The wiki notes 6, 9, 15, and 21 bursts for successive phases. | After the required bursts are met, the boss uses Astral Flow in the element of the last burst; reusing the same element across phases appears to trigger punishment mechanics. | Adds can be cleared with -ga spells, but Tonberry Sorcerer adds can cast Firaga and Sleepga. | Hard Mode from the category page requires magic bursting through each 20% phase with the same element each time, and at the 40% phase one alliance member must wear an Uggalepih Necklace when the phase ends. | Wiki source: Category:HENM and Tonberry Sovereign (HENM) page.',
    },
    {
        name = 'Ultimega',
        level = 'Unknown',
        tier = 'Tier II',
        area = 'Lufaise Meadows',
        spawn_type = 'Forced Spawn',
        spawn_time = 'Spawn positions: (J-7) / (J-9) / (K-9) | Entry item: Faded Gem | Members: 18 | Time limit: 60 minutes | Requires 1 Tier I clear',
        drops = { 'Spirited Ring', 'Ultima\'s Left Arm', 'Bravery Band', 'Ensorcelled Shard', 'Terminal Alloy', 'Lungo-Nango Jadeshell', 'Montiont Silverpiece', 'Levin (Hard Mode Only)' },
        other_conditions = 'Mobs: Neo-Ultima and Neo-Omega. | Both NMs must stay within about 10% HP of each other or the lower one heals to match the higher one. | They also must stay within about 20 yalms or they begin heavy regeneration and TP-move rage. | They should cross major x0% thresholds together, otherwise they begin spamming TP moves until the second mob reaches the same threshold. | Omega drops pods periodically; if three pods interact they create Nuclear Fuel and can wipe the alliance. | Omega shifts between physical and magical reduction phases and is typically slower to kill. | Ultima becomes especially dangerous at low HP because of Citadel Buster. | The wiki strategy recommends holding Omega near 12% and Ultima near 21% before a synchronized final push. | Hard Mode from the category page is activated by using a CCB Polymer Pump before any actions are taken. | Wiki source: Category:HENM and Ultimega (HENM) page.',
    },
}

M.nm_list = M.henm_list

return M