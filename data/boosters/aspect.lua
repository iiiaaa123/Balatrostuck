SMODS.Booster{
    key = 'aspect_booster',
    atlas = 'HomestuckAspectBooster',
    config = {extra = 2, choose = 1},
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
    kind = 'aspect',
    weight = 0.3,
    pos = { x = 0, y = 0 },
    create_card = function(self, card,i)
        if i == 1 then
            G.GAME.gamer_choices = {}
            if next(SMODS.find_card('v_bstuck_aspect_mastery')) and G.GAME.slab then
                local card = SMODS.create_card({set = "Aspect", area = G.pack_cards, key = 'c_bstuck_' .. string.gsub(G.GAME.slab.key, "slab_bstuck_", ""), skip_materialize = true, soulable = true, key_append = "gam"})
                table.insert(G.GAME.gamer_choices,card.config.center.key)
                return card
            end
        end
        local qualityControl = false
        for v=1, #G.vouchers.cards do
            local lekey = G.vouchers.cards[v].config.center.key
            if lekey == 'v_bstuck_giftofgab' then
                qualityControl = true
            end
        end

        local key = get_aspect_for_pack(qualityControl,true)
        local card = SMODS.create_card({set = "Aspect", area = G.pack_cards, key = key, skip_materialize = true, soulable = true, key_append = "gam"})
        return card
    end
}