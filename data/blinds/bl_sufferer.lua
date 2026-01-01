function Balatrostuck.INIT.Blinds.bl_sufferer()
    SMODS.Blind({
        key = 'sufferer',
        loc_txt = {
            name = 'The Sufferer',
            text = {'Rerolls cost 1$ more next ante'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=3},
        mult = 6,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.end_of_round and not context.individual and not context.repetition then
                G.GAME.effect.config.reroll_discount = G.GAME.effect.config.reroll_discount - 1
                G.GAME.GAMEMODE.summoner_duration = 2 --needs to be 2 because we're about to end an ante
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