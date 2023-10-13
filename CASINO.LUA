local pos = {
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

local cash = 2160
local betRanges = {
   {1, 55, 0},
   {56, 90, 2},
   {91, 100, 3}
}

function onUse(cid, item, fromPosition, itemEx, toPosition)
   local lel = pos[item.uid]
   local v = getThingfromPos(lel[1])
   local p = getThingPosition(cid)
   local betAmount = getItemAttribute(item.uid, "betAmount") or 0

   if betAmount <= 0 or betAmount > 200000 then
      return doCreatureSay(cid, 'La cantidad apostada debe estar entre 1 CC y 2 CC.', TALKTYPE_ORANGE_1, false, cid)
   end

   if v.itemid ~= cash then
      return doCreatureSay(cid, 'Solamente has de usar ' .. getItemInfo(cash).plural .. '.', TALKTYPE_ORANGE_1, false, cid)
   end

   local r = math.random(100)
   for _, range in ipairs(betRanges) do
      local startRange, endRange, multiplier = table.unpack(range)
      if r >= startRange and r <= endRange then
         doRemoveItem(v.uid)
         if multiplier > 0 then
            doSendAnimatedText(p, 'GANASTE', COLOR_GREEN)
            doSendMagicEffect(p, CONST_ME_MAGIC_GREEN)
            doCreateItem(cash, v.type * multiplier, lel[1])
         else
            doSendAnimatedText(p, 'PERDISTE', COLOR_RED)
            doSendMagicEffect(p, CONST_ME_MAGIC_RED)
            doSendMagicEffect(lel[1], CONST_ME_POFF)
         end
         return true
      end
   end
end
