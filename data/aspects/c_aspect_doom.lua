function Balatrostuck.INIT.Aspects.c_aspect_doom()
    Balatrostuck.Aspect{
        key = "doom",
        name = "Doom",
        loc_txt = {
            ['name'] = "Doom",
            ['text'] = {
                [1] = "", --"{S:0.8}({S:0.8,V:1}lvl.#1#{S:0.8}){} Level up",
                [2] = 'Played cards give {X:mult,C:white}X#1#{} Mult',
                [3] = 'when scored, each card in the',
                [4] = '{C:attention}full deck{} has a {C:green}#2# in #3#{} chance',
                [5] = 'to be {C:red}debuffed{} this round',
                [6] = 'when blind is selected',
                [7] = '{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} and {C:green}#2# in #5#{C:inactive})'
            }
        },
        pos = {
            x = 5,
            y = 1
        },
        soul_pos = {
            x = 5,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }


    Balatrostuck.Slab{
        key = 'doom',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 3,
            y = 0
        },
        config = {},
        name = 'Aspect of Doom',
        apply = function(self,slab,context)
            if context.debuff_card and pseudorandom('doom') < G.GAME.probabilities.normal/(slab:level() + 1) then
                return {
                    debuff = true
                }
            end

            if context.individual and context.cardarea == G.play then
                return {
                        x_mult = 1 + (slab:level() / 10),
                        card = context.other_card
                }
            end
        end
    }
end
