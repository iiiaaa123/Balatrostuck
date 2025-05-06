function Balatrostuck.INIT.Aspects.c_aspect_light()
    Balatrostuck.Aspect{
        key = "light",
        name = "Light",
        loc_txt = {
            ['name'] = "Light",
            ['text'] = {
                [1] = "", -- "{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
                [2] = 'Cards in your {C:attention}consumable',
                [3] = 'area give {X:mult,C:white}X#1#{} Mult',
                --[4] = '{C:inactive}(Currently {X:mult,C:white}X#3#{C:inactive} Mult)'
            }
        },
        pos = {
            x = 0,
            y = 0
        },
        soul_pos = {
            x = 0,
            y = 2
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            local level = G.GAME.BALATROSTUCK.aspect_levels[self.name] or 0
            local formula = 1 + ((level+1)/2)
            local current = 1 + (level/2)
            return {
                vars = {formula},
                main_start = {BSUI.Modules.GameText.LevelUp(G.C.UI.TEXT_DARK, level+1)}, -- replace with aspect colors later
                main_end = (level > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format('X'..current, G.C.WHITE, G.C.RED),
                    BSUI.Modules.GameText.Format(' Mult')
                })} or {})
            }
        end,
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end
    }



    Balatrostuck.Slab{
        key = 'light',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 0,
            y = 0
        },
        config = {},
        name = 'Aspect of Light',
        apply = function(self, slab, context) 
            if context.other_consumeable then
                return {
                    Xmult_mod = 1 + slab:level() / 2,
                    message = localize{type = 'variable', key = 'a_xmult', vars = {1 + slab:level() / 2}},
                    card = context.other_consumeable              
                }
            end
        end
    }
end