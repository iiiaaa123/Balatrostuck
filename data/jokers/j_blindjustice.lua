function Balatrostuck.INIT.Jokers.j_blindjustice()
    SMODS.Joker{
        name = "Blind Justce",
        key = "blindjustice",
        config = {
            extra = { xmult = 1, xmult_gain = 0.2, checked_debuffed = false}
        },

        --This joker gains +0.2x mult for each debuffed or face-down card played or held this hand. When a blind is selected, 2 cards in your deck permanently become face-down  [until this joker is sold]

        loc_txt = {
            ['name'] = 'Blind Justice',
            ['text'] = {
                "This joker gains +#1#x mult for each debuffed",
                "or face-down card played or held this hand.",
                "When a blind is selected, 2 cards in your",
                "deck permanently become face-down",
                "(until this joker is sold)",
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            

            if context.setting_blind and not context.blueprint_card then
                card.ability.extra.xmult = self.config.extra.xmult
                for i=1,2 do
                    local selected_card = pseudorandom_element(G.playing_cards, pseudoseed(i.."SN1FF"..G.GAME.round_resets.ante))
                    selected_card.ability.facedown_blind_justice = true
                end
            end

            if context.stay_flipped and context.to_area == G.hand then
                
                    if context.other_card.ability.facedown_blind_justice then
                        return {
                            stay_flipped = true
                        }
                    end
                end

            if context.modify_scoring_hand and not context.blueprint_card then --kinda silly but this seems to be the best context to do this..
                if context.other_card.facing == 'back' and not context.other_card.ability.should_scale_blind_justice then
                    context.other_card.ability.should_scale_blind_justice = true
                end
            end

            if context.before then
                if not card.ability.extra.calculated then
                    for _, cardy in ipairs(G.play.cards) do
                        if cardy.debuff or cardy.ability.should_scale_blind_justice then self.scale_up(card,cardy) end
                    end
                    for _, cardy in ipairs(G.hand.cards) do
                        if cardy.debuff or cardy.facing == "back" then self.scale_up(card,cardy) end
                    end
                end
                card.ability.extra.calculated = true
            end
            

            if context.joker_main then
                return {
                    xmult = card.ability.extra.xmult,
                    card = card
                }
            end
            if context.final_scoring_step and not context.blueprint_card then
                card.ability.extra.calculated = nil
                card.ability.extra.xmult = self.config.extra.xmult
                return {
                        message = localize('k_reset'),
                        card = card,
                        colour = G.C.MULT
                }
            end
            if context.end_of_round and context.individual and not context.blueprint_card then
                context.other_card.ability.should_scale_blind_justice = nil
            end

            if context.selling_self then
                for _, card in ipairs(G.playing_cards) do
                    card.ability.facedown_blind_justice = nil
                end
            end

            
            
        end,
        scale_up = function(card,other_card)
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
                card_eval_status_text(other_card, 'extra', nil, nil, nil, {message = "SN1FF", colour = G.C.MIND, instant = false})
                delay(0.3)
                card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_upgrade_ex')})
        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.xmult_gain, card.ability.extra.xmult}}
        end,

    }
end 