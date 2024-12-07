-- TODO: Localization and calculation logic
function Balatrostuck.INIT.Jokers.j_horrorterrors() 
    SMODS.Joker{
        name = "Horror Terrors",
        key = "horrorterrors",
        config = {
            extra = {
                repetitions = {}
            }
        },
        loc_txt = {
            ['name'] = 'Horror Terrors',
            ['text'] = {
                [1] = "Scoring cards",
                [2] = "give {C:mult}Mult{} equal to",
                [3] = "{C:dark_edition}factorial{} of times a",
                [4] = "{C:attention}duplicate{} rank {C:attention}scored"
            }
        },
        pos = {
            x = 8,
            y = 6
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.individual and context.cardarea == G.play and not (context.repetition) then
                local horrorcard = context.other_card
                local idx = horrorcard:get_id()
    
                if not context.blueprint then
                    if not card.ability.extra.repetitions[idx] then
                        card.ability.extra.repetitions[idx] = 0
                    else
                        card.ability.extra.repetitions[idx] = card.ability.extra.repetitions[idx] + 1
                    end
                end
    
                local mult_fac = factorial(card.ability.extra.repetitions[idx])
    
                return {
                    horrorcard = card,
                    mult = mult_fac
                }
    
            elseif context.after and not (context.blueprint or context.before or context.repetition) then
                card.ability.extra.repetitions = {}
            end
        end
    }
end