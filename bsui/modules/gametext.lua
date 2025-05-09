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

BSUI.Modules.GameText.CurrentValue = function (table)
    local ret = {}

    ret[#ret+1] = BSUI.Modules.GameText.Format('(Currently ', G.C.UI.TEXT_INACTIVE)

    for _,format in pairs(table) do
        ret[#ret+1] = format
    end

    ret[#ret+1] = BSUI.Modules.GameText.Format(')', G.C.UI.TEXT_INACTIVE)

    return BSUI.Row(BSUI.Config.Basic, ret)
end
