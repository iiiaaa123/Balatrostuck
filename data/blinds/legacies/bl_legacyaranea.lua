function Balatrostuck.INIT.Blinds.bl_legacyaranea()
    SMODS.Blind({
        key = 'legacyaranea',
        loc_txt = {
            name = "Aranea's Legacy",
            text = {'eternal to',
                'random joker end of round'}
        },
        hands_sub = 0,
        legacy=true,
        atlas = 'HomestuckBlinds',
        pos = {x=0,y=1},
        mult = 1.5,
        dollars = 4,
        boss_colour = HEX('F2BD43'),
        press_play = function(self)

        end,
        disable = function(self)

        end,
        defeat = function(self)
        end,
        calculate = function(self,context)
            if context.end_of_round and not context.individual and not context.repetition then
                local your_jokers = G.joker.cards
                pseudoshuffle(your_jokers, pseudoseed('spider'))
                for _,joker in pairs(your_jokers) do
                    if not joker.ability.eternal then 
                        joker:set_eternal()
                        break
                    end
                end
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

