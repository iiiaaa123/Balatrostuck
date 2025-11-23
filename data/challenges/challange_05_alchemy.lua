local not_skeleton = {}

for k, v in pairs(G.P_TAGS) do
    if v.key ~= "tag_bstuck_perfecltygeneric" then
        table.insert(not_skeleton, {id = v.key})
    end
end

SMODS.Challenge{
    key = "alchemy",
    loc_txt = {
        name = "Alchemy",
    },
    rules = { 
        custom = {
            {id = 'perfectly_generic'},
            {id = 'no_interest'}
        },
        --[[
        rules.custom ={ 
        all_eternal, 
        chips_dollar_cap, 
        daily, debuff_played_cards, 
        discard_cost, 
        flipped_cards, 
        inflation, 
        minus_hand_size_per_X_dollar, 
        no_extra_hand_money, 
        no_interest, 
        no_reward, 
        no_reward_specific, 
        no_shop_jokers, none, 
        set_eternal_ante, 
        set_joker_slots_ante, 
        set_seed
         ,
        rules.modifiers = {
            dollars, 
            discards, 
            hands, 
            reroll_cost, 
            joker_slots, 
            consumable_slots, 
            hand_size
        } --]]
    },
    jokers = {
        --[[
    { 
        id = "",
        edition = "",
        eternal = false,
        pinned = false

    }
        --]]
    },
    consumeables = {
        --[[
    { 
        id = "",
        edition = "",
        eternal = false,

    }
        ]]
    },
    vouchers  = { --[[
    { 
        id = "",
    
    } 
        ]]
    },
    restrictions = { 
      banned_tags = not_skeleton
    }
}