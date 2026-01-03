function Balatrostuck.INIT.Blinds.bl_juju()
    SMODS.Blind({
        key = 'juju',
        loc_txt = {
            name = 'juju',
            text = {'0.25x blind',
                '-1 Hand per hand played permanently'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10, showdown=true},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=11},
        mult = 0.5,
        dollars = 8,
        boss_colour = HEX('ffe6d1'),
        calculate = function(self,instance,context)
            if context.after then
                G.GAME.GAMEMODE.ability.juju_hands = G.GAME.GAMEMODE.ability.juju_hands + 1
            end
            if context.end_of_round and not context.individual and not context.repetition then
                G.GAME.round_resets.hands = G.GAME.round_resets.hands - G.GAME.GAMEMODE.ability.juju_hands
                G.GAME.GAMEMODE.ability.juju_hands = 0
            end
        end,

        disable = function(self)
            G.GAME.GAMEMODE.ability.juju_hands = 0
            G.GAME.blind.chips = G.GAME.blind.chips * 4
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end,

        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante == 8 then return true end
            return false
        end
    })
end

