OR, XOR, AND = 1, 3, 4

function check_for_bstuck_challenges()
    for k, v in ipairs(G.CHALLENGES) do
        if v.key:find("bstuck") and not G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or ''] then
            G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or ''] = true
        end
    end
    return true
end

SMODS.Joker:take_ownership("j_joker", {	
        atlas = 'HomestuckJokers',
        pos = { x = 5, y = 11 },
    	soul_pos = {x = 500, y = 500},
	}, true) -- this is a john joker thing just ignore it and do not remove the joker from the spritesheet

function Card:dialogue_say_stuff(n, not_first, pitch)
    self.talking = true
    local pitch = pitch or 1
    if not not_first then 
        G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.1, func = function()
            if self.children.speech_bubble then self.children.speech_bubble.states.visible = true end
            self:dialogue_say_stuff(n, true, pitch)
        return true end}), 'other')
    else
        if n <= 0 then self.talking = false; return end
        play_sound('voice'..math.random(1, 11), pitch*(math.random()*0.2+1), 0.5)
        self:juice_up()
        G.E_MANAGER:add_event(Event({trigger = "after", blockable = false, blocking = false, delay = 0.13, func = function()
            self:dialogue_say_stuff(n-1, true, pitch)
        return true end}), 'other')
    end
end

function Card:add_dialogue(text_key, align, yap_amount, baba_pitch)
    if self.children.speech_bubble then self.children.speech_bubble:remove() end
    self.config.speech_bubble_align = {align=align or 'bm', offset = {x=0,y=0},parent = self}
    self.children.speech_bubble = 
    UIBox{
        definition = G.UIDEF.speech_bubble(text_key, {quip = true}),
        config = self.config.speech_bubble_align
    }
    self.children.speech_bubble:set_role{role_type = "Minor", xy_bond = "Strong", r_bond = "Strong", major = self}
    self.children.speech_bubble.states.visible = false
    local yap_amount = yap_amount or 5
    local baba_pitch = baba_pitch or 1
    self:dialogue_say_stuff(yap_amount, nil, baba_pitch)
end

function Card:remove_dialogue(timer)
    local timer = (timer * G.SETTINGS.GAMESPEED) or 0
    G.E_MANAGER:add_event(Event({trigger = "after", blockable = false, blocking = false, delay = timer, func = function()
        if self.children.speech_bubble then self.children.speech_bubble:remove(); self.children.speech_bubble = nil end
    return true end}))
end


function bitoper(a, b, oper)
    local r, m, s = 0, 2^31
    repeat
       s,a,b = a+b+m, a%m, b%m
       r,m = r + m*oper%(s-a-b), m/2
    until m < 1
    return r
 end

 function factorial(n)
    if (n == 0) then
        return 1
    else
        return n * factorial(n - 1)
    end
end

