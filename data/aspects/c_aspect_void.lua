function Balatrostuck.INIT.Aspects.c_aspect_void()
    Balatrostuck.Aspect{
        key = "void",
        name = "Void",
        loc_txt = {
            name = "Void",
            text = {
                '{C:dark_edition}+#1#{} Joker slot'
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
        discovered = false,
        atlas = "HomestuckAspects",
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

                if #jokersToChoose > 0 and negativeCount <= (slab:level()-1) then
                    local flintstones = pseudorandom_element(jokersToChoose, pseudoseed('void'))
                    flintstones:set_edition({negative = true}, true)
                    flintstones.temp_edition = nil
                end
            end
        end
    }
end
