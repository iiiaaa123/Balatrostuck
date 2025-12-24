function Balatrostuck.INIT.Jokers.j_break()
    SMODS.Joker{
        name = "8R8K",
        key = "break",
        config = {
            extra = { Xmult_mod = 1
            }
        },
        loc_vars = function(self,info_queue,card)
            art_credit('akai', info_queue)
            return {vars = {get_grollars_exponential()}}
        end,
        loc_txt = {
            ['name'] = "8R8K",
            ['text'] = {
                [1] = "{C:white,X:green}X#1#{} {C:green}Mult"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,

        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.cardarea == G.jokers and context.joker_main then
                return {
                message = localize{type='variable',key='a_xmult',vars = {get_grollars_exponential()}},
                Xmult_mod = get_grollars_exponential(),
                colour = G.C.GREEN
                }
            end
        end
    }
end 