function get_table_keys(tab)
    local keyset = {}
    for k,v in pairs(tab) do
        keyset[#keyset + 1] = k
    end
    return keyset
end

function get_table_values(tab)
    local valueset = {}
    for k,v in pairs(tab) do
        valueset[#valueset + 1] = v
    end
    return valueset
end

function summation(n)
    return (n*(n + 1)) / 2
end

function get_grollars()
    return log2(G.GAME.probabilities.normal or 1)
end

function sum_levels()
    return ((G.GAME.hands['High Card'].level)+(G.GAME.hands['Pair'].level)+(G.GAME.hands['Two Pair'].level)+(G.GAME.hands['Three of a Kind'].level)+(G.GAME.hands['Straight'].level)+(G.GAME.hands['Flush'].level)+(G.GAME.hands['Full House'].level )+(G.GAME.hands['Four of a Kind'].level)+(G.GAME.hands['Straight Flush'].level)+(G.GAME.hands['Five of a Kind'].level)+(G.GAME.hands['Flush House'].level)+(G.GAME.hands['Flush Five'].level))
end


local bstuck_create_card = create_card
function create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
    if G.consumeables and area == G.consumeables then
        for i=1, #G.jokers.cards do
            eval_card(G.jokers.cards[i], {bstuck_create_card = _type})
        end
    end

    return bstuck_create_card(_type, area, legendary, _rarity, skip_materialize, soulable, forced_key, key_append)
end

local bstuck_mod_mult = mod_mult
function mod_mult(_mult)
    if G.GAME.modifiers.mult_dollar_cap then
        _mult = math.min(_mult, math.max((math.ceil(G.GAME.dollars / 2)), 0))
    end
    return bstuck_mod_mult(_mult)
end


function get_innocuous(card,get_only_name)
    local hearts = {
        {'applejuice', true}, {'lusty_joker', false}, {'flower_pot', false}, {'stump', true},
        {'oops', false}, {'cruxitedowel', true}, {'8_ball', false}, {'whatpumpkin', true},
        {'diet_cola', false}, {'hegemonicbrute', true}, {'balletslippers', true}, {'photograph',false},
        {'bloodstone',false}
    }
    local spades = {
        {'cueball',true},{'wrathful_joker', false}, {'soporpie', true},{'gamebro', true},
        {'ice_cream', false},{'banner', false}, {'snowman', true},{'selzer', false},
        {'walkie_talkie', false},{'sovereignslayer', true}, {'operation_regisurp',true},{'ahabscrosshairs', true},
        {'arrowhead', false}
    }
    local clubs = {
        {'seeing_double', false},{'gluttenous_joker', false},{'clover', true},{'bootstraps',false},
        {'caledfwlch', true},{'gros_michel', false},{'idol', false},{'jetpack', true},
        {'ramen', false},{'courtyarddroll',true},{'shoot_the_moon', false},{'drivers_license', false},
        {'onyx_agate', false}
    }
    local diamonds = {
        {'credit_card', false},{'greedy_joker', false}, {'space', false},{'ticket', false},
        {'trading', false},{'ringoflife',true}, {'alltheirons', true},{'gift',false},
        {'todo_list',false},{'draconiandignitary', true}, {'midas_mask', false},{'business',false},
        {'rough_gem', false}
    }
    local wild = {
        {'objectduality', true},{'joker', false}, {'innapropriatebucket', true},{'turtle_bean', false},
        {'sucker', true},{'cavendish', false}, {'fluoriteoctet', true},{'baseball', false},
        {'faygo', true},{'waywardvagabond', true}, {'tanglebuddies', true},{'dadswallet', true},
        {'signofthesignless', true}
    }
    local failsafe = {'jocker', true}
    local stone = {'captchacard', true}
    local innocuous_double = nil
    


    local enhancements = SMODS.get_enhancements(card,false)



    if SMODS.has_no_rank(card) then
        innocuous_double = stone
    elseif SMODS.has_any_suit(card) then
        local rankPos = card:get_id() - 1
        if rankPos > 13 then
            innocuous_double = failsafe
        else
            innocuous_double = wild[card:get_id() - 1]
        end
    else  -- Main Cards
        local rankPos = card:get_id() - 1
        if rankPos > 13 then
            innocuous_double = failsafe
        else
            if card.base.suit == 'Hearts' then
                innocuous_double = hearts[rankPos]
            elseif card.base.suit == 'Diamonds' then
                innocuous_double = diamonds[rankPos]
            elseif card.base.suit == 'Clubs' then
                innocuous_double = clubs[rankPos]
            elseif card.base.suit == 'Spades' then
                innocuous_double = spades[rankPos]
            else
                innocuous_double = failsafe
            end
        end
    end

    -- last saftey net if we haven't set the double yet
    if innocuous_double == nil then
        innocuous_double = failsafe
    end

    if get_only_name then
        local keyprefix = 'j_'
        if innocuous_double[2] then
            keyprefix = keyprefix .. 'bstuck_'
        end
        return localize{type = 'name_text', key = keyprefix .. innocuous_double[1], set = 'Joker'} or localize('k_none')
    else
        local keyprefix = 'j_'
        if innocuous_double[2] then
            keyprefix = keyprefix .. 'bstuck_'
        end
        return keyprefix .. innocuous_double[1]
    end
end

function rank_to_zodiac(card)
    local id = card:get_id()
    if id == 2 then return "Gemini"
    elseif id == 3 then return "Taurus"
    elseif id == 4 then return "Cancer"
    elseif id == 5 then return "Leo"
    elseif id == 6 then return "Virgo"
    elseif id == 7 then return "Libra"
    elseif id == 8 then return "Scorpio"
    elseif id == 9 then return "Sagittarius"
    elseif id == 10 then return "Capricorn"
    elseif id == 11 then return "Aquarius"
    elseif id == 12 then return "Pisces"
    elseif id == 13 then return "Ophiuchus"
    elseif id == 14 then return "Aries"
    else return nil
    end
end


function shuffle(t,seed)
    local tbl = {}
    for i = 1, #t do
        tbl[i] = t[i]
    end
    for i = #tbl, 2, -1 do
        local j = pseudorandom(seed,1,i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end


function tableContains(table, value)
    for i = 1,#table do
        if (table[i] == value) then
            return true
        end
    end
    return false
end


function art_credit(artist_name, info) 
    if not G.SETTINGS.bstuck_per_card_credits then return end

    local artist = G.bstuck_team[artist_name]
    info[#info+1] = { key = 'art_bstuck_1', set = 'Other', vars = {artist.name, colours={artist.color}}}
end


function art_credit2(artist_name1, artist_name2, info) 
    if not G.SETTINGS.bstuck_per_card_credits then return end

    local artist1 = G.bstuck_team[artist_name1]
    local artist2 = G.bstuck_team[artist_name2]
    info[#info+1] = { 
        key = 'art_bstuck_2',
        set = 'Other', 
        vars = {
            artist1.name,
            artist2.name,
            colours = {
                artist1.color,
                artist2.color
            }
        }
    }
end


function get_zodiac(normalize_weights,pack)
    G.GAME.gamer_choices = G.GAME.gamer_choices or {}
    local pool = {
        {key = 'aries',weight = 0.9,onestar = false},
        {key = 'gemini',weight = 0.8,onestar = false},
        {key = 'taurus',weight = 0.7,onestar = false},
        {key = 'cancer',weight = 0.6,onestar = false},
        {key = 'leo',weight = 0.6,onestar = false},    
        {key = 'virgo',weight = 0.4,onestar = false},
        {key = 'libra',weight = 0.4,onestar = false},
        {key = 'scorpio',weight = 0.4,onestar = false},
        {key = 'sagittarius',weight = 0.6,onestar = false},
        {key = 'capricorn',weight = 0.6,onestar = false},
        {key = 'aquarius',weight = 0.7,onestar = false},
        {key = 'pisces',weight = 0.8,onestar = false},
        {key = 'ophiuchus',weight = 0.9,onestar = false}
    }

    if normalize_weights or next(SMODS.find_card('v_bstuck_giftofgab')) then
        for i=1, #pool do
            pool[i].weight = 0
        end
    end

    if not next(find_joker("Showman")) then
        for i = #pool, 1, -1 do 
            if G.GAME.used_jokers['c_bstuck_' .. pool[i].key] then
                table.remove(pool, i)
            end
        end
    end




    local poolLuck = pseudorandom('gamerPack')
    local lowestWeight = 1


    for i=1, #pool do
        if pool[i].weight < lowestWeight then
            lowestWeight = pool[i].weight
        end
    end
    poolLuck = math.max(poolLuck,lowestWeight + pseudorandom('gamerPack',0.01,0.1))




    local shuffledPool = shuffle(pool,'gamerPack')

    for i=1, #shuffledPool do
        if shuffledPool[i].weight < poolLuck and not (G.GAME.used_jokers['c_bstuck_' .. shuffledPool[i].key] and not next(find_joker("Showman"))) then
            table.insert(G.GAME.gamer_choices,'c_bstuck_' .. shuffledPool[i].key)
            return 'c_bstuck_' .. shuffledPool[i].key
        end
    end

    return 'c_bstuck_libra'
end




function reset_hand(card, hand, instant)
    local decrease = G.GAME.hands[hand].level - 1
    G.GAME.hands[hand].level = 1
    G.GAME.hands[hand].mult = G.GAME.hands[hand].s_mult
    G.GAME.hands[hand].chips = G.GAME.hands[hand].s_chips 
    if not instant then 
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = true
            return true end }))
        update_hand_text({delay = 0}, {mult = G.GAME.hands[hand].mult, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            return true end }))
        update_hand_text({delay = 0}, {chips = G.GAME.hands[hand].chips, StatusText = true})
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.9, func = function()
            play_sound('tarot1')
            if card then card:juice_up(0.8, 0.5) end
            G.TAROT_INTERRUPT_PULSE = nil
            return true end }))
        update_hand_text({sound = 'button', volume = 0.7, pitch = 0.9, delay = 0}, {level=G.GAME.hands[hand].level})
        delay(1.3)
    end
    G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = (function() check_for_unlock{type = 'upgrade_hand', hand = hand, level = G.GAME.hands[hand].level} return true end)
    }))
    return decrease
