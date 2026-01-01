function Balatrostuck.INIT.Blinds.bl_legacyporrim()
    SMODS.Blind({
        key = 'legacyporrim',
        loc_txt = {
            name = "Porrim's Legacy",
            text = {'all non-queen played cards',
                'give 0.9x mult when scored'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'blind_chips',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,context)
            if context.individual and context.cardarea == G.play and context.other_card:get_id() ~= 12 then
                return {
                    x_mult = 0.9,
                    card = context.other_card
                }
            end
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

