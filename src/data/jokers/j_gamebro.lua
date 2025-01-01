function Balatrostuck.INIT.Jokers.j_gamebro()
    SMODS.Joker{
        name = "Game Bro",
        key = "gamebro",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Game Bro',
            ['text'] = {
                [1] = "N in 5 chance to give +N*10 mult,",
                [2] = "where N is equal to the amount of scoring bonus cards in played hand"
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