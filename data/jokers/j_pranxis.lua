function Balatrostuck.INIT.Jokers.j_pranxis()
    SMODS.Joker{
        name = "Pranxis",
        key = "pranxis",
        config = {
            extra = { amount_to_steal = 1, amount_to_gain = 2
            }
        },
        --  When a card is sold for $1 or less, this gain $2 in sell value

        loc_txt = {
            ['name'] = 'Pranxis',
            ['text'] = {
                "{C:Attention}Steals{} {C:money}$#1#{} of sell value from ",
                "other {C:attention}Jokers{} at end of round.",
                "When a card is sold for {C:money}$1{} or less",
                "this gains {C:money}$#2#{} in sell value"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 5,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.end_of_round and not context.blueprint and not context.repetition and not context.blueprint and not context.individual  then
                local _stolen = 0
                for _, joker in ipairs(G.jokers.cards) do
                    if joker ~= card and (((joker.sell_cost - card.ability.extra.amount_to_steal) >= 0) or joker.config.center_key == "j_bstuck_jocker") then
                        joker.ability.extra_value = (joker.ability.extra_value or 0) - card.ability.extra.amount_to_steal
                        _stolen = _stolen + card.ability.extra.amount_to_steal
                        joker:set_cost()
                        card_eval_status_text(joker, 'extra', nil, nil, nil, {message = "PRANK'D", colour = G.C.MONEY})
                    end
                end
                card.ability.extra_value = card.ability.extra_value + _stolen
                card:set_cost()
                return {
                        message = localize('k_val_up'),
                        message_card = card,
                        colour = G.C.MONEY
                    }

            end
            if context.selling_card and context.card and self ~= context.card then
                if context.card.sell_cost <= 1 then
                card.ability.extra_value = card.ability.extra_value + card.ability.extra.amount_to_gain
                card:set_cost()
                return {
                        message = localize('k_val_up'),
                        message_card = card,
                        colour = G.C.MONEY
                    }
                end
            end
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.amount_to_steal,card.ability.extra.amount_to_gain}}
        end,
    }
end 