function Balatrostuck.INIT.Zodiacs.c_zodiac_cancer()
    Balatrostuck.Zodiac{
        name = "Cancer",
        key = "cancer",
        config = {
            extra = {
                chips = 12
            }
        },
        pos = {
            x = 2,
            y = 0
        },
        loc_txt = {
            ['name'] = "Cancer",
            ['text'] = {
                "{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                'Each played {C:attention}4{} gives {C:chips}+#2# {C:attention}permanent{} Chips', --next level value
                'to all {C:attention}other{} scoring cards when scored',
                '{C:inactive}(Currently {C:chips}+#3#{C:inactive} permanent chips)' --current level value
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
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = card.config.extra.chips * level
            local current = 0
            if level-1 > 0 then current = card.config.extra.chips * (level-1) end
            return {
                vars = {
                    level,
                    formula,
                    current,
                    colours = {(level==1 and G.C.UI.TEXT_DARK or G.C.ZODIAC_LEVELS[math.min(7, level)])}
                }
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