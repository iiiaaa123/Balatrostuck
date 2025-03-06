function Balatrostuck.INIT.Jokers.j_clover()
    SMODS.Joker{
        name = "Clover",
        key = "clover",
        config = {
            extra = { satisfied = false
            }
        },
        loc_txt = {
            ['name'] = 'Clover',
            ['text'] = {
                [1] = "When round begins, create {C:green}#1#",
                [2] = "{C:attention}Lucky {C:green}Paradox {C:clubs}4 of Clubs{} in hand"
            }
        },
        pos = {
            x = 2,
            y = 5
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.first_hand_drawn then
                local firstmat = nil
                for i=1, G.GAME.probabilities.normal do
                    G.E_MANAGER:add_event(Event({
                        func = function() 
                            local front = G.P_CARDS['C_4']
                            G.playing_card = (G.playing_card and G.playing_card + 1) or 1
                            local _card = Card(G.play.T.x + G.play.T.w/2, G.play.T.y, G.CARD_W, G.CARD_H, front, G.P_CENTERS.m_lucky, {playing_card = G.playing_card})
                            _card:start_materialize({G.C.PARADOX},firstmat)
                            firstmat = true
                            _card:set_edition('e_bstuck_paradox',true,true)
                            G.hand:emplace(_card)
                            G.GAME.blind:debuff_card(_card)
                            G.hand:sort()
                            if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
                            -- G.deck.config.card_limit = G.deck.config.card_limit + 1
                            delay(0.1)
                            return true
                        end}))
                    playing_card_joker_effects({_card})
                end
            end
        end,
        loc_vars = function (self, info_queue, card)
            return {vars = {G.GAME.probabilities.normal}}
        end,
    }
end 