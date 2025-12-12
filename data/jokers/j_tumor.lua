function Balatrostuck.INIT.Jokers.j_tumor()
    SMODS.Joker{
        name = 'The Tumor',
        key = 'tumor',
        config = {extra = {x_mult = 2}},
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return { vars = { card.ability.extra.x_mult} }
        end,   
        loc_txt = {
            name = 'The Tumor',
            ['text'] = {
                '{C:white,X:mult}X2{} Mult if you',
                'have {C:money}$1{} or less'
                -- [1] = "{C:white,X:mult}2X{} Mult if hand",
                -- [2] = "is played with",
                -- [3] = "{C:money}$0{} or less"
            },
                    unlock = {'Unlocked by',
                            'finishing Act 1'}
        },
        pos = {x = 7, y = 7},
        cost = 0,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.joker_main and G.GAME.dollars <= 1 then
                return {
                    Xmult_mod = card.ability.extra.x_mult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.x_mult } },
                    card = card
                }
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end

