function Balatrostuck.INIT.Jokers.j_paintseal()
    SMODS.Joker{
        name = "Paint Seal",
        key = "paintseal",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Paint Seal',
            ['text'] = {
                [1] = "If {C:attention}first hand{} of round has",
                [2] = "only {C:attention}1{} card, create the",
                [3] = "corresponding {C:zodiac}Zodiac{} card",
                [4] = "and {C:red}destroy{} this Joker",
                [5] = "{C:inactive}(Must have room)"
            }
        },
        pos = {
            x = 7,
            y = 3
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            local zodiacs = {'gemini','taurus','cancer','leo','virgo','libra','scorpio','sagittarius','capricorn','aquarius','pisces','ophiuchus','aries'}

            if context.first_hand_drawn then
                local eval = function() return G.GAME.current_round.hands_played == 0 end
                juice_card_until(card, eval, true)
            end

            if context.before and #context.full_hand == 1 and not SMODS.has_no_rank(context.full_hand[1]) and G.GAME.current_round.hands_played == 0 and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = (function()
                            local zodiac = SMODS.create_card({set = 'Zodiac', key = 'c_bstuck_' .. zodiacs[context.full_hand[1]:get_id() - 1 or 2]})
                            zodiac:add_to_deck()
                            G.consumeables:emplace(zodiac)
                            G.GAME.consumeable_buffer = 0
                        return true
                end)}))

                delay(1)

                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.0,
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = 'Applied!',
                    colour = G.C.FILTER
                }
            end
        end
    }
end 