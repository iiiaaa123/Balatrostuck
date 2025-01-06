function Balatrostuck.INIT.Jokers.j_complacencyofthelearned()
    SMODS.Joker{
        name = "Complacency of the Learned",
        key = "complacencyofthelearned",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Complacency of the Learned',
            ['text'] = {
                [1] = "If a {C:attention}Lucky Card {C:green}succeeds{},",
                [2] = "{X:red,C:white}XMult{} equal to {C:attention}6{} multiplied",
                [3] = "by the number of times Lucky",
                [4] = "cards {C:attention}succeeded{}, divided by how",
                [5] = "many times cards were {C:attention}scored"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 8,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 