end





function Card:splatter()
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

    local dissolve_time = 2
    self.shattered = true
    self.dissolve = 0
    self.dissolve_colours = {G.C.RED}
    self:juice_up()
    local childParts = Particles(0, 0, 0,0, {
        timer_type = 'TOTAL',
        timer = 0.007*dissolve_time,
        scale = 0.3,
        speed = 4,
        lifespan = 0.5*dissolve_time,
        attach = self,
        colours = self.dissolve_colours,
        fill = true
    })
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.5*dissolve_time,
        func = (function() childParts:fade(0.15*dissolve_time) return true end)
    }))
    G.E_MANAGER:add_event(Event({
        blockable = false,
        func = (function()
                play_sound('bstuck_HomestuckGunshot', math.random()*0.2 + 0.9,0.5)
                play_sound('generic1', math.random()*0.2 + 0.9,0.5)
            return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        blockable = false,
        ref_table = self,
        ref_value = 'dissolve',
        ease_to = 1,
        delay =  0.5*dissolve_time,
        func = (function(t) return t end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.55*dissolve_time,
        func = (function() self:remove() return true end)
    }))
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        blockable = false,
        delay =  0.51*dissolve_time,
    }))
end


function log2(x)
    return math.log(x) / math.log(2)
end


function create_UIBox_zodiacs(simple)
    local hands = {
        create_zodiac_row('Gemini', simple),
        create_zodiac_row('Taurus', simple),
        create_zodiac_row('Cancer', simple),
        create_zodiac_row('Leo', simple),
        create_zodiac_row('Virgo', simple),
        create_zodiac_row('Libra', simple),
        create_zodiac_row('Scorpio', simple),
        create_zodiac_row('Sagittarius', simple),
        create_zodiac_row('Capricorn', simple),
        create_zodiac_row('Aquarius', simple),
        create_zodiac_row('Pisces', simple),
        create_zodiac_row('Ophiuchus', simple),
        create_zodiac_row('Aries', simple),
    }
  
    local t = BSUI.Root({align = "cm", minw = 3, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, {
        BSUI.Row({align = "cm", padding = 0.04}, hands)
    })

    return t
  end
  



  function create_zodiac_row(zodiac, simple)
    local count = 0
    local altColors = {
        Aries = HEX('9E3131'),
        Gemini = HEX('C9A100'),
        Taurus = HEX('A05D1E'),
        Cancer = HEX('F42525'),
        Leo = HEX('548200'),
        Virgo = HEX('078446'),
        Libra = HEX('008282'),
        Scorpio = HEX('4673A0'),
        Sagittarius = HEX('3552E0'),
        Capricorn = HEX('8D53CC'),
        Aquarius = HEX('823482'),
        Pisces = HEX('991E5D'),
        Ophiuchus = G.C.ZODIAC['Ophiuchus']
    }

    local textColour = (zodiac == 'Ophiuchus' and G.GAME.BALATROSTUCK.zodiac_levels[zodiac] == 1) and G.C.WHITE or G.C.UI.TEXT_DARK


    if G.deck then
        local ranks = {
            Gemini = 2,
            Taurus = 3,
            Cancer = 4,
            Leo = 5,
            Virgo = 6,
            Libra = 7,
            Scorpio = 8,
            Sagittarius = 9,
            Capricorn = 10,
            Aquarius = 11,
            Pisces = 12,
            Ophiuchus = 13,
            Aries = 14
        }
        for _,v in ipairs(G.playing_cards) do
            if v:get_id() == ranks[zodiac] then
                count = count + 1
            end
        end
    end
    full_UI_table = {
        main = {},
        info = {},
        type = {},
        name = nil,
        badges = badges or {}
    }

    local zodiac_row_tooltip = {text = nil, filler = {func = create_UIBox_zodiac_tip, args = zodiac}}
    local zodiac_row_tooltip_simple = {text = localize(zodiac, 'zodiac_names'), filler = {func = create_UIBox_zodiac_tip, args = zodiac}}
    
    local config_main_panel = BSUI.Config.Panel('cm', 0.05, darken(G.C.JOKER_GREY, 0.1), {force_focus = true, on_demand_tooltip = zodiac_row_tooltip}, 0.05, true)
    local config_main_panel_simple = BSUI.Config.Panel('cm', 0.05, darken(G.C.JOKER_GREY, 0.1), {force_focus = true, on_demand_tooltip = zodiac_row_tooltip_simple, focus_args = {snap_to = (simple)}}, 0.05, true)
    
    local level_display_color = G.GAME.BALATROSTUCK.zodiac_levels[zodiac] == 1 and altColors[zodiac] or G.C.HAND_LEVELS[math.min(7, math.max(1,G.GAME.BALATROSTUCK.zodiac_levels[zodiac]))]
    local config_level_display = BSUI.Config.PanelOutlined('cm', 0.01, level_display_color, G.C.WHITE, 0.8, {minw = 1.5})
    
    local zodiac_row = BSUI.Row(config_main_panel, {
        BSUI.Col({align = "cl", padding = 0, minw = 5}, {
            BSUI.Col(config_level_display, {
                BSUI.Text(localize('k_level_prefix')..G.GAME.BALATROSTUCK.zodiac_levels[zodiac], textColour, 0.5)
            }),
            BSUI.Col({align = "cm", minw = 4.5, maxw = 4.5}, {
                BSUI.Text(' '..localize(zodiac,'zodiac_names'), G.C.UI.TEXT_LIGHT, 0.45, true)
            })
        }),
        BSUI.Col(BSUI.Config.Basic, {
            BSUI.Text('  #', G.C.UI.TEXT_LIGHT, 0.45, true)
        }),
        BSUI.Col(BSUI.Config.Panel('cm', 0.05, G.C.L_BLACK, {minw = 0.9}), {
            BSUI.Text(count, G.C.FILTER, 0.45, true)
        })
    })
    
    local zodiac_row_simple = BSUI.Row(config_main_panel_simple, {
        BSUI.Col({align = "cm", padding = 0, minw = 5}, {
            BSUI.Text(localize(zodiac,'zodiac_names'), G.C.UI.TEXT_LIGHT, 0.5, true)
        })
    })

    return (not simple and zodiac_row or zodiac_row_simple or nil)

  end



function create_UIBox_zodiac_tip(zodiac)
    local lvl = math.max(1,G.GAME.BALATROSTUCK.zodiac_levels[zodiac])
    play_sound('paper1',0.95 + math.random()*0.1, 0.3)

    local slug = 'c_bstuck_'..string.lower(zodiac)
    local zodiac_card = G.P_CENTERS[slug]

    local _nodes = {}
    local _returnnodes = {}
    
    if G.GAME.BALATROSTUCK.zodiac_levels[zodiac] < 1 then
        _returnnodes[#_returnnodes+1] = BSUI.Row({align = "cm"}, {
            BSUI.Text('(Currently inactive)', G.C.UI.TEXT_INACTIVE, BSUI.TextScale)
        })
    end

    localize{
        type = 'descriptions', 
        set = 'Zodiac', 
        key = slug, 
        vars = zodiac_card:get_formula(lvl), 
        nodes = _nodes
    }
    
    for i=1,#_nodes do
        table.insert(_returnnodes, BSUI.Row({align = "cm"}, _nodes[i]))
    end
     
    return BSUI.Col(BSUI.Config.Basic, _returnnodes)
