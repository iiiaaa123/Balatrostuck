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
                'Played {C:attention}7s{} give {X:mult,C:white}X#2#{} Mult', --next level value
                '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)' --current level value
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
            self:add_caste('Libra')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = 1 + level/10
            return {
                vars = {
                    level,
                    formula,
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
                local scottthewoz = discard_aces
                for k,v in pairs(G.deck.cards) do
                    if k:get_id() == self.ability.rank then scottthewoz = scottthewoz + 1 end
                end

                return {
                    x_mult = (self:level() / 2) * scottthewoz,
                    card = context.other_card
                }
            end
        end
    }

end

--[1] = 'All scoring 7s',
--[2] = 'give {X:mult,C:white}X1.1{} Mult']