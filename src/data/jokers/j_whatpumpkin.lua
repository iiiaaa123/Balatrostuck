function Balatrostuck.INIT.Jokers.j_whatpumpkin()
    SMODS.Joker{
        name = "What Pumpkin",
        key = "whatpumpkin",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'What Pumpkin?',
            ['text'] = {
            }
        },
        pos = {
            x = 1,
            y = 4
         },
        cost = 8,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }:register()
end