function Balatrostuck.INIT.Jokers.j_echidna()
    SMODS.Joker{
        name = "Echidna",
        key = "echidna",
        config = {
            extra = {
                levels = 1
            }
        },
        loc_txt = {
            ['name'] = 'Echidna',
            ['text'] = {
                [1] = "{C:attention}Scratch Tags{} don't affect",
                [2] = "{C:attention}Jokers{}, second {C:attention}Skip Tag{} of",
                [3] = "ante is always a {C:attention}Scratch Tag"
            }
        },
        pos = {
            x = 3,
            y = 9
        },
        cost = 20,
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        soul_pos = {
            x = 8,
            y = 9
        },
        loc_vars = function(self, info_queue, card)
            local s = card.ability.extra.levels > 1 and 's' or ''
            return {vars = {card.ability.extra.levels, s}}
        end,

        calculate = function(self, card, context)
            if context.cardarea == G.jokers and context.before and G.GAME.current_round.hands_left == 0 then
                local text,disp_text = context.scoring_name
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_level_up_ex')})
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname=localize(text, 'poker_hands'),chips = G.GAME.hands[text].chips, mult = G.GAME.hands[text].mult, level=G.GAME.hands[text].level})
                level_up_hand(context.blueprint_card or card, text, nil, card.ability.extra.levels)
                card.ability.extra.levels = card.ability.extra.levels + 1
            end
        end
    }
end