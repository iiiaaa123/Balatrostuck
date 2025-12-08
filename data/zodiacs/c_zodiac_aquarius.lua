function Balatrostuck.INIT.Zodiacs.c_zodiac_aquarius()
    Balatrostuck.Zodiac{
        name = "Aquarius",
        key = "aquarius",
        config = {
        },
        pos = {
            x = 2,
            y = 1
        },
        loc_txt = {
            name = "Aquarius",
            text = {
                '{C:attention}Jacks{} create {C:attention}#1#{} random',
                '{C:attention}Tag#2#{} when {E:2,C:red}destroyed',
                'or {C:paradox}disappeared{}'
            }
        },
        cost = 4,
        discovered = false,
        atlas = "HomestuckZodiacs",
        use = function(self, card, area, copier)
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
                play_sound('timpani', 0.7)
                play_sound('bstuck_HomestuckBloodDrop', 1)
                card:juice_up(0.8, 0.5)
                return true end
            }))
            self:add_caste('Aquarius')
        end,
        can_use = function() return true end,
    }

    Balatrostuck.Caste {
        key = 'Aquarius',
        config = {discared_aces = 0},
        name = 'Aquarius',
        rank = 11,
        apply = function(self,context)
            if context.remove_playing_cards or context.paradox_ify then
                for i=1, #context.removed do
                    if context.removed[i]:get_id() == self.ability.rank then
                        for i=1, self:level(context.removed[i]) do
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                                local tagkey = get_next_tag_key()
                                if tagkey == 'tag_bstuck_scratch' then tagkey = 'tag_handy' end --prevent this from spawning scratch tag
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
        end
    }
end