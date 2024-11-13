-- TODO: Calculation logic
function Balatrostuck.INIT.Jokers.j_batterwitch() 
    SMODS.Joker{
        name = "Batterwitch",
        key = "batterwitch",
        config = {
            extra = {
                poker_hand = "Full House",
                xmult = 0.25,
                total = 1
            }
        },
        loc_txt = {
            ['name'] = 'Batterwitch',
            ['text'] = {
                [1] = 'Levels down {C:attention}#1#{}',
                [2] = 'when played',
                [3] = 'Gains {C:white,X:mult}X#2#{} Mult per level down',
                [4] = '{C:inactive}Hand changes every round{}',
                [5] = '{C:inactive}(Currently: {C:white,X:mult}X#3#{} Mult{C:inactive}){}'
            }
        },
        pos = {
            x = 1,
            y = 5
        },
        cost = 5,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_def = function(card)
            return {card.ability.extra.poker_hand, card.ability.extra.xmult, card.ability.extra.total}
        end,

        calculate = function(self, context)

        end
    }:register()
end