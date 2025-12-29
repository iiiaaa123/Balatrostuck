function Balatrostuck.INIT.Blinds.bl_legislacerator()
    SMODS.Blind({
        key = 'legislacerator',
        loc_txt = {
            name = 'The Legislacerator',
            text = {'Ludicrously large blind',
                '-1 Hand Size per hand played'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=6},
        mult = 99,
        dollars = 15,
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
            if not as_legacy and G.GAME.round_resets.ante >= 1 then return true end
            return false
        end
    })
end