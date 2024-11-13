function Balatrostuck.INIT.Jokers.j_beyondcanon()
    SMODS.Joker{
        name = "Beyond Canon",
        key = "beyondcanon",
        config = { extra = {

        }},
        loc_txt = {
            ['name'] = 'Beyond Canon',
            ['text'] = {
                [1] = 'Gives {X:mult,C:white}X1.5{} Mult',
                [2] = 'raised to power',
                [3] = 'of current ante,',
                [4] = 'forces 1 card to',
                [5] = 'always be {C:attention}selected'
            }
        },
        pos = {
            x = 5,
            y = 8
         },
        cost = 4,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function (self, context)
            if context.cardarea == G.jokers and not (context.individual or context.repetition or context.before or context.after) then
                local mult = math.ceil((1.5^G.GAME.round_resets.ante)*100)/100
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { mult } },
                    Xmult_mod = mult,
                    colour = G.C.RED
                }
            end
        end
    }:register()
end