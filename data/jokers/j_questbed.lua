function Balatrostuck.INIT.Jokers.j_questbed()
    SMODS.Joker{
        name = "Quest Bed",
        key = "questbed",
        config = {
            extra = 2
        },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {
                vars = {card.ability.extra}
            }
        end,
        loc_txt = {
            ['name'] = 'Quest Bed',
            ['text'] = {
                'Prevents Death',
                'then adds {C:attention}2{} levels',
                'to current {C:aspect}Aspect',
                '{C:red,E:2}destroys all jokers{}',
            },
            unlock = {"{C:attention}Discover{} every", "{C:aspect}Aspect{} card"}
        },
        pos = {
            x = 1,
            y = 0
         },

         check_for_unlock = function(self,args)
            if args.type == 'bstuck_questbed' then
                unlock_card(self)
            end
        end,

        cost = 7,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.game_over then
                local color = G.C.WHITE
                if G.GAME.slab then
                    local aspect = string.gsub(G.GAME.slab.key, "slab_bstuck_", "")
                    aspect = string.upper(aspect)
                    color = G.C[aspect]
                    local anspect = string.gsub(G.GAME.slab.key, "slab_bstuck_", "")
                    G.GAME.BALATROSTUCK.current_aspect = anspect
                    add_slab(Slab('slab_bstuck_' .. anspect),card.ability.extra)
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
                        card:shatter()
                        return true
                    end
                }))

                G.E_MANAGER:add_event(Event({
                    func = function()
                        for i=1, #G.jokers.cards do
                            G.jokers.cards[i]:start_dissolve()
                        end
                        return true
                    end
                }))
                
                return {
                    message = 'Ascended!',
                    saved = 'God tiered!',
                    colour = color
                }
            end
        end
    }
end