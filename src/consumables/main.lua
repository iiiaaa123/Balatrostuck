    local get_type_colourref = get_type_colour
    function get_type_colour(_c, card)
        local fromRef = get_type_colourref(_c, card)

        if _c.set == "Zodiac" then
            return G.C.ZODIAC[_c.name]
        elseif _c.set == "Aspect" then
            
            if _c.name == 'Breath' then return G.C.BREATH
            elseif _c.name == 'Blood' then return G.C.BLOOD

            elseif _c.name == 'Space' then return G.C.SPACE
            elseif _c.name == 'Time' then return G.C.TIME

            elseif _c.name == 'Light' then return G.C.LIGHT
            elseif _c.name == 'Void' then return G.C.VOID

            elseif _c.name == 'Mind' then return G.C.MIND 
            elseif _c.name == 'Heart' then return G.C.HEART

            elseif _c.name == 'Life' then return G.C.LIFE
            elseif _c.name == 'Doom' then return G.C.DOOM 

            elseif _c.name == 'Hope' then return G.C.HOPE
            elseif _c.name == 'Rage' then return G.C.RAGE

            end
        end

        return fromRef
    end