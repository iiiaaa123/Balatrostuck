-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_betacopy()
    SMODS.Joker{
        name = "Beta Copy",
        key = "betacopy",
        config = {
            extra = { ante_scaling = 2}
        },
        loc_txt = {
            ['name'] = 'Beta Copy',
            ['text'] = {
                [1] = "{C:red}X2{} Base Blind size",
                [2] = "Gain a {C:attention}Sburb Tag",
                [3] = "at the end of round",
                [4] = "{S:1.1,C:red,E:2}self destructs"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 25,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card) 
            info_queue[#info_queue + 1] = {key = "tag_bstuck_sburb", set = "Tag"}
            info_queue[#info_queue + 1] = G.P_CENTERS['p_bstuck_sburb_booster']
        end,
        in_pool = function(self,args)
            if G.GAME.pool_flags.beta_destroyed then
                return false
            end
            return true
        end,
        add_to_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling * card.ability.extra.ante_scaling
        end,
        remove_from_deck = function(self,card,from_debuff)
            G.GAME.starting_params.ante_scaling = G.GAME.starting_params.ante_scaling / card.ability.extra.ante_scaling
        end,
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        add_tag(Tag('tag_bstuck_sburb'))
                        play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                        play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                        return true
                    end)
                }))
                
                G.E_MANAGER:add_event(Event({
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
                G.GAME.pool_flags.beta_destroyed = true
                return {
                    message = "-Ify!",
                    card = card
                }
            end
        end
    }
end 