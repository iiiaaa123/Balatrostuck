function Balatrostuck.INIT.Jokers.j_faygo()
    SMODS.Joker{
        name = "Faygo",
        key = "faygo",
        config = {
            extra = {
                mult = 16,
                stale = 2,
                sign = "+"
            }
        },
        loc_txt = {
            ['name'] = 'Faygo',
            ['text'] = {
                [1] = 'Played cards give {C:mult}#3##1#{} Mult',
                [2] = 'when scored, then this joker',
                [3] = 'loses {C:mult}-#2#{} Mult'
            }
        },
        pos = {
            x = 6,
            y = 4
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.mult, card.ability.extra.stale, card.ability.extra.sign}}
        end,

        calculate = function(self, card, context)
            if context.cardarea == G.play and context.individual then
                local thunk = card.ability.extra.mult
                if not context.blueprint then
                    card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.stale
                    if card.ability.extra.mult < 0 then
                        card.ability.extra.sign = ''
                    end
                end
                return{
                    mult = thunk,
                    card = card
                }
            end
        end
    }
end