-- UniqueIDs usados abajo.
local pos = { -- Cada coordenada correspondiente a su palanca.
    -- [UniqueID de Palanca] = {{Coordenada de apuestas}},
    [5880]={{x=2158, y=2183, z=8, stackpos = 255}},
    [5881]={{x=1023, y=1003, z=6, stackpos = 255}},
    [5882]={{x=1025, y=1003, z=6, stackpos = 255}},
    
    [5883]={{x=1020, y=1011, z=6, stackpos = 255}},
    [5884]={{x=1022, y=1011, z=6, stackpos = 255}},
    [5885]={{x=1025, y=1011, z=6, stackpos = 255}},
    
    [5886]={{x=1017, y=1006, z=6, stackpos = 255}},
    [5887]={{x=1017, y=1008, z=6, stackpos = 255}},
    
    [5888]={{x=1028, y=1006, z=6, stackpos = 255}},
    [5889]={{x=1028, y=1008, z=6, stackpos = 255}},
}
local cash = 2160 -- ItemID del objeto apostado.

local t = {
    [{1, 55}] = 0,
    [{56, 90}] = 2,
    [{91, 100}] = 3
}
local a, b = getItemInfo(cash).name, getItemInfo(cash).plural

function onUse(cid, item, fromPosition, itemEx, toPosition)
    local lel = pos[item.uid]
    local v = getThingfromPos(lel[1])
    local p = getThingPosition(cid)

    if v.itemid ~= cash then
        return doCreatureSay(cid, 'Solamente has de usar ' .. b .. '.', TALKTYPE_ORANGE_1, false, cid)
    end

    local r = math.random(100)
    for i, k in pairs(t) do
        if lel then
            if r >= i[1] and r <= i[2] then
                doRemoveItem(v.uid)
                if k < 1 then
                    doSendAnimatedText(p, 'PERDISTE', COLOR_RED)
                    doSendMagicEffect(p, CONST_ME_MAGIC_RED)
                    doSendMagicEffect(lel[1], CONST_ME_POFF)
                else
                    -- Limitar la apuesta entre 1 y 2
                    local apuesta = math.random(1, 2)
                    doSendAnimatedText(p, 'GANASTE', COLOR_GREEN)
                    doSendMagicEffect(p, CONST_ME_MAGIC_GREEN)
                    doCreateItem(cash, v.type * apuesta, lel[1])
                end
                return true
            end
        end
    end
end
