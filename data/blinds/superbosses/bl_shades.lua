function Balatrostuck.INIT.Blinds.bl_shades()
    SMODS.Blind({
        key = 'shades',
        loc_txt = {
            name = 'The Shades',
            text = {'Most played hand will not score',
                }
        },
        hands_sub = 0,
        boss = { min = 1, max = 10, showdown=true},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=12},
        mult = 2,
        dollars = 8,
        boss_colour = HEX('f2a400'),
        calculate = function(self,instance,context)
            if context.debuff_hand then
                local most_played_key
                for key, hand in pairs(G.GAME.hands) do
                    print(key)
                    if not most_played_key then most_played_key = key 
                    elseif hand.played > G.GAME.hands[most_played_key].played then
                       most_played_key = key 
                    end
                end
                if most_played_key and context.scoring_name == most_played_key then
                    return {
                        debuff_text = 'You cannot play your most played hand',
                        debuff = true
                    }
                end
            end
        end,
        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante % 4 == 0 then return true end
            return false
        end
    })
end

