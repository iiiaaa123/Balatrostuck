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

        add_to_deck = function(self,card,from_debuff)
            G.GAME.round_resets.blind_tags.Big = 'tag_bstuck_scratch'
        end
    }
end