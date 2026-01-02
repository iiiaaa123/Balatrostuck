function Balatrostuck.INIT.Blinds.bl_dolorosa()
    SMODS.Blind({
        key = 'dolorosa',
        loc_txt = {
            name = 'The Dolorosa',
            text = {'Hands cannot be played until a joker is sold',}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=5},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.setting_blind then
                G.GAME.GAMEMODE.ability.dolorosa_active = true
            end

            if context.debuff_hand then
                if G.GAME.GAMEMODE.ability.dolorosa_active then
                    return {
                        debuff_text = 'Hands cannot be played until a joker is sold',
                        debuff = true
                    }
                end
            end

            if context.selling_card then
                if context.card.config.center.set == 'Joker' then
                    G.GAME.GAMEMODE.ability.dolorosa_active = false
                end
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