function Balatrostuck.INIT.Blinds.bl_orphaner()
    SMODS.Blind({
        key = 'orphaner',
        loc_txt = {
            name = 'The Orphaner',
            text = {'reset first triggered zodiac to lvl 0'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=10},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('6a006a'),
        calculate = function(self,instance,context)
            if context.zodiac_triggered and not G.GAME.GAMEMODE.ability.orphaner_triggered then
                
                local key = string.sub(context.zodiac.key,14):lower():gsub("^%l", string.upper) --i will never forgive you for making me do this
                Balatrostuck.Zodiac:remove_caste(key)
                G.GAME.GAMEMODE.ability.orphaner_triggered = true
            end
        end,

        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante >= 2 then return true end
            return false
        end
    })
end