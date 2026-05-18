-- ==========================================
-- ONLINE EXPIRATION DATE CHECK SYSTEM
-- ==========================================
local expiration_url = "https://raw.githubusercontent.com/Jking123456/new-luajava/refs/heads/main/expired.txt"

gg.toast("Checking script validation status...")
local response = gg.makeRequest(expiration_url)

if not response or not response.content then
    gg.alert("❌ Error: Failed to connect to verification server. Please check your internet connection.")
    os.exit()
end

-- Clean up formatting/spaces from the pulled string
local expiry_string = response.content:gsub("%s+", "")

-- Parse the date from the text file (Expected format in expired.txt: YYYY-MM-DD, e.g., 2026-12-31)
local year, month, day = expiry_string:match("(%d%d%d%d)%-(%d%d)%-(%d%d)")

if not year or not month or not day then
    gg.alert("❌ Server Error: Invalid expiration format hosted on GitHub. Expected YYYY-MM-DD.")
    os.exit()
end

-- Convert server date and current system time to timestamps for comparison
local expiry_time = os.time({year = tonumber(year), month = tonumber(month), day = tonumber(day)})
local current_time = os.time()

if current_time > expiry_time then
    gg.alert("🛑 This script has expired!\n\nExpiration Date: " .. year .. "-" .. month .. "-" .. day .. "\nPlease contact the developer for an updated version.")
    os.exit()
else
    gg.toast("✅ Verification Successful! Active until: " .. year .. "-" .. month .. "-" .. day)
end

-- ==========================================
-- MAIN SCRIPT IMPLEMENTATION
-- ==========================================
if gg.getRangesList("libtersafe2.so")[1] then
	local t = {}
	t[1] = gg.getRangesList("libtersafe2.so")[1]["start"] + 0xA24BC; 
	gg.setValues({
		[1] = { 
			address = t[1],
			flags = 4,
			value = 0,
		},
	})
	gg.toast("Activated Successfully")
end

-- ==========================================
-- RYUJI SCRIPT CORE DATA & FLAGS
-- ==========================================
local session_flags_sansxml = {
    clear_battle = false,
    white_body = false
}
local done_flags_sansxml = {
    clear_battle = false,
    white_body = false
}

-- ==========================================
-- RYUJI SCRIPT FUNCTIONS
-- ==========================================
function applyRadarMapSafe_sansxml(enabled)
    if enabled then
        gg.setRanges(gg.REGION_ANONYMOUS)
        gg.searchNumber("98784247822;47244640279", gg.TYPE_QWORD)
        gg.searchNumber("98784247822", gg.TYPE_QWORD)
        local results_sansxml = gg.getResults(999999)
        if #results_sansxml > 0 then
            local script_by_sansxml = {}
            for i_sansxml = 1, #results_sansxml do
                script_by_sansxml[i_sansxml] = {
                    address = results_sansxml[i_sansxml].address,
                    value = 98784247823,
                    flags = gg.TYPE_QWORD
                }
            end
            gg.setValues(script_by_sansxml)
            gg.toast("<[ 🌐 ]> MAPHACK NO ICON ANYMOUS : ✅")
        end
        gg.clearResults()
    end
end

function applyMapIcon_sansxml(enabled)
    if enabled then
        gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_CODE_APP)
        gg.searchNumber("h FF C3 00 D1 FD 7B 01 A9 FD 43 00 91 F3 13 00 F9 81 14 00 B4 49 F5 01 D0 E8 03 00 AA 20 C1 41 F9 0A 5C 42 79 6A 00 48 36 0A E0 40 B9 8A 08 00 34", gg.TYPE_BYTE)
        local results1 = gg.getResults(1)
        gg.clearResults()
        gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_CODE_APP)
        gg.searchNumber("h FF C3 00 D1 FD 7B 01 A9 FD 43 00 91 F3 13 00 F9 09 D0 65 39 89 0C 00 35 81 14 00 B4 E9 C4 01 90 E8 03 00 AA 20 C1 41 F9 0A 5C 42 79 6A 00 48 36", gg.TYPE_BYTE)
        local results2 = gg.getResults(1)
        gg.clearResults()
        local script_by_sansxml = {}
        local count = 0
        if #results1 > 0 then
            count = count + 1
            script_by_sansxml[count] = {
                address = results1[1].address,
                value = 'h 20 00 80 D2 C0 03 5F D6',
                flags = gg.TYPE_QWORD
            }
        end
        if #results2 > 0 then
            count = count + 1
            script_by_sansxml[count] = {
                address = results2[1].address,
                value = 'h 20 00 80 D2 C0 03 5F D6',
                flags = gg.TYPE_QWORD
            }
        end
        if count > 0 then
            gg.setValues(script_by_sansxml)
            gg.toast("<[ 🌐 ]> MAPHACK ICON : ✅")
        else
            gg.toast("⚠️ Pattern not found")
        end
    end
