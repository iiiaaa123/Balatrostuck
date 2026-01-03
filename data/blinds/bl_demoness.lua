function Balatrostuck.INIT.Blinds.bl_demoness()
    SMODS.Blind({
        key = 'demoness',
        loc_txt = {
            name = 'The Demoness',
            text = {'All playing cards are debuffed',
                'after first hand is played'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=0},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('a10000'),
        calculate = function(self,instance,context)
            if context.final_scoring_step then
                for _, card in pairs(G.hand.cards) do
                        if not card.debuff then
                            card:set_debuff(true)
                            if card.debuff then card.debuffed_by_blind = true end
                        end
                end
                for _, card in pairs(G.deck.cards) do
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
            if (not as_legacy) and G.GAME.round_resets.ante >= 5 then return true end
            return false
        end
    })
end