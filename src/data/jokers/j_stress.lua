function Balatrostuck.INIT.Jokers.j_stress()
    SMODS.Joker{
        name = "Stress",
        key = "stress",
        config = {
            extra = {
                xmult = 3
            }
        },
        loc_txt = {
            ['name'] = 'Stress',
            ['text'] = {
                [1] = 'Gives {C:white,X:mult}X#1#{} if {C:attention}2 face cards{}',
                [2] = 'are destroyed during the round'
            }
        },
        pos = {
            x = 5,
            y = 7
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.xmult}}
        end
    }
end