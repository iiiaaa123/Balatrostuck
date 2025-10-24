SMODS.Challenge{
    key = "plurality",
    loc_txt = {
        name = "Plurality",
    },
    rules = {
                modifiers = {
            {id = 'hands', value = 1},
            {id = 'hand_size', value = 5}
        } 
    },
    jokers = {
    { 
        id = "j_bstuck_museofspace",
        eternal = true,
        pinned = false

    }
    },
    consumeables = {
    { 
        id = "c_black_hole",

    }
    },
    vouchers  = { --[[
    { 
        id = "",
    
    } 
        ]]
    },
    restrictions = { --[[
        restrictions.banned_cards = {},
        restrictions.banned_tags = {},
        restrictions.banned_other = {},
    ]]
    }
}