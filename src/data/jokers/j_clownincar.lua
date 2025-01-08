function Balatrostuck.INIT.Jokers.j_clownincar()
    SMODS.Joker{
        name = "Clown In Car",
        key = "clownincar",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Clown In Car',
            ['text'] = {
                [1] = "{C:attention}Playing cards{} in {C:attention}Standard Packs{} can",
                [2] = "only be the ranks corresponding",
                [3] = "to held {C:attention}Zodiac Cards{} (if any)"
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