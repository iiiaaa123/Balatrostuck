--TODO: not allowed hands thang
function Balatrostuck.INIT.Jokers.j_beyondcanon()
    SMODS.Joker{
        name = "Beyond Canon",
        key = "beyondcanon",
        config = { extra = {
            Xmult = 2
        }},
        loc_txt = {
            ['name'] = 'Beyond Canon',
            ['text'] = {
                [1] = '{X:mult,C:white}X#1#{} to the power of',
                [2] = 'current {C:attention}ante{} Mult,',
                [3] = '{C:attention}poker hands{} played previously',
                [4] = 'this ante are {C:red}not allowed',
                [5] = '{C:inactive}(Currently {X:mult,C:white}X#2#{C:inactive} Mult)'
            },
            unlock = {'Unlocked by',
            'finishing Act 2'}
        },
        pos = {
            x = 5,
            y = 8
         },
        cost = 7,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult^G.GAME.round_resets.ante} }
        end, 

        calculate = function (self, card, context)
            if context.cardarea == G.jokers and context.joker_main then
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult^G.GAME.round_resets.ante } },
                    Xmult_mod = card.ability.extra.Xmult^G.GAME.round_resets.ante,
                    colour = G.C.RED
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_ascend' then
                unlock_card(self)
            end
        end
    }
end