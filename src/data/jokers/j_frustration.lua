-- DONE: This joker doesn't need any more work unless something comes up
-- this is the first joker that needs a refactor (in alphabetical order)
function Balatrostuck.INIT.Jokers.j_frustration() 
    SMODS.Joker{
        name = "Frustration",
        key = "frustration",
        config = {
            extra = {
                chips_amt = 2,
                chips_total = 0
            }
        },
        loc_txt = {
            ['name'] = 'Frustration',
            ['text'] = {
                [1] = "Gains {C:chips}+#1# Chips{} per",
                [2] = "{C:attention}non-scoring card{} played",
                [3] = "{C:inactive}(Currently: {}{C:chips}+#2# Chips{}{C:inactive}){}"
            }
        },
        pos = {
            x = 1,
            y = 3
        },
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.chips_amt, card.ability.extra.chips_total}}
        end,

        calculate = function(self, context)
            if context.joker_main and context.cardarea == G.jokers then
                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips_total } },
                    chip_mod = self.ability.extra.chips_total,
                    colour = G.C.CHIPS
                }
            elseif context.cardarea == G.play and context.individual then
                local scoring_amount = #context.scoring_hand
                local full_amount = #context.full_hand

                local mult_incr = full_amount - scoring_amount
                self.ability.extra.chips_total = self.ability.extra.chips_total + (self.ability.extra.chips_amt * mult_incr)
            end
        end
    }:register()
end