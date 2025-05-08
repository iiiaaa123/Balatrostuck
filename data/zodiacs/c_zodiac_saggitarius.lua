function Balatrostuck.INIT.Zodiacs.c_zodiac_sagittarius()
    Balatrostuck.Zodiac{
        name = "Sagittarius",
        key = "sagittarius",
        config = {
        },
        pos = {
            x = 0,
            y = 1
        },
        loc_txt = {
            ['name'] = "Sagittarius",
            ['text'] = {
                'Played cards give',
                '{C:chips}+#1#{} Chips if played hand', --next level value
                'contains a {C:attention}non-scoring 9',
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
            self:add_caste('Sagittarius')
        end,
        can_use = function() return true end,
        loc_vars = function(self, info_queue, card)
            return {
                vars = {
                    self:get_formula(self:next_level()),
                },
                main_start = {BSUI.Modules.GameText.LevelUp(self:get_level_color(), self:next_level() )},
                main_end = self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('+'..self:get_formula(self:level()), G.C.CHIPS),
                    BSUI.Modules.GameText.Format(' Chips', G.C.UI.TEXT_INACTIVE)
                })} or {}
            }
        end,
        
    }

    Balatrostuck.Caste{
        key = 'Sagittarius',
        name = 'Sagittarius',
        rank = 9,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end

            if context.individual and context.cardarea == G.play then
                local milk = false
                for i=1, #G.play.cards do
                    if G.play.cards[i]:get_id() == self.ability.rank then
                        for j=1, #context.scoring_hand do
                            if context.scoring_hand[i] == G.play.cards[i] then
                                break
                            elseif j == #context.scoring_hand then
                                milk = true
                            end
                        end
                    end
                end
                
                if milk then
                    return {
                        chips = 25 * self:level(context.other_card),
                        card = context.other_card
                    }
                end
            end
        end
    }





end