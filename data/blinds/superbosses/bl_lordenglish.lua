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
        mult = 2,
        dollars = 8,
        boss_colour = HEX('2ed73a'),
        press_play = function(self)
            G.GAME.modifiers.bstuck_LORDENGLISHMODE = true
            G.GAME.modifiers.bstuck_LORDENGLISHMODE_remove_blinds = true
        end,
        disable = function(self)
            G.GAME.modifiers.bstuck_LORDENGLISHMODE_remove_blinds = nil
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

