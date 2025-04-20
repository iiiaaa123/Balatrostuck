function Balatrostuck.INIT.Zodiacs.c_zodiac_aquarius()
    Balatrostuck.Zodiac{
        name = "Aquarius",
        key = "aquarius",
        config = {},
        pos = {
            x = 2,
            y = 1
        },
        loc_txt = {
            ['name'] = "Aquarius",
            ['text'] = {
                '{S:0.8}({S:0.8, V:1}lvl.#1#{S:0.8}){} Level up', --needs color var
                '{C:attention}Jacks{} create {C:attention}#2#{} random',
                '{C:attention}Tag#4#{} when {C:attention}destroyed', --next level value + dynamic plural
                '{C:inactive}(Currently {C:attention}#3#{C:inactive} Tag#5#)' --current level value + dynamic plural
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
            self:add_caste('Aquarius')
        end,
        can_use = function() return true end,
        loc_vars = function(card)
            local level = (G.GAME.BALATROSTUCK.zodiac_levels[card.name] or 0) + 1
            local formula = level
            local current = 0
            if level - 1 > 0 then current = level-1 end
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

    Balatrostuck.Caste {
        key = 'Aquarius',
        config = {discared_aces = 0},
        name = 'Aquarius',
        rank = 11,
        apply = function(self,context)
            if context.remove_playing_cards then
                for i=1, #context.removed do
                    if context.removed[i]:get_id() == self.ability.rank then
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                            local tagkey = get_next_tag_key()
                            local tag = Tag(tagkey)
                            if tagkey == 'tag_orbital' then
                                local _poker_hands = {}
                                for k, v in pairs(G.GAME.hands) do
                                    if v.visible then _poker_hands[#_poker_hands+1] = k end
                                end
                                
                                tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed('orbital'))
                            end
                            play_sound('timpani')
                            add_tag(tag)
                            return true
                        end}))
                    end
                end
            end
        end
    }
end