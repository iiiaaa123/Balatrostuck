function Balatrostuck.INIT.Blinds.bl_executioner()
    SMODS.Blind({
        key = 'executioner',
        loc_txt = {
            name = 'The E%ecutioner',
            text = {'1 in 3 cards are drawn',
                'face-down throughout the round'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=8},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.stay_flipped and context.to_area == G.hand and
            pseudorandom('e%ecute') < G.GAME.probabilities.normal / 3 then

                return {
                    stay_flipped = true --might need to be changed
                }
                
            end
        end,



        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante >=1 then return true end
            return false
        end
    })
end