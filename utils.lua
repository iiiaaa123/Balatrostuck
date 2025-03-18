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



function get_aspect_for_pack(normalize_weights)
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

    if normalize_weights then
        for i=1, #pool do
            pool[i].weight = 0
        end
    end

    if not next(find_joker("Showman")) then
        for i = #pool, 1, -1 do 
            local entry = pool[i]
            if tableContains(G.GAME.gamer_choices,'c_bstuck_' .. pool[i].key) then
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
        if shuffledPool[i].weight < poolLuck then
            table.insert(G.GAME.gamer_choices,'c_bstuck_' .. shuffledPool[i].key)
            return 'c_bstuck_' .. shuffledPool[i].key
        end
    end

    return 'c_bstuck_breath'
end
            