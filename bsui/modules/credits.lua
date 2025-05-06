BSUI.Modules.Credits = {}

BSUI.Modules.Credits.Header = function(colour, text, scale, dims)
    return BSUI.Row(BSUI.Theme.ColorHeader('tm', colour, dims, 0.075), {
        BSUI.Pad(0, 0.25),
        BSUI.Text(text, G.C.WHITE, scale*1.09, true)
    })
end

BSUI.Modules.Credits.Name = function(name, scale)
    return BSUI.Row(BSUI.Config.Basic, {
        BSUI.Text(name, G.C.WHITE, scale, true)
    })
end

BSUI.Modules.Credits.Names = function(names, scale)
    local ret = {}
    for _,name in pairs(names) do
        ret[#ret+1] = BSUI.Modules.Credits.Name(name, scale)
        ret[#ret+1] = BSUI.Row( BSUI.Config.Basic, {BSUI.Pad(0.0, 0.1)})
    end
    return BSUI.Col(BSUI.Config.Basic, ret)
end