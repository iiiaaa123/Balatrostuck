function Balatrostuck.INIT.Editions.e_paradox()
    SMODS.Shader{
        key = 'paradox',
        path = 'paradox.fs'
    }
    SMODS.Edition{
        key = "paradox",
        shader = 'paradox', -- change that to paradox shader later
        loc_txt = {
            name = 'Paradox',
            label = 'Paradox',
            text = { '{C:red}Destroyed{} at the end of blind', 'occupies {C:dark_edition}no space{}' },
        },
        extra_cost = -3,
        config = {card_limit = 1},
        sound = { sound = "bstuck_HomestuckParadox", per = 0.7, vol = 0.4 },
        badge_colour = HEX('6ABE30'),
        unlocked = true,
        discovered = true,
        calculate = function(self,card,context)
            if context.end_of_round and context.other_card == nil then
                
                -- Life money
                if G.GAME.BALATROSTUCK.current_aspect == 'life' then
                    local aspectLevel = G.GAME.BALATROSTUCK.aspect_levels['Life']
                    ease_dollars(aspectLevel * 2)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$')..(aspectLevel*2),colour = G.C.MONEY, delay = 0.45})
                end

                -- deletion
                if not next(SMODS.find_card('j_bstuck_biscuits')) then
                    if context.cardarea == G.hand or (context.cardarea ~= G.deck and context.cardarea ~= G.discard) then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                play_sound('tarot1')
                                card.T.r = -0.2
                                card:juice_up(0.3, 0.4)
                                card.states.drag.is = true
                                card.children.center.pinch.x = true
                                G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                    func = function()
                                            context.cardarea:remove_card(card)
                                            card:remove()
                                            card = nil
                                return true; end}))
                            return true
                            end
                        }))
                        return {
                            message = '-Ify!'
                        }
                    else
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                context.cardarea:remove_card(card)
                                card:remove()
                                card = nil
                                return true
                        end}))
                    end
                end
            end
        end
    }

end