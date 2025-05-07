function Balatrostuck.INIT.Zodiacs.c_zodiac_taurus()
    Balatrostuck.Zodiac{
        name = "Taurus",
        key = "taurus",
        config = {
            extra = {
                formula = function (level)
                    return 0.95 ^ level
                end
            }
        },
        pos = {
            x = 0,
            y = 0
        }, 
        loc_txt = {
            name = "Taurus", --value is 0.95^lvl
            text = {
                "Each discarded {C:attention}3{}", 
                "multiplies the current",
                "{C:attention}Blind requirement{} by {C:white,X:mult}X#1#{}", --next level value 
            }
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs",
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Taurus')
        end,
        can_use = function() return true end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {
                vars = {
                    card.ability.extra.formula(self:next_level()),
                },
                main_start = {BSUI.Modules.GameText.LevelUp(self:get_level_color(), self:next_level())},
                main_end = self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.XMult(card.ability.extra.formula(self:level())),
                })} or {}
            }
        end,
    }
    
    Balatrostuck.Caste{
        key = 'Taurus',
        name = 'Taurus',
        rank = 3,
        apply = function(self,context)
            if context.discard and self:level(context.other_card) < 1 then return end

            if context.discard and context.other_card:get_id() == self.ability.rank then
                return {
                    func = function()
                        play_sound('xchips',0.8,0.4)
                        local peepee = math.floor(G.GAME.blind.chips * (0.95^self:level(context.other_card)))
                        local amount = G.GAME.blind.chips - peepee

                        for i=1, 5 do
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.GAME.blind.chips = G.GAME.blind.chips - (amount/5)
                                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                                    return true
                                end
                            }))
                            delay(0.05)
                        end
                        G.GAME.blind.chips = math.floor( G.GAME.blind.chips)
                    end
                }
            end
        end
    }




end