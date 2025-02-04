function Balatrostuck.INIT.Zodiacs.c_zodiac_cancer()
    Balatrostuck.Zodiac{
        name = "Cancer",
        key = "cancer",
        config = {},
        pos = {
            x = 2,
            y = 0
        },
        loc_txt = {
            ['name'] = "Cancer",
            ['text'] = {
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                '{C:attention}Held 4s{} give {C:mult}+#2#{} Mult', --next level value
                '{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)' --current level value
            }
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Cancer')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = 3 + level
            local current = 0
            if level - 1 < 0 then current = 3 + (level - 1) end
            return {
                vars = {
                    level,
                    formula,
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])},
                    current
                }
            }
        end,
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }



    Balatrostuck.Caste{
        key = 'Cancer',
        config = {base_mult = 4},
        name = 'Cancer',
        rank = 4,
        apply = function(self,context)
            if context.individual and context.cardarea == G.hand and context.other_card:get_id() == self.ability.rank then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = context.other_card,
                    }
                else
                    return {
                        h_mult = self.ability.config.base_mult + self:level(),
                        card = context.other_card
                    }
                end
            end
        end

    }
end