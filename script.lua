--> Current items 
--> Antidote x2
--> Poke Ball x 16

--> Pokemon
--> Ivysaur
--> Metapod

function string.fromhex(str)
    return (str:gsub('..', function (cc)
        return string.char(tonumber(cc, 16))
    end))
end

function string.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

