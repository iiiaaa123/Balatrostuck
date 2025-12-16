--TODO: not allowed hands thang
function Balatrostuck.INIT.Jokers.j_beyondcanon()
    SMODS.Joker{
        name = "Beyond Canon",
        key = "beyondcanon",
        config = { extra = {
            Xmult = 1,
            banned_hands = {},
            xmult_growth = 0.5
        }},
        loc_txt = {
            ['name'] = 'Beyond Canon',
            ['text'] = { --Gains X0.5 mult for each unique hand played this ante. Poker hands played previously this ante are not allowed. (Currently: 1x mult)

                [1] = 'Gains {X:mult,C:white}X#2#{} Mult for each',
                [2] = 'unique hand played this ante,',
                [3] = '{C:attention}poker hands{} played previously',
                [4] = 'this ante are {C:red}not allowed',
                [5] = '{C:inactive}(Currently {X:mult,C:white}X#1#{C:inactive} Mult)'
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
            art_credit('akai', info_queue)
            return { vars = { card.ability.extra.Xmult, card.ability.extra.xmult_growth} }
        end, 

        calculate = function (self, card, context)
            if context.debuff_hand then
                for i=1, #card.ability.extra.banned_hands do
                    if context.scoring_name == card.ability.extra.banned_hands[i] then
                        return {
                            debuff_text = 'Poker hands previously played this ante are not allowed.',
                            debuff = true
                        }
                    end
                end
            end
            
            if context.end_of_round and context.cardarea == G.jokers and G.GAME.blind.boss then
                card.ability.extra.banned_hands = {}
                card.ability.extra.Xmult = card.config.extra.Xmult --reset to base
            end

            if context.cardarea == G.jokers and context.joker_main then
                card.ability.extra.banned_hands[#card.ability.extra.banned_hands+1] = context.scoring_name
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.xmult_growth
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult^G.GAME.round_resets.ante } },
                    Xmult_mod = card.ability.extra.Xmult,
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