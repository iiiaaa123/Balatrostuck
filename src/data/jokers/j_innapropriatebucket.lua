function Balatrostuck.INIT.Jokers.j_innapropriatebucket()
    SMODS.Joker{
        name = "Gene Joker",
        key = "innapropriatebucket",
        config = {
            extra = {
            }
        },
        loc_txt = {
            ['name'] = 'Innapropriate Bucket',
            ['text'] = {
                [1] = "[Suit] also acts as [Suit]",
                [2] = "Both suits change every round"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 4,
        rarity = 1,
        blueprint_compat = false,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers'
    }
end 