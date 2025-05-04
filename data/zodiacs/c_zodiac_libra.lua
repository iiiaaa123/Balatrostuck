function Balatrostuck.INIT.Zodiacs.c_zodiac_libra()
    Balatrostuck.Zodiac{
        name = "Libra",
        key = "libra",
        config = {},
        pos = {
            x = 5,
            y = 0
        },
        loc_txt = {
            ['name'] = "Libra",
            ['text'] = {
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                'Each played {C:attention}7{}',
                'gives {X:mult,C:white}X#2#{} Mult', --next level value
                '{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)' --current level value
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
            self:add_caste('Libra')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = 1 + level/10
            local current = 1
            if (level-1) > 0 then current = 1 + (level-1)/10 end
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
        key = 'Libra',
        config = {base_xmult = 1},
        name = 'Libra',
        rank = 7,
        apply = function(self,context)
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                return {
                    x_mult = 1 + (self:level() / 10),
                    card = context.other_card
                }
            end
        end
    }

end

--[1] = 'All scoring 7s',
--[2] = 'give {X:mult,C:white}X1.1{} Mult']