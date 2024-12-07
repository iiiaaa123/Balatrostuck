-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_tanglebuddies() 
    SMODS.Joker{
        name = "Tangle Buddies",
        key = "tanglebuddies",
        config = {
            extra = {
                repetitions = {}
            }
        },
        loc_txt = {
            ['name'] = 'Tangle Buddies',
            ['text'] = {
                [1] = "Scoring cards",
                [2] = "give {C:mult}Mult{} equal to",
                [3] = "{C:attention}summation{} of times a",
                [4] = "{C:attention}duplicate{} rank {C:attention}scored"
            }
        },
        pos = {
            x = 7,
            y = 6
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function (self,card,context)
            if context.individual and context.cardarea == G.play and not (context.repetition) then
                local buddycard = context.other_card
                local idx = buddycard:get_id()
    
                if not context.blueprint then
                    if not card.ability.extra.repetitions[idx] then
                        card.ability.extra.repetitions[idx] = 0
                    else
                        card.ability.extra.repetitions[idx] = card.ability.extra.repetitions[idx] + 1
                    end
                end
    
                local mult_fac = summation(card.ability.extra.repetitions[idx])
    
                return {
                    buddycard = card,
                    mult = mult_fac
                }
    
            elseif context.after and not (context.blueprint or context.before or context.repetition) then
                card.ability.extra.repetitions = {}
            end
        end
    }
end