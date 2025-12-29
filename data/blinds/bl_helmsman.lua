function Balatrostuck.INIT.Blinds.bl_helmsman()
    SMODS.Blind({
        key = 'helmsman',
        loc_txt = {
            name = 'The Helmsman',
            text = {'Ludicrously large blind',
                '-1 Hand Size per hand played'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=2},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        press_play = function(self)
            G.GAME.blind.hands_sub = (G.GAME.blind.hands_sub or 0) + 1
            G.hand:change_size(-1)
        end,
        disable = function(self)
            G.hand:change_size(G.GAME.blind.hands_sub)
            G.GAME.blind.chips = G.GAME.blind.chips / 89
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end,
        defeat = function(self)
            G.hand:change_size(G.GAME.blind.hands_sub)
        end,

        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante >= 5 then return true end
            return false
        end
    })
end