function Balatrostuck.INIT.Blinds.bl_bettycrocker()
    SMODS.Blind({
        key = 'bettycrocker',
        loc_txt = {
            name = 'Betty Crocker',
            text = {'all your jokers',
                'become rental'}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=11},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.setting_blind and not context.individual and not context.repetition then
                for _,joker in pairs(G.jokers.cards) do
                    if not joker.ability or not joker.ability.rental then
                        joker:juice_up()
                        joker:set_rental(true)
                        joker.set_rental_from_crocker = true
                    end
                end
            end
        end,
        disable = function(self)
            for _,joker in pairs(G.jokers.cards) do
                if joker.ability and joker.ability.rental and joker.set_rental_from_crocker then
                    joker:juice_up()
                    joker:set_rental(false)
                    joker.set_rental_from_crocker = nil
                end
            end
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

