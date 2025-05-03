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
                [1] = '{C:attention}Playing cards{} can\'t be debuffed',
                [2] = 'if full deck contains a {C:attention}Wild card'
            }
        },
        pos = {
            x = 2,
            y = 1
        },
        cost = 2,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS['m_wild']
        end
    }
end