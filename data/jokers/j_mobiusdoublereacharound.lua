function Balatrostuck.INIT.Jokers.j_mobiusdoublereacharound()
    SMODS.Joker{
        name = "Mobius Double Reacharound",
        key = "mobiusdoublereacharound",
        config = {
            extra = {odds = 8}
        },
        loc_txt = {
            ['name'] = 'Mobius Double Reacharound',
            ['text'] = {
                [1] = "If played hand contains a {C:attention}Straight,",
                [2] = "played cards have a {C:green}#1# in #2#{} chance",
                [3] = "to create a {C:zodiac}Zodiac{} card when scored"
            }
        },
        pos = {
            x = 6,
            y = 3
         },
        loc_vars = function(self,info_queue,card)
            return{ vars = {G.GAME.probabilities.normal,card.ability.extra.odds}}
        end,
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        calculate = function(self,card,context)
            if context.individual and context.cardarea == G.play and next(context.poker_hands['Straight']) then
                if pseudorandom('Mobius') < G.GAME.probabilities.normal/card.ability.extra.odds and
                #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    return {
                        extra = {focus = card, message = '+ Zodiac!', func = function()
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
    }
end 