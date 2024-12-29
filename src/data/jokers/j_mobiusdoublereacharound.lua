function Balatrostuck.INIT.Jokers.j_mobiusdoublereacharound()
    SMODS.Joker{
        name = "Mobius Double Reacharound",
        key = "mobiusdoublereacharound",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Mobius Double Reacharound',
            ['text'] = {
                [1] = "Scored cards have a 1 in 8 chance to",
                [2] = "create a zodiac card if played hand contains a straight"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 