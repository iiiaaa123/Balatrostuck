SMODS.Booster{
    key = 'splinter_booster',
    atlas = 'HomestuckAspectBooster',
    config = {extra = 3, choose = 1},
    discovered = false,
    loc_txt = {
        ['name'] = 'Splinter',
        ['text'] = {
            'Choose {C:attention}1{} of your',
            'existing jokers',
        },
        group_name = 'Splinter Pack',
        kind = 'shop_pack'
    },
    cost = 4,
    pos = { x = 1, y = 2 },
    set_ability = function(self, card, initial, delay_sprites)
        local unique_jokers = {}
        if G.jokers then
            for _, joker in ipairs(G.jokers.cards or {}) do
                if not bstuck_in_table(joker.config.center_key,unique_jokers) then table.insert(unique_jokers,joker.config.center_key) end
            end
        end
        card.ability.extra = #unique_jokers or 1
    end,
    weight = 0,
    create_card = function(self, card,i)
        local unique_jokers = {}
        for _, joker in ipairs(G.jokers.cards) do
            if not bstuck_in_table(joker.config.center_key,unique_jokers) then table.insert(unique_jokers,joker.config.center_key) end
        end
        print(inspect(unique_jokers))
        if i > #unique_jokers then
            i = 1
        end
        local key = unique_jokers[i] or "j_joker"

        return SMODS.create_card({set = "Joker", area = G.pack_cards, key = key, skip_materialize = true, soulable = true, key_append = "gam"})
    end,

    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.PARADOX)
        ease_background_colour({ new_colour = G.C.PARADOX, special_colour = G.C.BLACK, contrast = 2 })
    end,
        

}