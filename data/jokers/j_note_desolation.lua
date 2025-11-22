function Balatrostuck.INIT.Jokers.j_note_desolation()
    SMODS.Joker{
        name = "Note Desolation",
        key = "note_desolation",
        config = {
            extra = {
                chips = 612,
                rolls = 0,
                active = false
            }
        },
        loc_txt = {
            ['name'] = 'Note Desolation',
            ['text'] = {
                [1] = '{C:green}Reroll{} base cost is {C:money}$4{}, after',
                [2] = '{C:attention}13{} Rerolls this gives {C:chips}+#1#{} Chips',
                [3] = 'on the {C:attention}next hand{} played',
                [4] = '{C:inactive}(Currently {C:attention}#2#{C:inactive}/13)'
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        cost = 4,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        add_to_deck = function(self,card,from_debuff)
            G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost - 1
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.round_resets.reroll_cost = G.GAME.round_resets.reroll_cost + 1
        end,
        calculate = function(self,card,context)
            if context.reroll_shop and not context.blueprint and not card.ability.extra.active then
                card.ability.extra.rolls = card.ability.extra.rolls + 1
                if card.ability.extra.rolls < 13 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = (13 - card.ability.extra.rolls).." Left!", colour = G.C.FILTER})
                end
                if card.ability.extra.rolls >= 13 then
                    card.ability.extra.active = true                    
                    local eval = function(card) return (card.ability.extra.active) end
                    juice_card_until(card, eval, true)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_active_ex')})
                end
            end

            if context.joker_main and card.ability.extra.active then
                local tempchips = card.ability.extra.chips 
                card.ability.extra.rolls = 0
                return {
                    chips = tempchips,
                    card = card
                }
            end

            if context.after and not context.blueprint and card.ability.extra.active then
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_reset')})
                card.ability.extra.active = false
            end
                
        end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.chips, math.min(card.ability.extra.rolls, 13)}}
        end
    }
end