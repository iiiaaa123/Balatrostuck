function Balatrostuck.INIT.Jokers.j_commandervantas()
    SMODS.Joker{
        name = "Commander Vantas",
        key = "commandervantas",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Commander Vantas',
            ['text'] = {
                [1] = '{C:attention}Wild Cards{} can\'t',
                [2] = 'be debuffed'
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
        end
    }
end