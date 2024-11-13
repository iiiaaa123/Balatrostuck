function Balatrostuck.INIT.Jokers.j_applejuice()
    SMODS.Joker{
        name = "Apple Juice",
        key = "applejuice",
        config = { extra = {
            d_size = 8
        }},
        loc_txt = {
            ['name'] = 'Apple Juice',
            ['text'] = {
                [1] = 'If no {C:red}discards{} remain',
                [2] = 'add 1 extra {C:red}discard',
                [3] = '{C:inactive}(#1# discards left)'
            }
        },
        pos = {
            x = 0,
            y = 4
        },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = false,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_def = function(card)
            return {card.ability.extra.d_size}
        end,

        calculate = function(self, context)
            if (context.pre_discard and not context.blueprint_card) and G.GAME.current_round.discards_left <= 1 then
                if self.ability.extra.d_size <= 1 then
                    ease_discard(1, nil, true)
                    self.getting_sliced = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            self:start_dissolve({G.C.RED}, nil, 1.6)
                            return true;
                        end
                    }))
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                else
                G.E_MANAGER:add_event(Event({func = function()
                    ease_discard(1, nil, true)
                    self.ability.extra.d_size = self.ability.extra.d_size - 1
                    card_eval_status_text(context.blueprint_card or self, 'extra', nil, nil, nil, {message = "-1 Discard", colour = G.C.RED})
                return true end }))
                end
            end
        end
    }:register()
end 