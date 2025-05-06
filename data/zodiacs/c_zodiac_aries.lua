function Balatrostuck.INIT.Zodiacs.c_zodiac_aries()
    Balatrostuck.Zodiac{
        name = "Aries",
        key = "aries",
        config = {
        },
        pos = {
            x = 4,
            y = 1
        },
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Aries')
        end,
        can_use = function() return true end,
        loc_vars = function(self, info_queue, card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1       
            local formula = 0.5 * level
            local current = 0
            if level-1 > 0 then current = 0.5 * (level-1) end

            return {
                key = self.key,
                
                vars = {
                    formula,
                },
                main_start = {BSUI.Modules.GameText.LevelUp((level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)]), level)},
                main_end = {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('gains ', G.C.UI.TEXT_INACTIVE),
                    BSUI.Modules.GameText.Format('X'..current, G.C.WHITE, G.C.RED)
                })}
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
            if context.individual and self:level(context.other_card) < 1 then return end

            if context.setting_blind then
                for i=1, #G.playing_cards do
                    G.playing_cards[i].ignore_aries = false
                end
            end
            
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                context.other_card.ignore_aries = true
                local scottthewoz = 0
                
                
                for k,v in pairs(G.deck.cards) do
                    if v:get_id() == self.ability.rank then scottthewoz = scottthewoz + 1 end
                end

                for k,v in pairs(G.discard.cards) do
                    if v:get_id() == self.ability.rank and not v.ignore_aries then scottthewoz = scottthewoz + 1 end
                end
                
                return {
                    x_mult = (self:level(context.other_card) / 2) * scottthewoz,
                    card = context.other_card
                }
            end
        end
    }
end 