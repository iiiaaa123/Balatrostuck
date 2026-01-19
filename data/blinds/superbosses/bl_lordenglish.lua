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
        atlas = 'EnglishBlind',
        pos = {x=0,y=0},
        mult = 2,
        dollars = 8,
        boss_colour = HEX('2ed73a'),
        set_blind = function ()
            G.GAME.blind.children.animatedSprite.scale = {x = 128, y = 128}
            G.GAME.blind.children.animatedSprite.scale_mag = 128/1.5
            G.GAME.blind.children.animatedSprite:reset()
        end,
        press_play = function(self)
            G.GAME.modifiers.bstuck_LORDENGLISHMODE = true
            G.GAME.modifiers.bstuck_LORDENGLISHMODE_remove_blinds = true
        end,
        disable = function(self)
            G.GAME.modifiers.bstuck_LORDENGLISHMODE_remove_blinds = nil
        end,
        defeat = function(self)
            G.GAME.blind.children.animatedSprite.scale = {x = 34, y = 34}
            G.GAME.blind.children.animatedSprite.scale_mag = 34/1.5
            G.GAME.blind.children.animatedSprite:reset()
        end,

        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            return false
        end
    })
end

