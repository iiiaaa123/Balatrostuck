-- TODO: add the titles and shit
function Balatrostuck.INIT.Jokers.j_echeladder()
    SMODS.Joker{
        name = "Echeladder",
        key = "echeladder",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Echeladder',
            ['text'] = {
                [1] = 'Earn {C:money}$10{} at the end of each {C:attention}ante{}'
            }
        },
        pos = {
            x = 1,
            y = 10
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        calc_dollar_bonus = function(self, card)
            if G.GAME.blind.boss then -- AND not alternia stake) OR (alternia stake AND alternian blind)
                return 10
            else
                return 0
            end
        end

-- vvv levels vvv
-- Lord of Light
-- Cosmic Consequences Conman 
-- Went Fishing No Kidding
-- Better than Vriska
-- Endangered Card Shark
-- Poker Face Maintenance Staff
-- Roulette Graduate
-- 1 in 4 Foil
-- Banana Peel Afficionado
-- High Card Afficionado 
-- Medieval Jester
-- 99% of Gamblers
-- Junior Japer

    }:register()
end