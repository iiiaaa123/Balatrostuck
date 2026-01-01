function Balatrostuck.INIT.Blinds.bl_legacykurloz()
    SMODS.Blind({
        key = 'legacykurloz',
        loc_txt = {
            name = "Kurloz's Legacy",
            text = {'leftmost joker becomes',
                'paradox when blind is selected'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        calculate = function(self,context)
            if context.end_of_round and not context.individual and not context.repetition then
                for _,joker in pairs(G.jokers.cards) do
                    if not joker.edition or joker.edition.key ~= 'e_bstuck_paradox' then
                        joker:set_edition('e_bstuck_paradox',true,true)
                        break
                    end
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

