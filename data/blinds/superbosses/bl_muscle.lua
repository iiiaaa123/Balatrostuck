function Balatrostuck.INIT.Blinds.bl_muscle()
    SMODS.Blind({
        key = 'muscle',
        loc_txt = {
            name = 'The Muscle',
            text = {'all cards are drawn facedown',
                }
        },
        hands_sub = 0,
        boss = { min = 1, max = 10, showdown=true},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=13},
        mult = 2,
        dollars = 8,
        boss_colour = HEX('000056'),
        calculate = function(self,instance,context)
            if context.stay_flipped and context.to_area == G.hand then
                context.other_card.flipped_by_blind = true
                return {
                    stay_flipped = true
                }
            end
        end,

        disable = function(self)
            bstuck_undebuff_and_unflip_from_boss()
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

