function Balatrostuck.INIT.Aspects.c_aspect_doom()
    Balatrostuck.Aspect{
        key = "doom",
        name = "Doom",
        loc_txt = {
            ['name'] = "Doom",
            ['text'] = {
                [1] = 'Played cards give {X:mult,C:white}X#1#{} Mult',
                [2] = 'when scored, each card in {C:attention}full',
                [3] = '{C:attention}deck{} has a {C:green}#2# in #3#{} chance',
                [4] = 'to be {C:red}debuffed{} this round',
                [5] = 'when blind is selected',
                [6] = '{C:inactive}(Currently {X:mult,C:white}X#4#{C:inactive} and {C:green}#2# in #5#{C:inactive})'
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
            if context.setting_blind then
                for _, v in ipairs(G.playing_cards) do
                    if pseudorandom('doom') < G.GAME.probabilities.normal/(slab:level() + 1) then
                        v:set_debuff(true)
                    end
                end
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
