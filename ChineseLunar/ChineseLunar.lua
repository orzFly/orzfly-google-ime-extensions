-- encoding: UTF-8

------------------------------------------------
-- 谷歌拼音输入法农历与万年历扩展
-- 版本: 0.2.2.2
-- 作者: orzFly
-- 作者主页: http://orzfly.com/
-- 扩展主页: http://orztech.com/google-pinyin-ime-extension/chinese-lunar
-- 项目主页: http://code.google.com/p/google-pinyin-api/
-- 问题反馈: http://orztech.com/forms/2
--
-- 此扩展遵循GPLv3发布
------------------------------------------------
-- 农历算法来源于 http://xbeta.cn/archiver/tid-31975.html
-- 本扩展中万年历基于来源于 http://bbs.pxysm.com/thread-1182-1-2.html 的英文版无农历万年历增强
-- 参考了谷歌拼音输入法自带扩展 base.lua 中部分代码
------------------------------------------------
-- orderedPairs: http://lua-users.org/wiki/SortedIteration
_0=pairs function _1(_6)local _2={}for _4 in _0(_6)do table.insert(_2,_4)end table.sort(_2)return _2 end function _3(_6,_5)if _5==nil then _6._7=_1(_6)_4=_6._7[1]return _4,_6[_4]end _4=nil for _8 = 1,table.getn(_6._7)do if _6._7[_8]==_5 then _4=_6._7[_8+1]end end if _4 then return _4,_6[_4]end _6._7=nil return end function _9(_6)return _3,_6,nil end pairs=_9
-- shallow_copy: http://stackoverflow.com/questions/4535152/cloning-a-lua-table-in-lua-c-api
shallow_copy=function(tab) local retval = {} for k, v in pairs(tab) do retval[k] = v end return retval end

--以下修改于 base.lua
function orzFly_ChineseLunar(input, inside)
  local now = input
  if #input == 0 then
    now = os.date("%Y-%m-%d")
  end
  local year, month, day
  now:gsub("^(%d+)[-\\/.](%d+)[-\\/.](%d+)$", function(y, m, d)
    year = tonumber(y)
    month = tonumber(m)
    day = tonumber(d)
  end)
  if year==month and month == day and day == nil then
    now:gsub("^(%d%d%d%d)(%d%d)(%d%d)$", function(y, m, d)
      year = tonumber(y)
      month = tonumber(m)
      day = tonumber(d)
    end)
  end
  orzFly_ChineseLunar_VerifyDateWithYear(year, month, day)
  return orzFly_ChineseLunar_FormatChineseLunarDate(orzFly_ChineseLunar_GetChineseLunarDate(year, month, day), inside)
end

function orzFly_ChineseLunar_VerifyDate(month, day)
  if month < 1 or month > 12 or day < 1 or day > _orzFly_ChineseLunar_Month_Table_Leaf[month] then
    error("Invalid date")
  end
end

function orzFly_ChineseLunar_VerifyDateWithYear(year, month, day)
  orzFly_ChineseLunar_VerifyDate(month, day)
  if year < 1900 or year > 2100 then
    error("Invalid year")
  end
  if year == 1900 and month == 1 then
    error("Invalid year")
  end
  if month == 2 and day == 29 then
    if year % 400 ~= 0 and year % 100 == 0 then
      error("Invalid lunar day")
    end
    if year % 4 ~= 0 then
      error("Invalid lunar day")
    end
  end
end

function orzFly_ChineseLunar_GetChineseMathNum(num)
  local ret
  if num < 10 then
    ret = _orzFly_ChineseLunar_Chinese_Digits[num]
  elseif num < 20 then
    ret = _orzFly_ChineseLunar_Chinese_Digits[10]
    if num > 10 then
      ret = ret .. _orzFly_ChineseLunar_Chinese_Digits[num % 10]
    end
  elseif num < 100 then
    local mod = num % 10
    ret = _orzFly_ChineseLunar_Chinese_Digits[(num - mod) / 10] .. _orzFly_ChineseLunar_Chinese_Digits[10]
    if mod > 0 then
      ret = ret .. _orzFly_ChineseLunar_Chinese_Digits[mod]
    end
  else
    error("Invalid number")
  end
  return ret
end
--以上修改于 base.lua

function orzFly_ChineseLunar_FormatChineseLunarDate(args, inside)
  local info = ""
  if not inside == true then
    local solarterm = orzFly_ChineseLunarSolarTerm_GetSolarTermFromDate(args["year"], args["month"], args["day"])
    if type(solarterm) == "table" then info = info .. " " .. solarterm["name"] end
    local festival = orzFly_ChineseFestival_GetFestivalFromDate(args["year"], args["month"], args["day"])
    if type(festival) == "table" then info = info .. " " .. festival["name"] end
  end
  local result = {
    "农历" .. args["TianGanDiZhi"] .. "年" .. "（" .. args["ShenXiao"] .. "）" .. args["RunYue"] .. args["Yue"] .. "月" .. args["Ri"] .. "日" .. info,
    "农历" .. args["NianHao"] .. "年" .. args["RunYue"] .. args["Yue"] .. "月" .. args["Ri"] .. "日" .. info,
    "农历" .. args["TianGanDiZhi"] .. "年" .. args["lunarMonth"] .. "月" .. args["lunarDay"] .. "日" .. info
  }
  return result
end

