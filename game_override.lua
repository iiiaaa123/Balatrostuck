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


local generate_UIbox_ability_tableref = Card.generate_UIbox_ability_table
function Card:generate_UIbox_ability_table()
    local full_UI_table = generate_UIbox_ability_tableref(self)

    if self.playing_card then
        local zodiac = rank_to_zodiac(self)
        if zodiac and G.GAME.BALATROSTUCK.zodiac_levels[zodiac] > 0 then
            generate_card_ui({key = zodiac, set = "zodiacui"}, full_UI_table)
        end
    end

    return full_UI_table
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

    local paradox_list = {
        G.C.PARADOX1,
        G.C.PARADOX2,
    }

    local suckers_list = {
        G.C.RED,
        G.C.GREEN,
    }


    local anim_timer = self.TIMERS.REAL*1.5
    local anim_timer_pdox = self.TIMERS.REAL*2
    local progress = anim_timer % 1
    local pdox_progress = anim_timer_pdox % 1
    local chosen_zodiac_pair = (anim_timer - progress) % #zodiac_list + 1
    local chosen_aspect_pair = (anim_timer - progress) % #aspect_list + 1
    local chosen_paradox_pair = (anim_timer_pdox - pdox_progress) % #paradox_list + 1
    local suckers_pair = (anim_timer - progress) % #suckers_list + 1
    local suck_left = suckers_list[suckers_pair]
    local suck_right = suckers_list[suckers_pair % #suckers_list + 1]

    self.C.SUCKERS[1] = suck_left[1] * (1 - progress) + suck_right[1] * progress
    self.C.SUCKERS[2] = suck_left[2] * (1 - progress) + suck_right[2] * progress
    self.C.SUCKERS[3] = suck_left[3] * (1 - progress) + suck_right[3] * progress

    local left_colour = zodiac_list[chosen_zodiac_pair]
    local right_colour = zodiac_list[chosen_zodiac_pair % #zodiac_list + 1] -- this works?

    local left_colour_aspect = aspect_list[chosen_aspect_pair]
    local right_colour_aspect = aspect_list[chosen_aspect_pair % #aspect_list + 1] -- this works?

    local left_colour_paradox = paradox_list[chosen_paradox_pair]
    local right_colour_paradox = paradox_list[chosen_paradox_pair % #paradox_list + 1] -- this works?


    self.C.SECONDARY_SET.Zodiac[1] = left_colour[1] * (1 - progress) + right_colour[1] * progress
    self.C.SECONDARY_SET.Zodiac[2] = left_colour[2] * (1 - progress) + right_colour[2] * progress
    self.C.SECONDARY_SET.Zodiac[3] = left_colour[3] * (1 - progress) + right_colour[3] * progress
    

    self.C.SECONDARY_SET.Aspect[1] = left_colour_aspect[1] * (1 - progress) + right_colour_aspect[1] * progress
    self.C.SECONDARY_SET.Aspect[2] = left_colour_aspect[2] * (1 - progress) + right_colour_aspect[2] * progress
    self.C.SECONDARY_SET.Aspect[3] = left_colour_aspect[3] * (1 - progress) + right_colour_aspect[3] * progress

    self.C.PARADOX[1] = left_colour_paradox[1] * (1 - pdox_progress) + right_colour_paradox[1] * pdox_progress
    self.C.PARADOX[2] = left_colour_paradox[2] * (1 - pdox_progress) + right_colour_paradox[2] * pdox_progress
    self.C.PARADOX[3] = left_colour_paradox[3] * (1 - pdox_progress) + right_colour_paradox[3] * pdox_progress
    -- G.ARGS.LOC_COLOURS["aspect"] = G.C.SECONDARY_SET.Aspect
    -- G.ARGS.LOC_COLOURS["zodiac"] = G.C.SECONDARY_SET.Zodiac



end

local init_game_objectref = Game.init_game_object
function Game:init_game_object()
    local ret = init_game_objectref(self)

    ret.pool_flags.bstuck_actprogress = 0
    ret.BALATROSTUCK = {}
    ret.BALATROSTUCK.art_credit = true -- make this toggleable somehow LOL
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
    ret.BALATROSTUCK.strife_assignment = {}
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
        G.ui_slab:update_atlas()
    end
end
    

local easedollars_ref = ease_dollars
function ease_dollars(mod, instant)
    SMODS.calculate_context({bstuck_money_increased = true, total_dollars = G.GAME.dollars + mod})
    easedollars_ref(mod,instant)
end


local draw_ref = Card.draw
function Card:draw(layer)
    if self.config.center.animated and self.config.center.discovered then
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

SMODS.Booster:take_ownership_by_kind('Buffoon', {
    create_card = function(self, card, i)
        local _edition = nil
        if next(SMODS.find_card('j_bstuck_descendascend')) then
            _edition = 'e_bstuck_paradox'
        end

        return {set = "Joker", edition = _edition, area = G.pack_cards, skip_materialize = true}
    end,
   true
})

SMODS.Booster:take_ownership_by_kind('Standard', {
    create_card = function(self, card, i)
        local _key = nil
        if next(SMODS.find_card('j_bstuck_clownincar')) then
            local _pool = {}
            local _suits = {}
            local peepee = {
                c_bstuck_gemini = "2",
                c_bstuck_taurus = "3",
                c_bstuck_cancer = "4",
                c_bstuck_leo = "5",
                c_bstuck_virgo = "6",
                c_bstuck_libra = "7",
                c_bstuck_scorpio = "8",
                c_bstuck_sagittarius = "9",
                c_bstuck_capricorn = "10",
                c_bstuck_aquarius = "Jack",
                c_bstuck_pisces = "Queen",
                c_bstuck_ophiuchus = "King",
                c_bstuck_aries = "Ace"
            }

            for k,v in pairs(SMODS.Suits) do
                _suits[#_suits+1] = v.card_key
            end

            for i=1, #G.consumeables.cards do
                if peepee[G.consumeables.cards[i].config.center.key] then
                    for j=1, #_suits do
                        _pool[#_pool+1] = _suits[j] .. '_' .. peepee[G.consumeables.cards[i].config.center.key]
                    end
                end
            end

            
            if #_pool > 0 then
                _key = pseudorandom_element(_pool,pseudoseed('Clown'))
            end
        end
        
        local _edition = poll_edition('standard_edition'..G.GAME.round_resets.ante, 2, true)
        if G.GAME.selected_back.effect.center.key == 'b_bstuck_prospitan' then
            _edition = 'e_bstuck_paradox'
        end
        
        
        local _seal = SMODS.poll_seal({mod = 10})
        return {key = _key, set = (pseudorandom(pseudoseed('stdset'..G.GAME.round_resets.ante)) > 0.6) and "Enhanced" or "Base", edition = _edition, seal = _seal, area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "sta"}
    end,
   true
})



set_cost_ref = Card.set_cost
function Card:set_cost()
    set_cost_ref(self)
    if self.config.center.key == 'j_bstuck_jocker' then
        self.cost = math.floor(-4*(100-G.GAME.discount_percent)/100)
        self.sell_cost = math.floor(-2*(100-G.GAME.discount_percent)/100)
    end

    if self.ability.name:find('Standard') and G.GAME.selected_back.effect.center.key == 'b_bstuck_prospitan' then
        self.cost = math.max(0,self.cost - 4)
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




create_card_ref = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if _type == 'zodiac' or _type == 'Zodiac' and forced_key == nil then
        forced_key = get_zodiac()
    end
    local _card = create_card_ref(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if next(SMODS.find_card('j_bstuck_typheus')) then
        if _type == 'joker' or _type == 'Joker' and _card.edition == nil then
            local _edition = poll_edition('Typheus', nil, nil, true)
            _card:set_edition(_edition)
        end
    end

    return _card
end

