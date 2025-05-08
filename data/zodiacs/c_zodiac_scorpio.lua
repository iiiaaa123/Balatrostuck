function Balatrostuck.INIT.Zodiacs.c_zodiac_scorpio()
    Balatrostuck.Zodiac{
        name = "Scorpio",
        key = "scorpio",
        config = {
        },
        pos = {
            x = 6,
            y = 0
        },
        loc_txt = {
            name = "Scorpio",
            text = {
                'Each played {C:attention}8{} doubles all',
                '{C:green,E:2}probabilities{} when scored',
                'up to {C:attention}#1#{} time#2# per hand',
                '{s:0.8}Resets when next hand is played',
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
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {
                vars = {
                    self:get_formula(self:next_level()),
                    (self:next_level()~=1 and 's' or ''),
                },
                main_start = {BSUI.Modules.GameText.LevelUp(self:get_level_color(), self:next_level())},
                main_end = self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('up to ', G.C.UI.TEXT_INACTIVE),
                    BSUI.Modules.GameText.Format(self:get_formula(self:level()), G.C.IMPORTANT),
                    BSUI.Modules.GameText.Format(' time'..(self:level()~=1 and 's' or ''), G.C.UI.TEXT_INACTIVE)
                })} or {}
            }
        end,
    }

    Balatrostuck.Caste{
        key = 'Scorpio',
        config = {discared_aces = 0},
        name = 'Scorpio',
        rank = 8,
        apply = function(self,context)
            if context.individual and self:level(context.other_card) < 1 then return end

            if context.before and not context.individual then
                G.GAME.probabilities.normal = G.GAME.probabilities.normal / G.GAME.BALATROSTUCK.vriska_luck
                G.GAME.BALATROSTUCK.vriska_luck = 1
                G.GAME.probabilities.normal = G.GAME.probabilities.normal * G.GAME.BALATROSTUCK.vriska_luck
            end         
            
            if context.individual and context.cardarea == G.play and context.other_card:get_id() == self.ability.rank then
                if G.GAME.BALATROSTUCK.vriska_luck-1 < self:level(context.other_card) then
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



