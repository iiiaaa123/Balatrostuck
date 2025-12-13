function Balatrostuck.INIT.Jokers.j_cherubshackles()
    SMODS.Joker{
        name = "Cherub Shackles",
        key = "cherubshackles",
        config = {
            extra = { 
            }
        },
        loc_txt = {
            ['name'] = 'Cherub Shackles',
            ['text'] = {
                [1] = "If played hand includes a pair, whenever a",
                [2] = "played Stone scores it gives 1.5x mult"
            }
        },
        pos = {
            x = 9,
            y = 12
        },

        
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,

        in_pool = function(self, args)
            for _, playing_card in ipairs(G.playing_cards or {}) do
                if SMODS.has_enhancement(playing_card, 'm_stone') then
                    return true
                end
            end
        return false
        end,   


        atlas = 'HomestuckJokers',
        calculate = function (self, card, context)
            if context.individual and context.cardarea == G.play and next(context.poker_hands['Pair']) then
                if SMODS.has_enhancement(context.other_card, 'm_stone') then
                    return {
                               x_mult = 1.5,
                              card = card
                         }
                end
            end
        end,
        
        loc_vars = function (self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {G.GAME.probabilities.normal}}
        end
    }
end 