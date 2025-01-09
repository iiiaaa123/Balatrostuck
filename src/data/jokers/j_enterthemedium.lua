function Balatrostuck.INIT.Jokers.j_enterthemedium()
    SMODS.Joker{
        name = "Enter The Medium",
        key = "enterthemedium",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Enter The Medium',
            ['text'] = {
                [1] = "This Joker becomes a random",
                [2] = "{C:attention}Balatrostuck{} Joker at end of {C:attention}ante"
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