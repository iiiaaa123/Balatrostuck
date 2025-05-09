function Balatrostuck.INIT.Zodiacs.c_zodiac_cancer()
    Balatrostuck.Zodiac{
        name = "Cancer",
        key = "cancer",
        config = {
        },
        pos = {
            x = 2,
            y = 0
        },
        loc_txt = {
            name = "Cancer",
            text = {
                'Each played {C:attention}4{} gives', 
                '{C:chips}+#1# {C:attention}permanent{} Chips', --next level value
                'to all {C:attention}other{} scoring cards',
                'when scored'
            }
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Cancer')
        end,
        can_use = function() return true end,
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {
                vars = {
                    self:get_formula(self:next_level()),
                },
                main_start = {BSUI.Modules.GameText.LevelUp(self:get_level_color(), self:next_level() )},
                main_end =  self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Chips(self:get_formula(self:level())),
                    BSUI.Modules.GameText.Inactive(' permament chips')
                })} or {}
            }
        end,
        cost = 4,
        discovered = true,
        atlas = "HomestuckZodiacs"
    }



    Balatrostuck.Caste{
        key = 'Cancer',
        config = {},
        name = 'Cancer',
        rank = 4,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end

            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                local card = context.other_card
                local scoring_hand = context.scoring_hand

                return {
                    func = function()
                        local delay = 0.5
                        for i=1, #scoring_hand do
                            local _card = scoring_hand[i]
                            _card.ability.perma_bonus = _card.ability.perma_bonus or 0
                            _card.ability.perma_bonus = _card.ability.perma_bonus + self:level(card) * 3
                            card_eval_status_text(_card, 'extra', nil, nil, nil, {message = 'Upgraded!', delay = delay})
                            delay = delay - 0.05
                        end
                    end
                }
            end
        end

    }
end