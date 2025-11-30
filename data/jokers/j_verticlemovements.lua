function Balatrostuck.INIT.Jokers.j_verticlemovements()
    SMODS.Joker{
        name = "VERTICLEMOVEMENTS",
        key = "verticlemovements",
        config = {extra = {x_mult = 1.2}},
        loc_txt = {
            ['name'] = 'VERTICLEMOVEMENTS',
            ['text'] = {
                [1] = "{C:attention}Jokers{} in the shop are {C:paradox}Paradox{},",
                [2] = "all {C:paradox}Paradox{} cards give {C:white,X:mult}X1.2{} Mult"
            },
            unlock = {"Win with the",
            "{C:attention}Painted Deck"}
        },
        unlock_condition = {type = 'win_deck', deck = 'b_painted'},
        pos = {
            x = 9,
            y = 2
         },
        loc_vars = function (self, info_queue, card) 
            art_credit('delirium', info_queue)
            info_queue[#info_queue + 1] = G.P_CENTERS['e_bstuck_paradox']
        end,
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.store_joker_replace and context.shop_card.ability.set == 'Joker' and not context.blueprint then
                local _card = nil
                if context.shop_card == nil then
                    --sendInfoMessage(context.debugstring)
                    return false
                else
                    _card = context.shop_card
                end
    
                _card:set_edition('e_bstuck_paradox')
                _card.temp_edition = nil
                return true
            end


            -- Paradox Playing Cards 
            if context.individual and not context.end_of_round then
                if context.other_card.edition and context.other_card.edition.key == 'e_bstuck_paradox' 
                and context.cardarea ~= G.deck and context.cardarea ~= G.discard then
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end               

            -- Paradox Consumables 
            if context.other_consumeable then
                if context.other_consumeable.edition and context.other_consumeable.edition.key == 'e_bstuck_paradox' then          
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.other_consumeable:juice_up(0.5, 0.5)
                            return true
                        end
                    })) 
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end

            -- Paradox Jokers
            if context.other_joker then
                if context.other_joker.edition and context.other_joker.edition.key == 'e_bstuck_paradox' then          
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            context.other_joker:juice_up(0.5, 0.5)
                            return true
                        end
                    })) 
                    return {
                        x_mult = card.ability.extra.x_mult,
                        card = card
                    }
                end
            end
        end
    }
end 
