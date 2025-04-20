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

    ret.pool_flags.bstuck_actprogress = 0
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
        Breath = 0,
        Piss = 0
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
    ret.BALATROSTUCK.active_castes = {}
    ret.BALATROSTUCK.strife_assignment = 'Unassigned'
    ret.BALATROSTUCK.current_aspect = ''
    ret.BALATROSTUCK.pack_size_bonus = 0
    ret.BALATROSTUCK.bucket_suits = {'Diamonds','Clubs'}
    ret.BALATROSTUCK.joker_keys = {}
    ret.BALATROSTUCK.vriska_luck = 1
    ret.BALATROSTUCK.blood_discards = 0
    check_for_piss()

    return ret
end



local game_loadref = Game.start_run
function Game:start_run(args)
    game_loadref(self,args)
    self.GAME.BALATROSTUCK.active_castes = {}
    
    for k,v in pairs(self.GAME.BALATROSTUCK.zodiac_levels) do
        if v > 0 then
            local newCaste = Caste('caste_bstuck_' .. string.lower(k),self.P_CASTES['caste_bstuck_' .. k])
            table.insert(G.GAME.BALATROSTUCK.active_castes, newCaste)
        end
    end

    if self.GAME.BALATROSTUCK.current_aspect ~= '' or nil then
        local _slab = Slab('slab_bstuck_' .. self.GAME.BALATROSTUCK.current_aspect)
        self.GAME.slab = _slab    
    end
end
    

local easedollars_ref = ease_dollars
function ease_dollars(mod, instant)
    SMODS.calculate_context({bstuck_money_increased = true, total_dollars = G.GAME.dollars + mod})
    easedollars_ref(mod,instant)
end


local draw_ref = Card.draw
function Card:draw(layer)
    if self.config.center.animated then
        self.animTime = self.animTime or G.TIMERS.REAL
        self.animPos = self.animPos or copy_table(self.config.center.pos)

        -- per frame
        if self.animTime + (1/self.config.center.animation_speed) <= G.TIMERS.REAL then
            if self.config.center.dimensions then
                self.animPos.x = self.animPos.x + 1
                if self.animPos.x >= self.config.center.dimensions.x then
                    self.animPos.y = self.animPos.y + 1
                    self.animPos.x = 0
                    if self.animPos.y >= self.config.center.dimensions.y then
                        self.animPos.y = 0
                    end
                end
            else
                self.animPos.x = self.animPos.x + 1
                if self.animPos.x >= self.config.center.frames then
                    self.animPos.x = 0
                end
            end
            self.animTime = G.TIMERS.REAL
            self.children.center:set_sprite_pos(self.animPos)
        end
    end
    draw_ref(self,layer)
end

local shatter_ref = Card.shatter
function Card:shatter()
    if self.edition and self.edition.key == 'e_bstuck_paradox' and next(SMODS.find_card('j_bstuck_biscuits')) and self.config.center.key ~= 'j_bstuck_questbed' then
        self.getting_sliced = nil
        play_sound('bstuck_HomestuckParadoxSaved',0.7,0.7)
        card_eval_status_text(self, 'extra', nil, nil, nil, {message = localize('k_safe_ex')})
        for j=1, #G.jokers.cards do
            local card = G.jokers.cards[j]
            if card.config.center.key == 'j_bstuck_biscuits' then
                card:juice_up()
            end
        end
        return false
    end
    shatter_ref(self)
end

function check_for_piss()
    -- sendInfoMessage(G.P_CENTERS['c_bstuck_piss'].discovered and 'True' or 'False')
    if G.P_CENTERS['c_bstuck_piss'].discovered then
        G.P_CENTERS['c_bstuck_piss'].no_collection = false
    else 
        G.P_CENTERS['c_bstuck_piss'].no_collection = true
    end

end


-- SMODS.Booster:take_ownership_by_kind('Standard', {
--     create_card = function(self, card, i)
--         if SMODS.find_card('j_bstuck_clown')
        
--         local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, 2, true)
--         local _seal = SMODS.poll_seal({mod = 10})
--         return {set = (pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "sta"}
--     end,
--    true
-- )



set_cost_ref = Card.set_cost
function Card:set_cost()
    set_cost_ref(self)
    if self.config.center.key == 'j_bstuck_jocker' then
        self.cost = math.floor(-4*(100-G.GAME.discount_percent)/100)
        self.sell_cost = math.floor(-2*(100-G.GAME.discount_percent)/100)
    end
end

setbase_ref = Card.set_base
function Card:set_base(card, initial)
    if not initial and card then
        if self.suit ~= self.base.suit then
            SMODS.calculate_context({changing_suit = true, other_card = self, new_suit = card.suit})
        end
    end
    setbase_ref(self,card,initial)
end