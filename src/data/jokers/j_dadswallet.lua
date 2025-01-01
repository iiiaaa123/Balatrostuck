function Balatrostuck.INIT.Jokers.j_dadswallet()
    SMODS.Joker{
        name = "Dads Wallet",
        key = "dadswallet",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Dads Wallet',
            ['text'] = {
                [1] = "+1 consumable slot",
                [2] = "for every 15$ you have, max 3"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 