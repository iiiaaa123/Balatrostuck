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
    set_ability = function(self, card, initial, delay_sprites)
        if pseudorandom('piss') < 1/4 then
            card.ability.extra = 13
        end
    end,
    weight = 0,
    create_card = function(self, card,i)
        keys = {
            'breath', 'void', 'blood', 'time', 'heart', 'rage', 'light', 'hope', 'life', 'mind', 'doom','space', 'piss'
        }
        if i > #keys then
            i = 1
        end

        return {set = "Aspect", key = 'c_bstuck_' .. keys[i], area = G.pack_cards, skip_materialize = true, soulable = false, key_append = "buf"}
    end
}