function Balatrostuck.INIT.Jokers.j_typheus()
    SMODS.Joker{
        name = "Typheus",
        key = "typheus",
        config = {
            extra = 4
        },
        loc_txt = {
            ['name'] = 'Typheus',
            ['text'] = {
                'All cards always',
                'spawn with',
                'an {C:dark_edition}Edition'
            }
        },
        pos = {
            x = 4,
            y = 9
        },
        cost = 20,
        rarity = 4,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            art_credit('akai', info_queue)
            return {vars = {}}
        end,
        soul_pos = {
            x = 9,
            y = 9
        }
    }
end