end





function get_cur_back_sprite(_card)
    local atlas = G.ASSET_ATLAS[(G.GAME.viewed_back or G.GAME.selected_back) and ((G.GAME.viewed_back or G.GAME.selected_back)[G.SETTINGS.colourblind_option and 'hc_atlas' or 'lc_atlas'] or (G.GAME.viewed_back or G.GAME.selected_back).atlas) or 'centers']
    local pos = _card.params.bypass_back or (_card.playing_card and G.GAME[_card.back].pos or G.P_CENTERS['b_red'].pos)
    return atlas, pos
end


G.FUNCS.can_activate_joker = function(e)
    
    if e.config.ref_table:can_activate_joker() then 
        e.config.colour = G.C.RED
        e.config.button = 'activate_joker'
    else
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
    end
end




function Card:can_activate_joker(args)
    local obj = self.config.center
    if obj.can_activate and type(obj.can_activate) == 'function' then
        return obj:can_activate(self, args)
    end
end


function Card:activate_joker(args)
    stop_use()
    local obj = self.config.center
    if obj.activate and type(obj.activate) == 'function' then
        obj:activate(self, args)
        return
    end
end


function Card:activate_cost(args)
    local obj = self.config.center
    if obj.activate_cost and type(obj.activate_cost) == 'function' then
        return obj:activate_cost(self, args)
    end
