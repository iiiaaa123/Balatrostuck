function Balatrostuck.INIT.Jokers.j_caledfwlch()
    SMODS.Joker{
        name = "Caledfwlch",
        key = "caledfwlch",
        config = { extra = {
            probability = 3,
            mult = 3
        }},
        loc_txt = {
            ['name'] = 'Caledfwlch',
            ['text'] = {
                [1] = '{C:green}#1# in #2#{} chance for {C:white,X:mult}X#3#{} Mult',
                [2] = 'otherwise {C:mult}+#3#{} Mult'
            }
        },
        pos = {
            x = 0,
            y = 6
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function (self, info_queue, card)
            return {vars = {G.GAME.probabilities.normal, card.ability.extra.probability, card.ability.extra.mult}}
        end,

        calculate = function (self, card, context)
            if context.joker_main and context.cardarea == G.jokers then
                if pseudorandom('caledfwlch') < G.GAME.probabilities.normal / card.ability.extra.probability then
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.mult } },
                        Xmult_mod = card.ability.extra.mult
                    }
                else
                    return {
                        message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } },
                        mult_mod = card.ability.extra.mult
                    }
                end
            end
        end  
    }
end