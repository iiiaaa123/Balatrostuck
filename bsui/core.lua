--- Everything below here is my way of making sure that we have a UI that doesn't suck ass to read
--- Sincerely, Akai "Balatrostuck Gaming" ff0064
--     G.UIT 
--     T=1, --text
--     B=2, --box (can be rounded)
--     C=3, --column
--     R=4, --row
--     O=5, --object - must be a Node
--     ROOT=7,
--     S=8, --slider
--     I=9, --input text box
--     padding = 0, --default padding

BSUI = {}

BSUI.Config = {}
BSUI.Modules = {}
BSUI.Theme = {}

BSUI.TextScale = 0.32

BSUI.Config.Basic = {
    align = 'cm',
    padding = G.UIT.padding,
    colour = G.C.CLEAR
}

BSUI.Config.Panel = function(align, padding, colour, dims, emboss, hover, juice)
    local ret = {
        align = align,
        padding = padding,
        colour = colour,
        emboss = emboss and emboss or false,
        hover = hover and hover or false,
        juice = juice and juice or false,
        r = 0.12
    }
    if dims then
        for k,v in pairs(dims) do
            ret[k] = v
        end
    end
    return ret
end

BSUI.Config.PanelOutlined = function(align, padding, colour, outline, thickness, dims, emboss, hover, juice)
    local ret = {
        align = align,
        padding = padding,
        colour = colour,
        emboss = emboss and emboss or false,
        hover = hover and hover or false,
        juice = juice and juice or false,
        outline = thickness,
        outline_colour = outline,
        r = 0.12
    }
    if dims then
        for k,v in pairs(dims) do
            ret[k] = v
        end
    end
    return ret
end

BSUI.Theme.ColorHeader = function(align, basecolour, dims, emboss, hover, juice)
    return BSUI.Config.PanelOutlined(align, 0.05, basecolour, darken(basecolour, 0.2), 1.2, dims or {}, emboss or false, hover or false, juice or false)
end

BSUI.Root = function(config, nodes)
    local conf = (config and config or BSUI.Config.Basic)
    return {
        n = G.UIT.ROOT,
        config = conf,
        nodes = nodes
    }
end

BSUI.Pad = function(width, height)
    return {
        n = G.UIT.B,
        config = {
            w = width,
            h = height,
            align = 'cm'
        },
        nodes = {}
    }
end

BSUI.Row = function(config, nodes)
    local conf = (config and config or BSUI.Config.Basic)
    return {
        n = G.UIT.R,
        config = conf,
        nodes = nodes
    }
end

BSUI.Col = function(config, nodes)
    local conf = (config and config or BSUI.Config.Basic)
    return {
        n = G.UIT.C,
        config = conf,
        nodes = nodes
    }
end

BSUI.PadCol = function (width)
    return BSUI.Col(BSUI.Config.Basic, {BSUI.Pad(width, 0)})
end

BSUI.PadRow = function (height)
    return BSUI.Row(BSUI.Config.Basic, {BSUI.Pad(0, height)})
end

BSUI.Text = function(text, colour, scale, shadow)
    return {
        n = G.UIT.T,
        config = {
            text = text,
            colour = colour,
            scale = scale,
            shadow = shadow,
        }
    }
end

BSUI.Image = function(image)
    return {
        n = G.UIT.O,
        config = { object = image }
    }
end

BSUI.DynaText = function ()
    return {
        n = G.UIT.O,
        config = { object = DynaText()}
    }
end