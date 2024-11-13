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
    if (n == 0) then
        return 0
    else
        return n + summation(n - 1)
    end
end