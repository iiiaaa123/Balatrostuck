OR, XOR, AND = 1, 3, 4

function check_for_bstuck_challenges()
    local challenges_beaten = true
    for k, v in ipairs(G.CHALLENGES) do
        if v.key:find("bstuck") and not G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or ''] then
            challenges_beaten = false
        end
    end
    return challenges_beaten
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
        {'ice_cream',false},{'wrathful_joker', false}, {'soporpie', true},{'bull', false},
        {'gamebro', true},{'banner', false}, {'snowman', true},{'selzer', false},
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

function act_joker(act_number, condition, info)
    info[#info+1] = { key = 'bstuck_act_joker', set = 'Other', vars = {condition, act_number}}
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

        for i = #pool, 1, -1 do 
            if G.GAME.used_jokers['c_bstuck_' .. pool[i].key] and not SMODS.showman('c_bstuck_' .. pool[i].key) then --"allow duplicates" check rather than literally checking for showman card
                table.remove(pool, i)
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

function bstuck_concat_tables(t1,t2)
    for i=1,#t2 do
        t1[#t1+1] = t2[i]
    end
    return t1
end


function bstuck_remove_tag_ui(_tag)
    local HUD_tag_key = nil
    for k, v in pairs(G.HUD_tags) do
        if v == _tag.HUD_tag then HUD_tag_key = k end
    end

    if HUD_tag_key then 
        if G.HUD_tags and G.HUD_tags[HUD_tag_key+1] then
            if HUD_tag_key == 1 then
                G.HUD_tags[HUD_tag_key+1]:set_alignment({type = 'bri',
                offset = {x=0.7,y=0},
                xy_bond = 'Weak',
                major = G.ROOM_ATTACH})
            else
                G.HUD_tags[HUD_tag_key+1]:set_role({
                xy_bond = 'Weak',
                major = G.HUD_tags[HUD_tag_key-1]})
            end
        end
        table.remove(G.HUD_tags, HUD_tag_key)
    end

    _tag.HUD_tag:remove()
end




function bstuck_get_tag_key(append,disallowed_tags)
    G.FORCE_TAG = G.GAME.challenge and (G.GAME.challenge == "c_bstuck_alchemy") and "tag_bstuck_perfecltygeneric" or nil
    if G.FORCE_TAG then return G.FORCE_TAG end
    local _pool, _pool_key = get_current_pool('Tag', nil, nil, append)
    for k,v in pairs(_pool) do
        for _, tag_key in ipairs(disallowed_tags) do
            if v == tag_key then table.remove(_pool,k) end
        end
    end
    local _tag = pseudorandom_element(_pool, pseudoseed(_pool_key))
    local it = 1
    while _tag == 'UNAVAILABLE' do
        it = it + 1
        _tag = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
    end

    return _tag
end


function bstuck_give_random_tag(append,disallowed_tags)
    
    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
        local _banned_tags = bstuck_concat_tables({"tag_bstuck_scratch","tag_bstuck_sburb"},disallowed_tags or {})
        local tagkey = bstuck_get_tag_key(append,_banned_tags)
        local tag = Tag(tagkey)
        if tagkey == 'tag_orbital' then
            local _poker_hands = {}
            for k, v in pairs(G.GAME.hands) do
                if v.visible then _poker_hands[#_poker_hands+1] = k end
            end
            tag.ability.orbital_hand = pseudorandom_element(_poker_hands, pseudoseed('orbital'))
        end
        play_sound('timpani')
        add_tag(tag)
        return true
    end}))
end

--can trigger non-card non-jokers (like tags) in contexts using this 
local mod = SMODS.current_mod
mod.calculate = function(self, context)
    if context.using_consumeable then 
        for i=1, #G.GAME.tags do
            G.GAME.tags[i]:apply_to_run({type = 'using_consumeable', consumeable=context.consumeable})
        end
    end
    --for tag heaven stuff
    if context.ending_shop or context.skip_blind then
        bstuck_clean_tags()
    end
end

