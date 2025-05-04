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
                [1] = "{C:green}1 in 3{} chance to give {C:money}+$3{}",
                [2] = "{C:blue}+33 chips{}"
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.joker_main then
                local effect = {
                    chips = card.ability.extra.chips,
                    card = card
                }
                if pseudorandom('Butterfly') < G.GAME.probabilities.normal/card.ability.extra.odds then
                    effect.dollars = card.ability.extra.dollars
                end
                return effect
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end 