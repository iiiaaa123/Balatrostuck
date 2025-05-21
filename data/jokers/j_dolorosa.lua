function Balatrostuck.INIT.Jokers.j_dolorosa()
    SMODS.Joker{
        name = "Wardrobifier",
        key = "dolorosa",
        config = {
            extra = {
                clothes = "m_bonus"
            }
        },
        loc_txt = {
            ['name'] = 'Wardrobifier',
            ['text'] = {
                [1] = "If {C:attention}first played hand{} is a {C:attention}high card{}",
                [2] = "create the {C:paradox}Paradox{} {C:tarot}Tarot{} corresponding",
                [3] = "to each {C:attention}enhanced{} card scored"
            }
        },
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS["e_bstuck_paradox"]
            return {
                vars = {localize {
                    type = 'name_text',
                    key = card.ability.extra.clothes,
                    set = 'Enhanced'
                }}
            }
        end,    
        pos = {
            x = 4,
            y = 5
         },
        cost = 8,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.setting_blind then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end

            if context.individual and context.cardarea == G.play and context.scoring_name == 'High Card' and G.GAME.current_round.hands_played == 0 then
                local _card = context.other_card
                local peepee = SMODS.get_enhancements(_card)
                for k,v in pairs(peepee) do
                    if Balatrostuck.enhancement_cards[k] then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                local _taort = SMODS.add_card({key = Balatrostuck.enhancement_cards[k]})
                                _taort:set_edition('e_bstuck_paradox',false,false)
                                _card:juice_up()
                                return true
                            end
                        }))
                    end
                end
            end
        end
        }
end 