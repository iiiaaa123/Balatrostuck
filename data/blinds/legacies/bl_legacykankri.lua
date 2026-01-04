function Balatrostuck.INIT.Blinds.bl_legacykankri()
    SMODS.Blind({
        key = 'legacykankri',
        loc_txt = {
            name = "Kankri's Legacy",
            text = {'discarded cards have',
                'a 1 in 2 chance of de-enhanced'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('ff0000'),
        calculate = function(self,instance,context)
            if context.discard then
                if context.cardarea == G.discard and context.other_card.config.center.set == "Enhanced"and pseudorandom('kankri') < G.GAME.probabilities.normal/2 then
                    card_eval_status_text(context.other_card, 'extra', nil, nil, nil, {message = "Drained!", colour = G.C.SET.Enhanced, instant = false})
                    context.other_card:set_ability(G.P_CENTERS.c_base, nil, true)

                end
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

