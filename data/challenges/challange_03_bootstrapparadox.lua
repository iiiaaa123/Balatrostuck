SMODS.Challenge{
    key = "bootstrapparadox",
    loc_txt = {
        name = "Bootstrap Paradox",
    },
    rules = { 
        custom = {
            {id = 'mult_dollar_cap'},
        },
        modifiers = {
            {id = 'dollars', value = 10}, 
            {id = 'hands', value = 9}
        } 
    },
    jokers = {
    { 
        id = "j_bootstraps",
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