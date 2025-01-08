function Balatrostuck.INIT.Jokers.j_cloudwatching()
    SMODS.Joker{
        name = "Cloudwatching",
        key = "cloudwatching",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Cloudwatching',
            ['text'] = {
                [1] = "When round begins, create a {C:green}Paradox{} copy of",
                [2] = "the {C:attention}15th card{} from the top of your {C:attention}deck",
                [3] = "and add it to your {C:attention}hand"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 3,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 