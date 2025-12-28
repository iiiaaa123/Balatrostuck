function Balatrostuck.INIT.Jokers.j_quarters()
    SMODS.Joker{
        name = "Quarters",
        key = "quarters",
        config = {
            extra = { 
            }
        },
        loc_txt = {
            ['name'] = 'Quarters',
            ['text'] = { --Create a negative Jail Key when obtained. Jail Key creates negative jokers and is not consumed on use. (You can use it on jokers to transform a card back.) 


                "Create a negative {C:attention}Jail Key{} when obtained.",
                "{C:attention}Jail Key{} creates negative jokers",
                "and is not consumed on use.",
                "{C:inactive}(You can use it on jokers to transform a card back.)"
            }
        },
        pos = {
            x = 13,
            y = 3
        },
        soul_pos = {
            x = 13,
            y = 6
        },
        
        cost = 28,
        rarity = "bstuck_felt",
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.using_consumeable == true and context.consumeable.config.center.key == 'c_bstuck_jailkey' and context.consumeable.edition and context.consumeable.edition.key == "e_negative" and not context.blueprint then
                G.E_MANAGER:add_event(Event({func = function()
                    local _card = SMODS.add_card({set = 'Spectral', key = 'c_bstuck_jailkey'})
                    _card:set_edition("e_negative", true,true)
                    G.consumeables:add_to_highlighted(_card)
                    return true
                end }))
            end
            if context.check_eternal and context.trigger.from_sell == true and context.other_card.edition and context.other_card.edition.key == "e_negative" and context.other_card.config.center.key == 'c_bstuck_jailkey' then
                return {no_destroy = {override_compat = true}}
            end

        end,
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        add_to_deck = function(self,card,from_debuff)
            if not from_debuff then
                G.E_MANAGER:add_event(Event({func = function()
                    SMODS.add_card({set = 'Spectral', key = 'c_bstuck_jailkey', edition='e_negative'})

                    return true
                end }))
            end
        end
    }
end 