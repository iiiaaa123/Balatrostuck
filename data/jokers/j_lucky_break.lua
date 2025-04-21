function Balatrostuck.INIT.Jokers.j_lucky_break()
    SMODS.Joker{
        name = "FL1P",
        key = "lucky_break",
        config = {
            extra = {
                broken = false,
                probability = 16777216
            }
        },
        loc_txt = {
            ['name'] = 'FL1P',
            ['text'] = {
                [1] = 'All {C:green}chance-based{} effects succeed',
                [2] = 'in the {C:attention}final hand{} of round',
            }
        },
        pos = {
            x = 6,
            y = 1
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        remove_from_deck = function(self,card,from_debuff)
            if card.ability.extra.broken then
                card.ability.extra.broken = false
                G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.probability
            end
        end
        calculate = function(self,card, context)
            if context.before and context.cardarea == G.jokers and not (context.after or context.repetition or context.individual or context.blueprint) then
                if G.GAME.current_round.hands_left == 0 then
                    card.ability.extra.broken = true
                    G.GAME.probabilities.normal = G.GAME.probabilities.normal * card.ability.extra.probability
                    return {
                        message = "Lucky 8r8k!",
                        color = G.C.VRISKA,
                        delay = 0.66
                    }
                end
            elseif context.end_of_round and not (context.repetition or context.individual or context.blueprint) then
                if card.ability.extra.broken then
                    G.GAME.probabilities.normal = G.GAME.probabilities.normal / card.ability.extra.probability
                    card.ability.extra.broken = false
                end
            end
        end
    }
end