function Balatrostuck.INIT.Jokers.j_joker()
    SMODS.Joker{
        name = "Joker",
        key = "joker",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Joker',
            ['text'] = {
                [1] = 'Gives {C:red}+4 Mult',
                [2] = '{C:white}a',
                [3] = '{C:blue}JOHN: hey there!'
            }
        },
        pos = {
            x = 6,
            y = 4
        },
        cost = 6,
        rarity = 3,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        soul_pos = {
            x = 5,
            y = 4
        },
        loc_vars = function(self, info_queue, card)
        end
    }:register()
end