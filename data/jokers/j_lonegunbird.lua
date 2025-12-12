function Balatrostuck.INIT.Jokers.j_lonegunbird()
    SMODS.Joker{
        name = "Lone Gunbird",
        key = "lonegunbird",
        config = {
            extra = {
                rolls_needed = 5,
                rolls = 0
            }
        },
        loc_txt = {
            ['name'] = 'Lone Gunbird',
            ['text'] = {
                [1] = 'Gain a random {C:attention}Tag{} every',
                [2] = '{C:attention}#1#{} rerolls in the shop',
                [3] = '{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)'
            },
            unlock = {'Unlocked by',
                    'finishing Act 1'}
        },
        pos = {
            x = 8,
            y = 7
        },
        cost = 2,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = false,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {card.ability.extra.rolls_needed, card.ability.extra.rolls}}
        end,

        calculate = function(self, card, context)
            if context.reroll_shop and not context.blueprint then
                card.ability.extra.rolls = card.ability.extra.rolls + 1
                if card.ability.extra.rolls >= card.ability.extra.rolls_needed then
                    card_eval_status_text(card, 'extra', nil, nil, nil, {message = 'Tag!',colour = G.C.GREEN, card = card})
                    card.ability.extra.rolls = 0
                    bstuck_give_random_tag("gunbird")
                end
            end
        end,
        check_for_unlock = function(self,args)
            if args.type == 'bstuck_apple_eaten' then
                unlock_card(self)
            end
        end
    }
end