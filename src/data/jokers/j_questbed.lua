function Balatrostuck.INIT.Jokers.j_questbed()
    SMODS.Joker{
        name = "Quest Bed",
        key = "questbed",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Quest Bed',
            ['text'] = {
                [1] = 'Upon {C:attention}death{} destroy',
                [2] = 'all jokers and add',
                [3] = '{C:attention}5{} levels to',
                [4] = 'current {C:aspect}Aspect{}'
            }
        },
        pos = {
            x = 1,
            y = 0
         },
        cost = 7,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end