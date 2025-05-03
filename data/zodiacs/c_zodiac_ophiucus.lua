function Balatrostuck.INIT.Zodiacs.c_zodiac_ophiuchus()
    Balatrostuck.Zodiac{
        name = "Ophiuchus",
        key = "ophiuchus",
        config = {},
        pos = {
            x = 5,
            y = 1
        },
        loc_txt = {
            ['name'] = "Ophiuchus",
            ['text'] = {
                "{S:0.8}({S:0.8, V:1}lvl.#1#{S:0.8}){} Level up", --needs color var
                "When played {C:attention}Kings{} are scored, a",
                "random card held in hand becomes",
                "{C:green}Paradox{} and gives {X:mult,C:white}X#2#{} Mult", --next level value
                "{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive})" --current level value
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
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = 1.25 ^ level
            local current = 1
            if (level-1) > 0 then current = 1.25 ^ (level - 1) end
            return {
                vars = {
                    level,
                    formula,
                    current,
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
            }
        end,
    }

    Balatrostuck.Caste{
        key = 'Ophiuchus',
        config = {},
        name = 'Ophiuchus',
        rank = 13,
        apply = function(self,context)
        
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
                        x_mult = 1.25 ^ self:level(),
                        card = context.other_card
                    }
                end
            end
        end
    }



end