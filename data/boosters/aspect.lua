SMODS.Booster{
    key = 'aspect_booster',
    atlas = 'HomestuckAspectBooster',
    discovered = true,
    loc_txt = {
        ['name'] = 'Aspect Pack',
        ['text'] = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} Aspects to',
            'be used immediately'
        },
        group_name = 'Aspect Pack'
    },
    pos = { x = 0, y = 0 },
    create_card = function(self, card,i)
        if i == 1 or G.GAME.gamer_choices == nil then
            G.GAME.gamer_choices = {}
        end
        
        local qualityControl = false
        for v=1, #G.vouchers.cards do
            local lekey = G.vouchers.cards[v].config.center.key
            if lekey == 'v_bstuck_aspect_mastery' then
                qualityControl = true
            end
        end

        local key = get_aspect_for_pack(qualityControl)
        local card = SMODS.create_card({set = "Aspect", area = G.pack_cards, key = key, skip_materialize = true, soulable = true, key_append = "gam"})
        return card
        
        
        
    end
}