function Balatrostuck.INIT.Jokers.j_smallerbutterflies()
    SMODS.Joker{
        name = "Smaller Butterflies",
        key = "smallerbutterflies",
        config = {
            extra = { dollars = 3, chips = 33, odds = 3
            }
        },
        loc_txt = {
            ['name'] = 'Smaller Butterflies',
            ['text'] = {
                'Each empty {C:attention}Joker{} slot ',
                'has a {C:green}#1# in #2#{} chance ',
                'to give {C:money}$#3#{} '
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 2,
            y = 11
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.dollars}}
        end,
        calculate = function(self,card,context)
            if context.joker_main then
                local thunk = 0
                for i = 1, G.jokers.config.card_limit - #G.jokers.cards do
                    if pseudorandom('Butterfly') < G.GAME.probabilities.normal/card.ability.extra.odds then
                        thunk = thunk + card.ability.extra.dollars
                    end
                end
                if thunk > 0 then
                    return {
                        dollars = thunk,
                        card = card
                    }
                else
                    return {
                        card = card,
                        message = localize('k_nope_ex'),
                        colour = G.C.GREEN
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