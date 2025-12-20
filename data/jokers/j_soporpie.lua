function Balatrostuck.INIT.Jokers.j_soporpie()
    SMODS.Joker{
        name = "Sopor Pie",
        key = "soporpie",
        config = {
            extra = {
                chips = 100,
                chips_mod = 100,
                h_size = 1
            }
        },
        loc_txt = {
            ['name'] = 'Sopor Pie',
            ['text'] = {
                -- [1] = '{C:blue}+#2# Chips{} every round',
                -- [2] = '{C:attention}-1 hand size per round',
                -- [3] = '{C:inactive}(Currently: {C:blue}+#1# Chips{}{C:inactive})'
                '{C:blue}+#1#{} Chips, {C:attention}-#3#{} hand size,',
                'increases by {C:blue}100{} and',
                'reduces by {C:red}1{} every round',

            },
            unlock = {'{C:red}Lose{} a Run because',
                    'you {C:attention}cannot draw cards{}'}
        },
        pos = {
            x = 2,
            y = 4
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.chips, card.ability.extra.chips_mod, card.ability.extra.h_size}}
        end,

        check_for_unlock = function(self,args)
            if args.type == 'bstuck_soporpie' then
                unlock_card(self)
            end
        end,

        add_to_deck = function(self, card, from_debuff)
            G.hand:change_size(-1)
        end,

        remove_from_deck = function(self, card, from_debuff)
            G.hand:change_size(card.ability.extra.h_size)
        end,

        calculate = function(self, card, context)
            if context.joker_main and context.cardarea == G.jokers then
                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } },
                    chip_mod = card.ability.extra.chips,
                    colour = G.C.CHIPS
                }
            elseif context.end_of_round and not (context.repetition or context.individual or context.blueprint) then
                card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
                card.ability.extra.h_size = card.ability.extra.h_size + 1
                G.hand:change_size(-1)
                return {
                    message = 'YuMmYy!',
                    colour = G.C.GREEN
                }
            end
        end
    }
end
