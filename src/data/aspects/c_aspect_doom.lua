function Balatrostuck.INIT.Aspects.c_aspect_doom()
    Balatrostuck.Aspect{
        key = "doom",
        name = "Doom",
        loc_txt = {
            ['name'] = "Doom",
            ['text'] = {
                [1] = 'When a {C:green,E:1,S:1.1}probability',
                [2] = 'up to {C:green}1 in 3{} fails',
                [3] = 'gain a {C:dark_edition}Negative{} Fool'
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
            if context.start_of_round then
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
