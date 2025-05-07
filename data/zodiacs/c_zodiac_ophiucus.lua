function Balatrostuck.INIT.Zodiacs.c_zodiac_ophiuchus()
    Balatrostuck.Zodiac{
        name = "Ophiuchus",
        key = "ophiuchus",
        config = {
            extra = {
                formula = function (level)
                    return 1.25 ^ level
                end
            }
        },
        pos = {
            x = 5,
            y = 1
        },
        loc_txt = {
            name = "Ophiuchus",
            text = {
                "When played {C:attention}Kings{} are scored, a",
                "random card held in hand becomes",
                "{C:paradox}Paradox{} and gives {X:mult,C:white}X#1#{} Mult", --next level value
            }
        },
        cost = 4,
        discovered = false,
        atlas = "HomestuckZodiacs",
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Ophiuchus')
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
                    BSUI.Modules.GameText.Format(' Mult', G.C.UI.TEXT_INACTIVE),
                })} or {}
            }
        end,
    }

    Balatrostuck.Caste{
        key = 'Ophiuchus',
        config = {},
        name = 'Ophiuchus',
        rank = 13,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end
        
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                local possible_choices = {}
                for i=1, #G.hand.cards do 
                    if G.hand.cards[i].edition == nil then
                        table.insert(possible_choices,G.hand.cards[i])
                    end
                end

                if #possible_choices >= 1 then
                    local _card = pseudorandom_element(possible_choices,pseudoseed('Looking for me?  O  '))
                    G.E_MANAGER:add_event(Event({func = function()
                        G.hand:remove_card(_card)
                        play_sound('bstuck_HomestuckParadox',0.7)
                        _card:juice_up()
                        _card:set_edition('e_bstuck_paradox',true,true)
                        G.hand:emplace(_card)
                        G.hand:sort()
                        return true end
                    }))
                    return {
                        x_mult = 1.25 ^ self:level(context.other_card),
                        card = context.other_card
                    }
                end
            end
        end
    }



end