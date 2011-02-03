-- encoding: UTF-8

------------------------------------------------
-- 谷歌拼音汉字区位码输入扩展
-- 版本: 0.1.0.1
-- 作者: orzFly a.k.a Yeechan Lu
-- 作者主页: http://orzfly.com/
-- 扩展主页: http://orztech.com/google-pinyin-ime-extension/hanzi-areacode-input
-- 项目主页: http://code.google.com/p/google-pinyin-api/
-- 问题反馈: http://orztech.com/forms/2
--
-- 此扩展遵循GPLv3发布
------------------------------------------------
-- orderedPairs: http://lua-users.org/wiki/SortedIteration
_0=pairs function _1(_6)local _2={}for _4 in _0(_6)do table.insert(_2,_4)end table.sort(_2)return _2 end function _3(_6,_5)if _5==nil then _6._7=_1(_6)_4=_6._7[1]return _4,_6[_4]end _4=nil for _8 = 1,table.getn(_6._7)do if _6._7[_8]==_5 then _4=_6._7[_8+1]end end if _4 then return _4,_6[_4]end _6._7=nil return end function _9(_6)return _3,_6,nil end pairs=_9
-- Bin Dec Hex: http://www.dialectronics.com/Lua/code/BinDecHex.shtml
-- /* 
--  * Copyright (c) 2007 Tim Kelly/Dialectronics
--  *
--  * Permission is hereby granted, free of charge, to any person obtaining 
--  * a copy of this software and associated documentation files (the 
--  * "Software"),  to deal in the Software without restriction, including 
--  * without limitation the rights to use, copy, modify, merge, publish, 
--  * distribute, sublicense, and/or sell copies of the Software, and to permit 
--  * persons to whom the Software is furnished to do so, subject to the 
--  * following conditions:
--  *
--  * The above copyright notice and this permission notice shall be 
--  * included in all copies or substantial portions of the Software.
--  *
--  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
--  * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
--  * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  
--  * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
--  * CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT 
--  * OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
--  * THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--  */
local hex2bin = {["0"] = "0000",["1"] = "0001",["2"] = "0010",["3"] = "0011",["4"] = "0100",["5"] = "0101",["6"] = "0110",["7"] = "0111",["8"] = "1000",["9"] = "1001",["a"] = "1010",["b"] = "1011",["c"] = "1100",["d"] = "1101",["e"] = "1110",["f"] = "1111"}
local bin2hex = {["0000"] = "0",["0001"] = "1",["0010"] = "2",["0011"] = "3",["0100"] = "4",["0101"] = "5",["0110"] = "6",["0111"] = "7",["1000"] = "8",["1001"] = "9",["1010"] = "A",["1011"] = "B",["1100"] = "C",["1101"] = "D",["1110"] = "E",["1111"] = "F"}
function Hex2Bin(s) local ret = "" local i = 0 for i in string.gfind(s, ".") do i = string.lower(i) ret = ret..hex2bin[i] end return ret end
function Bin2Hex(s) local l = 0 local h = "" local b = "" local rem l = string.len(s) rem = l % 4 l = l-1 h = "" if (rem > 0) then s = string.rep("0", 4 - rem)..s end for i = 1, l, 4 do b = string.sub(s, i, i+3) h = h..bin2hex[b] end return h end
function Bin2Dec(s) local num = 0 local ex = string.len(s) - 1 local l = 0 l = ex + 1 for i = 1, l do b = string.sub(s, i, i) if b == "1" then num = num + 2^ex end ex = ex - 1 end return string.format("%u", num) end
function Dec2Bin(s, num) local n if (num == nil) then n = 0 else n = num end s = string.format("%x", s) s = Hex2Bin(s) while string.len(s) < n do s = "0"..s end return s end
function Hex2Dec(s) local s = Hex2Bin(s) return Bin2Dec(s) end function Dec2Hex(s) s = string.format("%x", s) return s end
function BMAnd(v, m) local bv = Hex2Bin(v) local bm = Hex2Bin(m) local i = 0 local s = "" while (string.len(bv) < 32) do bv = "0000"..bv end while (string.len(bm) < 32) do bm = "0000"..bm end for i = 1, 32 do cv = string.sub(bv, i, i) cm = string.sub(bm, i, i) if cv == cm then if cv == "1" then s = s.."1" else s = s.."0" end else s = s.."0" end end return Bin2Hex(s) end
function BMNAnd(v, m) local bv = Hex2Bin(v) local bm = Hex2Bin(m) local i = 0 local s = "" while (string.len(bv) < 32) do bv = "0000"..bv end while (string.len(bm) < 32) do bm = "0000"..bm end for i = 1, 32 do cv = string.sub(bv, i, i) cm = string.sub(bm, i, i) if cv == cm then if cv == "1" then s = s.."0" else s = s.."1" end else s = s.."1" end end return Bin2Hex(s) end
function BMOr(v, m) local bv = Hex2Bin(v) local bm = Hex2Bin(m) local i = 0 local s = "" while (string.len(bv) < 32) do bv = "0000"..bv end while (string.len(bm) < 32) do bm = "0000"..bm end for i = 1, 32 do cv = string.sub(bv, i, i) cm = string.sub(bm, i, i) if cv == "1" then s = s.."1" elseif cm == "1" then s = s.."1" else s = s.."0" end end return Bin2Hex(s) end
function BMXOr(v, m) local bv = Hex2Bin(v) local bm = Hex2Bin(m) local i = 0 local s = "" while (string.len(bv) < 32) do bv = "0000"..bv end while (string.len(bm) < 32) do bm = "0000"..bm end for i = 1, 32 do cv = string.sub(bv, i, i) cm = string.sub(bm, i, i) if cv == "1" then if cm == "0" then s = s.."1" else s = s.."0" end elseif cm == "1" then if cv == "0" then s = s.."1" else s = s.."0" end else s = s.."0" end end return Bin2Hex(s) end
function BMNot(v, m) local bv = Hex2Bin(v) local bm = Hex2Bin(m) local i = 0 local s = "" while (string.len(bv) < 32) do bv = "0000"..bv end while (string.len(bm) < 32) do bm = "0000"..bm end for i = 1, 32 do cv = string.sub(bv, i, i) cm = string.sub(bm, i, i) if cm == "1" then if cv == "1" then s = s.."0" else s = s.."1" end else s = s..cv end end return Bin2Hex(s) end
function BShRight(v, nb) local s = Hex2Bin(v) while (string.len(s) < 32) do s = "0000"..s end s = string.sub(s, 1, 32 - nb) while (string.len(s) < 32) do s = "0"..s end return Bin2Hex(s) end
function BShLeft(v, nb) local s = Hex2Bin(v) while (string.len(s) < 32) do s = "0000"..s end s = string.sub(s, nb + 1, 32) while (string.len(s) < 32) do s = s.."0" end return Bin2Hex(s) end

