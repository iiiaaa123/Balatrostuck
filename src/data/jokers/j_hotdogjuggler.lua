function Balatrostuck.INIT.Jokers.j_hotdogjuggler()
    SMODS.Joker{
        name = "Hotdog Juggler",
        key = "hotdogjuggler",
        config = {
            extra = {
                discards = 25,
                hotdog_discards = 25
            }
        },
        loc_txt = {
            ['name'] = 'Hotdog Juggler',
            ['text'] = {
                [1] = "Create a {C:zodiac}Zodiac{} card every",
                [2] = "{C:attention}#2# {C:inactive}[#1#]{} cards discarded",
                [3] = "{C:inactive}(Must have room)"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.discards, card.ability.extra.hotdog_discards}}
        end,
        calculate = function(self,card,context)
            if context.discard then
                card.ability.extra.discards = card.ability.extra.discards - 1
                if card.ability.extra.discards <= 0 and
                #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    card.ability.extra.discards = card.ability.extra.hotdog_discards 
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