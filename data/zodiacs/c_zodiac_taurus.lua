function Balatrostuck.INIT.Zodiacs.c_zodiac_taurus()
    Balatrostuck.Zodiac{
        name = "Taurus",
        key = "taurus",
        config = {},
        pos = {
            x = 0,
            y = 0
        }, 
        loc_txt = {
            ['name'] = "Taurus", --value is 0.95^lvl
            ['text'] = {
                "{S:0.8}({S:0.8}lvl.#1#{S:0.8}){} Level up", --needs color var
                "Discarded {C:attention}3s{} multiply the current",
                "{C:attention}Blind requirement{} by {C:white,X:mult}X0.95{}", --next level value 
                "{C:inactive}(Currently {C:white,X:mult}X0.95{C:inactive})" --current level value
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs",
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Taurus')
        end,
        can_use = function() return true end
    }
    
    Balatrostuck.Caste{
        key = 'Taurus',
        name = 'Taurus',
        rank = 3,
        apply = function(self,context)
            

            if context.discard and context.other_card:get_id() == self.ability.rank then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                            play_sound('xchips',0.8,0.4)
                            G.E_MANAGER:add_event(Event({
                                trigger = 'ease',
                                blockable = false,
                                ref_table = G.GAME.blind,
                                ref_value = 'chips',
                                delay = 1,
                                ease_to = G.GAME.blind.chips * (0.95^self:level()),
                                func = (function(t) 
                                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                                    return t end)
                            }))
                            return true
                        end}))
                    end
                }
            end
        end
    }




end