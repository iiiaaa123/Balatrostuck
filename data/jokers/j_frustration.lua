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
                [1] = "This Joker gains {C:chips}+#1# Chips{} for",
                [2] = "every {C:attention}non-scoring{} card played",
                [3] = "{C:inactive}(Currently {C:chips}+#2#{C:inactive} Chips)"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 1,
            y = 3
        },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.chips_amt, card.ability.extra.chips_total}}
        end,

        calculate = function(self, card, context)
            if context.joker_main and context.cardarea == G.jokers then
                local scoring_amount = #context.scoring_hand
                local full_amount = #context.full_hand

                local chip_increase = full_amount - scoring_amount
                card.ability.extra.chips_total = card.ability.extra.chips_total + (card.ability.extra.chips_amt * chip_increase)

                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips_total } },
                    chip_mod = card.ability.extra.chips_total,
                    colour = G.C.CHIPS
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end