function Balatrostuck.INIT.Jokers.j_lucky_break()
    SMODS.Joker{
        name = "Lucky Break",
        key = "lucky_break",
        config = {
            extra = {
                broken = false,
                probability = 16777216
            }
        },
        loc_txt = {
            ['name'] = 'Lucky Break',
            ['text'] = {
                [1] = 'All chance-based effects succeed',
                [2] = 'in {C:attention}final hand{} of round',
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

        calculate = function(self, context)
            if context.before and context.cardarea == G.jokers and not (context.after or context.repetition or context.individual or context.blueprint) then
                if G.GAME.current_round.hands_left == 0 then
                    self.ability.extra.broken = true
                    G.GAME.probabilities.normal = G.GAME.probabilities.normal * self.ability.extra.probability
                    return {
                        message = "Lucky 8r8k!",
                        color = G.C.VRISKA,
                        delay = 0.66
                    }
                end
            elseif context.end_of_round and not (context.repetition or context.individual or context.blueprint) then
                if self.ability.extra.broken then
                    G.GAME.probabilities.normal = G.GAME.probabilities.normal / self.ability.extra.probability
                    self.ability.extra.broken = false
                end
            end
        end
    }:register()
end