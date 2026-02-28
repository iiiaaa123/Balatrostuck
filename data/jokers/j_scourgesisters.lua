function Balatrostuck.INIT.Jokers.j_scourgesisters()
    SMODS.Joker{
        name = "Scourge Sisters",
        key = "scourgesisters",
        config = {
            extra = {odds = 8}
        },
        loc_txt = {
            ['name'] = 'Scourge Sisters',
            ['text'] = {
                [1] = "{C:attention}7s{} and {C:attention}8s{} are drawn {C:attention}face-down{}",
                [2] = "Played cards have a {C:green}#1# in #2#{} chance",
                [3] = "of creating a random {C:attention}tag{} when scored"
            }
        },
        pos = {
            x = 16,
            y = 0
        },

        
        cost = 7,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.individual and context.cardarea == G.play  then
                    if pseudorandom('vrisrezi') < G.GAME.probabilities.normal/card.ability.extra.odds then
                        card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'T4G!',colour = G.C.GREEN, card = card})
                        bstuck_give_random_tag("vrisrezi")
                    end
            end
            if context.stay_flipped and context.to_area == G.hand and context.other_card:get_id() == 8 then
                return {
                        stay_flipped = true
                    }
            end
            if context.stay_flipped and context.to_area == G.hand and context.other_card:get_id() == 7 then
                return {
                        stay_flipped = true
                    }
            end
        end,

        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return{ vars = {G.GAME.probabilities.normal,card.ability.extra.odds}}
        end,
    }
end 