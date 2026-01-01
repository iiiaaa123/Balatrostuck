function Balatrostuck.INIT.Blinds.bl_legacymeenah()
    SMODS.Blind({
        key = 'legacymeenah',
        loc_txt = {
            name = "Meenah's Legacy",
            text = {'jokers lose 1$ of sell',
                'value per hand played'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,context)
            if context.after then
                for _, joker in ipairs(G.jokers.cards) do
                    joker.ability.extra_value = (joker.ability.extra_value or 0) - 1
                    joker:set_cost()
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

