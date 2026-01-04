function Balatrostuck.INIT.Blinds.bl_host()
    SMODS.Blind({
        key = 'host',
        loc_txt = {
            name = 'The Host',
            text = {'3x blind',
                'after playing, reset score if didnt win'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10, showdown=true},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=14},
        mult = 3,
        dollars = 8,
        boss_colour = HEX('ffffff'),
        calculate = function(self,instance,context)
            if context.final_scoring_step then
                if G.GAME.chips < G.GAME.blind.chips then
                    G.GAME.chips = 0
                end
            end
        end,

        disable = function(self)
            G.GAME.blind.chips = G.GAME.blind.chips / 3
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
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

