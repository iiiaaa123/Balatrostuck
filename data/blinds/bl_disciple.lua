function Balatrostuck.INIT.Blinds.bl_disciple()
    SMODS.Blind({
        key = 'disciple',
        loc_txt = {
            name = 'The Disciple',
            text = {'Pay 5$ whenever you use a discard',}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=4},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.pre_discard then
                ease_dollars(-5)
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