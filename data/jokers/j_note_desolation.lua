function Balatrostuck.INIT.Jokers.j_note_desolation()
    SMODS.Joker{
        name = "Note Desolation",
        key = "note_desolation",
        config = {
            extra = {num_odds = 4, dom_odds = 13,
                    mult = 20}
        },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.num_odds * G.GAME.probabilities.normal, card.ability.extra.dom_odds, card.ability.extra.mult }}
        end,
        loc_txt = {
            ['name'] = 'Note Desolation',
            ['text'] = {
                [1] = "{C:green}#1# in #2#{} cards get",
                [2] = "drawn {C:attention}face-down",
                [3] = "{C:red}+#3# mult{}"
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.stay_flipped and context.to_area == G.hand and
                 pseudorandom('captcha') < (card.ability.extra.num_odds * G.GAME.probabilities.normal) / card.ability.extra.dom_odds then
                return {
                    stay_flipped = true
                }
            end

            if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
            end

        end
    }
end