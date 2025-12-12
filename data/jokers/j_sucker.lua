function Balatrostuck.INIT.Jokers.j_sucker()
    SMODS.Joker{

        name = "Sucker",
        key = "sucker",
        config = {
            extra = {
                base = 6,
                decrement = 1
            }
        },
        loc_txt = {
            ['name'] = 'Sucker',
            ['text'] = {
                '{C:green}#1# in #2#{} chance for', 
                '{C:white,X:mult}X#2#{} Mult, decreases',
                'by {C:suckers,E:2}1{} for each',
                'card in played hand'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 3,
            y = 4
        },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.probabilities.normal, card.ability.extra.base }}
        end,

        calculate = function(self, card, context)
            if context.before and not context.blueprint then
                card.ability.extra.base = card.ability.extra.base - #context.full_hand
            
            elseif context.joker_main and context.cardarea == G.jokers and card.ability.extra.base > 0 then
                if pseudorandom('suckers') < G.GAME.probabilities.normal / card.ability.extra.base then
                    return {
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.base } },
                        Xmult_mod = card.ability.extra.base
                    }
                end

            elseif context.after and not context.blueprint then
                if card.ability.extra.base > 0 then 
                    card.ability.extra.base = 6
                else
                    card.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card:start_dissolve({G.C.RED}, nil, 1.6)
                            return true;
                        end
                    }))

                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end