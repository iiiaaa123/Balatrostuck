function Balatrostuck.INIT.Jokers.j_synchronization()
    SMODS.Joker{
        name = "Synchronization",
        key = "synchronization",
        config = {
            extra = {
                Xmult = 3,
                faces = 0
            }
        },
        loc_txt = {
            ['name'] = 'Synchronization',
            ['text'] = {
                [1] = '{C:white,X:mult}X#1#{} Mult if {C:attention}2 face cards{}',
                [2] = 'have been destroyed this {C:attention}ante'
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
            return {vars = {card.ability.extra.Xmult}}
        end,

        calculate = function(self, card, context)
            if context.cards_destroyed and not context.blueprint and card.ability.extra.faces < 2 then
                for k, val in ipairs(context.glass_shattered) do
                    if val:is_face() then
                        card.ability.extra.faces = card.ability.extra.faces + 1
                    end
                end
                if card.ability.extra.faces >= 2 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
                end
                
            elseif context.remove_playing_cards and not context.blueprint and card.ability.extra.faces < 2 then
                card.ability.extra.tick = false
                for k, val in ipairs(context.removed) do
                    if val:is_face() then
                        card.ability.extra.faces = card.ability.extra.faces + 1
                    end
                end
                if card.ability.extra.faces >= 2 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex'), colour = G.C.FILTER})
                end

            elseif context.cardarea == G.jokers and context.joker_main and card.ability.extra.faces >= 2 then
                return{
                    message = localize{type='variable',key='a_xmult',vars={card.ability.extra.Xmult}},
                    Xmult_mod = card.ability.extra.Xmult
                }

            elseif context.end_of_round and not context.repetition and not context.individual and G.GAME.blind.boss and not context.blueprint then
                card.ability.extra.faces = 0
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset'), colour = G.C.FILTER})
            end
        end
    }
end