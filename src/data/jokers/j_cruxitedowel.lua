-- DONE: This joker doesn't need any more work unless something comes up
function Balatrostuck.INIT.Jokers.j_cruxitedowel() 
    SMODS.Joker{
        name = "Cruxite Dowel",
        key = "cruxitedowel",
        config = {
            extra = {
                consumables_orders = {}
            }
        },
        loc_txt = {
            ['name'] = 'Cruxite Dowel',
            ['text'] = {
                [1] = 'Every {C:attention}3{} consumables',
                [2] = 'used, alchemize an',
                [3] = '{C:alchemical}Alchemical{} card'
            }
        },
        pos = {
            x = 4,
            y = 1
            },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self, card, context)
            if context.using_consumeable then
                if #card.ability.extra.consumables_orders < 3 and not context.blueprint then
                    table.insert(card.ability.extra.consumables_orders, context.consumeable.ability.order)
                end
    
                if #card.ability.extra.consumables_orders == 3 then
                    local table = card.ability.extra.consumables_orders
                    local alch_idx = ((bitoper(bitoper(table[1], table[2], AND), table[3], OR) - 1)) % #G.P_CENTER_POOLS["Alchemical"] + 1
                    local alch_name = G.P_CENTER_POOLS["Alchemical"][alch_idx].key
    
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                            play_sound('timpani')
                            local chemicalcard = create_card('Alchemical', G.consumables, nil, nil, nil, nil, alch_name, 'crux')
                            chemicalcard:add_to_deck()
                            if G.GAME.used_vouchers.v_cauldron and pseudorandom('cauldron') > 0.5 then
                                chemicalcard:set_edition({negative = true}, true)
                            end
                            G.consumeables:emplace(chemicalcard)
                            G.GAME.consumeable_buffer = 0
                        return true end }))
                    end
    
                    if not context.blueprint then
                        card.ability.extra.consumables_orders = {}
                    end
                end
            end
        end
    }
end
