function Balatrostuck.INIT.Jokers.j_twinarmageddons()
    SMODS.Joker{
        name = "Twin Armageddons",
        key = "twinarmageddons",
        config = {
            extra = {
                hand = 'Two Pair'
            }
        },
        loc_txt = {
            ['name'] = 'Twin Armageddons',
            ['text'] = {
                [1] = 'If {C:attention}scoring hand',
                [2] = 'is {C:attention}#1#',
                [3] = 'add {C:red}Mult{} equal to',
                [4] = "scored {C:blue}Chips{} value"
            }
        },
        pos = {
            x = 0,
            y = 3
         },
        cost = 8,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, twincard)
            return {vars = {twincard.ability.extra.hand}}
        end,

        calculate = function(self,card,context)
            if context.cardarea == G.jokers and context.joker_main then
            elseif context.cardarea == G.play and context.individual and next(context.poker_hands[card.ability.extra.hand]) then
                local chips = context.other_card:get_chip_bonus()
                if (context.other_card:get_edition() ~= nil and context.other_card:get_edition().chip_mod ~= nil) then
                    chips = context.other_card:get_edition().chip_mod + chips
                end
                return {
                    mult = chips,
                    twincard = card
                }
            end
        end
    }
end