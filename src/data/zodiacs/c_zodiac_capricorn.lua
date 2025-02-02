function Balatrostuck.INIT.Zodiacs.c_zodiac_capricorn()
    Balatrostuck.Zodiac{
        name = "Capricorn",
        key = "capricorn",
        config = {},
        pos = {
            x = 1,
            y = 1
        },
        loc_txt = {
            ['name'] = "Capricorn",
            ['text'] = {
                [1] = 'test'
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
            self:add_caste('Capricorn')
        end,
        can_use = function() return true end
    }


    Balatrostuck.Caste{
        key = 'Capricorn',
        config = {},
        name = 'Capricorn',
        rank = 10,
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
                        x_mult = 1 / (self:level() + 1),
                        card = context.other_card
                    }
                end
            end
        

            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                return {
                    x_mult = self:level() + 1,
                    card = context.other_card
                }
            end
        end
    }
end