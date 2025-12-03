function Balatrostuck.INIT.Jokers.j_hegemonicbrute()
    SMODS.Joker{
        name = "Hegemonic Brute",
        key = "hegemonicbrute",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Hegemonic Brute',
            ['text'] = {
                [1] = 'If played hand contains a {C:attention}Flush{}',
                [2] = 'and a scoring {C:hearts}Hearts{} card, {C:attention}first{}',
                [3] = 'and {C:attention}second{} played cards used in',
                [4] = 'scoring become {C:attention}Mult{} cards',
            }
        },
        pos = {
            x = 6,
            y = 5
        },
        cost = 3,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.before and (next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Straight Flush"])) and not context.blueprint then
                local has_hearts = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Hearts") then has_hearts = true end
                end

                if has_hearts then
                    context.scoring_hand[1]:set_ability(G.P_CENTERS.m_mult, nil, true)
                    context.scoring_hand[2]:set_ability(G.P_CENTERS.m_mult, nil, true)
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.scoring_hand[1]:juice_up()
                            context.scoring_hand[2]:juice_up()
                            return true
                        end
                    }))
                    return {
                        message = 'Mult!',
                        card = card,
                        colour = G.C.MULT
                    }
                end
            end
        end
    }
end