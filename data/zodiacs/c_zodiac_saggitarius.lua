function Balatrostuck.INIT.Zodiacs.c_zodiac_sagittarius()
    Balatrostuck.Zodiac{
        name = "Sagittarius",
        key = "sagittarius",
        config = {
            extra = {
                chips = 25
            }
        },
        pos = {
            x = 0,
            y = 1
        },
        loc_txt = {
            ['name'] = "Sagittarius",
            ['text'] = {
                '{S:0.8}({S:0.8, V:1}lvl.#1#{S:0.8}){} Level up', --needs color var
                'Played cards give',
                '{C:chips}+#2#{} Chips if played hand', --next level value
                'contains a {C:attention}non-scoring 9',
                '{C:inactive}(Currently {C:chips}+#3#{C:inactive} Chips)' --current level value
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
            self:add_caste('Sagittarius')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = level*card.config.extra.chips
            local current = 0
            if level-1 > 0 then current = (level-1)*card.config.extra.chips end
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
        key = 'Sagittarius',
        name = 'Sagittarius',
        rank = 9,
        apply = function(self,context)
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
                        chips = 25 * self:level(),
                        card = context.other_card
                    }
                end
            end
        end
    }





end