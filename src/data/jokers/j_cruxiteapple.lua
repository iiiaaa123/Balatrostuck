function Balatrostuck.INIT.Jokers.j_cruxiteapple()
    SMODS.Joker{
        name = "Cruxite Apple",
        key = "cruxiteapple",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Cruxite Apple',
            ['text'] = {
                [1] = "After {C:attention}final hand{} of round,",
                [2] = "gain {C:attention}1{} free {C:green}Reroll{} in the shop",
                [3] = "and {C:attention}destroy{} this card"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 1,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'

        --needs a tooltip in the info queue that says "Unlocks Acend this run"
    }
end 