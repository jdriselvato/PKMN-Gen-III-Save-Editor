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

function Chksum(length, Data)
    length = length >> 2
    local Chk = 0
    for i=0,length-1 do
        Chk = Chk + Data[i+1]
    end
    local tmp = bit32.rshift(Chk, 16)
    tmp = tmp + Chk
    Chk = bit32.band(tmp, 0xFFFF)
    return Chk
end

function gba_block_checksum(ptr, size)
  local sum = 0
  for i = 0, size-1, 4 do
    local byte1 = ptr[i]
    local byte2 = ptr[i+1]
    local byte3 = ptr[i+2]
    local byte4 = ptr[i+3]
    local num = byte1 + byte2*256 + byte3*256*256 + byte4*256*256*256
    sum = sum + num
  end
  return sum + (sum >> 16)
end