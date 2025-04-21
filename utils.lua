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