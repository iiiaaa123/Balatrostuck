function Balatrostuck.INIT.Zodiacs.c_zodiac_capricorn()
    Balatrostuck.Zodiac{
        name = "Capricorn",
        key = "capricorn",
        config = {
        },
        pos = {
            x = 1,
            y = 1
        },
        loc_txt = {
            name = "Capricorn",
            text = {
                --"{S:0.8}({S:0.8, V:1}lvl.#1#{S:0.8}){} Level up",
                "Each played {C:attention}10{} gives {X:mult,C:white}X#1#{} Mult", --X2 should be the next level's value
                "when scored, each held {C:attention}10{}",
                "gives {X:mult,C:white}X#2#{} Mult",          --X0.5 should be the next level's value
                --"{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} and {X:mult,C:white}X#5#{C:inactive})"    --should be the current level values respectively
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
            self:add_caste('Capricorn')
        end,
        can_use = function() return true end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            local formula_curr = self:get_formula(self:level())
            return {
                vars = {
                    self:get_formula(self:next_level()).up,
                    self:get_formula(self:next_level()).down
                },
                main_start = {BSUI.Modules.GameText.LevelUp(self:get_level_color(), self:next_level() )},
                main_end = self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.XMult(formula_curr.up),
                    BSUI.Modules.GameText.Inactive(' and '),
                    BSUI.Modules.GameText.XMult(formula_curr.down)
                })} or {}
            }
        end,
    }


    Balatrostuck.Caste{
        key = 'Capricorn',
        config = {},
        name = 'Capricorn',
        rank = 10,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end

            if context.individual and context.cardarea == G.hand and context.other_card:get_id() == self.ability.rank and not context.end_of_round then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = context.other_card,
                    }
                else
                    return {
                        x_mult = 1 / (self:level(context.other_card) + 1),
                        card = context.other_card
                    }
                end
            end
        

            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                return {
                    x_mult = self:level(context.other_card) + 1,
                    card = context.other_card
                }
            end
        end
    }
end