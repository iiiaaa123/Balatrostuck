function Balatrostuck.INIT.Blinds.bl_legacycronus()
    SMODS.Blind({
        key = 'legacycronus',
        loc_txt = {
            name = "Cronus's Legacy",
            text = {'cards held debuffed',
                'after hand is played'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.final_scoring_step then
                for _, card in pairs(G.hand.cards) do
                        if not card.debuff then
                            card:set_debuff(true)
                            if card.debuff then card.debuffed_by_blind = true end
                        end
                end
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

