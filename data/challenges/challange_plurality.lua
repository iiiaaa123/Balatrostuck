SMODS.Challenge{
    key = "plurality",
    loc_txt = {
        name = "Plurality",
    },
    rules = {
                modifiers = {
            {id = 'hands', value = 5},
            {id = 'hand_size', value = 1}
        } 
    },
    jokers = {
    { 
        id = "j_bstuck_lordoftime",
        eternal = true,
        pinned = false

    }
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
    restrictions = { --[[
        restrictions.banned_cards = {},
        restrictions.banned_tags = {},
        restrictions.banned_other = {},
    ]]
    }
}