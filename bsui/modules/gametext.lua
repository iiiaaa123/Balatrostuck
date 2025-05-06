BSUI.Modules.GameText = {}

BSUI.Modules.GameText.LevelUp = function (level_color, num)
    return BSUI.Row(BSUI.Config.Basic, {
        BSUI.Col(BSUI.Config.Basic, {BSUI.Text('(lvl. '..num..') ', level_color, 0.33, false)}),
        BSUI.Col(BSUI.Config.Basic, {BSUI.Text('Level up', G.C.UI.TEXT_DARK, 0.33, false)})
    })
end

BSUI.Modules.GameText.Format = function (text, colour, background)
    local bg = background or G.C.CLEAR
    local col = colour or G.C.UI.TEXT_DARK

    local padding = 0.0125
    return BSUI.Col({align='m', padding=padding, colour=bg, r=0, outline = 0.75, outline_colour=bg}, {
        BSUI.Row(BSUI.Config.Basic, {BSUI.Text(text, col, 0.33, false)}),
    })
end

BSUI.Modules.GameText.CurrentValue = function (table)
    local ret = {}

    ret[#ret+1] = BSUI.Modules.GameText.Format('(Currently ', G.C.UI.TEXT_INACTIVE)

    for _,format in pairs(table) do
        ret[#ret+1] = format
    end

    ret[#ret+1] = BSUI.Modules.GameText.Format(')', G.C.UI.TEXT_INACTIVE)

    return BSUI.Row(BSUI.Config.Basic, ret)
end
