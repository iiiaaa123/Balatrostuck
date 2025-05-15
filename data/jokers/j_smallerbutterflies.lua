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
                'Played cards have',
                'a {C:green}1 in 3{} chance to',
                'give {C:money}$3{} and {C:blue}+33{} Chips','when scored',
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 9,
            y = 12
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.cardarea == G.play and context.individual then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                elseif pseudorandom('Butterfly') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    return {
                        chips = card.ability.extra.chips,
                        dollars = card.ability.extra.dollars,
                        card = card
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