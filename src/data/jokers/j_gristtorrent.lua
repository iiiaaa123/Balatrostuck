function Balatrostuck.INIT.Jokers.j_gristtorrent()
    SMODS.Joker{
        name = "GristTorrent",
        key = "gristtorrent",
        config = {
            extra = {
                uses = 5,
                money = 1,
                tor = 2
            }
        },
        loc_txt = {
            ['name'] = 'GristTorrent',
            ['text'] = {
                [1] = 'Played cards lose {C:chips}#3# chips{} when scored (min. 0)',
                [2] = 'Gain {C:money}$#2#{} the first 5 times this happens each round',
                [3] = 'This joker gains {C:money}$#2#{} sell value afterward',
                [4] = 'bluh this wording sucks lets redo it later',
                [5] = '{C:inactive}(Remaining:{} {C:attention}#1#{} {C:inactive}uses)'
            }
        },
        pos = {
            x = 3,
            y = 10
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
    }:register()
end