-- TODO: Fix calculation logic
function Balatrostuck.INIT.Jokers.j_mirthful()
    SMODS.Joker{
        name = "Mirthful Joker",
        key = "mirthful",
        config = {
            extra = {num_odds = 69, dom_odds = 420}
        },
        loc_txt = {
            ['name'] = 'Mirthful Joker',
            ['text'] = {
                [1] = "{C:green}#1# in #2#{} chance to",
                [2] = "create a {C:zodiac}Zodiac{} card",
                [3] = "at end of round"
            }
        },
        loc_vars = function(self,info_queue,card)
            return {vars = {card.ability.extra.num_odds * G.GAME.probabilities.normal, card.ability.extra.dom_odds }}
        end,
        pos = {
            x = 0,
            y = 5
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.end_of_round and context.cardarea == G.jokers then
                if pseudorandom('Mirthful') < (card.ability.extra.num_odds * G.GAME.probabilities.normal) / card.ability.extra.dom_odds and
                #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    return {
                        extra = {focus = card, message = '+1 Zodiac!', func = function()
                            G.E_MANAGER:add_event(Event({
                                trigger = 'before',
                                delay = 0.0,
                                func = (function()
                                        local zodiac = SMODS.create_card({set = 'Zodiac'})
                                        zodiac:add_to_deck()
                                        G.consumeables:emplace(zodiac)
                                        G.GAME.consumeable_buffer = 0
                                    return true
                                end)}))
                        end},
                        colour = G.C.SECONDARY_SET.Tarot,
                        card = card
                    }
                end
            end
        end

        -- PRESERVED FOR SAFE KEEPING :) - Delirium
        -- SMODS.Jokers.j_mirthful.calculate_joker = function (self, context)
        --     if context.cardarea == G.jokers and next(context.poker_hands["Straight"]) and not (context.individual or context.repetition or context.before or context.after) then
        --         local has_6 = false
        --         local has_9 = false
        --         for _,v in ipairs(context.scoring_hand) do
        --             if not has_6 then has_6 = v:get_id() == 6 end
        --             if not has_9 then has_9 = v:get_id() == 9 end
        --         end
                    
        --         if has_9 and has_6 then
        --             ease_dollars(4)
        --             G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + 8
        --             G.E_MANAGER:add_event(Event({func = (function() G.GAME.dollar_buffer = 0; return true end)}))
        --             return {
        --                 mult_mod = 20,
        --                 message = localize { type = 'variable', key = 'a_mult', vars = { 20 } },
        --             }
        --         end
        --     end
        -- end
    }
end