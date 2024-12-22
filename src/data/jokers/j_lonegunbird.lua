function Balatrostuck.INIT.Jokers.j_lonegunbird()
    SMODS.Joker{
        name = "Lone Gunbird",
        key = "lonegunbird",
        config = {
            extra = {
                rolls_needed = 6,
                rolls = 0
            }
        },
        loc_txt = {
            ['name'] = 'Lone Gunbird',
            ['text'] = {
                [1] = 'Gain a random {C:attention}Tag',
                [2] = 'every {C:attention}#1#{} rerolls in the shop',
                [3] = '{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)'
            }
        },
        pos = {
            x = 6,
            y = 4
        },
        cost = 2,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.extra.rolls_needed, card.ability.extra.rolls}}
        end,

        calculate = function(self, card, context)
            if context.reroll_shop and not context.blueprint then
                card.ability.extra.rolls = card.ability.extra.rolls + 1
                if card.ability.extra.rolls >= 6 then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Tag!',colour = G.C.FILTER, card = card})
                    card.ability.extra.rolls = 0
                    --do the steamodded tag thang
                end
            end
        end
    }
end