end

function applyA1()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(":Report", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(":report", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(":reported", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.searchNumber(":disconnect", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.searchNumber(":disconnected", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.searchNumber(":Clear", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.searchNumber(":Logs", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber(":libcsharp", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.searchNumber(":libcsharp.so", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.searchNumber(":liblogic.so", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    
    gg.searchNumber(":liblogic", gg.TYPE_BYTE, false, gg.SIGN_EQUAL, 0, -1, 0)
    revert = gg.getResults(10000, nil, nil, nil, nil, nil, nil, nil, nil)
    gg.editAll("0", gg.TYPE_BYTE)
    gg.clearResults()
    gg.toast("🟢𝘈𝘤𝘵𝘪𝘷𝘢𝘵𝘦 𝘧𝘦𝘢𝘵𝘶𝘳𝘦𝘴")
end

function applyDroneViewGeneric_sansxml()
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS | gg.REGION_CODE_APP)
    gg.searchNumber("h FD 7B BE A9 F4 4F 01 A9 FD 03 00 91 B4 31 00 B0 F3 03 00 AA 88 E6 42 F9 C8 00 00 B4 E0 03 13 AA 00 01 3F D6 F4 4F 41 A9 FD 7B C2 A8 C0 03 5F D6", gg.TYPE_BYTE)
    local resultsCount = gg.getResultsCount()
    if resultsCount == 0 then
        gg.toast("⚠️ Pattern not found")
        return
    end
    local results = gg.getResults(1)
    gg.clearResults()
    if results[1] then
        local _address = results[1].address
        local script_by_sansxml = {}
        script_by_sansxml[1] = { address = _address + 0, value = '53000000h', flags = 4 }
        script_by_sansxml[2] = { address = _address + 4, value = '72A84B80h', flags = 4 }
        script_by_sansxml[3] = { address = _address + 8, value = '1E270000h', flags = 4 }
        script_by_sansxml[4] = { address = _address + 12, value = 'D65F03C0h', flags = 4 }
        gg.setValues(script_by_sansxml)
        gg.toast("<[ 🌐 ]> DRONE VIEWERS : ✅")
        gg.clearResults()
    end
end

function applyDroneViewAlt_sansxml(val1, val2, val3, val4, val5)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("1089806008;-1053839852;1089722122", 4)
    gg.refineNumber("1089806008", 4)
    gg.getResults(100)
    gg.editAll(val1, 4)
    gg.clearResults()
    gg.searchNumber(val1 .. ";-1053839852;1089722122", 4)
    gg.refineNumber("-1053839852", 4)
    gg.getResults(100)
    gg.editAll(val2, 4)
    gg.clearResults()
    gg.searchNumber(val1 .. ";" .. val2 .. ";1089722122", 4)
    gg.refineNumber("1089722122", 4)
    gg.getResults(100)
    gg.editAll(val3, 4)
    gg.clearResults()
    gg.searchNumber("-1057677640;-1057761526;1110143140", 4)
    gg.refineNumber("-1057677640", 4)
    gg.getResults(100)
    gg.editAll(val4, 4)
    gg.clearResults()
    gg.searchNumber(val4 .. ";-1057761526;1110143140", 4)
    gg.refineNumber("-1057761526", 4)
    gg.getResults(100)
    gg.editAll(val5, 4)
    gg.clearResults()
    gg.toast("<[ 🌐 ]> DRONE VIEWERS HORIZONTAL : ✅")
end

function applyDroneViewVertical_sansxml(val1, val2, val3, val4, val5)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("1089806008;-1053839852;1089722122", 4)
    gg.refineNumber("1089806008", 4)
    gg.getResults(100)
    gg.editAll(val1, 4)
    gg.clearResults()
    gg.searchNumber(val1 .. ";-1053839852;1089722122", 4)
    gg.refineNumber("-1053839852", 4)
    gg.getResults(100)
    gg.editAll(val2, 4)
    gg.clearResults()
    gg.searchNumber(val1 .. ";" .. val2 .. ";1089722122", 4)
    gg.refineNumber("1089722122", 4)
    gg.getResults(100)
    gg.editAll(val3, 4)
    gg.clearResults()
    gg.searchNumber("-1057677640;-1057761526;1110143140", 4)
    gg.refineNumber("-1057677640", 4)
    gg.getResults(100)
    gg.editAll(val4, 4)
    gg.clearResults()
    gg.searchNumber(val4 .. ";-1057761526;1110143140", 4)
    gg.refineNumber("-1057761526", 4)
    gg.getResults(100)
    gg.editAll(val5, 4)
    gg.clearResults()
    gg.toast("<[ 🌐 ]> DRONE VIEWERS VERTICAL : ✅")
end

function applyFixBodyInGrass_sansxml(enabled)
    if enabled then
        gg.clearResults()
        gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
        if gg.searchNumber("1.0;256.0;20.0:281", 16, false, 536870912, 0, -1, 0) then
            gg.refineNumber("1", 16, false, 536870912, 0, -1, 0)
            local results = gg.getResults(99)
            if #results > 0 then gg.editAll("0", 16) end
        end
        gg.clearResults()
        gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
        if gg.searchNumber("1.0F;0.46000000834F;0.30000001192F;0.20000000298F", 16, false, 536870912, 0, -1, 0) then
            gg.refineNumber("1", 16, false, 536870912, 0, -1, 0)
            local results = gg.getResults(9999)
            if #results > 0 then gg.editAll("0", 16) end
        end
        gg.clearResults()
        gg.toast("<[ 🌐 ]> FIX BODY IN GRASS : ✅")
    end
end

function applyWhiteBodyInGrass_sansxml(enabled)
    if enabled and not done_flags_sansxml.white_body then
        gg.clearResults()
        gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS)
        if gg.searchNumber("1.0;0.00019685877;0.00021969635:7465", 16, false, 536870912, 0, -1, 0) then
            gg.refineNumber("1", 16, false, 536870912, 0, -1, 0)
            local results = gg.getResults(1000)
            if #results > 0 then gg.editAll("9", 16) end
        end
        gg.clearResults()
        gg.toast("<[ 🌐 ]> WHITE BODY IN GRASS : ✅")
        done_flags_sansxml.white_body = true
    end
end

function applyClearBattleRecord_sansxml(enabled)
    if enabled and not done_flags_sansxml.clear_battle then
        gg.clearResults()
        gg.removeListItems(gg.getListItems())
        gg.setRanges(gg.REGION_C_ALLOC | gg.REGION_ANONYMOUS | gg.REGION_CODE_APP)
        collectgarbage("collect")
        local basePaths = { '/storage/emulated/0/Android/data', '/sdcard/Android/data' }
        for _, base in ipairs(basePaths) do
            os.rename(base..'/com.ludashi.superboost/virtual/0/com.mobile.legends/cache', base..'/com.ludashi.superboost/virtual/0/com.mobile.legends/clear_battle_sansxml')
            os.rename(base..'/com.ludashi.superboost/virtual/0/com.mobile.legends/files/UnityCache', base..'/com.ludashi.superboost/virtual/0/com.mobile.legends/files/clear_battle_sansxml')
            os.rename(base..'/com.ludashi.superboost/virtual/0/com.mobile.legends/files/dragon/BattleRecord', base..'/com.ludashi.superboost/virtual/0/com.mobile.legends/files/dragon/clear_battle_sansxml')
        end
        gg.toast("<[ 🌐 ]> CLEAR BATTLE RECORD : ✅")
        done_flags_sansxml.clear_battle = true
    end
end

function showAboutMe_sansxml()
    local message_sansxml = [[
╔═══════════════════════════════════╗
║ Syempe pogi ako 😁         
╠═══════════════════════════════════╣
║ someone asked me "aren't you afraid of 
  loneliness?" i'm not afraid of loneliness, i'm 
  just afraid i'm wasting my time on things that 
  don't belong to me.                                                                                
║             
║  --------------------------------------------------------------------------------------
║  💎UP COMING VIP SCRIPT.                             
╚═══════════════════════════════════╝]]
    gg.copyText("DNS : dns.adguard.com")
    gg.alert(message_sansxml, "ok")
end

-- ==========================================
-- ENGINE SYSTEM PROCEDURES
-- ==========================================
function xqmnb(Search, Modification)
   gg.clearResults()
   gg.setRanges(Search[1].memory)
   gg.searchNumber(Search[3].value, Search[3].type, false, 536870912, 0, -1)
   if gg.getResultCount() == 0 then
      gg.toast(Search[2].name..' Activation Failed')
      return false
   end
   local Result = gg.getResults(gg.getResultCount())
   local sum
   for index = 4, #Search do
      sum = 0
      for i = 1, #Result do
         if gg.getValues({{address = Result[i].address + Search[index].offset, flags = Search[index].type}})[1].value ~= Search[index].lv then
            Result[i].Usable = true
            sum = sum + 1
         end
      end
      if sum == #Result then
         gg.toast(Search[2].name..' Activation Failed')
         return false
      end
   end
   local Data, Freeze, Freezes = {}, {}, 0
   sum = 0
   for _, value in ipairs(Modification) do
      for i = 1, #Result do
         if not Result[i].Usable then
            local Value = {
               address = Result[i].address + value.offset, 
               flags = value.type, 
               value = value.value, 
               freeze = value.freeze
            }
            if value.freeze then
               Freeze[#Freeze + 1] = Value
               Freezes = Freezes + 1
            else
               Data[#Data + 1] = Value
            end
            sum = sum + 1
         end
      end
   end
   gg.setValues(Data)
   if #Freeze > 0 then
      gg.addListItems(Freeze)
   end
   if Freezes == 0 then
      gg.toast(Search[2].name..' Activated Successfully, modified '..sum..' entries')
   else
      gg.toast(Search[2].name..' Activated Successfully, modified '..sum..' entries, frozen '..Freezes..' entries')
   end
   gg.clearResults()
   return true
end

function ggClearEdit(searchVal, editVal)
    gg.clearResults()
    gg.setRanges(gg.REGION_ANONYMOUS)
    if searchVal ~= "" then
        gg.searchNumber(searchVal, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1)
    end
    gg.getResults(9999)
    gg.editAll(editVal, gg.TYPE_DWORD)
    gg.toast("Modification Successful")
end

loadYunLuaGroup("5C3C4E3813681C4C204C35346F1B4C2F7EFF612D2B22176FF346535E1C0B1E493339036EE15318")
function init()
	stab = _ENV["Tab Pages"]
	ttitle = _ENV["Title"]
	xfcpic = _ENV["Floating Icon"]
end

_ENV["Floating Icon"] = 'https://cccimg.com/view.php/ff4c4aeda0c9c991b7ba150d02a421e2.png'
_ENV["Title"] = 'ELGG - UI'

-- Modified Tab setups based on specifications
_ENV["Tab Pages"] = {
	'MAIN',
	'VISUAL',
	'DRONES',
	'Functions',
	'Settings',
}

init() 

uistart({ 
	{     
		-- Tab 1: MAIN
		CAtext('CREATOR RYUJI STATUS', '#00FF62', '14sp', true),
		CAtext('Supernatural Pop Assist', '#ffffff', '12sp', true),
		CAbutton('🤷 About Me Info', function() showAboutMe_sansxml() end),
		CAbutton('Select Process', function() gg.setProcessX() end),
		CAbutton('Chat Group 1048755465', function() gg.alert('Chat Group-1048755465') end, 0xff0062ff), 
		CAbutton('🛡️ Memory Bypass', function() applyA1() end),
		CAbutton('⚡ Clear Battle Record', function() applyClearBattleRecord_sansxml(true) end),
	}, 
	{ 
		-- Tab 2: VISUAL
		CAtext('-- Battle Maps & Models --', '#ffffff', '12sp', true),
		CAswitch("Maphack No Icon Anonymous", function() applyRadarMapSafe_sansxml(true) end, function() end),
		CAswitch("Maphack Icon Display", function() applyMapIcon_sansxml(true) end, function() end),
		CAswitch("Fix Body In Grass", function() applyFixBodyInGrass_sansxml(true) end, function() end),
		CAswitch("White Body In Grass", function() applyWhiteBodyInGrass_sansxml(true) end, function() end),
	}, 
	{ 
		-- Tab 3: DRONES
		CAtext('🚁 Drone Viewer Setup Options', '#ffffff', '12sp', true),
		CAbutton('Apply Base Drone Viewer Alternative', function() applyDroneViewGeneric_sansxml() end),
		
		CAtext('🎯 Drone Viewer Horizontal Range', '#005BFF', '11sp', true),
		CAbutton('Horizontal Level 1', function() applyDroneViewAlt_sansxml("1094506008", "-1048839852", "1094522122", "-1053577640", "-1054071526") end),
		CAbutton('Horizontal Level 2', function() applyDroneViewAlt_sansxml("1095506008", "-1047839852", "1095522122", "-1052577640", "-1053071526") end),
		CAbutton('Horizontal Level 3', function() applyDroneViewAlt_sansxml("1096506008", "-1046839852", "1096522122", "-1051577640", "-1052071526") end),
		CAbutton('Horizontal Level 4', function() applyDroneViewAlt_sansxml("1097506008", "-1045839852", "1097522122", "-1050577640", "-1051071526") end),
		CAbutton('Horizontal Level 5', function() applyDroneViewAlt_sansxml("1098506008", "-1044839852", "1098522122", "-1049577640", "-1050071526") end),
		
		CAtext('🌀 Drone Viewer Vertical Range', '#005BFF', '11sp', true),
		CAbutton('Vertical Level 1', function() applyDroneViewVertical_sansxml("1084806008", "-1057839852", "1084722122", "-1061677640", "-1061761526") end),
		CAbutton('Vertical Level 2', function() applyDroneViewVertical_sansxml("1086806008", "-1055839852", "1086722122", "-1059677640", "-1059761526") end),
		CAbutton('Vertical Level 3', function() applyDroneViewVertical_sansxml("1088806008", "-1053839852", "1088722122", "-1057677640", "-1057761526") end),
		CAbutton('Vertical Level 4', function() applyDroneViewVertical_sansxml("1080806008", "-1058839852", "1080722122", "-1063677640", "-1063761526") end),
		CAbutton('Vertical Level 5', function() applyDroneViewVertical_sansxml("1082806008", "-1056839852", "1082722122", "-1062677640", "-1062761526") end),
	}, 
	{ 
		-- Tab 4: Functions
		CAtext('-- Weapon Functions --', '#ffffff', '12sp', true),
		CAbutton('Remove Mahogany Sword Endlag - Once Per Match', function()
				local qmnb = {
					{['memory']=32},
					{['name']='Remove Mahogany Sword Endlag'},
					{['value']=0.7115384936332703, ['type']=16},
					{['lv']=3.0,['offset']=40, ['type']=16},
					{['lv']=0.821428656578064,['offset']=160, ['type']=16},
					{['lv']=3.0,['offset']=1280, ['type']=16},
				}
				local qmxg = {
					{['value']=9.999999796611898E-32,['offset']=-1388,['type']=16},
					{['value']=9.999999796611898E-32,['offset']=-1204,['type']=16},
					{['value']=4.5,['offset']=-992,['type']=16},
				}
				xqmnb(qmnb,qmxg)
			end),
		
		CAtext('-- In-Game Shop Shotgun Swap --', '#ffffff', '12sp', true),  
		CAswitch("Shotgun to Bear Shotgun", function() ggClearEdit('400005', '400002') end, function() ggClearEdit('400002', '400005') end),
		CA
