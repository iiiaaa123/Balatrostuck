function Balatrostuck.INIT.Jokers.j_pickleinspector()
    SMODS.Joker{
        name = "Pickle Inspector",
        key = "pickleinspector",
        config = {
            extra = {
                xmult_gain = 0.02,
                xmult = 1
            }
        },
        loc_txt = {
            ['name'] = 'Pickle Inspector',
            ['text'] = {
                [1] = "This Joker gains {X:red,C:white}X#1#{} Mult",
                [2] = "whenever {C:attention}another Joker triggers,",
                [3] = "resets at end of round",
                [4] = "{S:0.8}Pickle Inspector excluded",
                [5] = "{C:inactive}(Currently {X:red,C:white}X#2#{C:inactive} Mult)"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 5,
        rarity = 2,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',
        loc_vars = function(self,info_queue,card)
            return {vars = {card.ability.extra.xmult_gain, card.ability.extra.xmult}}
        end,
    }
end 