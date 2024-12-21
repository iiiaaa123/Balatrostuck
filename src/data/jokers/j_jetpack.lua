-- DONE
function Balatrostuck.INIT.Jokers.j_jetpack() 
    SMODS.Joker{
        name = "Jetpack",
        key = "jetpack",
        config = {
            extra = {
                mult = 7,
                denominator = 3
            }
        },
        loc_txt = {
            ['name'] = 'Jetpack',
            ['text'] = {
                [1] = "Each scored card gives",
                [2] = "{C:mult}+#1# Mult{} and has a",
                [3] = "{C:green}#2# in #3#{} chance to be",
                [4] = "{C:attention}permanently{} debuffed"
            }
        },
        pos = {
            x = 2,
            y = 6
        },
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.mult, G.GAME.probabilities.normal, card.ability.extra.denominator}}
        end,

        calculate = function(self, card, context)
            if context.cardarea == G.jokers and context.before then
                local debuffs = {}
                for _, v in ipairs(context.scoring_hand) do
                    if pseudoseed("this_is_stupid!") < (G.GAME.probabilities.normal / card.ability.extra.denominator) then
                        debuffs[#debuffs + 1] = v
                    end
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        for _, v in ipairs(debuffs) do
                            v:juice_up()
                            v.ability.perma_debuff = true
                        end
                        return true
                    end
                })) 

                if #debuffs > 0 then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                end
                --     G.E_MANAGER:add_event(Event({
                --         trigger = 'after',
                --         delat = 0.1,
                --         func = function()
                --             context.other_card:juice_up()
                --             return true
                --         end
                --     })) 
                -- end
            end
                
            if context.cardarea == G.play and context.individual then
                if context.other_card.debuff then
                    return {
                        message = localize('k_debuffed'),
                        colour = G.C.RED,
                        card = card,
                    }
                else
                    return {
                        mult = card.ability.extra.mult,
                        card = card
                    }
                end
            end
        end
    }
end