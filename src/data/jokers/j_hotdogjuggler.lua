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
    }
end 