function Balatrostuck.INIT.Blinds.bl_legacyhoruss()
    SMODS.Blind({
        key = 'legacyhoruss',
        loc_txt = {
            name = "Horuss's Legacy",
            text = {'pillar eff',
                'but facedown'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('0022cb'),
        calculate = function(self,card,context)
            if context.stay_flipped and context.to_area == G.hand and
                context.other_card.ability.played_this_ante then
                context.other_card.flipped_by_blind = true
                return {
                    stay_flipped = true --might need to be changed
                }
            end



        end,
        
        disable = function(self)
            bstuck_undebuff_and_unflip_from_boss()
        end,

        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if as_legacy and G.GAME.round_resets.ante >= 2 then return true end
            return false
        end
    })
end

