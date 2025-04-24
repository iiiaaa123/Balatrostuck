function Balatrostuck.INIT.Jokers.j_enterthemedium()
    SMODS.Joker{
        name = "Enter The Medium",
        key = "enterthemedium",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Enter The Medium',
            ['text'] = {
                [1] = "This Joker becomes a random",
                [2] = "{C:attention}Balatrostuck{} Joker at end of {C:attention}ante"
            }
        },
        pos = {
            x = 0,
            y = 10
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = false,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and G.GAME.blind.boss then
                local pool = get_current_pool('Joker')
                local _key = nil
                

                for i=1, #pool do
                    sendInfoMessage(pool[i])
                    if string.find(pool[i],'bstuck') then
                        local _key = pseudorandom_element(pool,pseudoseed('medium'))
                        break
                    end
                end

                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('card1', percent);card:juice_up(0.3, 0.3);return true end }))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,func = function()
                    card:remove_from_deck()
                    card.config.center = G.P_CENTERS[_key]
                    card:set_ability(card.config.center,true)
                    card:add_to_deck()
                    return true 
                end}))
                G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.15,func = function() card:flip();play_sound('tarot2', percent);card:juice_up(0.3, 0.3);return true end }))
            end
        end,
        add_to_deck = function(self,card,from_debuff)
            if G.GAME.pool_flags.bstuck_actprogress <= 2 then
                G.GAME.pool_flags.bstuck_actprogress = 3
            end
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.bstuck_actprogress >= 2
        end
    }
end 