function Balatrostuck.INIT.Zodiacs.c_zodiac_scorpio()
    Balatrostuck.Zodiac{
        name = "Scorpio",
        key = "scorpio",
        config = {},
        pos = {
            x = 6,
            y = 0
        },
        loc_txt = {
            name = "Scorpio",
            text = {
                '{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up',
                'Each played {C:attention}8{} doubles all',
                '{C:green,E:1,S:1.1}probabilities{} when scored',
                'up to {C:attention}#2#{} time#4# per hand',
                '{s:0.8}Resets when next hand is played', --next level amount
                '{C:inactive}(Currently up to {C:attention}#3# {C:inactive}time#5#)', --current level amount
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
            self:add_caste('Scorpio')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = level
            local current = 0
            if (level-1) > 0 then current = level-1 end
            return {
                vars = {
                    level,
                    formula,
                    current,
                    (level~=1 and 's' or ''),
                    ((level-1)~=1 and 's' or ''),
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
            }
        end,
    }

    Balatrostuck.Caste{
        key = 'Scorpio',
        config = {discared_aces = 0},
        name = 'Scorpio',
        rank = 8,
        apply = function(self,context)
            if context.before and not context.individual then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal / G.GAME.BALATROSTUCK.vriska_luck
                G.GAME.BALATROSTUCK.vriska_luck = 1
                G.GAME.probabilities.normal = G.GAME.probabilities.normal * G.GAME.BALATROSTUCK.vriska_luck
            end         
            
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                if G.GAME.BALATROSTUCK.vriska_luck-1 < self:level() then
                    G.GAME.probabilities.normal = G.GAME.probabilities.normal / G.GAME.BALATROSTUCK.vriska_luck
                    G.GAME.BALATROSTUCK.vriska_luck = G.GAME.BALATROSTUCK.vriska_luck * 2
                    G.GAME.probabilities.normal = G.GAME.probabilities.normal * G.GAME.BALATROSTUCK.vriska_luck
                    return {
                        message = 'Upgr8!',
                        colour = G.C.GREEN,
                        card = context.other_card
                    }
                end
            end
        end
    }
end



