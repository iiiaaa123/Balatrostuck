function Balatrostuck.INIT.Zodiacs.c_zodiac_virgo()
    Balatrostuck.Zodiac{
        name = "Virgo",
        key = "virgo",
        config = {
            extra = {
                formula = function (level)
                    return level > 0 and summation(level+2) or 0
                end
            }
        },
        pos = {
            x = 4,
            y = 0
        },
        loc_txt = {
            name = "Virgo",
            text = {
                'Each {C:attention}held 6{}',
                'gives {C:mult}+#1#{} Mult', --next level value
            }
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Virgo')
        end,
        can_use = function() return true end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {
                vars = {
                    card.ability.extra.formula(self:next_level()),
                },
                main_start = {BSUI.Modules.GameText.LevelUp(self:get_level_color(), self:next_level() )},
                main_end = self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('+'..card.ability.extra.formula(self:level()), G.C.MULT),
                    BSUI.Modules.GameText.Format(' Mult', G.C.UI.TEXT_INACTIVE)
                })} or {}
            }
        end,
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }

    Balatrostuck.Caste{
        key = 'Virgo',
        config = {base_mult = 4},
        name = 'Virgo',
        rank = 6,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end

            
            if context.individual and context.cardarea == G.hand and not context.end_of_round and context.other_card:get_id() == self.ability.rank then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = context.other_card,
                    }
                else
                    return {
                        h_mult = summation(2 + self:level(context.other_card)),
                        card = context.other_card
                    }
                end
            end
        end
    }


end