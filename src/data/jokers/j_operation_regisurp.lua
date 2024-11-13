-- TODO: Calculation logic, general rework
function Balatrostuck.INIT.Jokers.j_operation_regisurp()
    SMODS.Joker{
        name = "Operation Regisurp",
        key = "operation_regisurp",
        config = {
            extra = {
                suit = "Spades",
                dollars = 12
            }
        },
        loc_txt = {
            ['name'] = 'Operation Regisurp',
            ['text'] = {
                [1] = "When {C:attention}Queen of #1#{} is scored",
                [2] = "destroy the card and gain {C:money}$#2#{}",
            }
        },
        pos = {
            x = 8,
            y = 3
        },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_def = function(card)
            return {card.ability.extra.suit, card.ability.extra.dollars}
        end,

        calculate = function(self, context)
            
        end
    }:register()
end