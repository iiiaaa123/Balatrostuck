function Balatrostuck.INIT.Jokers.j_note_desolation()
    SMODS.Joker{
        name = "Note Desolation",
        key = "note_desolation",
        config = {
            extra = {
                mult_gain = 4,
                chips_gain = 13,
                chips = 0,
                last_hand = ""
            }
        },
        loc_txt = {
            ['name'] = 'Note Desolation',
            ['text'] = {
                [1] = 'Gains {C:mult}+4 Mult{} and',
                [2] = '{C:chips}+13 Chips{} for each',
                [3] = 'consecutive',
                [4] = '{C:attention}repeat hand type{}',
                [5] = '{C:inactive}(Currently: {}{C:mult}+#1# Mult {}',
                [6] = '{C:inactive}and {}{C:chips}+#2# Chips{}{C:inactive}){}'
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            return {vars = {card.ability.mult, card.ability.extra.chips }}
        end
    }:register()
end