--tag heaven code
--gonna add a bunch of maybe unecessary comments here because i feel like this whole thing is a mess
--could be realistically done through lovely overrides but i think that may even be worse
function add_tag(_tag,fromMind)
    local _done = false
    local _reps = 1
    local _current_tag = nil
    --print("adding ".._tag.key)
    for i = 1, #G.GAME.tags do
        _current_tag = G.GAME.tags[i]
        if _current_tag.key == _tag.key then
            --handle the case where we are adding a tag that we already have 
            _reps = (_current_tag.ability.extra.stack_count or 1) + 1
            _current_tag.ability.extra.stack_count = _reps
           
            _done = true
            break
        end
    end
    if not _done then
        if not _tag.from_load then --this line is really important, otherwise tags always load with 1 stack? somehow, not sure why
            if not _tag.ability.extra then
                _tag.ability.extra = {}
            end
            if not _tag.ability.stack_count then
                _tag.ability.extra.stack_count = 1
            end
        end
    end

    if not _done then --we only need to create a new hud if we're adding a tag for the first time
        G.HUD_tags = G.HUD_tags or {}
        local tag_sprite_ui = _tag:generate_UI()
        G.HUD_tags[#G.HUD_tags+1] = UIBox{
            definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
                tag_sprite_ui,
                --next line is the "2x" text or whatever
                --if a sprite needs to be added, it probably goes in here
                {n=G.UIT.O, config={object = DynaText({string = {{suffix = "x", ref_table = _tag.ability.extra, ref_value = 'stack_count'}}, colours = {G.C.UI.TEXT_LIGHT},shadow = true, scale = 0.25})}}
            }},
            config = {
                align = G.HUD_tags[1] and 'tm' or 'bri',
                offset = G.HUD_tags[1] and {x=0,y=0} or {x=0.7,y=0},
                major = G.HUD_tags[1] and G.HUD_tags[#G.HUD_tags] or G.ROOM_ATTACH}
        }
    end

        

  discover_card(G.P_TAGS[_tag.key])

  --this is for when we just added a double tag
  for i = 1, #G.GAME.tags do
    G.GAME.tags[i]:apply_to_run({type = 'tag_add', tag = _tag})
  end

  --skip actually adding the tag if we're just adding a stack
  if not _done then
    G.GAME.tags[#G.GAME.tags+1] = _tag
  end
  --this is to proc *other* double tags
  if not _tag.from_load then SMODS.calculate_context({tag_added = _tag}) end
  _tag.from_load = nil

    --skip adding the hud if we didn't make one, this could realistically be in one of the blocks above
    if not _done then 
        _tag.HUD_tag = G.HUD_tags[#G.HUD_tags]
        --print("added hud: ".._tag.HUD_tag)
    end
    --mind call
  if G.GAME.slab ~= nil and not fromMind then
      local slab_eval = nil
      slab_eval = G.GAME.slab:calculate({tag = _tag})
  end
end
--this is the function that actually does the tag effect
function Tag:yep(message, _colour, func)
    stop_use()


    G.E_MANAGER:add_event(Event({
        delay = 0.4,
        trigger = 'after',
        func = (function()
            attention_text({
                text = message,
                colour = G.C.WHITE,
                scale = 1, 
                hold = 0.3/G.SETTINGS.GAMESPEED,
                cover = self.HUD_tag,
                cover_colour = _colour or G.C.GREEN,
                align = 'cm',
                })
            play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
            play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
            return true
        end)
    }))
    G.E_MANAGER:add_event(Event({
        func = func
    }))
    --print(self.key.." checking removal conditions: count: "..self.ability.extra.stack_count.." triggered: "..tostring(self.triggered))
    --the part under here removes the tag, so it should only proc if the tag is called while triggered (shouldn't really happen)
    --or the stack count is 1 or less (last execution should be 1)
    if not self.ability.extra.stack_count or self.ability.extra.stack_count <= 1 or self.triggered then
        
        G.E_MANAGER:add_event(Event({
            func = (function()
                self.HUD_tag.states.visible = false
                return true
            end)
        }))

        
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.7,
            func = (function()
                self:remove()
                return true
            end)
        }))
    end
end

function Tag:apply_to_run(_context)
    --self.triggered is set and un-set a bunch of times, it is only kept as "true" after evaluation if the tag is fully done (and should be destroyed)
    --i'm also (unfortunately, due to how things are set up,) using it to check whether the current evaluation did anything (because the return value is important for other things)
    if self.triggered then return end
    --haven't touched this block
    local flags = SMODS.calculate_context({prevent_tag_trigger = self, other_context = _context})
    if flags.prevent_trigger then return end
    local obj = SMODS.Tags[self.key] --not sure why this references the base class instead of the instance, maybe a lua thing?
    local res

    --if the object is a modded tag (only modded tags have obj.apply) then loop over it.
    if obj and obj.apply and type(obj.apply) == 'function' then
        local _count = self.ability.extra.stack_count
        for i=1,_count do
            res = obj:apply(self, _context)
            if self.triggered and not res then --"res" is the return value for the tag, it's only used for store joker create and store joker modify contexts
            --do NOT return anything from tag evaluation unless its in those contexts as this causes this function to return early and possibly a bunch of issues
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                self.triggered = false --unset tag.triggered so that it can then trigger again if necessary
            else
                break --if the tag is not triggering anymore (do this when the tag doesn't have an applicable effect), exit the loop early
            end
        end
    end

    --this mess of a line just makes sure we dont go on to the bottom execution (which locks actions if broken)
    --if we are not actually processing a vanilla tag 
    --remember to only set tag.triggered = true if the tag procced *succesfully* 
    if res or self.triggered or (self.config.type == _context.type and obj and obj.apply and type(obj.apply) == 'function') then 
            self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 0)
            return res
    end
    --print("proceeding with vanilla tag eval for "..self.key)
    --vanilla tag evaluation
    --some of them i unrolled the repetitions and made them do in one single loop, for both performance
    --and gameplay reasons
    if not self.triggered and self.config.type == _context.type then
        if _context.type == 'eval' then 
            if self.name == 'Investment Tag' and
                G.GAME.last_blind and G.GAME.last_blind.boss then
                    self:yep('+', G.C.GOLD,function() 
                        return true
                    end)
                self.triggered = true
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0

                return {
                    dollars = self.config.dollars*_count,
                    condition = localize('ph_defeat_the_boss'),
                    pos = self.pos,
                    tag = self
                }
            end
        elseif _context.type == 'immediate' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            if self.name == 'Top-up Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.PURPLE,function() 
                    for i = 1, self.config.spawn_jokers*_count do
                        if G.jokers and #G.jokers.cards < G.jokers.config.card_limit then
                            local card = create_card('Joker', G.jokers, nil, 0, nil, nil, nil, 'top')
                            card:add_to_deck()
                            G.jokers:emplace(card)
                        end
                    end
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = true
                return true
            end
            if self.name == 'Skip Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                        G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                ease_dollars((G.GAME.skips or 0)*self.config.skip_bonus*_count)
                self.triggered = true
                
                return true
            end
            if self.name == 'Garbage Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                        G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                ease_dollars((G.GAME.unused_discards or 0)*self.config.dollars_per_discard*_count)
                self.triggered = true
                
                return true
            end
            if self.name == 'Handy Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                        G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                ease_dollars((G.GAME.hands_played or 0)*self.config.dollars_per_hand*_count)
                self.triggered = true
                
                return true
            end
            if self.name == 'Economy Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.MONEY,function() 
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                G.E_MANAGER:add_event(Event({
                    trigger = 'immediate',
                    func = function()
                        ease_dollars(math.min(self.config.max*_count, math.max(0,(G.GAME.dollars*(2^_count)) - G.GAME.dollars)), true)
                        return true
                    end
                }))
                self.triggered = true
                
                return true
            end
            if self.name == 'Orbital Tag' then
                local _count = self.ability.extra.stack_count
                --orbital should never crash with this, even if its visually corrupted
                if not self.ability.orbital_hand or self.ability.orbital_hand  == "[poker hand]" then 
                    local _poker_hands = {}
                    for k, v in pairs(G.GAME.hands) do
                        if v.visible then _poker_hands[#_poker_hands+1] = k end
                    end
                    self.ability.orbital_hand = pseudorandom_element(_poker_hands,pseudoseed("orbital"))
                end
                self.ability.extra.stack_count = 0
                update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {
                    handname= self.ability.orbital_hand,
                    chips = G.GAME.hands[self.ability.orbital_hand].chips,
                    mult = G.GAME.hands[self.ability.orbital_hand].mult,
                    level= G.GAME.hands[self.ability.orbital_hand].level})
                level_up_hand(self, self.ability.orbital_hand, nil, self.config.levels*_count)
                update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
                self:yep('+', G.C.MONEY,function() 
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = true
                
                return true
            end
        elseif _context.type == 'new_blind_choice' then 
            local lock = self.ID
            G.CONTROLLER.locks[lock] = true
            if self.name == 'Charm Tag' then
                self:yep('+', G.C.PURPLE,function() 
                    local key = 'p_arcana_mega_'..(math.random(1,2))
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Meteor Tag' then
                self:yep('+', G.C.SECONDARY_SET.Planet,function() 
                    local key = 'p_celestial_mega_'..(math.random(1,2))
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Ethereal Tag' then
                self:yep('+', G.C.SECONDARY_SET.Spectral,function() 
                    local key = 'p_spectral_normal_1'
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Standard Tag' then
                self:yep('+', G.C.SECONDARY_SET.Spectral,function() 
                    local key = 'p_standard_mega_1'
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Buffoon Tag' then
                
                self:yep('+', G.C.SECONDARY_SET.Spectral,function() 
                    local key = 'p_buffoon_mega_1'
                    local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
                    G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
                    card.cost = 0
                    card.from_tag = true
                    G.FUNCS.use_card({config = {ref_table = card}})
                    card:start_materialize()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
            if self.name == 'Boss Tag' then
                
                local lock = self.ID
                G.CONTROLLER.locks[lock] = true
                self:yep('+', G.C.GREEN,function() 
                    G.from_boss_tag = true
                    G.FUNCS.reroll_boss()
                    
                    G.E_MANAGER:add_event(Event({func = function()
                        G.E_MANAGER:add_event(Event({func = function()
                            G.CONTROLLER.locks[lock] = nil
                        return true; end}))
                    return true; end}))

                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
        elseif _context.type == 'voucher_add' then 
            if self.name == 'Voucher Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 0
                self:yep('+', G.C.SECONDARY_SET.Voucher,function() 
                    for i=1, _count or 1 do
                        G.ARGS.voucher_tag = G.ARGS.voucher_tag or {}
                        local voucher_key = get_next_voucher_key(true)
                        G.ARGS.voucher_tag[voucher_key] = true
                        G.shop_vouchers.config.card_limit = G.shop_vouchers.config.card_limit + 1
                        local card = Card(G.shop_vouchers.T.x + G.shop_vouchers.T.w/2,
                        G.shop_vouchers.T.y, G.CARD_W, G.CARD_H, G.P_CARDS.empty, G.P_CENTERS[voucher_key],{bypass_discovery_center = true, bypass_discovery_ui = true})
                        card.from_tag = true
                        create_shop_card_ui(card, 'Voucher', G.shop_vouchers)
                        card:start_materialize()
                        G.shop_vouchers:emplace(card)
                        
                    end
                    G.ARGS.voucher_tag = nil
                    return true
                end)
                self.triggered = true
                
            end
        elseif _context.type == 'tag_add' then 
            if self.name == 'Double Tag' and _context.tag.key ~= 'tag_double' and _context.tag.key ~= 'tag_bstuck_scratch' and  _context.tag.key ~= 'sburb' then
                local lock = self.ID
                
                G.CONTROLLER.locks[lock] = true
                self:yep('+', G.C.BLUE,function()
                    if _context.tag.ability and _context.tag.ability.orbital_hand then
                        G.orbital_hand = _context.tag.ability.orbital_hand
                    end
                    add_tag(Tag(_context.tag.key))
                    G.orbital_hand = nil
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
            end
        elseif _context.type == 'round_start_bonus' then 
            if self.name == 'Juggle Tag' then
                local _count = self.ability.extra.stack_count
                self.ability.extra.stack_count = 1
                self:yep('+', G.C.BLUE,function() 
                    G.hand:change_size(self.config.h_size*_count)
                    G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + (self.config.h_size*_count)
                    return true
                end)

                self.triggered = true
                
                return true
            end
        elseif _context.type == 'store_joker_create' then 
            local card = nil
            if self.name == 'Rare Tag' then
                
                local rares_in_posession = {0}
                for k, v in ipairs(G.jokers.cards) do
                    if v.config.center.rarity == 3 and not rares_in_posession[v.config.center.key] then
                        rares_in_posession[1] = rares_in_posession[1] + 1 
                        rares_in_posession[v.config.center.key] = true
                    end
                end

                if #G.P_JOKER_RARITY_POOLS[3] > rares_in_posession[1] then 
                    card = create_card('Joker', _context.area, nil, 1, nil, nil, nil, 'rta')
                    create_shop_card_ui(card, 'Joker', _context.area)
                    card.states.visible = false
                    self:yep('+', G.C.RED,function() 
                        card:start_materialize()
                        card.ability.couponed = true
                        card:set_cost()
                        return true
                    end)
                else
                    self:nope()
                end
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
            elseif self.name == 'Uncommon Tag' then
                card = create_card('Joker', _context.area, nil, 0.9, nil, nil, nil, 'uta')
                    create_shop_card_ui(card, 'Joker', _context.area)
                    card.states.visible = false
                    
                    self:yep('+', G.C.GREEN,function() 
                        card:start_materialize()
                        card.ability.couponed = true
                        card:set_cost()
                        return true
                    end)
                end
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return card
        elseif _context.type == 'shop_start' then
            
            if self.name == 'D6 Tag' and not G.GAME.shop_d6ed then
                G.GAME.shop_d6ed = true
                self:yep('+', G.C.GREEN,function() 
                    G.GAME.round_resets.temp_reroll_cost = 0
                    calculate_reroll_cost(true)
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
        elseif _context.type == 'store_joker_modify' then
            local _applied = nil
            if not _context.card.edition and not _context.card.temp_edition and _context.card.ability.set == 'Joker' then
                local lock = self.ID
                G.CONTROLLER.locks[lock] = true
                
                if self.name == 'Foil Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card:set_edition({foil = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        _context.card.temp_edition = nil
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                elseif self.name == 'Holographic Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card.temp_edition = nil
                        _context.card:set_edition({holo = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                elseif self.name == 'Polychrome Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card.temp_edition = nil
                        _context.card:set_edition({polychrome = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                elseif self.name == 'Negative Tag' then
                    _context.card.temp_edition = true
                    self:yep('+', G.C.DARK_EDITION,function() 
                        _context.card.temp_edition = nil
                        _context.card:set_edition({negative = true}, true)
                        _context.card.ability.couponed = true
                        _context.card:set_cost()
                        G.CONTROLLER.locks[lock] = nil
                        return true
                    end)
                    _applied = true
                end
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
            end

            return _applied
        elseif _context.type == 'shop_final_pass' then
            if self.name == 'Coupon Tag' and (G.shop and not G.GAME.shop_free) then
                G.GAME.shop_free = true
                
                self:yep('+', G.C.GREEN,function() 
                    if G.shop_jokers and G.shop_booster then 
                        for k, v in pairs(G.shop_jokers.cards) do
                            v.ability.couponed = true
                            v:set_cost()
                        end
                        for k, v in pairs(G.shop_booster.cards) do
                            v.ability.couponed = true
                            v:set_cost()
                        end
                    end
                    return true
                end)
                self.triggered = not self.ability.extra.stack_count or (self.ability.extra.stack_count <= 1)
                self.ability.extra.stack_count = self.ability.extra.stack_count - 1
                return true
            end
        end
    end
end

--bandaid for some visual bugs i dont know why they're happening (uibox related fuckery)
--deletes all tag uis and regenerates them, currently called when skipping a blind or at the end of the shop
function bstuck_clean_tags()
    for _, HUD_tag in ipairs(G.HUD_tags) do
        HUD_tag:remove()
    end
    G.HUD_tags = {}
    
    for _, tag_object in ipairs(G.GAME.tags) do
        if tag_object.ability.extra.stack_count <= 0 then
            --remove any tags that have 0 stack size
            --print("removed "..tag_object.key.." because it had 0 stack size")
            tag_object:remove()
        else
            local tag_sprite_ui = tag_object:generate_UI()
            G.HUD_tags[#G.HUD_tags+1] = UIBox{
                definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
                    tag_sprite_ui,
                    {n=G.UIT.O, config={object = DynaText({string = {{suffix = "x", ref_table = tag_object.ability.extra, ref_value = 'stack_count'}}, colours = {G.C.UI.TEXT_LIGHT},shadow = true, scale = 0.25})}}
                }},
                config = {
                    align = G.HUD_tags[1] and 'tm' or 'bri',
                    offset = G.HUD_tags[1] and {x=0,y=0} or {x=0.7,y=0},
                    major = G.HUD_tags[1] and G.HUD_tags[#G.HUD_tags] or G.ROOM_ATTACH}
            }
            tag_object.HUD_tag = G.HUD_tags[#G.HUD_tags]
        end
    end
    
    

end

--this one is to make scratch tag spawn only in big blinds
function get_next_tag_key_small_blind(append)
    G.FORCE_TAG = G.GAME.challenge and (G.GAME.challenge == "c_bstuck_alchemy") and "tag_bstuck_perfecltygeneric" or nil
    if G.FORCE_TAG then return G.FORCE_TAG end
    local _pool, _pool_key = get_current_pool('Tag', nil, nil, append)
    for k,v in pairs(_pool) do
        if v == "tag_bstuck_scratch" then table.remove(_pool,k) end
    end
    local _tag = pseudorandom_element(_pool, pseudoseed(_pool_key))
    local it = 1
    while _tag == 'UNAVAILABLE' do
        it = it + 1
        _tag = pseudorandom_element(_pool, pseudoseed(_pool_key..'_resample'..it))
    end

    return _tag
end