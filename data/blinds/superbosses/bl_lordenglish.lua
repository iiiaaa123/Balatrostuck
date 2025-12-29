function Balatrostuck.INIT.Blinds.bl_lordenglish()
    SMODS.Blind({
        key = 'lordenglish',
        loc_txt = {
            name = 'Lord English',
            text = {'no other blinds exist lmao',
                }
        },
        hands_sub = 0,
        boss = { min = 1, max = 10, showdown=true},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=11},
        mult = 99,
        dollars = 15,
        boss_colour = HEX('F2BD43'),
        press_play = function(self)
            G.GAME.modifiers.bstuck_LORDENGLISHMODE = true
        end,
        disable = function(self)
        end,
        defeat = function(self)
        end,

        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            return false
        end
    })
end

