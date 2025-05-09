BSUI.Modules.GameText = {}

BSUI.Modules.GameText.LevelUp = function (level_color, num)
    return BSUI.Row(BSUI.Config.Basic, {
        BSUI.Col({align='bm', padding=0, colour=G.C.CLEAR}, {
            BSUI.Text('(lvl.'..num..') ', level_color, BSUI.TextScale*1.1, false)
        }),
        BSUI.Col({align='bm', padding=0, colour=G.C.CLEAR}, {
            BSUI.Text('Level up', G.C.UI.TEXT_DARK, BSUI.TextScale, false)
        })
    })
end

BSUI.Modules.GameText.Format = function (text, colour, background)
    local bg = background or G.C.CLEAR
    local col = colour or G.C.UI.TEXT_DARK

    local padding = 0.0125
    return BSUI.Col({align='m', padding=padding, colour=bg, r=0, outline = 0.75, outline_colour=bg}, {
        BSUI.Row({align='bm', padding=0, colour=G.C.CLEAR}, {BSUI.Text(text, col, BSUI.TextScale, false)}),
    })
end

BSUI.Modules.GameText.Inactive = function (text)
    return BSUI.Modules.GameText.Format(text, G.C.UI.TEXT_INACTIVE)
end

BSUI.Modules.GameText.Chips = function (num)
    return BSUI.Modules.GameText.Format('+'..num, G.C.BLUE)
end

BSUI.Modules.GameText.Mult = function (num)
    return BSUI.Modules.GameText.Format('+'..num, G.C.RED)
end

BSUI.Modules.GameText.XMult = function (num)
    return BSUI.Modules.GameText.Format('X'..num, G.C.WHITE, G.C.RED)
end

BSUI.Modules.GameText.Money = function (num)
    return BSUI.Modules.GameText.Format('$'..num, G.C.MONEY)
end

BSUI.Modules.GameText.Chance = function (num)
    return BSUI.Modules.GameText.Format(G.C.GAME.probabilities.normal..' in '..num, G.C.GREEN)
end

BSUI.Modules.GameText.FormatBadge = function (text, colour)
    return BSUI.Col({align = "cm", minh = 0.45}, {
        BSUI.Row({align = "cm", colour = colour, r = 0.05, padding = 0.08}, {
            BSUI.Text(text, G.C.UI.TEXT_LIGHT, BSUI.TextScale*0.8, true)
        })
})
end

BSUI.Modules.GameText.EccheladderRung = function (text, colour, top)
    local width = top and 4.2 or 4
    local scale = text == "Poker Face Maintenance Staff" and 0.9 or 1
    return BSUI.Col({align = "cm", minh = 0.45, minw = width, padding=0}, {
        BSUI.Row({align = "cm", colour = colour, minw = width, r = nil, padding = 0.1, outline_colour = darken(colour, 0.66), outline = 1.2}, {
            BSUI.Text(text, G.C.UI.TEXT_LIGHT, BSUI.TextScale*scale, true)
        })
    })
end

BSUI.Modules.GameText.HomestuckLog = function (lines, color)
    local box_col = HEX('dfdfdf')

    local ret = {}

    for _,line in pairs(lines) do
        ret[#ret+1] = BSUI.Row({align='bm', padding=0, colour=G.C.CLEAR}, {BSUI.Text(line, color, BSUI.TextScale, false)})
    end

    return BSUI.Col(BSUI.Config.PanelOutlined('bm', 0.1, box_col, darken(box_col, 0.1), 1, {w = 3}), {
        BSUI.Row({align = "cm", colour = darken(box_col, 0.1), r = 0.05, padding = 0.0125}, {
            BSUI.Text('Hide Jokerlog', G.C.UI.TEXT_DARK, BSUI.TextScale)
        }),
        BSUI.Row(BSUI.Config.Basic, {BSUI.Pad(0, 0.1)}),
        BSUI.Row(BSUI.Config.Basic, {BSUI.Col(BSUI.Config.Basic, ret)}),
        BSUI.Row(BSUI.Config.Basic, {BSUI.Pad(0, 0.1)}),
    })
end

BSUI.Modules.GameText.CurrentValue = function (table)
    local ret = {}

    ret[#ret+1] = BSUI.Modules.GameText.Inactive('(Currently ')

    for _,format in pairs(table) do
        ret[#ret+1] = format
    end

    ret[#ret+1] = BSUI.Modules.GameText.Inactive(')')

    return BSUI.Row(BSUI.Config.Basic, ret)
end
