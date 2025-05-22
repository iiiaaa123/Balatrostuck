SMODS.Booster{
    key = 'aspect_booster_jumbo',
    atlas = 'HomestuckAspectBooster',
    config = {extra = 4, choose = 1},
    discovered = false,
    loc_txt = {
        ['name'] = 'Jumbo Aspect Pack',
        ['text'] = {
            'Choose {C:attention}#1#{} of up to',
            '{C:attention}#2#{} Aspects to',
            'be used immediately'
        },
        group_name = 'Aspect Pack'
    },
    kind = 'aspect',
    cost = 4,
    weight = 0.3,
    pos = { x = 2, y = 0 },
    create_card = function(self, card,i)
        local card = SMODS.create_card({set = "Aspect", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "gam"})
        return card
    end
}