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
                [1] = '{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up',
                [2] = '{C:attention}Held 5s{} have a {C:green}1 in 4{} chance',
                [3] = 'to give {C:money}$1{} when any', --next level value
                [4] = 'played card is scored',
                [5] = '{C:inactive}(Currently {C:money}$0{C:inactive})' --current level value
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
            self:add_caste('Leo')
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
        key = 'Leo',
        config = {base_money = 4, odds = 4},
        name = 'Leo',
        rank = 5,
        apply = function(self,context)
            if context.individual and context.cardarea == G.hand and context.other_card:get_id() == self.ability.rank and 
            pseudorandom('leo') < G.GAME.probabilities.normal/self.ability.config.odds then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = context.other_card,
                    }
                else
                    return {
                        dollars = self:level(),
                        card = context.other_card
                    }
                end
            end
        end
    }
end