function orzFly_ChineseLunar_GetChineseLunarDate(year, month, day)
  oy = year om = month od = day
  nTheDate = orzFly_ChineseLunar_date_to_excel_date(year,month,day) - orzFly_ChineseLunar_date_to_excel_date(1900,1,31)
  if (year == 2100) and (month <= 2) then nTheDate = nTheDate + 1 end --那个函数还是有点bug。所以1900/2100手工修正
  if (year == 1900) and (month <= 2) then nTheDate = nTheDate + 1 end
  nIsEnd = 0 m = 0 k = 0 n = 0
  while not (nIsEnd == 1) do
    if (_orzFly_ChineseLunar_ChineseLunarData[m + 1] < 4095) then k = 11 else k = 12 end
    n = k
    while n>=0 do
      nBit = _orzFly_ChineseLunar_ChineseLunarData[m + 1]
      for i=1,n do nBit = math.floor(nBit / 2) end
      nBit = nBit % 2
      if (nTheDate <= (29 + nBit)) then
        nIsEnd = 1
        break
      end
      nTheDate = nTheDate - 29 - nBit
      n = n - 1
    end
    if (nIsEnd == 1) then
      break
    end
    m = m + 1
  end
  year = 1900 + m
  month = k - n + 1
  day = math.floor(nTheDate)
  if (k == 12) then
    if (month == _orzFly_ChineseLunar_ChineseLunarData[m + 1] / 65536 + 1) then
      month = 1 - month
    elseif (month > _orzFly_ChineseLunar_ChineseLunarData[m + 1] / 65536 + 1) then
      month = month - 1
    end
  end
  ShenXiao = _orzFly_ChineseLunar_ShengXiao[(year-4)%60%12 + 1]
  TianGanDiZhi = _orzFly_ChineseLunar_TianGan[(year-4)%60%10 + 1].._orzFly_ChineseLunar_DiZhi[(year-4)%60%12 + 1];
  if(month < 1)then
    RunYue = "闰"
  else
    RunYue = ""
  end
  
  getNianHao = function(y) if (year - y) == 1 then return '元' else return orzFly_ChineseLunar_GetChineseMathNum(year - y) end end
  if (year>1874 and year<1909)     then NianHao = "光绪" .. getNianHao(1874)
  elseif (year>1908 and year<1912) then NianHao = "宣统" .. getNianHao(1908)
  elseif (year>1911 and year<1949) then NianHao = "民国" .. getNianHao(1911)
  elseif (year>1948)               then NianHao = "新中国" .. getNianHao(1948)
  else                                  NianHao = "" end
  Yue = _orzFly_ChineseLunar_MonthName[math.abs(month)]
  Ri = _orzFly_ChineseLunar_DayName[day]
  return {
    lunarYear = year, lunarMonth = month, lunarDay = day,
    year      = oy  , month      = om   , day      = od,
    ShenXiao  = ShenXiao, TianGanDiZhi = TianGanDiZhi, RunYue = RunYue, 
    NianHao   = NianHao , Yue          = Yue         , Ri     = Ri
  }
end

function orzFly_ChineseLunar_GetSolarDate(lunarYear, lunarMonth, lunarDay)
  local y = lunarYear
  local m = math.abs(lunarMonth)
  local d = lunarDay
  local lDiff
  local ly
  local lm
  local ld
  local i=0
  for i=1,3 do
    local lunarDate = orzFly_ChineseLunar_GetChineseLunarDate(y,m,d)
    ly, lm, ld = lunarDate['lunarYear'], lunarDate['lunarMonth'], lunarDate['lunarDay']
    if (lm == math.abs(lunarMonth)) and (ld == lunarDay) then
      if ((lunarMonth > 0) == (not (lunarDate['RunYue'] == "闰"))) then
        break
      end
      lDiff = 30
    else
      lDiff = (lunarYear - ly) * 12 * 29 + (math.abs(lunarMonth) - lm) * 29 + (lunarDay - ld)
      if lDiff == 0 then
        lDiff = 1
      end
    end
    y, m, d = orzFly_ChineseLunar_DateAddDays(y, m, d, lDiff)
  end
  return {
    lunarYear = lunarYear, lunarMonth = lunarMonth, lunarDay = lunarDay,
    year      = y        , month      = m         , day      = d
  }
end

function orzFly_ChineseLunar_DateAddDays(year, month, day, diff)
  local y = year local m = month local d = day local di = diff
  local sp = 0
  while not (di == 0) do
    if di > 0 then
      sp = _orzFly_ChineseLunarCalendar_DaysInMonth[orzFly_ChineseLunarCalendar_IsLeapYear(y)][m] - d + 1
      if di >= sp then
        di = di - sp
        m = m + 1
        if m == 13 then
          y = y + 1
          m = 1
        end
        d = 1
      else
        d = d + di
        di = 0
      end
    else
      sp = d
      if math.abs(di) >= sp then
        di = di + sp
        m = m - 1
        if m == 0 then
          y = y - 1
          m = 12
        end
        d = _orzFly_ChineseLunarCalendar_DaysInMonth[orzFly_ChineseLunarCalendar_IsLeapYear(y)][m]
      else
        d = d + di
        di = 0
      end
    end
  end
  return y, m, d
end

