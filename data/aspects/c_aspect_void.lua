function Balatrostuck.INIT.Aspects.c_aspect_void()
    Balatrostuck.Aspect{
        key = "void",
        name = "Void",
        loc_txt = {
            name = "Void",
            text = {
                'Add {C:dark_edition}Negative{} to a random',
                '{C:attention}Joker{} at start of round',
                'if there are {C:attention}#1# or fewer',
                '{C:dark_edition}Negative{} Jokers',
            }
        },
        pos = {
            x = 0,
            y = 1
        },
        soul_pos = {
            x = 0,
            y = 3
        },
        cost = 4,
        discovered = true,
        atlas = "HomestuckAspects",
        loc_vars = function(self, info_queue)
            art_credit2('akai', 'yokcos', info_queue)
            return {
                vars = {
                    summation(self:level()+1),
                },
                main_start = {BSUI.Modules.GameText.LevelUp(G.C.UI.TEXT_DARK, self:level()+1)},
                main_end = (self:level() > 0 and {BSUI.Modules.GameText.CurrentValue({
                    BSUI.Modules.GameText.Format(summation(self:level()), G.C.IMPORTANT),
                    BSUI.Modules.GameText.Inactive(' or fewer')
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
        key = 'void',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 1,
            y = 1
        },
        config = {},
        name = 'Aspect of Void',
        apply = function(self, slab, context) 
            if context.setting_blind then
                local negativeCount = 0
                local jokersToChoose = {}
                for j = 1, #G.jokers.cards do
                    if G.jokers.cards[j].edition then
                        if G.jokers.cards[j].edition.negative then negativeCount = negativeCount + 1 end
                    else
                        table.insert(jokersToChoose, G.jokers.cards[j])
                    end
                end

                if #jokersToChoose > 0 and negativeCount < summation(slab:level()) then
                    local flintstones = pseudorandom_element(jokersToChoose, pseudoseed('void'))
                    flintstones:set_edition({negative = true}, true)
                    flintstones.temp_edition = nil
                end
            end
        end
    }
end
