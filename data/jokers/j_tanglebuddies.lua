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
                "When played cards are scored,",
                "they give {C:mult}+Mult{} equal to",
                "{C:attention}summation{} the amount their",
                "{C:attention}rank{} has scored {C:attention}this hand"
            }
        },
        pos = {
            x = 7,
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

            if context.selling_self then
                card.ability.do_not_update_pool = true
            end
        end,
        remove_from_deck = function(self,card,from_debuff)
            if not from_debuff and not card.ability.do_not_update_pool then
                G.GAME.pool_flags.horrorterrors = true
            end
        end,
        in_pool = function(self,args)
            return not G.GAME.pool_flags.horrorterrors
        end
    }
end