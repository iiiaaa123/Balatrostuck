SMODS.Booster{
    key = 'zodiac2_booster',
    atlas = 'HomestuckAspectBooster',
    config = {extra = 3, choose = 1},
    discovered = false,
    loc_txt = {
        ['name'] = 'Zodiac Pack',
        ['text'] = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} {C:zodiac}Zodiac{} cards to',
            'be used immediately' 
        },
        group_name = 'Zodiac Pack'
    },
    kind = 'zodiac',
    weight = 1,
    cost = 4,
    pos = { x = 1, y = 1 },
    create_card = function(self, card,i)
        if i == 1 or G.GAME.gamer_choices == nil then
            G.GAME.gamer_choices = {}
        end
        
        local qualityControl = false
        for v=1, #G.vouchers.cards do
            local lekey = G.vouchers.cards[v].config.center.key
            if lekey == 'v_bstuck_giftofgab' then
                qualityControl = true
            end
        end

        local key = get_zodiac(qualityControl,true)
        local card = SMODS.create_card({set = "Zodiac", area = G.pack_cards, key = key, skip_materialize = true, soulable = true, key_append = "gam"})
        return card
        
        
        
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, G.C.SECONDARY_SET.Zodiac)
        ease_background_colour({ new_colour = G.C.SECONDARY_SET.Zodiac, special_colour = G.C.BLACK, contrast = 2 })
    end,

}