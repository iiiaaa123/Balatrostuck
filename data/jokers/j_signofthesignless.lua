function Balatrostuck.INIT.Jokers.j_signofthesignless()
    SMODS.Joker{
        name = "Sign of the Signless",
        key = "signofthesignless",
        config = {
            extra = {odds = 60}
        },
        loc_txt = {
            ['name'] = 'Sign of the Signless',
            ['text'] = {
                "If played hand is a single {C:attention}Wild Card{}",
                "create the corresponding {C:zodiac}Zodiac{} card,",
                "{C:green}1 in #1#{} chance to {C:red,E:2}self destruct{}",
                "and reset all {C:zodiac}Zodiac{} levels to {C:attention}0"
            }
        },
        pos = {
            x = 1,
            y = 7
         },
        cost = 9,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            info_queue[#info_queue+1] = G.P_CENTERS['m_wild']
            return {vars = {card.ability.extra.odds}}
        end,
        calculate = function(self,card,context)
            if context.individual and context.cardarea == G.play and #context.full_hand == 1 then
                if SMODS.has_enhancement(context.other_card, 'm_wild') then
                    if G.consumeables.config.card_limit - #G.consumeables.cards >= 1 then
                        return {
                            message = '+1 Zodiac!',
                            card = card,
                            func = function()
                                local haha = context.other_card
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local _card = SMODS.add_card({set = 'Zodiac', key = 'c_bstuck_' .. string.lower(rank_to_zodiac(haha))})
                                        return true
                                    end
                                }))
                            end
                        }
                    end
                end
            end

            if context.destroying_card and #G.play.cards == 1 and (G.consumeables.config.card_limit - #G.consumeables.cards >= 1) then
                if SMODS.has_enhancement(context.destroying_card, 'm_wild') then
                    return {remove = true}
                end
            end

            if context.joker_main then
                if pseudorandom('Signless') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    G.GAME.BALATROSTUCK.zodiac_levels = { Aries = 0, Taurus = 0, Gemini = 0, Cancer = 0,Leo = 0,Virgo = 0,Libra = 0,Scorpio = 0,Sagittarius = 0,Capricorn = 0,Aquarius = 0,Pisces = 0,Ophiuchus = 0}
                    G.GAME.BALATROSTUCK.active_castes = {}
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(self)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    }))
                    return {
                        message = 'Culled!',
                        card = card
                    }
                else
                    return {
                        message = 'Safe!',
                        card = card
                    }
                end
            end
        end
    }
end 