function Balatrostuck.INIT.Jokers.j_kernelsprite()
    SMODS.Joker{
        name = "Kernelsprite",
        key = "kernelsprite",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Kernelsprite',
            ['text'] = {
                [1] = "The next {C:attention}two discards{} that have only",
                [2] = "{C:attention}one card{}, {C:red}destroy{} it and {C:attention}store{} them.",
                [3] = "At start of round, create two {C:green}Paradox",
                [4] = "cards with the {C:attention}stored{} rank and suits",
                [5] = "{C:inactive}(Unassigned) (Unassigned)"
            }
        },
        pos = {
            x = 3,
            y = 3
         },
        cost = 4,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 