function Balatrostuck.INIT.Blinds.bl_subjuggulator()
    SMODS.Blind({
        key = 'subjuggulator',
        loc_txt = {
            name = 'The Subjuggulator',
            text = {'Destroy every played card.',}
        },
        hands_sub = 0,
        boss = { min = 1, max = 10},
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=9},
        mult = 2,
        dollars = 5,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,instance,context)
            if context.destroying_card and (context.cardarea == G.play or context.cardarea == 'unscored') then
                return {remove = true}
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