end


G.FUNCS.activate_joker = function(e, mute, nosave)
    e.config.button = nil
    local card = e.config.ref_table
    local area = card.area
    local prev_state = G.STATE
    local dont_dissolve = nil
    local delay_fac = 1





    G.TAROT_INTERRUPT = G.STATE
    G.STATE = (G.STATE == G.STATES.TAROT_PACK and G.STATES.TAROT_PACK) or
      (G.STATE == G.STATES.PLANET_PACK and G.STATES.PLANET_PACK) or
      (G.STATE == G.STATES.SPECTRAL_PACK and G.STATES.SPECTRAL_PACK) or
      (G.STATE == G.STATES.STANDARD_PACK and G.STATES.STANDARD_PACK) or
      (G.STATE == G.STATES.BUFFOON_PACK and G.STATES.BUFFOON_PACK) or
      G.STATES.PLAY_TAROT
      
    G.CONTROLLER.locks.use = true
    if G.shop and not G.shop.alignment.offset.py then
      G.shop.alignment.offset.py = G.shop.alignment.offset.y
      G.shop.alignment.offset.y = G.ROOM.T.y + 29
    end
    if G.blind_select and not G.blind_select.alignment.offset.py then
      G.blind_select.alignment.offset.py = G.blind_select.alignment.offset.y
      G.blind_select.alignment.offset.y = G.ROOM.T.y + 39
    end
    if G.round_eval and not G.round_eval.alignment.offset.py then
      G.round_eval.alignment.offset.py = G.round_eval.alignment.offset.y
      G.round_eval.alignment.offset.y = G.ROOM.T.y + 29
    end

    if card.children.use_button then card.children.use_button:remove(); card.children.use_button = nil end
    if card.children.sell_button then card.children.sell_button:remove(); card.children.sell_button = nil end
    if card.children.price then card.children.price:remove(); card.children.price = nil end

    
    delay(0.2)
    card:activate_joker()


    G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.2,
        func = function()
            card:highlight(false)
            G.E_MANAGER:add_event(Event({trigger = 'after',delay = 0.1,
            func = function()
                G.STATE = prev_state
                G.TAROT_INTERRUPT=nil
                G.CONTROLLER.locks.use = false

                if (prev_state == G.STATES.TAROT_PACK or prev_state == G.STATES.PLANET_PACK or
                  prev_state == G.STATES.SPECTRAL_PACK or prev_state == G.STATES.STANDARD_PACK or
                  prev_state == G.STATES.BUFFOON_PACK) and G.booster_pack then
                  if area == G.consumeables then
                    G.booster_pack.alignment.offset.y = G.booster_pack.alignment.offset.py
                    G.booster_pack.alignment.offset.py = nil
                  elseif G.GAME.pack_choices and G.GAME.pack_choices > 1 then
                    if G.booster_pack.alignment.offset.py then 
                      G.booster_pack.alignment.offset.y = G.booster_pack.alignment.offset.py
                      G.booster_pack.alignment.offset.py = nil
                    end
                    G.GAME.pack_choices = G.GAME.pack_choices - 1
                  else
                      G.CONTROLLER.interrupt.focus = true
                      if prev_state == G.STATES.TAROT_PACK then inc_career_stat('c_tarot_reading_used', 1) end
                      if prev_state == G.STATES.PLANET_PACK then inc_career_stat('c_planetarium_used', 1) end
                      G.FUNCS.end_consumeable(nil, delay_fac)
                  end
                else
                  if G.shop then 
                    G.shop.alignment.offset.y = G.shop.alignment.offset.py
                    G.shop.alignment.offset.py = nil
                  end
                  if G.blind_select then
                    G.blind_select.alignment.offset.y = G.blind_select.alignment.offset.py
                    G.blind_select.alignment.offset.py = nil
                  end
                  if G.round_eval then
                    G.round_eval.alignment.offset.y = G.round_eval.alignment.offset.py
                    G.round_eval.alignment.offset.py = nil
                  end
                  if area and area.cards[1] then 
                    G.E_MANAGER:add_event(Event({func = function()
                      G.E_MANAGER:add_event(Event({func = function()
                        G.CONTROLLER.interrupt.focus = nil
                        if card.ability.set == 'Voucher' then 
                          G.CONTROLLER:snap_to({node = G.shop:get_UIE_by_ID('next_round_button')})
                        elseif area then
                          G.CONTROLLER:recall_cardarea_focus(area)
                        end
                      return true end }))
                    return true end }))
                  end
                end
            return true
          end}))
        return true
    end}))
end