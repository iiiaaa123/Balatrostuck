local calculate_joker_ref = Card.calculate_joker
function Card:calculate_joker(context)

    if self.ability.set == 'Default' or self.ability.set == 'Enhanced' then
        if context.cardarea == G.held and context.joker_main and self:get_id() == 4 and G.GAME.BALATROSTUCK.zodiac_levels['Cancer'] >= 1 then
            return {
                mult = 3 + G.GAME.BALATROSTUCK.zodiac_levels['Cancer'],
                card = self
            }
        end
    end

    return calculate_joker_ref(self, context)
end


local game_updateref = Game.update
function Game:update(dt)
    game_updateref(self, dt)
    
    local zodiac_list = {
        HEX("A10000"),
        HEX("A15000"),
        HEX("A1A100"),
        HEX("626262"),
        HEX("416600"),
        HEX("008141"),
        HEX("005682"),
        HEX("000056"),
        HEX("2B0057"),
        HEX("6A006A"),
        HEX("77003C"),
    }

    local aspect_list = {
        G.C.TIME,
        G.C.SPACE,
        G.C.BLOOD,
        G.C.BREATH,
        G.C.HEART,
        G.C.MIND,
        G.C.LIGHT,
        G.C.VOID,
        G.C.DOOM,
        G.C.LIFE,
        G.C.HOPE,
        G.C.RAGE
    }

    local anim_timer = self.TIMERS.REAL*1.5
    local progress = anim_timer % 1
    local chosen_zodiac_pair = (anim_timer - progress) % #zodiac_list + 1
    local chosen_aspect_pair = (anim_timer - progress) % #aspect_list + 1

    local left_colour = zodiac_list[chosen_zodiac_pair]
    local right_colour = zodiac_list[chosen_zodiac_pair % #zodiac_list + 1] -- this works?

    local left_colour_aspect = aspect_list[chosen_aspect_pair]
    local right_colour_aspect = aspect_list[chosen_aspect_pair % #aspect_list + 1] -- this works?

    self.C.SECONDARY_SET.Zodiac[1] = left_colour[1] * (1 - progress) + right_colour[1] * progress
    self.C.SECONDARY_SET.Zodiac[2] = left_colour[2] * (1 - progress) + right_colour[2] * progress
    self.C.SECONDARY_SET.Zodiac[3] = left_colour[3] * (1 - progress) + right_colour[3] * progress
    

    self.C.SECONDARY_SET.Aspect[1] = left_colour_aspect[1] * (1 - progress) + right_colour_aspect[1] * progress
    self.C.SECONDARY_SET.Aspect[2] = left_colour_aspect[2] * (1 - progress) + right_colour_aspect[2] * progress
    self.C.SECONDARY_SET.Aspect[3] = left_colour_aspect[3] * (1 - progress) + right_colour_aspect[3] * progress

    -- G.ARGS.LOC_COLOURS["aspect"] = G.C.SECONDARY_SET.Aspect
    -- G.ARGS.LOC_COLOURS["zodiac"] = G.C.SECONDARY_SET.Zodiac
end

local init_game_objectref = Game.init_game_object
function Game:init_game_object()
    local ret = init_game_objectref(self)
    ret.BALATROSTUCK = {}
    ret.BALATROSTUCK.aspect_levels = {
        Space = 0,
        Time = 0,
        Hope = 0,
        Rage = 0,
        Light = 0,
        Void = 0,
        Heart = 0,
        Mind = 0,
        Doom = 0,
        Life = 0,
        Blood = 0,
        Breath = 0
    }
    ret.BALATROSTUCK.zodiac_levels = {
        Aries = 0,
        Taurus = 0,
        Gemini = 0,
        Cancer = 0,
        Leo = 0,
        Virgo = 0,
        Libra = 0,
        Scorpio = 0,
        Sagittarius = 0,
        Capricorn = 0,
        Aquarius = 0,
        Pisces = 0,
        Ophiuchus = 0
    }
    ret.BALATROSTUCK.strife_assignment = 'Unassigned'
    ret.BALATROSTUCK.current_aspect = ''
    return ret
end