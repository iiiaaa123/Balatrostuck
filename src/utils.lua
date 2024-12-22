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

local lup = level_up_hand
function level_up_hand(mod, x)
    lup(mod, x)
    for i = 1, #G.jokers.cards do
        local effects = G.jokers.cards[i]:calculate_joker({ bstuck_level_up_hand = mod })
    end
end