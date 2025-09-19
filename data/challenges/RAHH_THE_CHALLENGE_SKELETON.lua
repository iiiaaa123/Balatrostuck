-- delete this before release
local not_skeleton = {}
for k, v in pairs(G.P_CENTER_POOLS.Joker) do
    if v.key ~= "j_mr_bones" then
        table.insert(not_skeleton, {id = v.key})
    end
end

for k, v in pairs(bstuck_joker_keys) do
    table.insert(not_skeleton, {id = v})
end

SMODS.Challenge{
    key = "the_skeleton_challenge",
    loc_txt = {
        name = "THE SKELETON CHALLENGE 💀💀",
    },
    rules = { 
        modifiers = {
            {id = "dollars", value = 206},
            {id = "joker_slots", value = 2}, 
        } 
    },
    jokers = {
    { 
        id = "j_ring_master",
        eternal = true
    },
    { 
        id = "j_mr_bones",
    }
    },
    restrictions = {
        banned_cards = not_skeleton,
    },
}