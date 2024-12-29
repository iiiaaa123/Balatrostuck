function Balatrostuck.INIT.Jokers.j_paintseal()
    SMODS.Joker{
        name = "Paint Seal",
        key = "paintseal",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Paint Seal',
            ['text'] = {
                [1] = "On odd rounds the blind size is 1.5x bigger",
                [2] = "On even rounds gain a zodiac card when you win a blind"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 