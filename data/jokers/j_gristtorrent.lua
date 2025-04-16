function Balatrostuck.INIT.Jokers.j_gristtorrent()
    SMODS.Joker{
        name = "GristTorrent",
        key = "gristtorrent",
        config = {
            extra = {
                uses = 5,
                money = 1,
                tor = 1
            }
        },
        loc_txt = {
            ['name'] = 'GristTorrent',
            ['text'] = {
                [1] = 'Every played {C:attention}card{} permanently loses {C:blue}-2{} Chips',
                [2] = 'when scored. The first {C:attention}5{} times this happens',
                [3] = 'each round, earn {C:money}$1{}. The {C:attention}6th+{} time this happens',
                [4] = 'each round, this Joker gains {C:money}$1{} of sell value',
                [5] = '{C:inactive}({C:attention}5{C:inactive} remaining)'
            }
        },
        pos = {
            x = 7,
            y = 0
         },
        cost = 7,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.uses, card.ability.extra.money, card.ability.extra.tor}}
        end,

        calculate = function(self, card, context)
            if context.cardarea == G.play and context.individual and card.ability.extra.uses > 0 
            and ((context.other_card.ability.perma_bonus or 0) + context.other_card.base.nominal) > 0 then

                context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
                context.other_card.ability.perma_bonus = math.min((context.other_card.ability.perma_bonus - card.ability.extra.tor), 0)

                if not context.blueprint then
                    card.ability.extra.uses = card.ability.extra.uses - 1
                end
                G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
                    G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
                    return {
                        dollars = card.ability.extra.money,
                        card = card
                    }

            elseif context.cardarea == G.play and context.individual and card.ability.extra.uses <= 0 and not context.blueprint then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.money
                    card:set_cost()
                    return {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }

            elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
                card.ability.extra.uses = 5
                return {
                    message = localize('k_reset'),
                    colour = G.C.FILTER
                }
            end
        end
    }
end