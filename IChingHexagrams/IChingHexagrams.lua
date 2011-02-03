-- encoding: UTF-8

------------------------------------------------
-- 谷歌拼音易经卦输入扩展
-- 版本: 0.1.0.2
-- 作者：Yichen Lu
-- 作者主页：http://orztech.com/
-- 项目主页: http://code.google.com/p/google-pinyin-api/
--
-- 此扩展遵循GPLv3发布
------------------------------------------------
-- orderedPairs: http://lua-users.org/wiki/SortedIteration
_0=pairs function _1(_6)local _2={}for _4 in _0(_6)do table.insert(_2,_4)end table.sort(_2)return _2 end function _3(_6,_5)if _5==nil then _6._7=_1(_6)_4=_6._7[1]return _4,_6[_4]end _4=nil for _8 = 1,table.getn(_6._7)do if _6._7[_8]==_5 then _4=_6._7[_8+1]end end if _4 then return _4,_6[_4]end _6._7=nil return end function _9(_6)return _3,_6,nil end pairs=_9

function YichenLu_IChingHexagrams(arg)
  local input = string.lower(arg)
  local pos = string.find(input, ",")
  local inputn = nil
  local metatables = nil
  if (not (pos==nil)) then
    inputn = tonumber(string.sub(input,pos+1))
    if inputn == nil then
      metatables = {}
      for k, v in pairs(_YichenLu_IChingHexagrams_Code) do
        table.insert(metatables, {["suggest"] = k, ["help"] = v[3].."："..v[4], ["id"] = k})
      end
    elseif _YichenLu_IChingHexagrams_Code[inputn] then
      metatables = {_YichenLu_IChingHexagrams_Code[inputn][3], _YichenLu_IChingHexagrams_Code[inputn][4], _YichenLu_IChingHexagrams_Code[inputn][1], "."..inputn}
    end
  elseif #arg == 0 then
    metatables = {}
    for k, v in pairs(_YichenLu_IChingHexagrams_Code) do
       table.insert(metatables, {["suggest"] = v[2], ["help"] = v[3].."："..v[4], ["id"] = k})

    end
  elseif not (tonumber(input) == nil) then
    metatables = {}
    for k, v in pairs(_YichenLu_IChingHexagrams_Code) do
      if string.sub(v[1], 1, #input) == input then
        table.insert(metatables, {["suggest"] = string.sub(v[1], #input+1), ["help"] = v[3].."："..v[4], ["id"] = k})
      end
    end
  else
    metatables = {}
    local flag=nil
    for k, v in pairs(_YichenLu_IChingHexagrams_Code) do
      if string.sub(v[2], 1, #input) == input then
        table.insert(metatables, {["suggest"] = string.sub(v[2], #input+1), ["help"] = v[3].."："..v[4], ["id"] = k})
      end
      if v[2]==input then flag={["suggest"] = string.sub(v[2], #input+1), ["help"] = v[3].."："..v[4], ["id"] = k} end
    end
    if not (flag==nil) then metatables={flag} end
  end
  if (type(metatables)=="table") and (#metatables == 1) then
    return YichenLu_IChingHexagrams("."..metatables[1]["id"])
  elseif ((type(metatables)=="table") and (#metatables == 0)) or (metatables==nil) then
    return "-- 找不到您输入的卦 --"
  end
  return metatables
end

_YichenLu_IChingHexagrams_Code ={
[1] = {"000000", "qian1", "䷀", "乾"},
[2] = {"111111", "kun1", "䷁", "坤"},
[3] = {"101110", "zhun", "䷂", "屯"},
[4] = {"011101", "meng", "䷃", "蒙"},
[5] = {"101000", "xu", "䷄", "需"},
[6] = {"000101", "song", "䷅", "讼"},
[7] = {"111101", "shi", "䷆", "师"},
[8] = {"101111", "bi1", "䷇", "比"},
[9] = {"001000", "xiaoxu", "䷈", "小畜"},
[10] = {"000100", "lv1", "䷉", "履"},
[11] = {"111000", "tai", "䷊", "泰"},
[12] = {"000111", "pi", "䷋", "否"},
[13] = {"000010", "tongren", "䷌", "同人"},
[14] = {"010000", "dayou", "䷍", "大有"},
[15] = {"111011", "qian2", "䷎", "谦"},
[16] = {"110111", "yv", "䷏", "豫"},
[17] = {"100110", "sui", "䷐", "随"},
[18] = {"011001", "gu", "䷑", "蛊"},
[19] = {"111100", "lin", "䷒", "临"},
[20] = {"001111", "guan", "䷓", "观"},
[21] = {"010110", "shike", "䷔", "噬嗑"},
[22] = {"011010", "bi2", "䷕", "贲"},
[23] = {"011111", "bo", "䷖", "剥"},
[24] = {"111110", "fu", "䷗", "复"},
[25] = {"000110", "wuwang", "䷘", "无妄"},
[26] = {"011000", "daxu", "䷙", "大畜"},
[27] = {"011110", "yi1", "䷚", "颐"},
[28] = {"100001", "daguo", "䷛", "大过"},
[29] = {"101101", "kan", "䷜", "坎"},
[30] = {"010010", "li", "䷝", "离"},
[31] = {"100011", "xian", "䷞", "咸"},
[32] = {"110001", "heng", "䷟", "恒"},
[33] = {"000011", "dun", "䷠", "遁"},
[34] = {"110000", "dazhuang", "䷡", "大壮"},
[35] = {"010111", "jin", "䷢", "晋"},
[36] = {"111010", "mingyi", "䷣", "明夷"},
[37] = {"001010", "jia", "䷤", "家人"},
[38] = {"010100", "kui", "䷥", "睽"},
[39] = {"101011", "jian1", "䷦", "蹇"},
[40] = {"110101", "jie1", "䷧", "解"},
[41] = {"011100", "sun", "䷨", "损"},
[42] = {"001110", "yi2", "䷩", "益"},
[43] = {"100000", "guai", "䷪", "夬"},
[44] = {"000001", "gou", "䷫", "姤"},
[45] = {"100111", "cui", "䷬", "萃"},
[46] = {"111001", "sheng", "䷭", "升"},
[47] = {"100101", "kun2", "䷮", "困"},
[48] = {"101001", "jing", "䷯", "井"},
[49] = {"100010", "ge", "䷰", "革"},
[50] = {"010001", "ding", "䷱", "鼎"},
[51] = {"110110", "zhen", "䷲", "震"},
[52] = {"011011", "gen", "䷳", "艮"},
[53] = {"001011", "jian2", "䷴", "渐"},
[54] = {"110100", "guimei", "䷵", "归妹"},
[55] = {"110010", "feng", "䷶", "丰"},
[56] = {"010011", "lv2", "䷷", "旅"},
[57] = {"001001", "xun", "䷸", "巽"},
[58] = {"100100", "dui", "䷹", "兑"},
[59] = {"001101", "huan", "䷺", "涣"},
[60] = {"101100", "jie2", "䷻", "节"},
[61] = {"001100", "zhongfu", "䷼", "中孚"},
[62] = {"110011", "xiaoguo", "䷽", "小过"},
[63] = {"101010", "jiji", "䷾", "既济"},
[64] = {"010101", "weiji", "䷿", "未济"},
}
------------

ime.register_command("yj", "YichenLu_IChingHexagrams", "易经卦","none","按形状输入100010|按名称输入ge|按编号输入#49")
