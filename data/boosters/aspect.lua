SMODS.Booster{
    key = 'aspect_booster',
    atlas = 'HomestuckAspectBooster',
    config = {extra = 2, choose = 1},
    discovered = false,
    loc_txt = {
        ['name'] = 'Aspect Pack',
        ['text'] = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} {C:aspect}Aspect{} cards to',
            'be used immediately'
        },
        group_name = 'Aspect Pack'
    },
    kind = 'aspect',
    cost = 4,
    weight = 0.3,
    pos = { x = 0, y = 0 },
   -- loc_vars = function(self, info_queue, card)
    --        art_credit('akai', info_queue)
     --       return {true}
     --   end,
    create_card = function(self, card,i)
        local aspect = G.GAME.slab and string.gsub(G.GAME.slab.key, "slab_bstuck_", "") or "breath"
        aspect = 'c_bstuck_' .. aspect
        local card = G.GAME.slab and next(SMODS.find_card('v_bstuck_aspect_mastery')) and i == 1 and SMODS.create_card({key = aspect, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "gam"}) or SMODS.create_card({set = "Aspect", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "gam"})
        return card
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.CURRENT_ASPECT or G.C.PARADOX)
        ease_background_colour({ new_colour = G.C.CURRENT_ASPECT or G.C.PARADOX, special_colour = G.C.BLACK, contrast = 2 })
    end,

}


