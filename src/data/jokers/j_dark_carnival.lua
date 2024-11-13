function Balatrostuck.INIT.Jokers.j_dark_carnival()
    SMODS.Joker{
        name = "Dark Carnival",
        key = "dark_carnival",
        config = {
            extra = {
                poker_hand = "Straight",
                chips = 0,
                trash_list = {}
            }
        },
        loc_txt = {
            ['name'] = 'Dark Carnival',
            ['text'] = {
                [1] = "If a played hand",
                [2] = "contains a {C:attention}Straight{}",
                [3] = "destroy cards ranked under {C:attention}10",
                [4] = "and gain destroyed cards'",
                [5] = "{C:chips}Chips{} value",
                [4] = "{C:inactive}(Currently: {}{}{C:chips}+#1# Chips{}{C:inactive}){}"
            }
        },
        pos = {
            x = 0,
            y = 2
        },
        cost = 8,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_def = function(card)
            return { card.ability.extra.chips }
        end,
        calculate = function(self, context)
            if context.cardarea == G.jokers and context.joker_main then
                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                    chip_mod = self.ability.extra.chips,
                    colour = G.C.CHIPS
                }
    
            elseif context.cardarea == G.play and context.individual and not context.blueprint and (next(context.poker_hands['Straight']) or next(context.poker_hands['Straight Flush'])) then
                if context.other_card:get_id() < 10 then
                    table.insert(self.ability.extra.trash_list, context.other_card)
                    self.ability.extra.chips = context.other_card.base.nominal + self.ability.extra.chips
                    G.E_MANAGER:add_event(Event({
                        extra = {
                            message = localize { type = 'variable', key = 'a_chips', vars = { self.ability.extra.chips } },
                            focus = self
                        },
                        trigger = 'after',
                        delay = 0.5,
                        func = function() 
                            local card = context.other_card
                            card.getting_sliced = true
                            if card.ability.name == 'Glass Card' then 
                                card:shatter()
                            else
                                card:start_dissolve()
                            end
                            return true end }))
                end
            elseif context.end_of_round then
                if not context.blueprint and not context.repetition then
                    for i = 1, #self.ability.extra.trash_list do
                        self.ability.extra.trash_list[i]:start_dissolve(nil, true, 0, true)
                    end
                    self.ability.extra.trash_list = {}
                end
            end
        end
    }:register()
end