function orzFly_ChineseLunar_fix(n) n = tonumber(n) return n and ((n > 0 and math.floor or math.ceil)(n)) end
function orzFly_ChineseLunar_date_to_excel_date(yy,mm,dd) 
  local days, monthdays, leapyears, nonleapyears, nonnonleapyears
    monthdays= { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
    leapyears=orzFly_ChineseLunar_fix((yy-1900)/4);
    nonleapyears=orzFly_ChineseLunar_fix((yy-1900)/100)
    nonnonleapyears=orzFly_ChineseLunar_fix((yy-1600)/400)
    if ((math.mod(yy,4)==0) and mm<3) then
      leapyears = leapyears - 1
    end
    days= 365 * (yy-1900) + leapyears - nonleapyears + nonnonleapyears
    c=1
    while (c<mm) do
      days = days + monthdays[c]
      c=c+1
    end
    days=days+dd+1
    return days
end

_orzFly_ChineseLunarSolarTerm_Cache = {year = 0, yearly = {}}
function orzFly_ChineseLunarSolarTerm(input)
  local year
  input = string.gsub(input, "[-\\/.]", "")
  local pos = string.find(input, "#")
  inputold = input
  byDate = (pos==nil)
  if not byDate then input = string.sub(inputold,0, pos - 1) end
  if #input == 0 then
    now = os.date('*t')
    year = now['year']
  elseif #input < 4 then
    return
  elseif #input >= 4 then
    input:gsub("^(%d%d%d%d)", function(y)
      year = tonumber(y)
    end)
  end
  input:gsub("^(%d%d%d%d)", function(y)
    year = tonumber(y)
  end)
  if year < 1900 or year > 2100 then
    error("Invalid year")
  end
  if year == 1900 and month == 1 then
    error("Invalid year")
  end
  if year == nil then
    error("Invalid year")
  end
  if _orzFly_ChineseLunarSolarTerm_Cache['year'] == year..tostring(byDate) then
    yearly = _orzFly_ChineseLunarSolarTerm_Cache['yearly']
  else
    yearly = orzFly_ChineseLunarSolarTerm_GenerateYearly(year, byDate)
    _orzFly_ChineseLunarSolarTerm_Cache['year'] = year..tostring(byDate)
    _orzFly_ChineseLunarSolarTerm_Cache['yearly'] = yearly
  end
  local result = {}
  local key, value
  if not byDate then input = string.sub(inputold,pos+1) end
  for key, value in pairs(yearly) do
    if string.sub(value['suggest'], 1, #input) == input then
      local item = shallow_copy(value)
      item['suggest'] = string.sub(item['suggest'], #input+1)
      table.insert(result, item)
    end
  end
  if #result == 1 then
    local lunar = orzFly_ChineseLunar(result[1]['fulldate'], true)
    local key, value
    table.insert(lunar, 1, result[1]['year'] .. "年" ..result[1]['month'].."月" .. result[1]['day'] .. "日")
    for key, value in pairs(lunar) do
      lunar[key] = result[1]['name'] .."：".. value
    end
    return lunar
  else
    return result
  end
end

function orzFly_ChineseLunarSolarTerm_Trigger(input)
  local now = os.date('*t')
  local year = now['year']
  local yearly = orzFly_ChineseLunarSolarTerm_GenerateYearly(year, false)
  local key, value
  for key, value in pairs(yearly) do
    if value['name'] == input then
      return value['name'] .."："..value['year'] .. "年" ..value['month'].."月" .. value['day'] .. "日"
    end
  end
end

function orzFly_ChineseLunarSolarTerm_GetSolarTermFromDate(year, month, day)
  local yearly = {
    orzFly_ChineseLunarSolarTerm_Format(year, month, month * 2 + 1 -2),
    orzFly_ChineseLunarSolarTerm_Format(year, month, month * 2 + 2 -2)
  }
  local key, value
  for key, value in pairs(yearly) do
    if value['day'] == day then
      return value
    end
  end
end

function orzFly_ChineseLunarSolarTerm_GenerateYearly(year)
  local metatables = {}
  local i
  for i=1,12 do
    table.insert(metatables, orzFly_ChineseLunarSolarTerm_Format(year, i, i * 2 + 1 -2))
    table.insert(metatables, orzFly_ChineseLunarSolarTerm_Format(year, i, i * 2 + 2 -2))
  end
  for _, value in pairs(metatables) do
    if byDate then
      value['help'] = value['name']
      value['suggest'] = value['fulldate']
    else
      value['help'] = value['name'] .."："..value['year'] .. "年" ..value['month'].."月" .. value['day'] .. "日"
      value['suggest'] = value['id']
    end
  end
  return metatables
end

function orzFly_ChineseLunarSolarTerm_Format(year, month, n)
  local y = year
  local m = month
  local d = orzFly_ChineseLunarSolarTerm_GetSolarTermDate(y, m - 1, n)
  return {
    ["name"] = _orzFly_ChineseSolarTerm[n],
    ["year"] = y,
    ["month"] = m,
    ["day"] = d,
    ["fulldate"] = year..string.format("%002d",m)..string.format("%002d",d),
    ["id"] = _orzFly_ChineseSolarTerm_Pinyin[n],
  }
end

function orzFly_ChineseLunarSolarTerm_GetSolarTermDate(year, month, n)
  local m = _orzFly_ChineseSolarTerm_Info[n]
  if (y==2009 and n==2) then m = 43467 end
  local offDate = ((31556925974.7 * (year - 1900) + m * 60000 - 2208549300000 + 2209075200000) - orzFly_ChineseLunar_date_to_excel_date(year,month + 1,0) * 60 * 60 * 24 * 1000) / 60 / 60 / 24 / 1000 + 1
  return math.floor(offDate)
end

_orzFly_ChineseFestival_Cache = {}
function orzFly_ChineseFestival(input)
  local year
  input = string.gsub(input, "[-\\/.]", "")
  local pos = string.find(input, "#")
  inputold = input
  byDate = (pos==nil)
  if not byDate then input = string.sub(inputold,0, pos - 1) end
  if #input == 0 then
    now = os.date('*t')
    year = now['year']
  elseif #input < 4 then
    return
  elseif #input >= 4 then
    input:gsub("^(%d%d%d%d)", function(y)
      year = tonumber(y)
    end)
  end
  input:gsub("^(%d%d%d%d)", function(y)
    year = tonumber(y)
  end)
  if year < 1900 or year > 2100 then
    error("Invalid year")
  end
  if year == 1900 and month == 1 then
    error("Invalid year")
  end
  if year == nil then
    error("Invalid year")
  end
  if not (_orzFly_ChineseFestival_Cache[year..tostring(byDate)] == nil) then
    yearly = _orzFly_ChineseFestival_Cache[year..tostring(byDate)]
  else
    yearly = orzFly_ChineseFestival_GenerateYearly(year, byDate) _orzFly_ChineseFestival_Cache[year..tostring(byDate)] = yearly
  end
  local result = {}
  local key, value
  if not byDate then input = string.sub(inputold,pos+1) end
  for key, value in pairs(yearly) do
    if string.sub(value['suggest'], 1, #input) == input then
      local item = shallow_copy(value)
      item['suggest'] = string.sub(item['suggest'], #input+1)
      table.insert(result, item)
    end
  end
  if #result == 1 then
    local festival = {}
    local lunar = orzFly_ChineseLunar(result[1]['fulldate'], true)
    local key, value
    table.insert(festival, result[1]['name'])
    local re = result[1]['name'] .. "："
    table.insert(festival, re .. result[1]['year'] .. "年" ..result[1]['month'].."月" .. result[1]['day'] .. "日")
    for key, value in pairs(lunar) do
      table.insert(festival,re .. value)
    end
    return festival
  else
    return result
  end
end

function orzFly_ChineseFestival_Trigger(input)
  local now = os.date('*t')
  local year = now['year']
  local yearly
  if not (_orzFly_ChineseFestival_Cache[year.."false"] == nil) then
    yearly = _orzFly_ChineseFestival_Cache[year.."false"]
  else
    yearly = orzFly_ChineseFestival_GenerateYearly(year, false) _orzFly_ChineseFestival_Cache[year..tostring(false)] = yearly
  end
  local key, value
  for key, value in pairs(yearly) do
    if (value['name'] == input) or (value['shortname'] == input) then
      return value['name'] .."："..value['year'] .. "年" ..value['month'].."月" .. value['day'] .. "日"
    end
  end
end

function orzFly_ChineseFestival_GetFestivalFromDate(year, month, day)
  local yearly
  if not (_orzFly_ChineseFestival_Cache[year.."true"] == nil) then
    yearly = _orzFly_ChineseFestival_Cache[year.."true"]
  else
    yearly = orzFly_ChineseFestival_GenerateYearly(year, true) _orzFly_ChineseFestival_Cache[year..tostring(true)] = yearly
  end
  local key, value, fulldate
  fulldate = year..string.format("%002d",month)..string.format("%002d",day)
  for key, value in pairs(yearly) do
    if value['fulldate'] == fulldate then
      return value
    end
  end
end

function orzFly_ChineseFestival_GenerateYearly(year, byDate)
  local metatables = {}
  addFestival = function(festival)
    if festival == nil then return end
    local key
    if byDate then key = festival['fulldate'] else key = festival['id'] end
    if metatables[key] then
      metatables[key]['name'] = metatables[key]['name'] .."、".. festival['name']
      metatables[key]['shortname'] = metatables[key]['shortname'] .."、"..festival['shortname']
    else
      metatables[key] = festival
    end
  end
  local i
  for key, value in pairs(_orzFly_ChineseFestival_SolarFestival) do
    addFestival(orzFly_ChineseFestival_SolarFestival(year, key))
  end
  for key, value in pairs(_orzFly_ChineseFestival_LunarFestival) do
    addFestival(orzFly_ChineseFestival_LunarFestival(year, key))
  end
  for _, value in pairs(metatables) do
    if byDate then
      value['help'] = value['shortname']
      value['suggest'] = value['fulldate']
    else
      value['help'] = value['shortname'] .."："..value['year'] .. "年" ..value['month'].."月" .. value['day'] .. "日"
      value['suggest'] = value['id']
    end
  end
  return metatables
end

function orzFly_ChineseFestival_SolarFestival(year, key)
  local y = year
  if y < _orzFly_ChineseFestival_SolarFestival[key][1] then return end
  local m = _orzFly_ChineseFestival_SolarFestival[key][2]
  local d = _orzFly_ChineseFestival_SolarFestival[key][3]
  return {
    ["name"] = _orzFly_ChineseFestival_SolarFestival[key][5],
    ["shortname"] = _orzFly_ChineseFestival_SolarFestival[key][4],
    ["year"] = y,
    ["month"] = m,
    ["day"] = d,
    ["fulldate"] = y..string.format("%002d",m)..string.format("%002d",d),
    ["id"] = _orzFly_ChineseFestival_SolarFestival[key][6]
  }
end

function orzFly_ChineseFestival_LunarFestival(year, key)
  local ly = year
  local lm = _orzFly_ChineseFestival_LunarFestival[key][2]
  local ld = _orzFly_ChineseFestival_LunarFestival[key][3]
  local solarDay = orzFly_ChineseLunar_GetSolarDate(ly, lm, ld)
  local y = solarDay['year']
  if y > ly then
    ly = ly - 1
    solarDay = orzFly_ChineseLunar_GetSolarDate(ly, lm, ld)
    y = solarDay['year']
  end
  local m = solarDay['month']
  local d = solarDay['day']
  if y < _orzFly_ChineseFestival_LunarFestival[key][1] then return end
  return {
    ["name"] = _orzFly_ChineseFestival_LunarFestival[key][5],
    ["shortname"] = _orzFly_ChineseFestival_LunarFestival[key][4],
    ["year"] = y,
    ["month"] = m,
    ["day"] = d,
    ["fulldate"] = y..string.format("%002d",m)..string.format("%002d",d),
    ["id"] = _orzFly_ChineseFestival_LunarFestival[key][6]
  }
end

_orzFly_ChineseLunar_TianGan={"甲","乙","丙","丁","戊","己","庚","辛","壬","癸"}
_orzFly_ChineseLunar_DiZhi={"子","丑","寅","卯","辰","巳","午","未","申","酉","戌","亥"}
_orzFly_ChineseLunar_ShengXiao={"鼠","牛","虎","兔","龙","蛇","马","羊","猴","鸡","狗","猪"}
_orzFly_ChineseLunar_DayName={"初一","初二","初三","初四","初五","初六","初七","初八","初九","初十","十一","十二","十三","十四","十五","十六","十七","十八","十九","二十","廿一","廿二","廿三","廿四","廿五","廿六","廿七","廿八","廿九","三十"}
_orzFly_ChineseLunar_MonthName={"正","二","三","四","五","六","七","八","九","十","冬","腊"}
_orzFly_ChineseLunar_MonthAdd={0,31,59,90,120,151,181,212,243,273,304,334}
_orzFly_ChineseSolarTerm={"小寒","大寒","立春","雨水","惊蛰","春分","清明","谷雨","立夏","小满","芒种","夏至","小暑","大暑","立秋","处暑","白露","秋分","寒露","霜降","立冬","小雪","大雪","冬至"}
_orzFly_ChineseSolarTerm_Pinyin={"xiaohan","dahan","lichun","yushui","jingzhe","chunfen","qingming","guyu","lixia","xiaoman","mangzhong","xiazhi","xiaoshu","dashu","liqiu","chushu","bailu","qiufen","hanlu","shuangjiang","lidong","xiaoxue","daxue","dongzhi"}
_orzFly_ChineseSolarTerm_Info={0,21208,42467,63836,85337,107014,128867,150921,173149,195551,218072,240693,263343,285989,308563,331033,353350,375494,397447,419210,440795,462224,483532,504758}
_orzFly_ChineseFestival={"艾滋","爱耳","爱牙","爱眼","奥林","爸爸","百福","保健","标准","博物","捕鱼","财神","采参","采花","彩蛋","残疾","臭氧","除夕","春节","稻节","地球","地狱","帝界","电视","电信","电影","钉鞋","动物","端午","儿童","芳春","放生","妇女","干旱","公输","观潮","观莲","国庆","国医","海豹","海关","寒潮","航海","和平","红十","护士","花朝","环保","浣花","火把","记者","祭祖","家庭","建军","建筑","教师","结核","禁毒","精神","警察","抗日","孔子","腊八","篮球","劳动","老人","雷锋","联合","粮食","龙头","龙舟","旅游","盲人","门神","男性","难民","女儿","女娲","爬坡","盘古","贫困","平安","七夕","企业","气象","勤俭","青年","清和","清洁","情人","缺碘","人口","人权","撒种","散花","扫盲","生物","圣诞","湿地","视觉","水日","税收","踏青","太阳","糖尿","天庆","天医","填仓","图书","土地","万圣","卫生","问候","无烟","洗灶","宪章","消防","消费","小年","哮喘","新闻","信息","学生","医药","彝族","音乐","营养","邮政","愚人","元旦","元宵","月球","知识","植树","志愿","中秋","中元","中岳","重阳","住房","足球","祖娘"}
_orzFly_ChineseFestival_SolarFestival={{0,1,1,"元旦","元旦","yuandan"},{0,1,26,"海关","国际海关日","haiguan"},{1971,2,2,"湿地","世界湿地日","shidi"},{1960,2,10,"气象","国际气象节","qixiangguoji"},{270,2,14,"情人","情人节","qingren"},{1983,3,1,"海豹","国际海豹日","haibao"},{2000,3,3,"爱耳","全国爱耳日","aier"},{1963,3,5,"雷锋","学雷锋纪念日","leifeng"},{1909,3,8,"妇女","妇女节","funv"},{1979,3,12,"植树","植树节","zhishu"},{0,3,14,"警察","国际警察日","jingcha"},{1983,3,15,"消费","消费者权益日","xiaofei"},{1929,3,17,"国医","中国国医节","guoyi"},{0,3,17,"航海","国际航海日","hanghaiguoji"},{1993,3,22,"水日","世界水日","shuiri"},{1950,3,23,"气象","世界气象日","qixiangshijie"},{1996,3,24,"结核","世界防治结核病日","jiehe"},{1564,4,1,"愚人","愚人节","yuren"},{1991,4,1,"税收","税收宣传月","shuishou"},{0,4,1,"卫生","全国爱国卫生运动月","weisheng"},{1950,4,7,"卫生","世界卫生日","weishengshijie"},{1994,4,21,"企业","全国企业家活动日","qiye"},{1970,4,22,"地球","世界地球日","diqiu"},{1996,4,23,"图书","世界图书和版权日","tushu"},{2001,4,26,"知识","世界知识产权日","zhishi"},{1886,5,1,"劳动","国际劳动节","laodong"},{1919,5,4,"青年","中国五四青年节","qingnian"},{1994,5,5,"缺碘","碘缺乏病防治日","quedian"},{1948,5,8,"红十","世界红十字日","hongshi"},{1912,5,12,"护士","国际护士节","hushi"},{1994,5,15,"家庭","国际家庭日","jiating"},{1969,5,17,"电信","世界电信日","dianxin"},{1977,5,18,"博物","国际博物馆日","bowu"},{1990,5,20,"营养","全国学生营养日","yingyang"},{1988,5,31,"无烟","世界无烟日","wuyan"},{1951,6,1,"儿童","国际儿童节","ertong"},{1974,6,5,"环保","世界环境保护日","huanbao"},{1996,6,6,"爱眼","全国爱眼日","aiyan"},{1995,6,17,"干旱","防治荒漠化和干旱日","ganhan"},{2001,6,20,"难民","世界难民日","nanmin"},{1894,6,23,"奥林","国际奥林匹克日","aolin"},{1991,6,25,"土地","全国土地日","tudi"},{1987,6,26,"禁毒","国际禁毒日","jindu"},{0,6,26,"宪章","联合国宪章日","xianzhang"},{1985,7,1,"建筑","世界建筑日","jianzhu"},{1995,7,2,"记者","国际体育记者日","jizheguoji"},{1937,7,7,"抗日","抗日战争纪念日","kangri"},{0,7,11,"航海","中国航海节","hanghai"},{1987,7,11,"人口","世界人口日","renkou"},{0,7,20,"月球","世界月球日","yueqiu"},{1927,8,1,"建军","建军节","jianjun"},{1932,8,6,"电影","国际电影节","dianying"},{1988,8,8,"爸爸","中国男子节(爸爸节)","baba"},{1966,9,8,"扫盲","国际扫盲日","saomang"},{1985,9,8,"新闻","国际新闻工作者(团结)日","xinwenguoji"},{1985,9,10,"教师","中国教师节","jiaoshi"},{1985,9,14,"清洁","世界清洁地球日","qingjie"},{1987,9,16,"臭氧","国际臭氧层保护日","chouyang"},{1989,9,20,"爱牙","国际爱牙日","aiya"},{2002,9,21,"和平","国际和平日","heping"},{1980,9,27,"旅游","世界旅游日","lvyou"},{1949,10,1,"国庆","国庆节","guoqing"},{1980,10,1,"音乐","世界音乐日","yinyue"},{1990,10,1,"老人","国际老人节","laoren"},{0,10,2,"住房","国际住房日","zhufang"},{1949,10,4,"动物","世界动物日","dongwu"},{1998,10,8,"视觉","世界视觉日","shijue"},{1969,10,9,"邮政","世界邮政日","youzheng"},{1992,10,10,"精神","世界精神卫生日","jingshen"},{1987,10,13,"教师","国际教师节","jiaoshiguoji"},{0,10,13,"保健","世界保健日","baojian"},{1969,10,14,"标准","世界标准日","biaozhun"},{1984,10,15,"盲人","国际盲人节","mangren"},{1979,10,16,"粮食","世界粮食日","liangshi"},{1992,10,17,"贫困","世界消除贫困日","pinkun"},{1992,10,22,"医药","世界传统医药日","yiyao"},{0,10,24,"信息","世界发展信息日","xinxi"},{1945,10,24,"联合","联合国日","lianhe"},{2000,10,28,"男性","世界男性健康日","nanxing"},{0,10,31,"万圣","万圣节","wansheng"},{0,10,31,"勤俭","世界勤俭日","qinjian"},{2000,11,8,"记者","中国记者日","jizhe"},{1992,11,9,"消防","全国消防安全宣传教育日","xiaofang"},{1946,11,10,"青年","世界青年节","qingnianshijie"},{1991,11,14,"糖尿","世界糖尿病日","tangniao"},{1946,11,17,"学生","国际大学生节","xuesheng"},{0,11,20,"彝族","彝族年","yizu"},{1996,11,21,"电视","世界电视日","dianshi"},{1973,11,21,"问候","世界问候日","wenhou"},{1988,12,1,"艾滋","世界艾滋病日","aizi"},{1992,12,3,"残疾","世界残疾人日","canji"},{1985,12,5,"志愿","国际经济和社会发展志愿人员日","zhiyuan"},{1995,12,9,"足球","世界足球日","zuqiu"},{1950,12,10,"人权","世界人权日","renquan"},{1998,12,11,"哮喘","世界防治哮喘日","xiaochuan"},{0,12,21,"篮球","国际篮球日","lanqiu"},{0,12,24,"平安","平安夜","pingan"},{0,12,25,"圣诞","圣诞节","shengdan"},{1994,12,29,"生物","国际生物多样性日","shengwu"}}
_orzFly_ChineseFestival_LunarFestival={{0,1,1,"春节","春节","chunjie"},{0,1,3,"天庆","天庆节","tianqing"},{0,1,5,"财神","五路财神日","caishen"},{0,1,15,"元宵","元宵节","yuanxiao"},{0,1,16,"门神","馄饨节","menshen"},{0,1,20,"女娲","女娲补天日","nvwa"},{0,1,25,"填仓","填仓节","tiancang"},{0,2,2,"龙头","龙头节","longtou"},{0,2,8,"芳春","芳春节","fangchun"},{0,2,10,"彩蛋","彩蛋节","caidan"},{0,2,12,"花朝","花朝节","huazhao"},{0,2,28,"寒潮","寒潮节","hanchao"},{0,3,3,"踏青","踏青节","taqing"},{0,3,10,"撒种","撒种节","sazhong"},{0,3,18,"中岳","中岳节","zhongyue"},{0,4,1,"清和","清和节","qinghe"},{0,4,2,"公输","公输般日","gongshu"},{0,4,8,"放生","浴佛放生节","fangsheng"},{0,4,11,"孔子","孔子祭","kongzi"},{0,4,19,"浣花","浣花日","huanhua"},{0,5,1,"女儿","女儿节","nver"},{0,5,4,"采花","采花节","caihua"},{0,5,5,"端午","端午节","duanwu"},{0,5,17,"龙舟","龙舟节","longzhou"},{0,5,29,"祖娘","祖娘节","zuniang"},{0,6,15,"捕鱼","捕鱼祭","buyu"},{0,6,16,"爬坡","爬坡节","papo"},{0,6,19,"太阳","太阳日","taiyang"},{0,6,24,"火把","火把节","huoba"},{0,6,24,"观莲","观莲节","guanlian"},{0,7,7,"七夕","七夕节","qixi"},{0,7,12,"地狱","地狱开门日","diyu"},{0,7,15,"中元","中元节","zhongyuan"},{0,8,1,"天医","天医节","tianyi"},{0,8,15,"中秋","中秋节","zhongqiu"},{0,8,18,"观潮","观潮节","guanchao"},{0,8,24,"稻节","稻节","daojie"},{0,9,9,"重阳","重阳节","chongyang"},{0,9,13,"钉鞋","钉鞋日","dingxie"},{0,9,30,"采参","采参节","caican"},{0,10,1,"祭祖","祭祖节","jizu"},{0,10,16,"盘古","盘古节","pangu"},{0,11,39,"散花","散花灯","sanhua"},{0,12,8,"腊八","腊八节","laba"},{0,12,12,"百福","百福日","baifu"},{0,12,23,"洗灶","洗灶日","xizao"},{0,12,24,"小年","小年","xiaonian"},{0,12,25,"帝界","上帝下界之辰","dijie"},{0,12,30,"除夕","除夕","chuxi"}}

--下行数据已升级成 1900~2100 年。请尊重 orzFly 的劳动成果。
_orzFly_ChineseLunar_ChineseLunarData={526701,1198,2647,330317,3366,3477,265045,1386,2477,133469,1198,398491,2637,3365,334501,2900,3434,135898,2395,461111,1175,2635,333387,1701,1748,267701,694,2391,133423,1175,396438,3402,3749,331177,1453,694,201326,2350,465197,3221,3402,400202,2901,1386,267611,605,2349,137515,2709,464533,1738,2901,330421,1242,2651,199255,1323,529706,3733,1706,398762,2741,1206,267438,2647,1318,204070,3477,461653,1386,2413,330077,1197,2637,268877,3365,531109,2900,2922,398042,2395,1179,267415,2635,661067,1701,1748,398772,2742,2391,330031,1175,1611,200010,3749,527717,1452,2742,332397,2350,3222,268949,3402,3493,133973,1386,464219,605,2349,334123,2709,2890,267946,2773,592565,1210,2651,395863,1323,2707,265877,1706,2773,133557,1206,398510,2638,3366,335142,3411,1450,200042,2413,723293,1197,2637,399947,3365,3410,334676,2906,1389,133467,1179,464023,2635,2725,333477,1746,2778,199350,2359,526639,1175,1611,396618,3749,1714,267628,2734,2350,203054,3222,465557,3402,3493,330581,1386,2669,264797,1325,529707,2709,2890,399018,2773,1370,267450,2651,1323,202023,1683,462419,1706,2773,330165,1206,2647,264782,3366,531750,3410,3498,396650,1389,1198,267421,2637,3349,138021,3410}

--以下修改于 base.lua
_orzFly_ChineseLunar_Month_Table_Normal={31,28,31,30,31,30,31,31,30,31,30,31}
_orzFly_ChineseLunar_Month_Table_Leaf={31,29,31,30,31,30,31,31,30,31,30,31}
_orzFly_ChineseLunar_Chinese_Digits={[0]="〇",[1]="一",[2]="二",[3]="三",[4]="四",[5]="五",[6]="六",[7]="七",[8]="八",[9]="九",[10]="十",}
--以上修改于 base.lua

--以下修改自万年历
function orzFly_ChineseLunarCalendar_IsLeapYear(year)
  return ((year % 4 == 0) and not (year % 100 == 0)) or (year % 400 == 0)
end

function orzFly_ChineseLunarCalendar_FormatMonthly(y,m,day_table)
  local s = _orzFly_ChineseLunarCalendar_Header .. '\n'
  local day1 = orzFly_ChineseLunarSolarTerm_GetSolarTermDate(y, m-1, m*2-1)
  local day2 = orzFly_ChineseLunarSolarTerm_GetSolarTermDate(y, m-1, m*2)
  for i = 1, #day_table do
    if day_table[i] == _orzFly_ChineseLunarCalendar_Space then
      s = s .. "　　　"
    else
      lunar = orzFly_ChineseLunar_GetChineseLunarDate(y,m,day_table[i])
      if lunar['lunarDay'] == 1 then
        lunarInfo = lunar['Yue'] .. "月"
      else
        lunarInfo = lunar['Ri']
      end
      local festival = orzFly_ChineseFestival_GetFestivalFromDate(y,m,day_table[i])
      if type(festival) == "table" then
        lunarInfo = festival['shortname']
        local pos = string.find(lunarInfo, "、")
        if not (pos == nil) then lunarInfo = string.sub(lunarInfo,0, pos - 1) end
      end
      if day_table[i] == day1 then
        lunarInfo = _orzFly_ChineseSolarTerm[m*2-1]
      elseif day_table[i] == day2 then
        lunarInfo = _orzFly_ChineseSolarTerm[m*2]
      end
      s = s .. string.format('%2d', day_table[i]) .. lunarInfo
    end
    if (i % 7 == 0) then
      s = s .. "\n"
    else
      s = s .. "　"
    end
  end
  return s
end

function orzFly_ChineseLunarCalendar_PaddingString(s, width)
  local _, ucount = string.gsub(s, "[^\128-\193]", "")
  local scount = (ucount * 3 - #s) / 2
  local dcount = ucount - scount
  local length = scount + dcount * 2
  local padding = math.floor((width - length) / 2)
  return string.rep(" ",padding) .. s .. string.rep(" ",width-length-padding)
end

function orzFly_ChineseLunarCalendar_Generate(y, m, t)
  local s = os.date("*t", t)
  local week1stday = s['wday'] - 1
  local day_table = {}
  for i = 1, week1stday do
    table.insert(day_table, _orzFly_ChineseLunarCalendar_Space)
  end
  dm = _orzFly_ChineseLunarCalendar_DaysInMonth[orzFly_ChineseLunarCalendar_IsLeapYear(y)][m]
  for i = 1, dm do
    table.insert(day_table, i)
  end
  return day_table
end

function orzFly_ChineseLunarCalendar_GenerateMonthly(y, m)
  local t = os.time{year = y, month = m, day = 1}
  lunar = orzFly_ChineseLunar_GetChineseLunarDate(y,m,1)
  day_table = orzFly_ChineseLunarCalendar_Generate(y, m, t)
  return orzFly_ChineseLunarCalendar_PaddingString("公元 " .. lunar["year"] .. " 年 " .. lunar['NianHao'] .. "年 农历" .. lunar['TianGanDiZhi'] .. lunar['ShenXiao'] .. "年 " .. lunar['month'] .. " 月", 54) .. '\n' ..
         orzFly_ChineseLunarCalendar_FormatMonthly(y,m,day_table) .. '\n'
end

function orzFly_ChineseLunarCalendar_FormatYearly(y,month_table)
  local s = ''
  for m = 1, 12 do
    s = s .. orzFly_ChineseLunarCalendar_PaddingString(string.format("%d 月", m), 54) .. '\n' ..
             orzFly_ChineseLunarCalendar_FormatMonthly(y,m,month_table[m]) .. '\n\n'
  end
  return s
end

function orzFly_ChineseLunarCalendar_GenerateYearly(y)
  local month_table = {}
  lunar = orzFly_ChineseLunar_GetChineseLunarDate(y,5,1)
  for m = 1, 12 do
    local t = os.time{year = y, month = m, day = 1}
    day_table = orzFly_ChineseLunarCalendar_Generate(y, m, t)
    table.insert(month_table, day_table)
  end
  return orzFly_ChineseLunarCalendar_PaddingString("公元 " .. lunar["year"] .. " 年 " .. lunar['NianHao'] .. "年 农历" .. lunar['TianGanDiZhi'] .. lunar['ShenXiao'] .. "年", 54) .. '\n\n' ..
         orzFly_ChineseLunarCalendar_FormatYearly(y,month_table) .. '\n'
end

function orzFly_ChineseLunarCalendar(input)
  local year, month
  if #input == 0 then
    now = os.date('*t')
    year = now['year']
    month = now['month']
  else
    input:gsub("^(%d+)[-./\\](%d+)$", function(y, m)
      year = tonumber(y)
      month = tonumber(m)
    end)
    if year == nil then
      if #input == 6 then
        input:gsub("^(%d%d%d%d)(%d%d)$", function(y, m)
          year = tonumber(y)
          month = tonumber(m)
        end)
      else
        input:gsub("^(%d+)$", function(y)
          year = tonumber(y)
        end)
      end
    end
    if year < 1970 then
      error('not supported')
    end
  end
  if month == nil then return orzFly_ChineseLunarCalendar_GenerateYearly(year) else return orzFly_ChineseLunarCalendar_GenerateMonthly(year, month)
  end
end

_orzFly_ChineseLunarCalendar_Header = '星期日　星期一　星期二　星期三　星期四　星期五　星期六'
_orzFly_ChineseLunarCalendar_Space = -1
_orzFly_ChineseLunarCalendar_DaysInMonth = {
  [false] = _orzFly_ChineseLunar_Month_Table_Normal,
  [true] = _orzFly_ChineseLunar_Month_Table_Leaf,
}
--以上修改自万年历

------------
ime.register_command("nl", "orzFly_ChineseLunar", "农历", "alpha", "输入日期，例如2010-12-31")
ime.register_command("rl", "orzFly_ChineseLunarCalendar", "农历万年历", "none", "输入年月，例如2012-12")
ime.register_command("jq", "orzFly_ChineseLunarSolarTerm", "二十四节气", "none", "输入日期或#拼音，例如2011-01-05或#xiaohan")
ime.register_command("jr", "orzFly_ChineseFestival", "中国节假日", "none", "输入日期或#拼音，例如2011-01-01或#yuandan")
ime.register_trigger("orzFly_ChineseLunarSolarTerm_Trigger", "二十四节气", {}, _orzFly_ChineseSolarTerm)
ime.register_trigger("orzFly_ChineseFestival_Trigger", "中国节假日", {}, _orzFly_ChineseFestival)