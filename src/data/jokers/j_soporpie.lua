function Balatrostuck.INIT.Jokers.j_soporpie()
    SMODS.Joker{
        name = "Sopor Pie",
        key = "soporpie",
        config = {
            extra = {
                chips = 100,
                chips_mod = 100,
            }
        },
        loc_txt = {
            ['name'] = 'Sopor Pie',
            ['text'] = {
                [1] = '{C:blue}+#2# Chips{} every round',
                [2] = '{C:attention}-1 hand size per round',
                [3] = '{C:inactive}(Currently: {C:blue}+#1# Chips{}{C:inactive})'
            }
        },
        pos = {
            x = 2,
            y = 4
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.chips, card.ability.extra.chips_mod}}
        end,

        calculate = function(self, card, context)
            if context.joker_main and context.cardarea == G.jokers then
                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            elseif context.setting_blind and not (context.repetition or context.individual or context.blueprint) then
                G.hand:change_size(-1)
            elseif context.end_of_round and not (context.repetition or context.individual or context.blueprint) then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            end
        end
    }
end