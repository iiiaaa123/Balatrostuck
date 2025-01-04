function Balatrostuck.INIT.Jokers.j_aimlessrenegade()
    SMODS.Joker{
        name = "Aimless Renegade",
        key = "aimlessrenegade",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Aimless Renegade',
            ['text'] = {
                [1] = "When {C:attention}Blind{} is selected, this Joker",
                [2] = "gains {C:mult}+#1#{} Mult, {C:attention}destroys{} a random Joker,",
                [3] = "and creates a {C:green}Paradox {C:attention}Judgement card",
                [4] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
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