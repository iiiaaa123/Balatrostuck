SMODS.Booster{
    key = 'sburb_booster',
    atlas = 'HomestuckAspectBooster',
    config = {extra = 12, choose = 1},
    discovered = false,
    loc_txt = {
        ['name'] = 'Sburb Pack',
        ['text'] = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} {C:aspect}Aspect{} cards to',
            'be used immediately'
        },
        group_name = 'SBURB Pack'
    },
    pos = { x = 0, y = 2 },
    --loc_vars = function(self, info_queue, card)
    --        art_credit('delirium', info_queue)
     --       return {true}
     --   end,
    set_ability = function(self, card, initial, delay_sprites)
        local odds = G.GAME.selected_back.effect.center.key == 'b_bstuck_frog' and 1 or 4
        if pseudorandom('piss') < 1/odds and G.P_CENTERS['c_bstuck_piss'].unlocked then
            card.ability.extra = 13
        end
    end,
    weight = 0,
    create_card = function(self, card,i)
        local keys = {
            'breath', 'void', 'blood', 'time', 'heart', 'rage', 'light', 'hope', 'life', 'mind', 'doom','space', 'piss'
        }
        if not G.P_CENTERS['c_bstuck_piss'].unlocked then
            table.remove(keys,#keys)
        end


        if i > #keys then
            i = 1
        end

        return {set = "Aspect", key = 'c_bstuck_' .. keys[i], area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "buf"}
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.PARADOX)
        ease_background_colour({ new_colour = G.C.PARADOX, special_colour = G.C.BLACK, contrast = 2 })
    end,

}