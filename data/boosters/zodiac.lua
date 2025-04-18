SMODS.Booster{
    key = 'zodiac_booster',
    atlas = 'HomestuckAspectBooster',
    config = {extra = 3, choose = 1},
    discovered = true,
    loc_txt = {
        ['name'] = 'Zodiac Pack',
        ['text'] = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} Zodiac{} cards to',
            'be used immediately' 
        },
        group_name = 'Zodiac Pack'
    },
    pos = { x = 0, y = 1 },
    create_card = function(self, card,i)
        if i == 1 or G.GAME.gamer_choices == nil then
            G.GAME.gamer_choices = {}
        end
        
        local qualityControl = false
        for v=1, #G.vouchers.cards do
            local lekey = G.vouchers.cards[v].config.center.key
            if lekey == 'v_bstuck_gift_of_gab' then
                qualityControl = true
            end
        end

        local key = get_zodiac(qualityControl)
        local card = SMODS.create_card({set = "Zodiac", area = G.pack_cards, key = key, skip_materialize = true, soulable = true, key_append = "gam"})
        return card
        
        
        
    end
}