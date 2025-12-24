function Balatrostuck.INIT.Jokers.j_potionseller()
    SMODS.Joker{
        name = "Potion Seller",
        key = "potionseller",
        config = {
            extra = { stored_card = nil, cost = 0
            }
        },
        loc_txt = {
            ['name'] = 'Potion Seller',
            ['text'] = {
                "You can use this card to create the last {C:attention}destroyed or sold{}",
                "playing card or joker for its buy price",
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 4,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.blueprint then return end --no blueprint!
            --destroying
            if context.remove_playing_cards == true and context.removed then --playing cards
                card.ability.extra.stored_card = nil
                card.ability.extra.stored_card = context.removed[#context.removed]
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Restocked!"})
            end
            if context.BSTUCK_joker_destroyed == true and context.other_card then --jokers destructions from bstuck
                card.ability.extra.stored_card = nil
                card.ability.extra.stored_card = context.other_card
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Restocked!"})
            end
            if context.joker_type_destroyed == true and context.card then --vanilla joker destruction
                card.ability.extra.stored_card = nil
                card.ability.extra.stored_card = context.card
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Restocked!"})
            end
            --selling
            if context.selling_card and context.card ~= card then
                card.ability.extra.stored_card = nil
                card.ability.extra.stored_card = context.card
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Restocked!"})
            end
        end,
        can_activate = function(self,card,args)
            local _stored_card = card.ability.extra.stored_card
            local _cost = card:activate_cost()
            if _stored_card then
                local _is_playing_card = (_stored_card.config.center.set == "Default" or _stored_card.config.center.set == "Enhanced")
                if _is_playing_card and G.STATE == G.STATES.SELECTING_HAND and _cost <= G.GAME.dollars - G.GAME.bankrupt_at then
                    return true
                elseif not _is_playing_card and G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer) > 0 and _cost <= G.GAME.dollars - G.GAME.bankrupt_at then --must have room
                    return true
                end
            end
            return false
        end,
        activate_cost = function(self,card,args)
            local _stored_card = card.ability.extra.stored_card
            if _stored_card then return _stored_card.cost or 0 end
            return nil

        end,
        activate = function(self,card,args)
            local _stored_card = card.ability.extra.stored_card
            if _stored_card then
                ease_dollars(-card:activate_cost())
                local _is_playing_card = (_stored_card.config.center.set == "Default" or _stored_card.config.center.set == "Enhanced")
                if _is_playing_card then
                    local new_card = bstuck_copy_card(_stored_card)
                    G.hand:emplace(new_card)
                    card.ability.extra.stored_card = nil
                else
                    SMODS.add_card({set='Joker',key=_stored_card.config.center.key})
                    card.ability.extra.stored_card = nil
                end
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Bought!"})
            end
        end,
        loc_vars = function (self, info_queue, card)
            local get_card_name = function(_card)
                if _card then
                    local rank = _card.base.value
                    local suit = _card.base.suit
        
                    if _card.ability.effect ~= 'Stone Card' then
                        return localize(rank, 'ranks') .. " of " .. localize(suit, "suits_plural")
                    else
                        return "Stone"
                    end
                else
                    return "Unassigned"
                end
            end
            local _card_name
            local _stored_card = card.ability.extra.stored_card
            if _stored_card then
                local _is_playing_card = (_stored_card.config.center.set == "Default" or _stored_card.config.center.set == "Enhanced")
                _card_name = _stored_card.label
                if _is_playing_card then
                    _card_name = get_card_name(_stored_card)
                end
            end

            --local _card_price = _stored_card.ability.cost
            art_credit('akai', info_queue)
            return {
                vars = {G.GAME.probabilities.normal},
                main_end = {
                    BSUI.Modules.GameText.FormatBadge(' '..(_card_name or "None!")..' ', G.C.BLUE)
                }
            }
        end,
    }
end 