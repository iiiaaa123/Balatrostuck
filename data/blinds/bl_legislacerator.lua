function Balatrostuck.INIT.Blinds.bl_legislacerator()
    SMODS.Blind({
        key = 'legislacerator',
        loc_txt = {
            name = 'The Legislacerator',
            text = {'If played hand was played this ante',
                'debuff all played cards'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=6},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.before and context.scoring_name then
                if bstuck_in_table(context.scoring_name,G.GAME.GAMEMODE.ability.hands_played_this_ante) then
                    for _,card in ipairs(G.play.cards) do
                        card:set_debuff(true)
                        if card.debuff then card.debuffed_by_blind = true end
                    end
                end
            end
        end,


        in_pool = function(self)
            return false
        end,
        should_spawn = function(self,as_legacy)
            if (not as_legacy) and G.GAME.round_resets.ante >= 1 then return true end
            return false
        end
    })
end