function Balatrostuck.INIT.Jokers.j_applejuice()
    SMODS.Joker{
        name = "Apple Juice",
        key = "applejuice",
        config = { extra = {
            d_size = 8
        }},
        loc_txt = {
            ['name'] = 'Apple Juice',
            ['text'] = {
                [1] = 'Gain {C:red}+1{} discard when',
                [2] = '{C:attention}0{} discards remaining',
                [3] = '{C:inactive}({C:attention}#1#{C:inactive} uses left)'
            }
        },
        pos = {
            x = 0,
            y = 4
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = false,
        unlocked = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.d_size}}
        end,

        calculate = function(self,card,context)
            if (context.pre_discard and not context.blueprint_card and not context.hook) and G.GAME.current_round.discards_left <= 1 then
                local left, me = nil, nil
                for k, v in ipairs(G.jokers.cards) do
                    if v == card then me = v end
                    if left == nil and v.config.center_key == 'j_bstuck_applejuice' then left = v end
                end
                if me == left then
                    if card.ability.extra.d_size <= 1 then
                        ease_discard(1, nil, true)
                        card.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:start_dissolve({G.C.RED}, nil, 1.6)
                                return true;
                            end
                        }))
                        return {
                            message = localize('k_drank_ex'),
                            colour = G.C.FILTER
                        }
                    else
                    G.E_MANAGER:add_event(Event({func = function()
                        ease_discard(1, nil, true)
                        card.ability.extra.d_size = card.ability.extra.d_size - 1
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-1 Discard", colour = G.C.RED})
                    return true end }))
                    end
                end
            elseif context.first_hand_drawn and G.GAME.current_round.discards_left == 0 and not context.blueprint then
                local left, me = nil, nil
                for k, v in ipairs(G.jokers.cards) do
                    if v == card then me = v end
                    if left == nil and v.config.center_key == 'j_bstuck_applejuice' then left = v end
                end
                if me == left then
                    if card.ability.extra.d_size <= 1 then
                        ease_discard(1, nil, true)
                        card.getting_sliced = true
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:start_dissolve({G.C.RED}, nil, 1.6)
                                return true;
                            end
                        }))
                        return {
                            message = localize('k_drank_ex'),
                            colour = G.C.FILTER
                        }
                    else
                    G.E_MANAGER:add_event(Event({func = function()
                        ease_discard(1, nil, true)
                        card.ability.extra.d_size = card.ability.extra.d_size - 1
                        card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = "-1 Discard", colour = G.C.RED})
                    return true end }))
                    end
                end
            end
        end
    }
end 