function Balatrostuck.INIT.Blinds.bl_legacydamara()
    SMODS.Blind({
        key = 'legacydamara',
        loc_txt = {
            name = "Damara's Legacy",
            text = {'playing a hand',
                'costs 2 hands, not 1'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'blind_chips',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,context)
            if context.before then
                 ease_hands_played(-1)
            end
        end,

        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if as_legacy and G.GAME.round_resets.ante >= 2 then return true end
            return false
        end
    })
end

