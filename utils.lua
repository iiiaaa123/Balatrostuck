OR, XOR, AND = 1, 3, 4

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
    local sum = 0
    for i = 1, n do
        sum = sum + i
    end
    return sum
end

function sum_levels()
    return ((G.GAME.hands['High Card'].level)+(G.GAME.hands['Pair'].level)+(G.GAME.hands['Two Pair'].level)+(G.GAME.hands['Three of a Kind'].level)+(G.GAME.hands['Straight'].level)+(G.GAME.hands['Flush'].level)+(G.GAME.hands['Full House'].level )+(G.GAME.hands['Four of a Kind'].level)+(G.GAME.hands['Straight Flush'].level)+(G.GAME.hands['Five of a Kind'].level)+(G.GAME.hands['Flush House'].level)+(G.GAME.hands['Flush Five'].level))
end


function get_innocuous(card,get_only_name)
    local hearts = {
        {'applejuice', true}, {'lusty_joker', false}, {'flower_pot', false}, {'complacencyofthelearned', true},
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
        {'credit_card', false},{'greedy_joker', false}, {'walkie_talkie', false},{'ticket', false},
        {'trading', false},{'gristtorrent',true}, {'alltheirons', true},{'gift',false},
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





function get_aspect_for_pack(normalize_weights,pack)
    G.GAME.gamer_choices = G.GAME.gamer_choices or {}
    local pool = {
        {key = 'blood',weight = 0,onestar = false},
        {key = 'breath',weight = 0,onestar = false},
        {key = 'hope',weight = 0.2,onestar = false},
        {key = 'life',weight = 0.2,onestar = false},
        {key = 'doom',weight = 0.2,onestar = false},    
        {key = 'rage',weight = 0.2,onestar = false},
        {key = 'mind',weight = 0.4,onestar = false},
        {key = 'void',weight = 0.6,onestar = false},
        {key = 'light',weight = 0.6,onestar = false},
        {key = 'heart',weight = 0.6,onestar = false},
        {key = 'time',weight = 0.8,onestar = false},
        {key = 'space',weight = 0.8,onestar = false},
        {key = 'piss',weight = 0.9,onestar = false}
    }

    if normalize_weights or next(SMODS.find_card('v_bstuck_giftofgab')) then
        for i=1, #pool do
            pool[i].weight = 0
        end
    end

    


    if not next(find_joker("Showman")) then
        for i = #pool, 1, -1 do 
            local entry = pool[i]
            if tableContains(G.GAME.gamer_choices,'c_bstuck_' .. pool[i].key) and pack then
                table.remove(pool, i)
            else
                local conKeys = {}
                for j=1, #G.consumeables.cards do
                    table.insert(conKeys,G.consumeables.cards[j].config.center.key)
                end
                if tableContains(conKeys,'c_bstuck_' .. pool[i].key) then
                    table.remove(pool, i)
                end
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

    return 'c_bstuck_breath'
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
  
    local t = {n=G.UIT.ROOT, config={align = "cm", minw = 3, padding = 0.1, r = 0.1, colour = G.C.CLEAR}, nodes={
      {n=G.UIT.R, config={align = "cm", padding = 0.04}, nodes=
        hands
      },
    }}
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

    return (not simple and
      {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), emboss = 0.05, hover = true, force_focus = true, on_demand_tooltip = {text = nil, filler = {func = create_UIBox_zodiac_tip, args = zodiac}}}, nodes={
        {n=G.UIT.C, config={align = "cl", padding = 0, minw = 5}, nodes={
          {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = G.GAME.BALATROSTUCK.zodiac_levels[zodiac] == 1 and altColors[zodiac] or G.C.HAND_LEVELS[math.min(7, math.max(1,G.GAME.BALATROSTUCK.zodiac_levels[zodiac]))], minw = 1.5, outline = 0.8, outline_colour = G.C.WHITE}, nodes={
            {n=G.UIT.T, config={text = localize('k_level_prefix')..G.GAME.BALATROSTUCK.zodiac_levels[zodiac], scale = 0.5, colour = textColour}}
          }},
          {n=G.UIT.C, config={align = "cm", minw = 4.5, maxw = 4.5}, nodes={
            {n=G.UIT.T, config={text = ' '..localize(zodiac,'zodiac_names'), scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
          }}
        }},
        {n=G.UIT.C, config={align = "cm"}, nodes={
            {n=G.UIT.T, config={text = '  #', scale = 0.45, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
          }},
        {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK,r = 0.1, minw = 0.9}, nodes={
          {n=G.UIT.T, config={text = count, scale = 0.45, colour = G.C.FILTER, shadow = true}},
        }}
      }}
    or {n=G.UIT.R, config={align = "cm", padding = 0.05, r = 0.1, colour = darken(G.C.JOKER_GREY, 0.1), force_focus = true, emboss = 0.05, hover = true, on_demand_tooltip = {text = localize(zodiac, 'zodiac_names'), filler = {func = create_UIBox_zodiac_tip, args = zodiac}}, focus_args = {snap_to = (simple)}}, nodes={
      {n=G.UIT.C, config={align = "cm", padding = 0, minw = 5}, nodes={
          {n=G.UIT.T, config={text = localize(zodiac,'zodiac_names'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT, shadow = true}}
      }}
    }})
    or nil
  end



function create_UIBox_zodiac_tip(zodiac)
    local lvl = math.max(1,G.GAME.BALATROSTUCK.zodiac_levels[zodiac])
    play_sound('paper1',0.95 + math.random()*0.1, 0.3)
    local _zodiac_vars = {
        Aries = {lvl/2},
        Gemini = {lvl,lvl ~= 1 and 's' or ''},
        Taurus = {0.95^lvl},
        Cancer = {lvl * 3},
        Leo = {G.GAME.probabilities.normal,lvl},
        Virgo = {summation(2+lvl)},
        Libra = {1 + (lvl/ 10)},
        Scorpio = {lvl, (lvl~=1 and 's' or '')},
        Sagittarius = {lvl*25},
        Capricorn = {math.max(lvl), 1/math.max(lvl, 1)},
        Aquarius = {lvl, (lvl~=1 and 's' or '')},
        Pisces = {lvl*2},
        Ophiuchus = {1.25 ^ lvl}
    }
    local _nodes = {}
    local _returnnodes = {}
    

    if G.GAME.BALATROSTUCK.zodiac_levels[zodiac] < 1 then
        local inactivenodes = {}
        local text = localize{type = 'descriptions', set = 'zodiacui', key = 'Inactive', vars = _zodiac_vars[zodiac], nodes = inactivenodes}
        for i=1,#inactivenodes do
            table.insert(_returnnodes,{n=G.UIT.R, config={align = "cm"}, nodes=inactivenodes[i]})
        end
    end


    local text = localize{type = 'descriptions', set = 'zodiacui', key = zodiac, vars = _zodiac_vars[zodiac], nodes = _nodes}
    

    for i=1,#_nodes do
        table.insert(_returnnodes,{n=G.UIT.R, config={align = "cm"}, nodes=_nodes[i]})
    end
    
    return{n=G.UIT.C, colour = G.C.ZODIAC[zodiac], config={align = "cm"}, nodes=_returnnodes}     -- 0    
end



