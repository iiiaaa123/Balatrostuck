function Balatrostuck.INIT.Zodiacs.c_zodiac_aries()
    Balatrostuck.Zodiac{
        name = "Aries",
        key = "aries",
        config = {
            extra = {
                mult_mod = 2
            }
        },
        pos = {
            x = 4,
            y = 1
        },
        loc_txt = {
            ['name'] = "Aries",
            ['text'] = {
                '{{S:0.8}({S:0.8, V:1}lvl.#1#{}{S:0.8}){} Level up',
                '{C:attention}Aces{} gain {X:mult,C:white}X0.5{} Mult for', --next level value
                'each {C:attention}Ace discarded{} this round',
                'or currently in your {C:attention}deck',
                '{C:inactive}(Currently gains {X:mult,C:white}X0{C:inactive})', --current level value
            }
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('tarot1')
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Aries')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = card.config.extra.mult_mod * level
            return {
                vars = {
                    level,
                    formula,
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
            }
        end,
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }

    Balatrostuck.Caste{
        key = 'Aries',
        config = {discared_aces = 0},
        name = 'Aries',
        rank = 14,
        apply = function(self,context)
            if context.setting_blind then
                self.ability.config.discared_aces = 0
            end

            if context.discard and context.other_card:get_id() == self.ability.rank then
                self.ability.config.discared_aces = self.ability.config.discared_aces + 1
            end

            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                local scottthewoz = self.ability.config.discared_aces or 0
                for k,v in pairs(G.deck.cards) do
                    if v:get_id() == self.ability.rank then scottthewoz = scottthewoz + 1 end
                end

                return {
                    x_mult = (self:level() / 2) * scottthewoz,
                    card = context.other_card
                }
            end
        end
    }
end 