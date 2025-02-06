function Balatrostuck.INIT.Jokers.j_culling()
    SMODS.Joker{
        name = "Culling",
        key = "culling",
        config = {
            extra = {mult = 20, odds = 4, give_mult = false}
        },
        loc_txt = {
            ['name'] = 'Culling',
            ['text'] = {
                [1] = "{C:mult}+20{} Mult if a card has been {C:attention}destroyed{} this round,", 
                [2] = "played cards with {C:clubs}Clubs{} or {C:diamonds}Diamonds{} suit have a", 
                [3] = "{C:green}1 in 4{} chance to be {C:attention}destroyed{} when scored"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.setting_blind then
                card.ability.extra.give_mult = false
            end

            if context.destroying_card then
                if context.destroying_card:is_suit('Diamonds') or context.destroying_card:is_suit('Clubs') then
                    return (pseudorandom('Culling') < G.GAME.probabilities.normal/card.ability.extra.odds)
                end
            end

            if context.remove_playing_cards then
                card.ability.extra.give_mult = true
            end

            if context.joker_main and card.ability.extra.give_mult then
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
            end

        end
    }
end 