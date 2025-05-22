function Balatrostuck.INIT.Editions.e_paradox()
    SMODS.Shader{
        key = 'paradox',
        path = 'paradox.fs',
        send_vars = function(sprite, card)
            return {
                paradoxTexture = G.ASSET_ATLAS['bstuck_HomestuckParadox'].image
            }
        end
    }
    SMODS.Edition{
        key = "paradox",
        shader = 'paradox', -- change that to paradox shader later
        loc_txt = {
            name = 'Paradox',
            label = 'Paradox',
            text = { 
                '{C:paradox}Disappears{} at',
                'the end of round', 
                'occupies {C:dark_edition}no space{}' 
            },
        },
        extra_cost = -3,
        config = {card_limit = 1},
        sound = { sound = "bstuck_HomestuckParadox", per = 0.7, vol = 0.4 },
        badge_colour = HEX('6ABE30'),
        unlocked = true,
        discovered = false,
        calculate = function(self,card,context)
            if context.end_of_round and not context.individual and not context.repetition and not context.other_card 
            and not card.alreadyDead then

                -- Life money
                if G.GAME.BALATROSTUCK.current_aspect == 'life' then
                    local aspectLevel = G.GAME.slab and G.GAME.slab:level()
                    ease_dollars(2)
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('$')..(2),colour = G.C.MONEY, delay = 0.45})
                end

                -- deletion
                if not next(SMODS.find_card('j_bstuck_biscuits')) and not (card.ability.consumeable and next(SMODS.find_card('j_bstuck_oldsecret'))) then
                    if context.cardarea == G.hand or (context.cardarea ~= G.deck and context.cardarea ~= G.discard) then
                        card.alreadyDead = true
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
                                    return true; end
                                }))
                                
                                SMODS.calculate_context({ paradox_ify = true, removed = {card}})
                            return true
                        end}))
                        return {
                            message = '-Ify!',
                            card = card,
                            colour = G.C.PARADOX
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