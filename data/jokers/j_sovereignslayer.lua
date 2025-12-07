function Balatrostuck.INIT.Jokers.j_sovereignslayer()
    SMODS.Joker{
        name = "Sovereign Slayer",
        key = "sovereignslayer",
        config = {
            extra = {
                trash_list = {},
                odds = 3,
                walk_or_not = false
            }
        },
        loc_txt = {
            ['name'] = 'Sovereign Slayer',
            ['text'] = {
                [1] = 'If played hand contains a {C:attention}Flush{}',
                [2] = 'and a scoring {C:spades}Spades{} card,',
                [3] = 'each {C:attention}played card{} has a',
                [4] = '{C:green}#2# in #1#{} chance to be destroyed'
            }
        },
        pos = {
            x = 8,
            y = 5
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.odds, G.GAME.probabilities.normal,}}
        end,

        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.before and not context.blueprint and (next(context.poker_hands["Flush"]) or next(context.poker_hands["Flush Five"]) or next(context.poker_hands["Flush House"]) or next(context.poker_hands["Straight Flush"])) then
                card.ability.extra.trash_list = {}
                local has_spades = false
                for _, v in ipairs(context.scoring_hand) do
                    if v:is_suit("Spades") then has_spades = true end
                end

                card.ability.extra.walk_or_not = has_spades
                if has_spades then
                    for i=1, #context.full_hand do
                        if pseudorandom('black') < G.GAME.probabilities.normal / card.ability.extra.odds then
                            card.ability.extra.trash_list[#card.ability.extra.trash_list+1] = context.full_hand[i]
                        end
                    end                              
                end
            elseif context.destroying_card and not context.blueprint then
                
                for _, v in pairs(card.ability.extra.trash_list) do
                    if v == context.destroying_card then
                        card_eval_status_text(context.destroying_card, 'extra', nil, nil, nil, {message = "Stab!", colour = G.C.RED})
                        return true
                    end
                end
                if card.ability.extra.walk_or_not then
                    card_eval_status_text(context.destroying_card, 'extra', nil, nil, nil, {message = "Walk!", colour = G.C.SUITS.Spades})
                end
                return nil
            elseif context.after then
                card.ability.extra.walk_or_not = false
            end
        end
    }
end