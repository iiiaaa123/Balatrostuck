function Balatrostuck.INIT.Decks.b_dersite()
    SMODS.Back {
        key = 'dersite',
        loc_txt = {
            name = "Dersite Deck",
            text = {
                '{C:zodiac}Zodiac{} cards appear {C:attention}2X',
                'more frequently in the shop',
                '{s:0.2} ',
                '{C:planet}Celestial Packs{} and {C:planet}Planet{} cards',
                'no longer appear in the shop',
            }
        },
        atlas = 'HomestuckDecks',
        pos = {x = 0,y = 1},
        unlocked = true,
        apply = function(self,back)
            G.GAME.banned_keys['v_planet_merchant'] = true
            G.GAME.banned_keys['v_planet_tycoon'] = true
            G.GAME.zodiac_rate = 8
            G.GAME.planet_rate = 0
        end
    }
end
