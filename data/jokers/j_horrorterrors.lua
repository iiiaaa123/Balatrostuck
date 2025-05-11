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
                "When played cards are scored,",
                "they give {C:mult}+Mult{} equal to",
                "{C:dark_edition}factorial{} the amount their",
                "{C:attention}rank{} has scored {C:attention}this hand"
            }
        },
        pos = {
            x = 8,
            y = 6
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
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
        end,
        in_pool = function(self,args)
            return G.GAME.pool_flags.horrorterrors
        end
    }
end