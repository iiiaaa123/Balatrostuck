function Balatrostuck.INIT.Blinds.bl_legacymituna()
    SMODS.Blind({
        key = 'legacymituna',
        loc_txt = {
            name = "Mituna's Legacy",
            text = {'items in the next shop are',
                '1$ more expensive per discard used'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.pre_discard then
                if G.GAME.GAMEMODE and G.GAME.GAMEMODE.ability then
                    G.GAME.GAMEMODE.ability.mituna_cost = G.GAME.GAMEMODE.ability.mituna_cost + 1 --rest is in the gamemode code
                end
            end
            if context.end_of_round and not context.individual and not context.repetition then
                G.GAME.inflation = G.GAME.inflation + G.GAME.GAMEMODE.ability.mituna_cost --hehe
            end
        end,
        disable = function(self)
            G.GAME.GAMEMODE.ability.mituna_cost = 0
        end,
        
        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if as_legacy and G.GAME.round_resets.ante >= 5 then return true end
            return false
        end
    })
end

