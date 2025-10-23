SMODS.Challenge{
    key = "flarp",
    loc_txt = {
        name = "FLARP",
    },
    rules = { 
        custom = {{id = "only_shop_zodiac"}},
        modifiers = {
            {id = 'joker_slots', value = 0}
        } 
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
    vouchers  = {
    { 
        id = "v_bstuck_riseup",
    
    } 
    },
    restrictions = { 
      banned_cards = {
         {id = "c_judgement"}
      }
    }
}