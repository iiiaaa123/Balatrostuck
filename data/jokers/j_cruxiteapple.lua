function Balatrostuck.INIT.Jokers.j_cruxiteapple()
    SMODS.Joker{
        name = "Cruxite Apple",
        key = "cruxiteapple",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Cruxite Apple',
            ['text'] = {
                [1] = "After {C:attention}final hand{} of round,",
                [2] = "gain {C:attention}1{} free {C:green}Reroll{} in the shop",
                [3] = "and {C:attention}destroy{} this card"
            }
        },
        pos = {
            x = 0,
            y = 1
         },
        cost = 1,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers and G.GAME.current_round.hands_left == 0 then
                add_tag(Tag('tag_d_six'))
                delay(0.1)

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
                check_for_unlock({type = 'bstuck_apple_eaten'})
                if not (G.GAME.pool_flags.bstuck_actprogress and G.GAME.pool_flags.bstuck_actprogress <= 1) then
                    G.GAME.pool_flags.bstuck_actprogress = 1
                end
                return {
                    message = 'Bitten!',
                    colour = G.C.FILTER
                }
            end
        end
        --needs a tooltip in the info queue that says "Unlocks Acend this run"
    }
end 