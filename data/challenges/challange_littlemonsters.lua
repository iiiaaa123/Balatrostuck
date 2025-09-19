SMODS.Challenge{
    key = "littlemonsters",
    loc_txt = {
        name = "Little Monsters",
    },
    rules = { --[[
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
          { 
        id = "j_bstuck_applejuice",
        eternal = false,
        pinned = false

    },
    { 
        id = "j_bstuck_applejuice",
        eternal = false,
        pinned = false

    },
    { 
        id = "j_bstuck_applejuice",
        eternal = false,
        pinned = false

    },
    { 
        id = "j_bstuck_applejuice",
        eternal = false,
        pinned = false

    },
    { 
        id = "j_bstuck_applejuice",
        eternal = false,
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
    restrictions = { 
      -- restrictions.banned_cards = {
         --   {id = "j_merry_andy"}, 
          --  {id = "j_drunkard"}
      --  },
     --   restrictions.banned_other = {
       --     {id ="v_wasteful"}
       -- }
    }
}