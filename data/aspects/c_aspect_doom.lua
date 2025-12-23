function Balatrostuck.INIT.Aspects.c_aspect_doom()
    Balatrostuck.Aspect{
        key = "doom",
        name = "Doom",
        loc_txt = {
            name = "Doom",
            text = {
                '{C:zodiac}Zodiac{} cards give {C:green}#1#{} additional',
                'level#2# and have a {C:green}1 in #3#',
                'chance to reset all other',
                '{C:zodiac}Zodiacs{} to {C:red}level 0{} when used'
                -- 'When you use a {C:zodiac}Zodiac{} card',
                -- 'the corresponding {C:zodiac}Zodiac{} gains',
                -- '#1# additional level#2# but has',
                -- 'a 1 in #3# chance to reset',
                -- 'all other Zodiacs to 0'
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
        discovered = false,
        atlas = "HomestuckAspects",
        use = function(self, context)
            self:switch_slab()
        end,
        can_use = function(self)
            return true
        end,
    }
    -- TODO: THIS IS OUTDATED ABILITY - THE NEW EFFECT IS  N O T  WHAT THE BELOW CODE IS
    -- THIS NEEDS TO BE FIXED ASAP PLS
    Balatrostuck.Slab{
        key = 'doom',
        atlas = 'HomestuckAspectSlabs',
        pos = {
            x = 1,
            y = 2
        },
        config = {},
        name = 'Aspect of Doom',
        apply = function(self,slab,context)
            if context.zodiac_upgrade then
                if pseudorandom('doom') < 1/(slab:level()+1) then
                    local skibidibiden = context.zodiac
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('bstuck_HomestuckDoom',1,0.6)
                            G.ui_slab:juice_up()
                            for k,v in pairs(G.GAME.BALATROSTUCK.zodiac_levels) do
                                if k ~= skibidibiden then
                                    Balatrostuck.Zodiac:remove_caste(k)
                                end
                            end
                            
                            return true
                        end
                    }))
                end
                
                return {
                    amount = summation(slab:level()) + get_grollars(),
                    card = context.other_card
                }
            end
        end
    }
end


