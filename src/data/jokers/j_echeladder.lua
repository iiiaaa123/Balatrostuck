function Balatrostuck.INIT.Jokers.j_echeladder()
    SMODS.Joker{
        name = "Echeladder",
        key = "echeladder",
        config = {
            extra = {
                dollars = 10,
                title_cur = "Junior Japer",
                title_list = {
                    "Junior Japer",
                    "99% of Gamblers",
                    "Medieval Jester",
                    "High Card Afficionado",
                    "What Banana?",
                    "1 in 4 Foil",
                    "Roulette Graduate",
                    "Poker Face Maintenance Staff",
                    "Endangered Card Shark",
                    "Better than Vriska",
                    "Went Fishing No Kidding",
                    "Cosmic Consequences Conman",
                    "Lord of Light"
                },
                title_index = 1
            }
        },
        loc_txt = {
            ['name'] = 'Echeladder',
            ['text'] = {
                [1] = 'Earn {C:money}$#1#{} at the end of each {C:attention}ante{}',
                [2] = 'Current echeladder tier:',
                [3] = '{C:attention}#2#'
            }
        },
        pos = {
            x = 1,
            y = 10
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.dollars,card.ability.extra.title_cur}}
        end,

        calc_dollar_bonus = function(self, card)
            if G.GAME.blind.boss then -- AND not alternia stake) OR (alternia stake AND alternian blind)
                if card.ability.extra.title_index < 13 then
                    card.ability.extra.title_index = card.ability.extra.title_index + 1
                    card.ability.extra.title_cur = card.ability.extra.title_list[card.ability.extra.title_index]
                end
                return 10
            else
                return nil
            end
        end
    }
end