function Balatrostuck.INIT.Jokers.j_questbed()
    SMODS.Joker{
        name = "Quest Bed",
        key = "questbed",
        config = {
            extra = 2
        },
        loc_vars = function(self,info_queue,card)
            return {
                vars = {card.ability.extra}
            }
        end,
        loc_txt = {
            ['name'] = 'Quest Bed',
            ['text'] = {
                [1] = 'Upon {C:attention}death{} destroy',
                [2] = 'all jokers and add',
                [3] = '{C:attention}#1#{} levels to',
                [4] = 'current {C:aspect}Aspect{}'
            }
        },
        pos = {
            x = 1,
            y = 0
         },
        cost = 7,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.game_over then
                local color = G.C.WHITE
                if G.GAME.slab then
                    G.GAME.slab:increase_level(card.ability.extra)
                    local aspect = string.gsub(G.GAME.slab.key, "slab_bstuck_", "")
                    aspect = string.upper(aspect)
                    color = G.C[aspect]
                end
                                
                
                -- if card.edition and card.edition.key == 'e_bstuck_paradox' then
                --     G.E_MANAGER:add_event(Event({
                --         func = function()
                --             card:juice_up()
                --             card:set_edition({})
                --             play_sound('generic1')
                --             return true
                --         end
                --     }))
                --     delay(1)
                -- end
    
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('bstuck_HomestuckAscend',0.7,0.1)

                        card:shatter()
                        return true
                    end
                }))
                
                return {
                    message = 'Ascended!',
                    saved = true,
                    colour = color
                }
            end
        end
    }
end