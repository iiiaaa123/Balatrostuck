SMODS.Challenge{
    key = "shippingwars",
    loc_txt = {
        name = "Shipping Wars",
    },
   rules = {  
        custom = {
            {id = 'tripleblindsize'},
        },
    },
    jokers = {
    { 
        id = "j_bstuck_innapropriatebucket",
        eternal = false,
        pinned = false

    },
     { 
        id = "j_ancient",
        eternal = false,
        pinned = false

    }
    },
    consumeables = {
    { 
        id = "c_lovers",

    }
    },
    vouchers  = { --[[
    { 
        id = "",
    
    } 
        ]]
    },
    restrictions = { 
      banned_other = {
        {id = 'bl_club', type = 'blind'},
        {id = 'bl_goad', type = 'blind'},
        {id = 'bl_window', type = 'blind'},
        {id = 'bl_head', type = 'blind'}
      }
    }
}