function Balatrostuck.INIT.Zodiacs.c_zodiac_leo()
    Balatrostuck.Zodiac{
        name = "Leo",
        key = "leo",
        config = {},
        pos = {
            x = 3,
            y = 0
        },
        loc_txt = {
            ['name'] = "Leo",
            ['text'] = {
                '{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up',
                'Each {C:attention}held 5{} has a {C:green}#4# in 4{} chance',
                'to give {C:money}$#2#{} when any', --next level value
                'played card is scored',
                '{C:inactive}(Currently {C:money}$#3#{C:inactive})' --current level value
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
            self:add_caste('Leo')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = level
            local current = 0
            if level-1 > 0 then current = level-1 end
            return {
                vars = {
                    level,
                    formula,
                    current,
                    G.GAME.probabilities.normal,
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
            }
        end,
    }


    Balatrostuck.Caste{
        key = 'Leo',
        config = {base_money = 4, odds = 4},
        name = 'Leo',
        rank = 5,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end

            if context.individual and context.cardarea == G.play then
                for i=1, #G.hand.cards do
                    _card = G.hand.cards[i]

                    if _card:get_id() == self.rank and pseudorandom('leo') < G.GAME.probabilities.normal/self.ability.config.odds then
                        if _card.debuff then
                            card_eval_status_text(_card, 'debuff')
                        else
                            card_eval_status_text(_card, 'dollars', self:level(context.other_card))
                            ease_dollars(self:level(context.other_card))
                        end
                    end
                end
            end
        end
    }
end