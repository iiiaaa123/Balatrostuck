function Balatrostuck.INIT.Rarities.r_felt()
    SMODS.Rarity{ 
        loc_txt = {['name'] = "Felt"},
        key = "felt",
        badge_colour = G.C.FELT,
        pools = {
            ["Joker"] = { weight = 0 }, -- this should make things not spawn
        }
}   end