function orzFly_HanziAreaCode(arg)
  d= "一"
  return {d:byte(1), d:byte(2), d:byte(3)}
  --return orzFly_UTF2GB("一")
end

function orzFly_UTF2GB(arg)
  GBstr = ""
  for dig=1,#arg do
    if arg:sub(dig, dig+1) == "%" then
      if #arg >= dig + 8 then
        GBstr = GBstr .. orzFly_UTF2GB_ConvChinese(arg:sub(dig, dig+9))
        dig = dig + 8
      else
        GBstr = GBstr .. arg:sub(dig, dig+1)
      end
    else
      GBstr = GBstr .. arg:sub(dig, dig+1)
    end
  end
  return GBstr
end

function orzFly_UTF2GB_ConvChinese(x)
  A=ime.split_string(arg:sub(x,2),"%")
  i=0
  j=0

  for i=0,#A do
    A[i]=Hex2Bin(A[i])
  end

  for i=0,#A do
    DigS = string.find(A[i],"0")
    Unicode = ""
    for j=1,DigS-1 do
      if j==1 then
        A[i]=string.sub(A[i],-#A[i]+DigS)
        Unicode=Unicode .. A[i]
      else
        i=i+1
        A[i]=string.sub(A[i],-#A[i]+2)
        Unicode=Unicode .. A[i]
      end
    end

    if #Bin2Hex(Unicode)==4 then
      ConvChinese=ConvChinese .. string.char(Bin2Dec(Unicode))
    else
      ConvChinese=ConvChinese .. string.char(Bin2Dec(Unicode))
    end
  end
end

------------

ime.register_command("qw", "orzFly_HanziAreaCode", "区位码","none","显示上次输入的文字的区位码")
