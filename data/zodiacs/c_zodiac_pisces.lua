function Balatrostuck.INIT.Zodiacs.c_zodiac_pisces()
    Balatrostuck.Zodiac{
        name = "Pisces",
        key = "pisces",
        config = {},
        pos = {
            x = 3,
            y = 1
        },
        loc_txt = {
            ['name'] = "Pisces",
            ['text'] = {
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                'Played{C:attention} Queens{} give {C:money}$#2# {C:red,E:2}minus{} the', --next level value
                'amount of {C:attention}remaining hands{} when scored', 
                '{C:inactive}(Currently {C:money}$#3#{C:inactive})'    --current level value
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
            self:add_caste('Pisces')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = level*2
            local current = 0
            if level-1 > 0 then current = (level-1)*2 end
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
        key = 'Pisces',
        name = 'Pisces',
        rank = 12,
        apply = function(self,context)
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                return {
                    dollars = (2 * self:level()) - G.GAME.current_round.hands_left,
                    card = context.other_card
                }
            end
        end
    }




end
