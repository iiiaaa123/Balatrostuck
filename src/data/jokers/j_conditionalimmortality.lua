--TODO: fix nil mult in tooltip 
function Balatrostuck.INIT.Jokers.j_conditionalimmortality()
    SMODS.Joker{
        name = "Conditional Immortality",
        key = "conditionalimmortality",
        config = {
            extra = {
                mult_mod = 3,
                mult = 0
            }
        },
        loc_txt = {
            ['name'] = 'Conditional Immortality',
            ['text'] = {
                [1] = "This Joker gains {C:mult}+#1#{} Mult",
                [2] = "for every {C:attention}Jimbo{} sold,",
                [3] = "Jimbo appears {C:attention}10X{} more",
                [4] = "frequently in the shop",
                [5] = "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)"
            }
        },
        pos = {
            x = 2,
            y = 0
         },
        cost = 6,
        rarity = 1,
        blueprint_compat = true,
        eternal_compat = true,
        unlocked = true,
        discovered = true,
        atlas = 'HomestuckJokers',

        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = {
                set = "Joker",
                key = "j_joker",
                specific_vars = { self.config.mult },
            }
            return {vars = {card.ability.extra.mult, card.ability.extra.mult_mod}}
        end,
    }
end 