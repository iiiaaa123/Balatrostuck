function Balatrostuck.INIT.Blinds.bl_summoner()
    SMODS.Blind({
        key = 'summoner',
        loc_txt = {
            name = 'The Summoner',
            text = {'Retrigger all played cards'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 6,
        dollars = 5,
        boss_colour = HEX('a15000'),
        calculate = function(self,instance,context)
            if context.repetition and context.cardarea == G.play then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.scoring_card
                }
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
            if (not as_legacy) and G.GAME.round_resets.ante >= 5 then return true end
            return false
        end
    })
end