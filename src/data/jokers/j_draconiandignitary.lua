function Balatrostuck.INIT.Jokers.j_draconiandignitary()
    SMODS.Joker{
        name = "Draconian Dignitary",
        key = "draconiandignitary",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Draconian Dignitary',
            ['text'] = {
                [1] = 'If played hand contains a {C:attention}Flush{}',
                [2] = 'and a scoring {C:diamonds}Diamonds{} card,',
                [3] = 'earn {C:money}money{} equal to total',
                [4] = '{C:attention}sell value{} of adjacent jokers'
            }
        },
        pos = {
            x = 7,
            y = 5
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.before and (next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Straight Flush"])) then
                local has_diamonds = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Diamonds") then has_diamonds = true end
                end
    
                local other_jokers = {}
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then 
                        other_jokers = {
                            G.jokers.cards[i+1],
                            G.jokers.cards[i-1]
                        }
                    end
                end 
    
                local sell_cost = 0
                for _, joker in ipairs(other_jokers) do
                    if joker then
                        sell_cost = joker.sell_cost + sell_cost
                    end
                end
    
                if has_diamonds then
                    ease_dollars(sell_cost)
                    return {
                        message = localize('$')..sell_cost,
                        colour = G.C.MONEY,
                        card = card
                    }
                end
            end
        end
    }
end