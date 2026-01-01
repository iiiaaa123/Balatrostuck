function Balatrostuck.INIT.Blinds.bl_legacyrufioh()
    SMODS.Blind({
        key = 'legacyrufioh',
        loc_txt = {
            name = "Rufioh's Legacy",
            text = {'1.5x blind size, retrigger',
                'first 2 cards in played hand'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 2.25,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,context)
            if context.repetition and (context.other_card == context.scoring_hand[1] or context.other_card == context.scoring_hand[2]) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = 1,
                    card = context.other_card
                }
            end
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

