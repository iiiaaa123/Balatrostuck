function Balatrostuck.INIT.Jokers.j_courtyarddroll()
    SMODS.Joker{
        name = "Courtyard Droll",
        key = "courtyarddroll",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Courtyard Droll',
            ['text'] = {
                [1] = 'If played hand contains',
                [2] = 'a {C:attention}Flush{} and {C:clubs}Clubs{},',
                [3] = 'convert all {C:attention}played cards{}',
                [4] = 'to {C:attention}Stone{} cards',
            }
        },
        pos = {
            x = 5,
            y = 5
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.before and (next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Straight Flush"])) then
                local has_clubs = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Clubs") then has_clubs = true end
                end
    
                if has_clubs then
                    for _, v in ipairs(context.full_hand) do
                        v:set_ability(G.P_CENTERS.m_stone, nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                return true
                            end
                        })) 
                    end
                end
            end
        end
    }
end