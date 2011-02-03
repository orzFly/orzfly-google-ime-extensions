-- encoding: UTF-8

------------------------------------------------
-- 谷歌拼音输入法单位换算扩展
-- 版本: 0.1.0.1
-- 作者: orzFly
-- 作者主页: http://orzfly.com/
-- 扩展主页: http://orztech.com/google-pinyin-ime-extension/unit-converter
-- 项目主页: http://code.google.com/p/google-pinyin-api/
-- 问题反馈: http://orztech.com/forms/2
--
-- 此扩展遵循GPLv3发布
------------------------------------------------
-- orderedPairs: http://lua-users.org/wiki/SortedIteration
_0=pairs function _1(_6)local _2={}for _4 in _0(_6)do table.insert(_2,_4)end table.sort(_2)return _2 end function _3(_6,_5)if _5==nil then _6._7=_1(_6)_4=_6._7[1]return _4,_6[_4]end _4=nil for _8 = 1,table.getn(_6._7)do if _6._7[_8]==_5 then _4=_6._7[_8+1]end end if _4 then return _4,_6[_4]end _6._7=nil return end function _9(_6)return _3,_6,nil end pairs=_9

function orzFly_UnitConverter(arg)
  local input = string.lower(arg)
  local metatables = {}
  if #input > 0 then
    local module = string.sub(input, 1, 1)
    if _orzFly_UnitConverter_Code[module] then
      if #input > 1 then
        local from = string.sub(input, 2)
        local from_length = 0
        from:gsub("^[%d.]*", function(number)
          from_length = #number
          from = tonumber(number)
        end)
        if from then
          local from_unit = string.sub(input, 2 + from_length)
            from_unit:gsub("^[a-z]*", function(unit)
            from_unit = unit
          end)
          if #input > #module + from_length + #from_unit then
            if _orzFly_UnitConverter_Code[module][2][from_unit] then
              local to_unit = string.sub(input, #module + from_length + #from_unit + 2)
              if to_unit then
                if _orzFly_UnitConverter_Code[module][2][to_unit] then
                  local from_display = from
                  local from_unit_display = _orzFly_UnitConverter_Code[module][2][from_unit][2]
                  local to_display = _orzFly_UnitConverter_ProcessConverting(from, module, from_unit, to_unit)
                  local to_unit_display = _orzFly_UnitConverter_Code[module][2][to_unit][2]
                  metatables = {
                    to_display .. " " .. to_unit_display,
                    from_display .. " " .. from_unit_display  .. " = " .. to_display .. " " .. to_unit_display,
                  }
                else
                  for k, v in pairs(_orzFly_UnitConverter_Code[module][2]) do
                    if string.sub(k, 1, #to_unit) == to_unit then
                      local suggest = string.sub(k, #to_unit+1)
                      local help = _orzFly_UnitConverter_ProcessConverting(from, module, from_unit, k) .. " " .. v[2]
                      table.insert(metatables, {["suggest"] = suggest, ["help"] = help})
                    end
                  end
                  if #metatables == 0 then
                    metatables = "-- 无效目标单位 --"
                  end
                end
              end
            else
              metatables = "-- 无效源单位 --"
            end
          else
            for k, v in pairs(_orzFly_UnitConverter_Code[module][2]) do
              if string.sub(k, 1, #from_unit) == from_unit then
                local suggest = string.sub(k, #from_unit+1) .. "="
                table.insert(metatables, {["suggest"] = suggest, ["help"] = v[2]})
              end
            end
          end
        end
      else
        metatables = "-- 请输入源数据 --"
      end
    end
  else
    for k, v in pairs(_orzFly_UnitConverter_Code) do
      table.insert(metatables, {["suggest"] = k, ["help"] = v[1]})
    end
  end
  if not metatables then
    metatables = "-- 无效输入 --"
  end
  return metatables
end

function _orzFly_UnitConverter_ProcessConverting(from, module, from_unit, to_unit)
  if module == "w" then
    return _orzFly_UnitConverter_Temp_FromC(_orzFly_UnitConverter_Temp_ToC(from, from_unit), to_unit)
  else
    return from * _orzFly_UnitConverter_Code[module][2][from_unit][1] / _orzFly_UnitConverter_Code[module][2][to_unit][1]
  end
end

function _orzFly_UnitConverter_Temp_FromC(from, to_unit)
  if to_unit == "c" then --摄氏度
    return from
  elseif to_unit == "f" then --华氏度
    return 32 + (from * 9 / 5)
  elseif to_unit == "k" then --开氏度
    return from + 273.15
  elseif to_unit == "ra" then --兰氏度
    return (from + 273.15) * 1.8
  elseif to_unit == "re" then --列氏度
    return from / 1.25
  end
end

function _orzFly_UnitConverter_Temp_ToC(from, from_unit)
  if from_unit == "c" then --摄氏度
    return from
  elseif from_unit == "f" then --华氏度
    return (from - 32) * 5 / 9
  elseif from_unit == "k" then --开氏度
    return from - 273.15
  elseif from_unit == "ra" then --兰氏度
    return from / 1.8 - 273.15
  elseif from_unit == "re" then --列氏度
    return from * 1.25
  end
end

_orzFly_UnitConverter_Code={
  ["c"] = { "长度", {
    ["km"] = {1000, "千米"},
    ["m"] = {1, "米"},
    ["dm"] = {0.1, "分米"},
    ["cm"] = {0.01, "厘米"},
    ["mm"] = {0.001, "毫米"},
    ["um"] = {0.000001, "微米"},
    ["li"] = {500, "里"},
    ["zhang"] = {10 / 3, "丈"},
    ["chi"] = {1 / 3, "尺"},
    ["cun"] = {1 / 30, "寸"},
    ["fen"] = {1 / 300, "分"},
    ["lee"] = {1 / 3000, "厘"},
    ["ft"] = {0.3048, "英尺"},
    ["mi"] = {5280 * 0.3048, "英里"},
    ["fur"] = {660 * 0.3048, "弗隆"},
    ["yd"] = {3 * 0.3048, "码"},
    ["in"] = {0.3048 / 12, "英寸"},
    ["nmi"] = {1852, "海里"},
    ["fat"] = {6 * 0.3048, "英寻"},
    }
  },
  ["m"] = { "面积", {
    ["sqkm"] = {(1000 * 1000), "平方公里"},
    ["ha"] = {(100 * 100), "公顷"},
    ["sqm"] = {1, "平方米"},
    ["mu"] = {((10000/15) * 1), "市亩"},
    ["sqdm"] = {(0.1 * 0.1), "平方分米"},
    ["sqcm"] = {(0.01 * 0.01), "平方厘米"},
    ["sqmm"] = {(0.001 * 0.001), "平方毫米"},
    ["sqft"] = {(0.3048 * 0.3048), "平方英尺"},
    ["sqyd"] = {(3 * 3 * (0.3048 * 0.3048)), "平方码"},
    ["sqrd"] = {(16.5 *16.5 * (0.3048 * 0.3048)), "平方竿"},
    ["acre"] = {160 * (16.5 *16.5 * (0.3048 * 0.3048)), "英亩"},
    ["sq"] = {(5280 *5280 * (0.3048 * 0.3048)), "平方英寸"},
    ["sqmi"] = {((0.3048 * 0.3048) / (12 * 12)), "平方英里"},
    }
  },
  ["t"] = { "体积", {
    ["hl"] = {100, "公石"},
    ["dal"] = {10, "十升"},
    ["l"] = {1, "升"},
    ["dl"] = {0.1, "分升"},
    ["cl"] = {0.01, "厘升"},
    ["ml"] = {0.001, "毫升"},
    ["m"] = {1000, "立方米"},
    ["dm"] = {1, "立方分米"},
    ["cm"] = {0.001, "立方厘米"},
    ["mm"] = {0.000001, "立方毫米"},
    ["tas"] = {0.015, "公制汤勺"},
    ["tes"] = {0.005, "公制调羹"},
    ["in"] = {0.016387064, "立方英寸"},
    ["acft"] = {43560 * 1728 * 0.016387064, "亩英尺"},
    ["yd"] = {27 * 1728 * 0.016387064, "立方码"},
    ["ft"] = {1728 * 0.016387064, "立方英尺"},
    ["ulgal"] = {231 * 0.016387064, "加仑(美制液量)"},
    ["ulba"] = {42 * 231 * 0.016387064, "桶(美制液量)"},
    ["ulqt"] = { 231 * 0.016387064 / 4, "夸脱(美制液量)"},
    ["ulpt"] = { 231 * 0.016387064 / 8, "品脱(美制液量)"},
    ["ulgi"] = { 231 * 0.016387064 / 32, "及耳(美制液量)"},
    ["ulfloz"] = {231 * 0.016387064 / 128, "液量盎司(美制液量)"},
    ["ulfldr"] = { 231 * 0.016387064 / 1024, "液量打兰(美制液量)"},
    ["ulmin"] = {231 * 0.016387064 / 128 / 61440, "量滴"},
    ["uba"] = {7056 * 0.016387064, "桶(美)"},
    ["ubu"] = {2150.42 * 0.016387064, "蒲式耳(美)"},
    ["upk"] = {2150.42 * 0.016387064 / 4, "配克(美)"},
    ["uqt"] = {2150.42 * 0.016387064 / 32, "夸脱(美)"},
    ["upt"] = {2150.42 * 0.016387064 / 64, "品脱(美)"},
    ["ufloz"] = {8 * 231 * 0.016387064 / 128, "杯"},
    ["tbs"] = {231 * 0.016387064 / 128 / 2, "汤勺(美)"},
    ["tsp"] = {231 * 0.016387064 / 128 / 6, "调羹(美)"},
    ["gal"] = {4.54609, "加仑(英)"},
    ["bba"] = {36 * 4.54609, "桶(英)"},
    ["bbu"] = {8  * 4.54609, "蒲式耳(英)"},
    ["bpt"] = {4.54609 / 8, "品脱(英)"},
    ["bfloz"] = {4.54609 / 160, "液量盎司(英)"},
    }
  },
  ["z"] = { "重量", {
    ["t"] = {1000, "吨"},
    ["kg"] = {1, "千克"},
    ["g"] = {0.001, "克"},
    ["mg"] = {0.000001, "毫克"},
    ["jin"] = {0.5, "市斤"},
    ["dan"] = {50, "担"},
    ["liang"] = {0.05, "两"},
    ["qian"] = {0.005, "钱"},
    ["lb"] = {0.45359237, "磅"},
    ["bt"] = {2240 * 0.45359237, "(英制)长吨"},
    ["ut"] = {2000 * 0.45359237, "(美制)短吨"},
    ["bcwt"] = {112 * 0.45359237, "英担"},
    ["ucwt"] = {100 * 0.45359237, "美担"},
    ["bstone"] = {14 * 0.45359237, "英石"},
    ["oz"] = {0.45359237 / 16, "盎司"},
    ["dr"] = {0.45359237 / 256, "打兰"},
    ["grain"] = {0.45359237 / 7000, "格令"},
    ["lbt"] = {5760 * 0.45359237 / 7000, "金衡磅"},
    ["ozt"] = {480 * 0.45359237 / 7000, "金衡盎司"},
    ["dwt"] = {24 * 0.45359237 / 7000, "英钱"},
    ["graint"] = {0.45359237 / 7000, "金衡格令"},
    }
  },
  ["g"] = { "功率", {
    ["w"] = {0.001, "瓦"},
    ["kw"] = {1, "千瓦"},
    ["hp"] = {0.745712172, "英制马力"},
    ["ps"] = {0.7352941, "米制马力"},
    ["kgms"] = {0.0098039215, "公斤·米/秒"},
    ["kcals"] = {4.1841004, "千卡/秒"},
    ["btus"] = {1.05507491, "英热单位/秒"},
    ["ftlbs"] = {0.0013557483731, "英尺·磅/秒"},
    ["js"] = {0.001, "焦耳/秒"},
    ["nms"] = {0.001, "牛顿·米/秒"},
    }
  },
  ["n"] = { "功、能和热量", {
    ["j"] = {1, "焦耳"},
    ["kgm"] = {9.80392157, "公斤·米"},
    ["psh"] = {2647603.9184538, "米制马力·时"},
    ["hph"] = {2684563.7583893, "英制马力·时"},
    ["kwh"] = {3599712.023038157, "千瓦·时"},
    ["kcal"] = {4185.851820846, "千卡"},
    ["btu"] = {1055.0749103, "英热单位"},
    ["ftlb"] = {1.3557483731, "英尺·磅"},
    }
  },
  ["y"] = { "压力", {
    ["kpa"] = {1000, "千帕"},
    ["hpa"] = {100, "百帕"},
    ["pa"] = {1, "帕斯卡"},
    ["bar"] = {100000, "巴"},
    ["mb"] = {100, "毫巴"},
    ["atm"] = {101325, "标准大气压"},
    ["mmhg"] = {101325 / 760, "毫米汞柱"},
    ["torr"] = {101325 / 760, "托"},
    ["inhg"] = {25.4 * 101325 / 760, "英吋汞柱"},
    ["lbfin"] = {6894.757 , "磅力·英寸^-2"},
    ["lbfft"] = {6894.757 / 144, "磅力·英尺^-2"},
    ["kgfcm"] = {98066.5, "公斤力·厘米^-2"},
    ["kgfm"] = {9.80665, "公斤力·米^-2"},
    ["mmh2o"] = {1/0.101972, "毫米水柱"},
    }
  },
  ["w"] = { "温度", {
    ["c"] = {1, "摄氏度"},
    ["f"] = {1, "华氏度"},
    ["k"] = {1, "开氏度"},
    ["ra"] = {1, "兰氏度"},
    ["re"] = {1, "列氏度"},
    }
  },
  ["s"] = { "时间", {
    ["c"] = {3153600000, "世纪"},
    ["y"] = {31536000, "年"},
    ["season"] = {7884000, "季"},
    ["mo"] = {2628000, "月"},
    ["d"] = {86400, "日"},
    ["h"] = {3600, "时"},
    ["m"] = {60, "分"},
    ["s"] = {1, "秒"},
    ["ms"] = {0.001, "毫秒"},
    }
  },
}
------------

ime.register_command("dw", "orzFly_UnitConverter", "单位换算","none","格式：[模块][操作数][原始单位]=[目标单位]。例如 a1cm=m")
