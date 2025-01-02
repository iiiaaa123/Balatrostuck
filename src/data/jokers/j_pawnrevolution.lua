function Balatrostuck.INIT.Jokers.j_pawnrevolution()
    SMODS.Joker{
        name = "Pawn Revolution",
        key = "pawnrevolution",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Pawn Revolution',
            ['text'] = {
                [1] = "On first hand of round",
                [2] = "create a paradox copy of lowest ranked card held in hand"
            }
        },
        pos = {
            x = 9,
            y = 6
         },
        cost = 5,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 