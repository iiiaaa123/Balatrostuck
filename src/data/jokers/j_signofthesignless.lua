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
                [1] = "1 in 60 to be destroyed and reset all Zodiac levels. ",
                [2] = "If a played card is just a wild card destroy it and level up the Zodiac of the same rank"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 9,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            local zodiacs = {'Gemini','Taurus','Cancer','Leo','Virgo','Libra','Scorpio','Sagittarius','Capricorn','Aquarius','Pisces','Ophiuchus','Aries'}
            if context.individual and context.cardarea == G.play and #context.full_hand == 1 then
                if SMODS.has_enhancement(context.other_card, 'm_wild') then
                    local toilet = context.other_card:get_id()
                    local key = zodiacs[toilet - 1]
                    G.GAME.BALATROSTUCK.zodiac_levels[key] = G.GAME.BALATROSTUCK.zodiac_levels[key] + 1

                    if G.GAME.BALATROSTUCK.zodiac_levels[key] == 1 then
                      local newCaste = Caste('caste_bstuck_' .. key,G.P_CASTES['caste_bstuck_' .. key])
                      table.insert(G.GAME.BALATROSTUCK.active_castes, newCaste)
                    end

                    return {
                        message = 'Upgraded!',
                        card = card
                    }
                end
            end

            if context.destroying_card then
                if SMODS.has_enhancement(context.destroying_card, 'm_wild') then
                    return true
                end
            end

            if context.joker_main then
                if pseudorandom('Signless') < G.GAME.probabilities.normal/card.ability.extra.odds then
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