function Balatrostuck.INIT.Jokers.j_captchacard()
    SMODS.Joker{
        name = "Captchalogue Card",
        key = "captchacard",
        config = {
            extra = {
                rank = 10,
                suit = "Hearts"
            }
        },
        loc_txt = {
            ['name'] = 'Captchalogue Card',
            ['text'] = {
                [1] = "Create a random {C:attention}consumable",
                [2] = "for each scoring {C:attention}#1# of #2#",
                [3] = "in played hand"
            }
        },
        pos = {
            x = 5,
            y = 0
        },
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.rank, card.ability.extra.suit}}
        end
    }
end