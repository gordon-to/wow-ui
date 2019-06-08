--------------------------------------------------------------------------------
--                        A L L   T H E   T H I N G S                         --
--------------------------------------------------------------------------------
--				Copyright 2017-2019 Dylan Fortune (Crieve-Sargeras)           --
--------------------------------------------------------------------------------
local app = AllTheThings;	-- Create a local (non global) reference
local L = app.L;

-- Performance Cache 
-- While this may seem silly, caching references to commonly used APIs is actually a performance gain...
local C_ArtifactUI_GetAppearanceInfoByID = C_ArtifactUI.GetAppearanceInfoByID; 
local C_MountJournal_GetMountInfoByID = C_MountJournal.GetMountInfoByID;
local C_MountJournal_GetMountInfoExtraByID = C_MountJournal.GetMountInfoExtraByID;
local C_TransmogCollection_GetAppearanceSourceInfo = C_TransmogCollection.GetAppearanceSourceInfo;
local C_TransmogCollection_GetAllAppearanceSources = C_TransmogCollection.GetAllAppearanceSources;
local C_TransmogCollection_GetIllusionSourceInfo = C_TransmogCollection.GetIllusionSourceInfo;
local C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance = C_TransmogCollection.PlayerHasTransmogItemModifiedAppearance;
local C_TransmogCollection_GetIllusions = C_TransmogCollection.GetIllusions;
local C_TransmogCollection_GetSourceInfo = C_TransmogCollection.GetSourceInfo;
local C_TransmogSets_GetSetInfo = C_TransmogSets.GetSetInfo;
local C_ToyBox_GetToyInfo = C_ToyBox.GetToyInfo;
local C_ToyBox_GetToyLink = C_ToyBox.GetToyLink;
local C_Map_GetMapDisplayInfo = C_Map.GetMapDisplayInfo;
local C_Map_GetBestMapForUnit = C_Map.GetBestMapForUnit;
local SetPortraitTexture = _G["SetPortraitTexture"];
local SetPortraitTextureFromDisplayID = _G["SetPortraitTextureFromCreatureDisplayID"];
local EJ_GetCreatureInfo = _G["EJ_GetCreatureInfo"];
local EJ_GetEncounterInfo = _G["EJ_GetEncounterInfo"];
local GetAchievementCriteriaInfo = _G["GetAchievementCriteriaInfo"];
local GetAchievementInfo = _G["GetAchievementInfo"];
local GetAchievementLink = _G["GetAchievementLink"];
local GetClassInfo = _G["GetClassInfo"];
local GetDifficultyInfo = _G["GetDifficultyInfo"];
local GetFactionInfoByID = _G["GetFactionInfoByID"];
local GetItemInfo = _G["GetItemInfo"];
local GetItemInfoInstant = _G["GetItemInfoInstant"];
local GetItemSpecInfo = _G["GetItemSpecInfo"];
local GetTitleName = _G["GetTitleName"];
local IsDressableItem = _G["IsDressableItem"];
local PlayerHasToy = _G["PlayerHasToy"];
local IsTitleKnown = _G["IsTitleKnown"];
local InCombatLockdown = _G["InCombatLockdown"];
local MAX_CREATURES_PER_ENCOUNTER = 9;
local DESCRIPTION_SEPARATOR = "`";

-- Coroutine Helper Functions
app.RawData = {};
app.refreshing = {};
local function OnUpdate(self)
	for i=#self.__stack,1,-1 do
		if not self.__stack[i][1](self) then
			table.remove(self.__stack, i);
			if #self.__stack < 1 then
				self:SetScript("OnUpdate", nil);
			end
		end
	end
end
local function Push(self, name, method)
	if not self.__stack then
		self.__stack = {};
		self:SetScript("OnUpdate", OnUpdate);
	elseif #self.__stack < 1 then 
		self:SetScript("OnUpdate", OnUpdate);
	end
	--print("Push->" .. name);
	table.insert(self.__stack, { method, name });
end
local function StartCoroutine(name, method)
	if method and not app.refreshing[name] then
		local instance = coroutine.create(method);
		app.refreshing[name] = true;
		Push(app, name, function()
			-- Check the status of the coroutine
			if instance and coroutine.status(instance) ~= "dead" then
				local ok, err = coroutine.resume(instance);
				if ok then return true;	-- This means more work is required.
				else
					-- Show the error. Returning nothing is the same as canceling the work.
					print(err);
				end
			end
			app.refreshing[name] = nil;
		end);
	end
end
local constructor = function(id, t, typeID)
	if not t then
		return { [typeID] = id };
	end
	if not t.g and t[1] then
		t = { ["g"] = t, [typeID] = id };
	else
		t[typeID] = id;
	end
	return t;
end
local contains = function(arr, value)
	for i,value2 in ipairs(arr) do
		if value2 == value then return true; end
	end
end
local containsAny = function(arr, otherArr)
	for i, v in ipairs(arr) do
		for j, w in ipairs(otherArr) do
			if v == w then return true; end
		end
	end
end
local containsValue = function(dict, value)
	for key,value2 in pairs(dict) do
		if value2 == value then return true; end
	end
end

-- Data Lib
local AllTheThingsTempData = {}; 	-- For temporary data.
local AllTheThingsAD = {};			-- For account-wide data.
local AllTheThingsPCD = {};			-- For character specific data.
local function SetDataMember(member, data)
	AllTheThingsAD[member] = data;
end
local function GetDataMember(member, default)
	if AllTheThingsAD[member] == nil then AllTheThingsAD[member] = default; end
	return AllTheThingsAD[member];
end
local function SetTempDataMember(member, data)
	AllTheThingsTempData[member] = data;
end
local function GetTempDataMember(member, default)
	if AllTheThingsTempData[member] == nil then AllTheThingsTempData[member] = default; end
	return AllTheThingsTempData[member];
end
local function SetPersonalDataMember(member, data)
	AllTheThingsPCD[member] = data;
end
local function GetPersonalDataMember(member, default)
	if AllTheThingsPCD[member] == nil then AllTheThingsPCD[member] = default; end
	return AllTheThingsPCD[member];
end
local function SetDataSubMember(member, submember, data)
	if AllTheThingsAD[member] then AllTheThingsAD[member][submember] = data; end
end
local function GetDataSubMember(member, submember, default)
	if not AllTheThingsAD[member] then AllTheThingsAD[member] = { }; end
	if AllTheThingsAD[member][submember] == nil then AllTheThingsAD[member][submember] = default; end
	return AllTheThingsAD[member][submember];
end
local function SetTempDataSubMember(member, submember, data)
	if AllTheThingsTempData[member] then
		AllTheThingsTempData[member][submember] = data;
	end
end
local function GetTempDataSubMember(member, submember, default)
	if AllTheThingsTempData[member] == nil then
		AllTheThingsTempData[member] = { };
	end
	if AllTheThingsTempData[member][submember] == nil then
		AllTheThingsTempData[member][submember] = default;
	end
	return AllTheThingsTempData[member][submember];
end
local function SetPersonalDataSubMember(member, submember, data)
	if AllTheThingsPCD[member] then AllTheThingsPCD[member][submember] = data; end
end
local function GetPersonalDataSubMember(member, submember, default)
	if not AllTheThingsPCD[member] then AllTheThingsPCD[member] = { }; end
	if AllTheThingsPCD[member][submember] == nil then AllTheThingsPCD[member][submember] = default; end
	return AllTheThingsPCD[member][submember];
end
local function SetDataSubSubMember(member, submember, subsubmember, data)
	if AllTheThingsAD[member] and AllTheThingsAD[member][submember] then AllTheThingsAD[member][submember][subsubmember] = data; end
end
local function GetDataSubSubMember(member, submember, subsubmember, default)
	if not AllTheThingsAD[member] then
		AllTheThingsAD[member] = 
		{
			[submember] = 
			{
				[subsubmember] = default;
			};
		};
		return default;
	else
		if not AllTheThingsAD[member][submember] then
			AllTheThingsAD[member][submember] = 
			{
				[subsubmember] = default;
			};
			return default;
		else
			if AllTheThingsAD[member][submember][subsubmember] == nil then
				AllTheThingsAD[member][submember][subsubmember] = default;
				return default;
			end
		end
	end
	return AllTheThingsAD[member][submember][subsubmember];
end
local function SetPersonalDataSubSubMember(member, submember, subsubmember, data)
	if AllTheThingsPCD[member] and AllTheThingsPCD[member][submember] then AllTheThingsPCD[member][submember][subsubmember] = data; end
end
local function GetPersonalDataSubSubMember(member, submember, subsubmember, default)
	if not AllTheThingsPCD[member] then
		AllTheThingsPCD[member] = 
		{
			[submember] = 
			{
				[subsubmember] = default;
			};
		};
		return default;
	else
		if not AllTheThingsPCD[member][submember] then
			AllTheThingsPCD[member][submember] = 
			{
				[subsubmember] = default;
			};
			return default;
		else
			if AllTheThingsPCD[member][submember][subsubmember] == nil then
				AllTheThingsPCD[member][submember][subsubmember] = default;
				return default;
			end
		end
	end
	return AllTheThingsPCD[member][submember][subsubmember];
end
local function SetTempDataSubSubMember(member, submember, subsubmember, data)
	if AllTheThingsTempData[member] and AllTheThingsTempData[member][submember] then AllTheThingsTempData[member][submember][subsubmember] = data; end
end
local function GetTempDataSubSubMember(member, submember, subsubmember, default)
	if not AllTheThingsTempData[member] then
		AllTheThingsTempData[member] = 
		{
			[submember] = 
			{
				[subsubmember] = default;
			};
		};
		return default;
	else
		if not AllTheThingsTempData[member][submember] then
			AllTheThingsTempData[member][submember] = 
			{
				[subsubmember] = default;
			};
			return default;
		else
			if AllTheThingsTempData[member][submember][subsubmember] == nil then
				AllTheThingsTempData[member][submember][subsubmember] = default;
				return default;
			end
		end
	end
	return AllTheThingsTempData[member][submember][subsubmember];
end
app.SetDataMember = SetDataMember;
app.GetDataMember = GetDataMember;
app.SetDataSubMember = SetDataSubMember;
app.GetDataSubMember = GetDataSubMember;
app.SetPersonalDataMember = SetPersonalDataMember;
app.GetPersonalDataMember = GetPersonalDataMember;
app.GetTempDataMember = GetTempDataMember;
app.GetTempDataSubMember = GetTempDataSubMember;

(function()
	-- Map all Skill IDs to the old Skill IDs
	local tradeSkillMap = {
		-- Alchemy Skills
		[171] = 171,	-- Alchemy [7.3.5]
		[2485] = 171,	-- Classic Alchemy [8.0.1]
		[2484] = 171,	-- Outland Alchemy [8.0.1]
		[2483] = 171,	-- Northrend Alchemy [8.0.1]
		[2482] = 171,	-- Cataclysm Alchemy [8.0.1]
		[2481] = 171,	-- Pandaria Alchemy [8.0.1]
		[2480] = 171,	-- Draenor Alchemy [8.0.1]
		[2479] = 171,	-- Legion Alchemy [8.0.1]
		[2478] = 171,	-- Kul Tiran Alchemy [8.0.1]
		
		-- Archaeology Skills
		[794] = 794,	-- Archaeology [7.3.5]
		
		-- Blacksmithing Skills
		[164] = 164,	-- Blacksmithing [7.3.5]
		[2477] = 164,	-- Classic Blacksmithing [8.0.1]
		[2476] = 164,	-- Outland Blacksmithing [8.0.1]
		[2475] = 164,	-- Northrend Blacksmithing [8.0.1]
		[2474] = 164,	-- Cataclysm Blacksmithing [8.0.1]
		[2473] = 164,	-- Pandaria Blacksmithing [8.0.1]
		[2472] = 164,	-- Draenor Blacksmithing [8.0.1]
		[2454] = 164,	-- Legion Blacksmithing [8.0.1]
		[2437] = 164,	-- Kul Tiran Blacksmithing [8.0.1]
		
		-- Cooking Skills
		[185] = 185,	-- Cooking [7.3.5]
		[975] = 185,	-- Way of the Grill
		[976] = 185,	-- Way of the Wok
		[977] = 185,	-- Way of the Pot
		[978] = 185,	-- Way of the Steamer
		[979] = 185,	-- Way of the Oven
		[980] = 185,	-- Way of the Brew
		[2548] = 185,	-- Classic Cooking [8.0.1]
		[2547] = 185,	-- Outland Cooking [8.0.1]
		[2546] = 185,	-- Northrend Cooking [8.0.1]
		[2545] = 185,	-- Cataclysm Cooking [8.0.1]
		[2544] = 185,	-- Pandaria Cooking [8.0.1]
		[2543] = 185,	-- Draenor Cooking [8.0.1]
		[2542] = 185,	-- Legion Cooking [8.0.1]
		[2541] = 185,	-- Kul Tiran Cooking [8.0.1]
		
		-- Enchanting Skills
		[333] = 333,	-- Enchanting [7.3.5]
		[2494] = 333,	-- Classic Enchanting [8.0.1]
		[2493] = 333,	-- Outland Enchanting [8.0.1]
		[2492] = 333,	-- Northrend Enchanting [8.0.1]
		[2491] = 333,	-- Cataclysm Enchanting [8.0.1]
		[2489] = 333,	-- Pandaria Enchanting [8.0.1]
		[2488] = 333,	-- Draenor Enchanting [8.0.1]
		[2487] = 333,	-- Legion Enchanting [8.0.1]
		[2486] = 333,	-- Kul Tiran Enchanting [8.0.1]
		
		-- Engineering Skills
		[202] = 202,	-- Engineering [7.3.5]
		[2506] = 202,	-- Classic Engineering [8.0.1]
		[2505] = 202,	-- Outland Engineering [8.0.1]
		[2504] = 202,	-- Northrend Engineering [8.0.1]
		[2503] = 202,	-- Cataclysm Engineering [8.0.1]
		[2502] = 202,	-- Pandaria Engineering [8.0.1]
		[2501] = 202,	-- Draenor Engineering [8.0.1]
		[2500] = 202,	-- Legion Engineering [8.0.1]
		[2499] = 202,	-- Kul Tiran Engineering [8.0.1]
		
		-- First Aid Skills
		[129] = 129,	-- First Aid [7.3.5] [REMOVED FROM GAME]
		
		-- Fishing Skills
		[356] = 356,	-- Fishing [7.3.5]
		[2592] = 356,	-- Classic Fishing [8.0.1]
		[2591] = 356,	-- Outland Fishing [8.0.1]
		[2590] = 356,	-- Northrend Fishing [8.0.1]
		[2589] = 356,	-- Cataclysm Fishing [8.0.1]
		[2588] = 356,	-- Pandaria Fishing [8.0.1]
		[2587] = 356,	-- Draenor Fishing [8.0.1]
		[2586] = 356,	-- Legion Fishing [8.0.1]
		[2585] = 356,	-- Kul Tiran Fishing [8.0.1]
		
		-- Herbalism Skills
		[182] = 182,	-- Herbalism [7.3.5]
		[2556] = 182,	-- Classic Herbalism [8.0.1]
		[2555] = 182,	-- Outland Herbalism [8.0.1]
		[2554] = 182,	-- Northrend Herbalism [8.0.1]
		[2553] = 182,	-- Cataclysm Herbalism [8.0.1]
		[2552] = 182,	-- Pandaria Herbalism [8.0.1]
		[2551] = 182,	-- Draenor Herbalism [8.0.1]
		[2550] = 182,	-- Legion Herbalism [8.0.1]
		[2549] = 182,	-- Kul Tiran Herbalism [8.0.1]
		
		-- Inscription Skills
		[773] = 773,	-- Inscription [7.3.5]
		[2514] = 773,	-- Classic Inscription [8.0.1]
		[2513] = 773,	-- Outland Inscription [8.0.1]
		[2512] = 773,	-- Northrend Inscription [8.0.1]
		[2511] = 773,	-- Cataclysm Inscription [8.0.1]
		[2510] = 773,	-- Pandaria Inscription [8.0.1]
		[2509] = 773,	-- Draenor Inscription [8.0.1]
		[2508] = 773,	-- Legion Inscription [8.0.1]
		[2507] = 773,	-- Kul Tiran Inscription [8.0.1]
		
		-- Jewelcrafting Skills
		[755] = 755,	-- Jewelcrafting [7.3.5]
		[2524] = 755,	-- Classic Jewelcrafting [8.0.1]
		[2523] = 755,	-- Outland Jewelcrafting [8.0.1]
		[2522] = 755,	-- Northrend Jewelcrafting [8.0.1]
		[2521] = 755,	-- Cataclysm Jewelcrafting [8.0.1]
		[2520] = 755,	-- Pandaria Jewelcrafting [8.0.1]
		[2519] = 755,	-- Draenor Jewelcrafting [8.0.1]
		[2518] = 755,	-- Legion Jewelcrafting [8.0.1]
		[2517] = 755,	-- Kul Tiran Jewelcrafting [8.0.1]
		
		-- Leatherworking Skills
		[165] = 165,	-- Leatherworking [7.3.5]
		[2532] = 165,	-- Classic Leatherworking [8.0.1]
		[2531] = 165,	-- Outland Leatherworking [8.0.1]
		[2530] = 165,	-- Northrend Leatherworking [8.0.1]
		[2529] = 165,	-- Cataclysm Leatherworking [8.0.1]
		[2528] = 165,	-- Pandaria Leatherworking [8.0.1]
		[2527] = 165,	-- Draenor Leatherworking [8.0.1]
		[2526] = 165,	-- Legion Leatherworking [8.0.1]
		[2525] = 165,	-- Kul Tiran Leatherworking [8.0.1]
		
		-- Mining Skills
		[186] = 186,	-- Mining [7.3.5]
		[2572] = 186,	-- Classic Mining [8.0.1]
		[2571] = 186,	-- Outland Mining [8.0.1]
		[2570] = 186,	-- Northrend Mining [8.0.1]
		[2569] = 186,	-- Cataclysm Mining [8.0.1]
		[2568] = 186,	-- Pandaria Mining [8.0.1]
		[2567] = 186,	-- Draenor Mining [8.0.1]
		[2566] = 186,	-- Legion Mining [8.0.1]
		[2565] = 186,	-- Kul Tiran Mining [8.0.1]
		
		-- Skinning Skills
		[393] = 393,	-- Skinning [7.3.5]
		[2564] = 393,	-- Classic Skinning [8.0.1]
		[2563] = 393,	-- Outland Skinning [8.0.1]
		[2562] = 393,	-- Northrend Skinning [8.0.1]
		[2561] = 393,	-- Cataclysm Skinning [8.0.1]
		[2560] = 393,	-- Pandaria Skinning [8.0.1]
		[2559] = 393,	-- Draenor Skinning [8.0.1]
		[2558] = 393,	-- Legion Skinning [8.0.1]
		[2557] = 393,	-- Kul Tiran Skinning [8.0.1]
		
		-- Tailoring Skills
		[197] = 197,	-- Tailoring [7.3.5]
		[2540] = 197,	-- Classic Tailoring [8.0.1]
		[2539] = 197,	-- Outland Tailoring [8.0.1]
		[2538] = 197,	-- Northrend Tailoring [8.0.1]
		[2537] = 197,	-- Cataclysm Tailoring [8.0.1]
		[2536] = 197,	-- Pandaria Tailoring [8.0.1]
		[2535] = 197,	-- Draenor Tailoring [8.0.1]
		[2534] = 197,	-- Legion Tailoring [8.0.1]
		[2533] = 197,	-- Kul Tiran Tailoring [8.0.1]
	};
	app.GetBaseTradeSkillID = function(skillID)
		return tradeSkillMap[skillID] or skillID;
	end
	app.GetTradeSkillLine = function()
		return app.GetBaseTradeSkillID(C_TradeSkillUI.GetTradeSkillLine());
	end
	app.GetTradeSkillCache = function(invalidate)
		local cache = GetTempDataMember("PROFESSION_CACHE");
		if not cache or invalidate then
			cache = {};
			SetTempDataMember("PROFESSION_CACHE", cache);
			local prof1, prof2, archaeology, fishing, cooking, firstAid = GetProfessions();
			for i,j in ipairs({prof1 or 0, prof2 or 0, archaeology or 0, fishing or 0, cooking or 0, firstAid or 0}) do
				if j ~= 0 then cache[app.GetBaseTradeSkillID(select(7, GetProfessionInfo(j)))] = true; end
			end
		end
		return cache;
	end
end)();

local backdrop = {
	bgFile = "Interface/Tooltips/UI-Tooltip-Background", 
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border", 
	tile = true, tileSize = 16, edgeSize = 16, 
	insets = { left = 4, right = 4, top = 4, bottom = 4 }
};

-- Game Tooltip Icon
local GameTooltipIcon = CreateFrame("FRAME", nil, GameTooltip);
GameTooltipIcon:SetPoint("TOPRIGHT", GameTooltip, "TOPLEFT", 0, 0);
GameTooltipIcon:SetSize(72, 72);
GameTooltipIcon.icon = GameTooltipIcon:CreateTexture(nil, "ARTWORK");
GameTooltipIcon.icon:SetAllPoints(GameTooltipIcon);
GameTooltipIcon.icon:Show();
GameTooltipIcon.icon.Background = GameTooltipIcon:CreateTexture(nil, "BACKGROUND");
GameTooltipIcon.icon.Background:SetAllPoints(GameTooltipIcon);
GameTooltipIcon.icon.Background:Show();
GameTooltipIcon.icon.Border = GameTooltipIcon:CreateTexture(nil, "BORDER");
GameTooltipIcon.icon.Border:SetAllPoints(GameTooltipIcon);
GameTooltipIcon.icon.Border:Show();
GameTooltipIcon:Hide();

-- Model is used to display the model of an NPC/Encounter.
local GameTooltipModel, model, fi = CreateFrame("FRAME", "ATTGameTooltipModel", GameTooltip);
GameTooltipModel:SetPoint("TOPRIGHT", GameTooltip, "TOPLEFT", 0, 0);
GameTooltipModel:SetSize(128, 128);
GameTooltipModel:SetBackdrop(backdrop);
GameTooltipModel:SetBackdropBorderColor(1, 1, 1, 1);
GameTooltipModel:SetBackdropColor(0, 0, 0, 1);
GameTooltipModel.Models = {};
GameTooltipModel.Model = CreateFrame("DressUpModel", nil, GameTooltipModel);
GameTooltipModel.Model:SetPoint("TOPLEFT", GameTooltipModel ,"TOPLEFT", 4, -4)
GameTooltipModel.Model:SetPoint("BOTTOMRIGHT", GameTooltipModel ,"BOTTOMRIGHT", -4, 4)
GameTooltipModel.Model:SetFacing(MODELFRAME_DEFAULT_ROTATION);
GameTooltipModel.Model:SetScript("OnUpdate", function(self, elapsed)
	self:SetFacing(self:GetFacing() + elapsed);
end);
GameTooltipModel.Model:Hide();

for i=1,MAX_CREATURES_PER_ENCOUNTER do
	model = CreateFrame("DressUpModel", "ATTGameTooltipModel" .. i, GameTooltipModel);
	model:SetPoint("TOPLEFT", GameTooltipModel ,"TOPLEFT", 4, -4);
	model:SetPoint("BOTTOMRIGHT", GameTooltipModel ,"BOTTOMRIGHT", -4, 4);
	model:SetCamDistanceScale(1.7);
	model:SetDisplayInfo(987);
	model:SetFacing(MODELFRAME_DEFAULT_ROTATION);
	fi = math.floor(i / 2);
	model:SetPosition(fi * -0.1, (fi * (i % 2 == 0 and -1 or 1)) * ((MAX_CREATURES_PER_ENCOUNTER - i) * 0.1), fi * 0.2 - 0.3);
	model:SetDepth(i);
	model:Hide();
	tinsert(GameTooltipModel.Models, model);
end
GameTooltipModel.HideAllModels = function(self)
	for i=1,MAX_CREATURES_PER_ENCOUNTER do
		GameTooltipModel.Models[i]:Hide();
	end
	GameTooltipModel.Model:Hide();
end
GameTooltipModel.SetCreatureID = function(self, creatureID)
	GameTooltipModel.HideAllModels(self);
	if creatureID > 0 then
		self.Model:SetUnit("none");
		self.Model:SetCreature(creatureID);
		if not self.Model:GetModelFileID() then
			Push(app, "SetCreatureID", function()
				if self.lastModel == creatureID then
					self:SetCreatureID(creatureID);
				end
			end);
		end
	end
	self:Show();
end
GameTooltipModel.TrySetDisplayInfos = function(self, reference, displayInfos)
	if displayInfos then
		local rotation = reference.modelRotation and ((reference.modelRotation * math.pi) / 180) or MODELFRAME_DEFAULT_ROTATION;
		local scale = reference.modelScale or 1;
		local count = #displayInfos;
		if count > 1 then
			count = math.min(count, MAX_CREATURES_PER_ENCOUNTER);
			local ratio = count / MAX_CREATURES_PER_ENCOUNTER;
			if count < 3 then
				for i=1,count do
					model = self.Models[i];
					model:SetDisplayInfo(displayInfos[i]);
					model:SetCamDistanceScale(scale);
					model:SetFacing(rotation);
					model:SetPosition(0, (i % 2 == 0 and 0.5 or -0.5), 0);
					model:Show();
				end
			else
				scale = (1 + (ratio * 0.5)) * scale;
				for i=1,count do
					model = self.Models[i];
					model:SetDisplayInfo(displayInfos[i]);
					model:SetCamDistanceScale(scale);
					model:SetFacing(rotation);
					fi = math.floor(i / 2);
					model:SetPosition(fi * -0.1, (fi * (i % 2 == 0 and -1 or 1)) * ((MAX_CREATURES_PER_ENCOUNTER - i) * 0.1), fi * 0.2 - (ratio * 0.15));
					model:Show();
				end
			end
		else
			self.Model:SetFacing(rotation);
			self.Model:SetCamDistanceScale(scale);
			self.Model:SetDisplayInfo(displayInfos[1]);
			self.Model:Show();
		end
		self:Show();
		return true;
	end
end
GameTooltipModel.TrySetModel = function(self, reference)
	GameTooltipModel.HideAllModels(self);
	if app.Settings:GetTooltipSetting("Models") then
		self.lastModel = reference;
		local displayInfos = reference.displayInfo;
		if GameTooltipModel.TrySetDisplayInfos(self, reference, displayInfos) then
			return true;
		elseif reference.qgs then
			if #reference.qgs > 1 then
				displayInfos = {};
				local markedKeys = {};
				for i,creatureID in ipairs(reference.qgs) do
					local displayID = app.NPCDB[creatureID];
					if displayID and not markedKeys[displayID] then
						tinsert(displayInfos, displayID);
						markedKeys[displayID] = 1;
					end
				end
				if GameTooltipModel.TrySetDisplayInfos(self, reference, displayInfos) then
					return true;
				end
			else
				local displayID = app.NPCDB[reference.qgs[1]];
				if displayID then
					self.Model:SetFacing(reference.modelRotation and ((reference.modelRotation * math.pi) / 180) or MODELFRAME_DEFAULT_ROTATION);
					self.Model:SetCamDistanceScale(reference.modelScale or 1);
					self.Model:SetDisplayInfo(displayID);
					self.Model:Show();
					self:Show();
					return true;
				end
			end
		end
		
		if reference.displayID then
			self.Model:SetFacing(reference.modelRotation and ((reference.modelRotation * math.pi) / 180) or MODELFRAME_DEFAULT_ROTATION);
			self.Model:SetCamDistanceScale(reference.modelScale or 1);
			self.Model:SetDisplayInfo(reference.displayID);
			self.Model:Show();
			self:Show();
			return true;
		elseif reference.modelID then
			self.Model:SetFacing(reference.modelRotation and ((reference.modelRotation * math.pi) / 180) or MODELFRAME_DEFAULT_ROTATION);
			self.Model:SetCamDistanceScale(reference.modelScale or 1);
			self.Model:SetDisplayInfo(reference.modelID);
			self.Model:Show();
			self:Show();
			return true;
		elseif reference.unit and not reference.icon then
			self.Model:SetFacing(reference.modelRotation and ((reference.modelRotation * math.pi) / 180) or MODELFRAME_DEFAULT_ROTATION);
			self.Model:SetCamDistanceScale(reference.modelScale or 1);
			self.Model:SetUnit(reference.unit);
			self.Model:Show();
			self:Show();
		end
		
		local s = reference.s;
		if s then
			if reference.artifactID then
				-- Okay, fine.
			elseif reference.g and #reference.g > 0 then
				local npc = reference.g[1];
				if npc and npc.npcID and npc.npcID <= -5200 and npc.npcID >= -5206 then
					-- Okay, we're good.
				else
					s = nil;
				end
			else
				s = nil;
			end
		end
		
		if s then
			local categoryID, appearanceID = C_TransmogCollection_GetAppearanceSourceInfo(s);
			if appearanceID then
				self.Model:SetCamDistanceScale(0.8);
				self.Model:SetItemAppearance(appearanceID);
				self.Model:Show();
				self:Show();
				return true;
			end
		end
		
		if reference.model then
			self.Model:SetFacing(reference.modelRotation and ((reference.modelRotation * math.pi) / 180) or MODELFRAME_DEFAULT_ROTATION);
			self.Model:SetCamDistanceScale(reference.modelScale or 1);
			self.Model:SetUnit("none");
			self.Model:SetModel(reference.model);
			self.Model:Show();
			self:Show();
			return true;
		elseif reference.creatureID and reference.creatureID > 0 then
			self.Model:SetFacing(reference.modelRotation and ((reference.modelRotation * math.pi) / 180) or MODELFRAME_DEFAULT_ROTATION);
			self.Model:SetCamDistanceScale(reference.modelScale or 1);
			self:SetCreatureID(reference.creatureID);
			self.Model:Show();
			return true;
		end
		if reference.atlas then
			GameTooltipIcon:SetSize(64,64);
			GameTooltipIcon.icon:SetAtlas(reference.atlas);
			GameTooltipIcon:Show();
			if reference["atlas-background"] then
				GameTooltipIcon.icon.Background:SetAtlas(reference["atlas-background"]);
				GameTooltipIcon.icon.Background:Show();
			end
			if reference["atlas-border"] then
				GameTooltipIcon.icon.Border:SetAtlas(reference["atlas-border"]);
				GameTooltipIcon.icon.Border:Show();
				if reference["atlas-color"] then
					local swatches = reference["atlas-color"];
					GameTooltipIcon.icon.Border:SetVertexColor(swatches[1], swatches[2], swatches[3], swatches[4] or 1.0);
				else
					GameTooltipIcon.icon.Border:SetVertexColor(1, 1, 1, 1.0);
				end
			end
			return true;
		end
	end
end
GameTooltipModel:Hide();

app.yell = function(msg)
	UIErrorsFrame:AddMessage(msg or "nil", 1, 0, 0);
	app:PlayRemoveSound();
end
app.print = function(...)
	print(L["TITLE"], ...);
end

-- audio lib
local lastPlayedFanfare;
function app:PlayCompleteSound()
	if app.Settings:GetTooltipSetting("Celebrate") then
		-- Play a random complete sound
		local t = app.Settings.AUDIO_COMPLETE_TABLE;
		if t and type(t) == "table" then
			local id = math.random(1, #t);
			if t[id] then PlaySoundFile(t[id], "master"); end
		end
	end
end
function app:PlayFanfare()
	if app.Settings:GetTooltipSetting("Celebrate") then
		-- Don't spam the users. It's nice sometimes, but let's put a delay of at least 1 second on there.
		local now = time();
		if lastPlayedFanfare and (now - lastPlayedFanfare) < 1 then return nil; end
		lastPlayedFanfare = now;
		
		-- Play a random fanfare
		local t = app.Settings.AUDIO_FANFARE_TABLE;
		if t and type(t) == "table" then
			local id = math.random(1, #t);
			if t[id] then PlaySoundFile(t[id], "master"); end
		end
	end
end
function app:PlayRareFindSound()
	if app.Settings:GetTooltipSetting("Celebrate") then
		-- Play a random rarefind sound
		local t = app.Settings.AUDIO_RAREFIND_TABLE;
		if t and type(t) == "table" then
			local id = math.random(1, #t);
			if t[id] then PlaySoundFile(t[id], "master"); end
		end
	end
end
function app:PlayRemoveSound()
	if app.Settings:GetTooltipSetting("Warn:Removed") then
		-- Play a random fanfare
		local t = app.Settings.AUDIO_REMOVE_TABLE;
		if t and type(t) == "table" then
			local id = math.random(1, #t);
			if t[id] then PlaySoundFile(t[id], "master"); end
		end
	end
end

-- Color Lib
local CS = CreateFrame("ColorSelect", nil, app);
local function Colorize(str, color)
	return "|c" .. color .. str .. "|r";
end
local function HexToARGB(hex)
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6)), tonumber("0x"..hex:sub(7,8));
end
local function HexToRGB(hex)
	return tonumber("0x"..hex:sub(1,2)), tonumber("0x"..hex:sub(3,4)), tonumber("0x"..hex:sub(5,6));
end
local function RGBToHex(r, g, b)
	return string.format("ff%02x%02x%02x", 
		r <= 255 and r >= 0 and r or 0, 
		g <= 255 and g >= 0 and g or 0, 
		b <= 255 and b >= 0 and b or 0);
end
local function ConvertColorRgbToHsv(r, g, b)
  CS:SetColorRGB(r, g, b);
  local h,s,v = CS:GetColorHSV()
  return {h=h,s=s,v=v}
end
local red, green = ConvertColorRgbToHsv(1,0,0), ConvertColorRgbToHsv(0,1,0);
local progress_colors = setmetatable({[1] = "ff15abff"}, {
	__index = function(t, p)
		local h;
		p = tonumber(p);
		if abs(red.h - green.h) > 180 then
			local angle = (360 - abs(red.h - green.h)) * p;
			if red.h < green.h then
				h = floor(red.h - angle);
				if h < 0 then h = 360 + h end
			else
				h = floor(red.h + angle);
				if h > 360 then h = h - 360 end
			end
		else
			h = floor(red.h-(red.h-green.h)*p)
		end
		CS:SetColorHSV(h, red.s-(red.s-green.s)*p, red.v-(red.v-green.v)*p);
		local r,g,b = CS:GetColorRGB();
		local color = RGBToHex(r * 255, g * 255, b * 255);
		rawset(t, p, color);
		return color;
	end
});
local function GetNumberWithZeros(number, desiredLength)
	if desiredLength > 0 then
		local str = tostring(number);
		local length = string.len(str);
		local pos = string.find(str,"[.]");
		if not pos then
			str = str .. ".";
			for i=desiredLength,1,-1 do
				str = str .. "0";
			end
		else
			local totalExtra = desiredLength - (length - pos);
			for i=totalExtra,1,-1 do
				str = str .. "0";
			end
			if totalExtra < 1 then
				str = string.sub(str, 1, pos + desiredLength);
			end
		end
		return str;
	else
		return tostring(floor(number));
	end
end
local function GetProgressColor(p)
	return progress_colors[p];
end
local function GetProgressColorText(progress, total)
	if total and total > 0 then
		local percent = progress / total;
		return "|c" .. GetProgressColor(percent) .. tostring(progress) .. " / " .. tostring(total) .. " (" .. GetNumberWithZeros(percent * 100, app.Settings:GetTooltipSetting("Precision")) .. "%) |r";
	end
end
local function GetCollectionIcon(state)
	return L[(state and (state == 2 and "COLLECTED_APPEARANCE_ICON" or "COLLECTED_ICON")) or "NOT_COLLECTED_ICON"];
end
local function GetCollectionText(state)
	return L[(state and (state == 2 and "COLLECTED_APPEARANCE" or "COLLECTED")) or "NOT_COLLECTED"];
end
local function GetCompletionIcon(state)
	return L[state and "COMPLETE_ICON" or "NOT_COLLECTED_ICON"];
end
local function GetCompletionText(state)
	return L[state and "COMPLETE" or "INCOMPLETE"];
end
local function GetProgressTextForRow(data)
	if data.total and (data.total > 1 or (data.total > 0 and not data.collectible)) then
		return GetProgressColorText(data.progress or 0, data.total);
	elseif data.collectible then
		return GetCollectionIcon(data.collected);
	elseif data.trackable then
		return GetCompletionIcon(data.saved);
	end
end
local function GetProgressTextForTooltip(data)
	if data.total and (data.total > 1 or (data.total > 0 and not data.collectible)) then
		return GetProgressColorText(data.progress or 0, data.total);
	elseif data.collectible then
		return GetCollectionText(data.collected);
	elseif data.trackable then
		return GetCompletionText(data.saved);
	end
end
CS:Hide();

-- Source ID Harvesting Lib
local DressUpModel = CreateFrame('DressUpModel');
local NPCModelHarvester = CreateFrame('DressUpModel', nil, OffScreenFrame);
local inventorySlotsMap = {	-- Taken directly from CanIMogIt (Thanks!)
    ["INVTYPE_HEAD"] = {1},
	["INVTYPE_NECK"] = {2},
    ["INVTYPE_SHOULDER"] = {3},
    ["INVTYPE_BODY"] = {4},
    ["INVTYPE_CHEST"] = {5},
    ["INVTYPE_ROBE"] = {5},
    ["INVTYPE_WAIST"] = {6},
    ["INVTYPE_LEGS"] = {7},
    ["INVTYPE_FEET"] = {8},
    ["INVTYPE_WRIST"] = {9},
    ["INVTYPE_HAND"] = {10},
	["INVTYPE_RING"] = {11},
	["INVTYPE_TRINKET"] = {12},
    ["INVTYPE_CLOAK"] = {15},
    ["INVTYPE_WEAPON"] = {16, 17},
    ["INVTYPE_SHIELD"] = {17},
    ["INVTYPE_2HWEAPON"] = {16, 17},
    ["INVTYPE_WEAPONMAINHAND"] = {16},
    ["INVTYPE_RANGED"] = {16},
    ["INVTYPE_RANGEDRIGHT"] = {16},
    ["INVTYPE_WEAPONOFFHAND"] = {17},
    ["INVTYPE_HOLDABLE"] = {17},
    ["INVTYPE_TABARD"] = {19},
};
local function BuildGroups(parent, g)
	if g then
		-- Iterate through the groups
		for key, group in ipairs(g) do
			-- Set the group's parent
			group.parent = parent;
			
			-- Build the groups
			BuildGroups(group, group.g);
		end
	end
end
local function BuildSourceText(group, l)
	if group.parent then
		if l < 1 then
			if group.dr then
				return BuildSourceText(group.parent, l + 1) .. DESCRIPTION_SEPARATOR .. "|c" .. GetProgressColor(group.dr * 0.01) .. tostring(group.dr) .. "%|r";
			else
				return BuildSourceText(group.parent, l + 1);
			end
		else
			return BuildSourceText(group.parent, l + 1) .. " -> " .. (group.text or "*");
		end
	end
	return group.text or "*";
end
local function BuildSourceTextForChat(group, l)
	if group.parent then
		if l < 1 then
			if group.dr then
				return BuildSourceTextForChat(group.parent, l + 1) .. DESCRIPTION_SEPARATOR .. "|c" .. GetProgressColor(group.dr * 0.01) .. tostring(group.dr) .. "%|r";
			else
				return BuildSourceTextForChat(group.parent, l + 1);
			end
		else
			return BuildSourceTextForChat(group.parent, l + 1) .. " -> " .. (group.text or "*");
		end
		return group.text or "*";
	end
	return "ATT";
end
local function BuildSourceTextForTSM(group, l)
	if group.parent then
		if l < 1 or not group.text then
			return BuildSourceTextForTSM(group.parent, l + 1);
		else
			return BuildSourceTextForTSM(group.parent, l + 1) .. "`" .. group.text;
		end
	end
	return L["TITLE"];
end
local function CloneData(data)
	local clone = setmetatable({}, { __index = data });
	if data.g then
		clone.g = {};
		for i,group in ipairs(data.g) do
			local child = CloneData(group);
			child.parent = clone;
			tinsert(clone.g, child);
		end
	end
	return clone;
end
local function GetSourceID(itemLink, itemID)
    if IsDressableItem(itemLink) then
		-- Updated function courtesy of CanIMogIt, Thanks AmiYuy and Team! :D
		local sourceID = select(2, C_TransmogCollection.GetItemInfo(itemLink));
		if sourceID then return sourceID, true; end
		
		local itemID, _, _, slotName = GetItemInfoInstant(itemLink);
		if slotName then
			local slots = inventorySlotsMap[slotName];
			if slots then
				DressUpModel:SetUnit('player');
				DressUpModel:Undress();
				for i, slot in pairs(slots) do
					DressUpModel:TryOn(itemLink, slot);
					local sourceID = DressUpModel:GetSlotTransmogSources(slot);
					if sourceID and sourceID ~= 0 then
						-- Added 5/4/2018 - Account for DressUpModel lag... sigh
						local sourceItemLink = select(6, C_TransmogCollection.GetAppearanceSourceInfo(sourceID));
						if sourceItemLink and tonumber(sourceItemLink:match("item:(%d+)")) == itemID then
							return sourceID, true;
						end
					end
				end
			end
		end
		return nil, true;
	end
	return nil, false;
end
app.IsComplete = function(o)
	if o.total then return o.total == o.progress; end
	if o.collectible then return o.collected; end
	if o.trackable then return o.saved; end
end
app.GetSourceID = GetSourceID;
app.MaximumItemInfoRetries = 400;
local function GetDisplayID(data)
	if data.displayID then
		return data.displayID;
	elseif data.creatureID then
		local displayID = app.NPCDB[data.creatureID];
		if displayID then
			return displayID;
		end
	end
	
	if data.qgs and #data.qgs > 0 then
		return app.NPCDB[data.qgs[1]];
	end
end
local function SetPortraitIcon(self, data, x)
	self.lastData = data;
	local displayID = GetDisplayID(data);
	if displayID then
		SetPortraitTextureFromDisplayID(self, displayID);
		self:SetWidth(self:GetHeight());
		self:SetTexCoord(0, 1, 0, 1);
		return true;
	elseif data.unit and not data.icon then
		SetPortraitTexture(self, data.unit);
		self:SetWidth(self:GetHeight());
		self:SetTexCoord(0, 1, 0, 1);
		return true;
	end
	
	-- Fallback to a traditional icon.
	if data.atlas then
		self:SetAtlas(data.atlas);
		self:SetWidth(self:GetHeight());
		self:SetTexCoord(0, 1, 0, 1);
		if data["atlas-background"] then
			self.Background:SetAtlas(data["atlas-background"]);
			self.Background:SetWidth(self:GetHeight());
			self.Background:Show();
		end
		if data["atlas-border"] then
			self.Border:SetAtlas(data["atlas-border"]);
			self.Border:SetWidth(self:GetHeight());
			self.Border:Show();
			if data["atlas-color"] then
				local swatches = data["atlas-color"];
				self.Border:SetVertexColor(swatches[1], swatches[2], swatches[3], swatches[4] or 1.0);
			else
				self.Border:SetVertexColor(1, 1, 1, 1.0);
			end
		end
		return true;
	elseif data.icon then
		self:SetWidth(self:GetHeight());
		self:SetTexture(data.icon);
		local texcoord = data.texcoord;
		if texcoord then
			self:SetTexCoord(texcoord[1], texcoord[2], texcoord[3], texcoord[4]);
		else
			self:SetTexCoord(0, 1, 0, 1);
		end
		return true;
	end
end
local function GetRelativeDifficulty(group, difficultyID)
	if group then
		if group.difficultyID then
			if group.difficultyID == difficultyID then
				return true;
			end
			if group.difficulties then
				for i, difficulty in ipairs(group.difficulties) do
					if difficulty == difficultyID then
						return true;
					end
				end
			end
			return false;
		end
		if group.parent then
			return GetRelativeDifficulty(group.parent, difficultyID);
		else
			return true;
		end
	end
end
local function GetRelativeMap(group, currentMapID)
	if group then
		if group.mapID then return group.mapID; end
		if group.maps then
			if contains(group.maps, currentMapID) then
				return currentMapID;
			else
				return group.maps[1];
			end
		end
		if group.parent then return GetRelativeMap(group.parent, currentMapID); end
	end
	return currentMapID;
end
local function GetRelativeField(group, field, value)
	if group then
		if group[field] then
			if group[field] == value then
				return true;
			end
		end
		if group.parent then return GetRelativeField(group.parent, field, value); end
	end
end
local function GetRelativeValue(group, field)
	if group then
		if group[field] then return group[field]; end
		if group.parent then return GetRelativeValue(group.parent, field); end
	end
end

-- Quest Completion Lib
local DirtyQuests = {};
local CompletedQuests = setmetatable({}, {__newindex = function (t, key, value)
	DirtyQuests[key] = true;
	rawset(t, key, value);
	
	if app.Settings:GetTooltipSetting("Report:CompletedQuests") then
		local searchResults = app.SearchForField("questID", key);
		if searchResults and #searchResults > 0 then
			if app.Settings:GetTooltipSetting("Report:UnsortedQuests") then
				return true;
			end
		else
			key = key .. " (Missing in ATT)";
		end
		print("Completed Quest ID #" .. key);
	end
end});
local IsQuestFlaggedCompleted = function(questID)
	return questID and CompletedQuests[questID];
end

-- Quest Name Harvesting Lib (http://www.wowinterface.com/forums/showthread.php?t=46934)
local QuestHarvester = CreateFrame("GameTooltip", "AllTheThingsQuestHarvester", UIParent, "GameTooltipTemplate");
local QuestTitleFromID = setmetatable({}, { __index = function(t, id)
	QuestHarvester:SetOwner(UIParent, "ANCHOR_NONE");
	QuestHarvester:SetHyperlink("quest:"..id);
	local title = AllTheThingsQuestHarvesterTextLeft1:GetText();
	QuestHarvester:Hide()
	if title and title ~= RETRIEVING_DATA then
		t[id] = title
		return title
	end
end })

-- NPC & Title Name Harvesting Lib (https://us.battle.net/forums/en/wow/topic/20758497390?page=1#post-4, Thanks Gello!)
local NPCTitlesFromID = {};
local NPCNameFromID = setmetatable({}, { __index = function(t, id)
	QuestHarvester:SetOwner(UIParent,"ANCHOR_NONE")
	QuestHarvester:SetHyperlink(format("unit:Creature-0-0-0-0-%d-0000000000",id))
	local title = AllTheThingsQuestHarvesterTextLeft1:GetText();
	if title and QuestHarvester:NumLines() > 2 then
		-- title = title .. " <" .. AllTheThingsQuestHarvesterTextLeft2:GetText() .. ">";
		NPCTitlesFromID[id] = AllTheThingsQuestHarvesterTextLeft2:GetText();
	end
	QuestHarvester:Hide();
	if title and title ~= RETRIEVING_DATA then
		t[id] = title
		return title;
	end
end })

-- Search Caching
local searchCache = {};
local function SetNote(key, id, note)
	wipe(searchCache);
	collectgarbage();
	SetDataSubSubMember("Notes", key, id, note);
end
local function GetNoteForGroup(group)
	if group then
		local key = group.key;
		if key then
			return group[key] and GetDataSubSubMember("Notes", key, group[key]);
		else
			return GetDataSubMember("Notes", BuildSourceTextForChat(group, 0));
		end
	end
end
local function SetNoteForGroup(group, note)
	if group then
		wipe(searchCache);
		local key = group.key;
		if key then
			SetDataSubSubMember("Notes", key, group[key], note);
		else
			SetDataSubMember("Notes", BuildSourceTextForChat(group, 0), note);
		end
	end
end
app.SetNote = SetNote;
app.searchCache = searchCache;
local function CreateObject(t)
	local s = {};
	if t[1] then
		-- array
		for i,o in ipairs(t) do
			tinsert(s, CreateObject(o));
		end
		return s;
	else
		if t.key == "criteriaID" then s.achievementID = t.achievementID; end
		for key,value in pairs(t) do
			s[key] = value;
		end
		if t.g then
			s.g = {};
			for i,o in ipairs(t.g) do
				tinsert(s.g, CreateObject(o));
			end
		end
		
		local meta = getmetatable(t);
		if meta then
			setmetatable(s, meta);
			return s;
		else
			t = s;
			if t.mapID then
				t = app.CreateMap(t.mapID, t);
			elseif t.s then
				t = app.CreateItemSource(t.s, t.itemID, t);
			elseif t.encounterID then
				t = app.CreateEncounter(t.encounterID, t);
			elseif t.instanceID then
				t = app.CreateInstance(t.instanceID, t);
			elseif t.currencyID then
				t = app.CreateCurrencyClass(t.currencyID, t);
			elseif t.speciesID then
				t = app.CreateSpecies(t.speciesID, t);
			elseif t.objectID then
				t = app.CreateObject(t.objectID, t);
			elseif t.followerID then
				t = app.CreateFollower(t.followerID, t);
			elseif t.illusionID then
				t = app.CreateIllusion(t.illusionID, t);
			elseif t.professionID then
				t = app.CreateProfession(t.professionID, t);
			elseif t.categoryID then
				t = app.CreateCategory(t.categoryID, t);
			elseif t.criteriaID then
				t = app.CreateAchievementCriteria(t.criteriaID, t);
			elseif t.achID then
				t = app.CreateAchievement(t.achID, t);
			elseif t.recipeID then
				t = app.CreateRecipe(t.recipeID, t);
			elseif t.spellID then
				t = app.CreateRecipe(t.spellID, t);
			elseif t.itemID then
				if t.isToy then
					t = app.CreateToy(t.itemID, t);
				else
					t = app.CreateItem(t.itemID, t);
				end
			elseif t.classID then
				t = app.CreateCharacterClass(t.classID, t);
			elseif t.npcID or t.creatureID then
				t = app.CreateNPC(t.npcID or t.creatureID, t);
			elseif t.questID then
				t = app.CreateQuest(t.questID, t);
			elseif t.unit then
				t = app.CreateUnit(t.unit, t);
			else
				t = setmetatable({}, { __index = t });
			end
			t.visible = true;
			return t;
		end
	end
end
local function MergeObject(g, t, index)
	local key = t.key;
	if not key then
		if t.mapID then
			key = "mapID";
		elseif t.s then
			key = "s";
		elseif t.currencyID then
			key = "currencyID";
		elseif t.objectID then
			key = "objectID";
		elseif t.followerID then
			key = "followerID";
		elseif t.encounterID then
			key = "encounterID";
		elseif t.instanceID then
			key = "instanceID";
		elseif t.illusionID then
			key = "illusionID";
		elseif t.speciesID then
			key = "speciesID";
		elseif t.recipeID then
			key = "recipeID";
		elseif t.spellID then
			key = "spellID";
		elseif t.categoryID then
			key = "categoryID";
		elseif t.achID then
			key = "achID";
		elseif t.toyID then
			key = "toyID";
		elseif t.itemID then
			key = "itemID";
		elseif t.professionID then
			key = "professionID";
		elseif t.classID then
			key = "classID";
		elseif t.npcID then
			key = "npcID";
		elseif t.creatureID then
			key = "creatureID";
		elseif t.questID then
			key = "questID";
		elseif t.unit then
			key = "unit";
		elseif t.criteriaID then
			key = "criteriaID";
		end
	end
	for i,o in ipairs(g) do
		if o[key] == t[key] then
			if t.g then
				local tg = t.g;
				t.g = nil;
				if o.g then
					for j,k in ipairs(tg) do
						MergeObject(o.g, k);
					end
				else
					o.g = tg;
				end
			end
			for k,value in pairs(t) do
				if k ~= "expanded" then -- and k ~= "parent" then
					o[k] = value;
				end
			end
			return o;
		end
	end
	if index then
		tinsert(g, index, t);
	else
		tinsert(g, t);
	end
	return t;
end
local function ExpandGroupsRecursively(group, expanded, manual)
	if group.g and (not group.itemID or manual) then
		group.expanded = expanded;
		for i, subgroup in ipairs(group.g) do
			ExpandGroupsRecursively(subgroup, expanded, manual);
		end
	end
end
local function ReapplyExpand(g, g2)
	for j,p in ipairs(g2) do
		local found = false;
		local key = p.key;
		local id = p[key];
		for i,o in ipairs(g) do
			if o[key] == id then
				found = true;
				if o.expanded then
					if not p.expanded then
						p.expanded = true;
						if o.g and p.g then ReapplyExpand(o.g, p.g); end
					end
				end
				break;
			end
		end
		if not found then
			ExpandGroupsRecursively(p, true);
		end
	end
end
local function ResolveSymbolicLink(o)
	if o.sym then
		local searchResults = {};
		-- {{"select", "itemID", 119321}, {"where", "modID", 6 },{"pop"}},
		for j,sym in ipairs(o.sym) do
			local cmd = sym[1];
			if cmd == "select" then
				-- Instruction to search the full database for something.
				for k,s in ipairs(app.SearchForField(sym[2], sym[3])) do
					table.insert(searchResults, s);
				end
			elseif cmd == "pop" then
				-- Instruction to "pop" all of the group values up one level.
				local orig = searchResults;
				searchResults = {};
				for k,s in ipairs(orig) do
					if s.g then
						for l,t in ipairs(s.g) do
							table.insert(searchResults, t);
						end
					end
				end
			elseif cmd == "where" then
				-- Instruction to include only search results where a key value is a value
				local key, value = sym[2], sym[3];
				for k=#searchResults,1,-1 do
					local s = searchResults[k];
					if not s[key] or s[key] ~= value then
						table.remove(searchResults, k);
					end
				end
			elseif cmd == "index" then
				-- Instruction to include the search result with a given index within each of the selection's groups.
				local index = sym[2];
				local orig = searchResults;
				searchResults = {};
				for k=#orig,1,-1 do
					local s = orig[k];
					if s.g and index <= #s.g then
						table.insert(searchResults, s.g[index]);
					end
				end
			elseif cmd == "not" then
				-- Instruction to include only search results where a key value is not a value
				if #sym > 3 then
					local dict = {};
					for k=2,#sym,2 do
						dict[sym[k] ] = sym[k + 1];
					end
					for k=#searchResults,1,-1 do
						local s = searchResults[k];
						local matched = true;
						for key,value in pairs(dict) do
							if not s[key] or s[key] ~= value then
								matched = false;
								break;
							end
						end
						if matched then
							table.remove(searchResults, k);
						end
					end
				else
					local key, value = sym[2], sym[3];
					for k=#searchResults,1,-1 do
						local s = searchResults[k];
						if s[key] and s[key] == value then
							table.remove(searchResults, k);
						end
					end
				end
			elseif cmd == "is" then
				-- Instruction to include only search results where a key exists
				local key = sym[2];
				for k=#searchResults,1,-1 do
					local s = searchResults[k];
					if not s[key] then table.remove(searchResults, k); end
				end
			elseif cmd == "isnt" then
				-- Instruction to include only search results where a key doesn't exist
				local key = sym[2];
				for k=#searchResults,1,-1 do
					local s = searchResults[k];
					if s[key] then table.remove(searchResults, k); end
				end
			elseif cmd == "contains" then
				-- Instruction to include only search results where a key value contains a value.
				local key = sym[2];
				local clone = {unpack(sym)};
				table.remove(clone, 1);
				table.remove(clone, 1);
				for k=#searchResults,1,-1 do
					local s = searchResults[k];
					if not s[key] or not contains(clone, s[key]) then
						table.remove(searchResults, k);
					end
				end
			end
		end
		
		if #searchResults > 0 then
			-- print("Symbolic Link for ", o.key, " ", o[o.key], " contains ", #searchResults, " values after filtering.");
			return searchResults;
		else
			-- print("Symbolic Link for ", o.key, " ", o[o.key], " contained no values after filtering.");
		end
	end
end
local function BuildContainsInfo(groups, entries, paramA, paramB, indent, layer)
	for i,group in ipairs(groups) do
		if app.GroupRequirementsFilter(group) and app.GroupFilter(group) then
			local right = nil;
			if group.total and (group.total > 1 or (group.total > 0 and not group.collectible)) then
				if (group.progress / group.total) < 1 or app.Settings:Get("Show:CompletedGroups") then
					right = GetProgressColorText(group.progress, group.total);
				end
			elseif paramA and paramB and (not group[paramA] or (group[paramA] and group[paramA] ~= paramB)) then
				if group.collectible then
					if group.collected or (group.trackable and group.saved) then
						if app.Settings:Get("Show:CollectedThings") then
							right = L["COLLECTED_ICON"];
						end
					else
						right = L["NOT_COLLECTED_ICON"];
					end
				elseif group.trackable then
					if app.Settings:Get("Show:IncompleteThings") then
						if group.saved then
							if app.Settings:Get("Show:CollectedThings") then
								right = L["COMPLETE_ICON"];
							end
						else
							right = L["NOT_COLLECTED_ICON"];
						end
					end
				elseif group.visible then
					right = "---";
				end
			end
			
			-- If there's progress to display, then let's summarize a bit better.
			if right then
				-- If this group has a droprate, add it to the display.
				if group.dr then right = "|c" .. GetProgressColor(group.dr * 0.01) .. tostring(group.dr) .. "%|r " .. right; end
				
				-- If this group has specialization requirements, let's attempt to show the specialization icons.
				local specs = group.specs;
				if specs and #specs > 0 then
					table.sort(specs);
					for i,spec in ipairs(specs) do
						local id, name, description, icon, role, class = GetSpecializationInfoByID(spec);
						if class == app.Class then right = "|T" .. icon .. ":0|t " .. right; end
					end
				end
				
				-- Insert into the display.
				local o = { prefix = indent, left = group.text or RETRIEVING_DATA, right = right };
				if o.left == RETRIEVING_DATA or o.left:find("%[]") then o.working = true; end
				if group.u then o.left = o.left .. " |T" .. L["UNOBTAINABLE_ITEM_TEXTURES"][L["UNOBTAINABLE_ITEM_REASONS"][group.u][1]] .. ":0|t"; end
				if group.icon then o.prefix = o.prefix .. "|T" .. group.icon .. ":0|t "; end
				tinsert(entries, o);
				
				-- Only go down one more level.
				if layer < 2 and group.g and (not group.achievementID or paramA == "creatureID") and not group.parent.difficultyID and #group.g > 0 and not (group.g[1].artifactID or group.filterID == 109) then
					BuildContainsInfo(group.g, entries, paramA, paramB, indent .. " ", layer + 1);
				end
			end
		end
	end
end
local function GetCachedSearchResults(search, method, paramA, paramB, ...)
	if search then
		local now = time();
		local cache = searchCache[search];
		if cache and (now - cache[1]) < cache[2] then return cache[3]; end
		
		-- Determine if this tooltip needs more work the next time it refreshes.
		if not paramA then paramA = ""; end
		local working, info = false, {};
		cache = { now, 100000000 };
		searchCache[search] = cache;
		
		-- Call to the method to search the database.
		local group = method(paramA, paramB, ...) or {};
		
		-- For Creatures and Encounters that are inside of an instance, we only want the data relevant for the instance + difficulty.
		if paramA == "creatureID" or paramA == "encounterID" then
			if IsInInstance() then
				local difficultyID = select(3, GetInstanceInfo());
				if difficultyID and difficultyID > 0 then
					local subgroup = {};
					for i,j in ipairs(group) do
						if GetRelativeDifficulty(j, difficultyID) then
							tinsert(subgroup, j);
						end
					end
					group = subgroup;
				end
			elseif paramA == "encounterID" then
				local difficultyID = EJ_GetDifficulty();
				if difficultyID and difficultyID > 0 then
					local subgroup = {};
					for i,j in ipairs(group) do
						if GetRelativeDifficulty(j, difficultyID) then
							tinsert(subgroup, j);
						end
					end
					group = subgroup;
				end
			end
			
			if not app.Settings:Get("DebugMode") then
				local regroup = {};
				if app.Settings:Get("AccountMode") then
					for i,j in ipairs(group) do
						if app.RecursiveUnobtainableFilter(j) then
							tinsert(regroup, j);
						end
					end
				else
					for i,j in ipairs(group) do
						if app.RecursiveClassAndRaceFilter(j) and app.RecursiveUnobtainableFilter(j) then
							tinsert(regroup, j);
						end
					end
				end
				
				group = regroup;
			end
			
			if group and #group > 0 then
				if app.Settings:GetTooltipSetting("Descriptions") and paramA ~= "encounterID" then
					for i,j in ipairs(group) do
						if j.description and j[paramA] and j[paramA] == paramB then
							tinsert(info, 1, { left = j.description, wrap = true, color = "ff66ccff" });
						end
					end
				end
				local subgroup = {};
				table.sort(group, function(a, b)
					return not (a.npcID and a.npcID == -1) and b.npcID and b.npcID == -1;
				end);
				for i,j in ipairs(group) do
					if j.g and not (j.achievementID and j.parent.difficultyID) and j.npcID ~= 0 then
						for k,l in ipairs(j.g) do
							tinsert(subgroup, l);
						end
					else
						tinsert(subgroup, j);
					end
				end
				group = subgroup;
			end
		elseif paramA == "achievementID" then
			-- Don't do anything for things linked to maps.
			local regroup = {};
			local criteriaID = ...;
			if app.Settings:Get("AccountMode") then
				for i,j in ipairs(group) do
					if j.criteriaID == criteriaID and app.RecursiveUnobtainableFilter(j) then
						if j.mapID or j.parent == nil or j.parent.parent == nil then
							tinsert(regroup, setmetatable({["g"] = {}}, { __index = j }));
						else
							tinsert(regroup, j);
						end
					end
				end
			else
				for i,j in ipairs(group) do
					if j.criteriaID == criteriaID and app.RecursiveClassAndRaceFilter(j) and app.RecursiveUnobtainableFilter(j) then
						if j.mapID or j.parent == nil or j.parent.parent == nil then
							tinsert(regroup, setmetatable({["g"] = {}}, { __index = j }));
						else
							tinsert(regroup, j);
						end
					end
				end
			end
			
			group = regroup;
		elseif paramA == "titleID" then
			-- Don't do anything
			local regroup = {};
			if app.Settings:Get("AccountMode") then
				for i,j in ipairs(group) do
					if app.RecursiveUnobtainableFilter(j) then
						tinsert(regroup, setmetatable({["g"] = {}}, { __index = j }));
					end
				end
			else
				for i,j in ipairs(group) do
					if app.RecursiveClassAndRaceFilter(j) and app.RecursiveUnobtainableFilter(j) then
						tinsert(regroup, setmetatable({["g"] = {}}, { __index = j }));
					end
				end
			end
			
			group = regroup;
		else
			-- Determine if this is a cache for an item
			local itemID, sourceID;
			if not paramB then
				local itemString = string.match(paramA, "item[%-?%d:]+");
				if itemString then
					if app.Settings:GetTooltipSetting("itemString") then tinsert(info, { left = itemString }); end
					local _, itemID2, enchantId, gemId1, gemId2, gemId3, gemId4, suffixId, uniqueId, linkLevel, specializationID, upgradeId, difficultyID, numBonusIds = strsplit(":", itemString);
					if itemID2 then
						itemID = tonumber(itemID2); 
						paramA = "itemID";
						paramB = itemID;
					end
					if #group > 0 then
						local first = group[1];
						if first.s then sourceID = first.s; end
						if first.u and first.u == 7 and numBonusIds and numBonusIds ~= "" and tonumber(numBonusIds) > 0 then
							tinsert(info, { left = L["RECENTLY_MADE_OBTAINABLE"] });
							tinsert(info, { left = L["RECENTLY_MADE_OBTAINABLE_PT2"] });
						end
					end
				else
					local kind, id = strsplit(":", paramA);
					kind = string.lower(kind);
					if id then id = tonumber(id); end
					if kind == "itemid" then
						paramA = "itemID";
						paramB = id;
						itemID = id;
					elseif kind == "questid" then
						paramA = "questID";
						paramB = id;
					elseif kind == "creatureid" or kind == "npcid" then
						paramA = "creatureID";
						paramB = id;
					elseif kind == "achievementid" then
						paramA = "achievementID";
						paramB = id;
					end
				end
			elseif paramA == "itemID" then
				itemID = paramB;
				if #group > 0 then
					local first = group[1];
					if first.s then sourceID = first.s; end
				end
			end
			
			if itemID then
				-- Show the unobtainable source text
				for i,j in ipairs(group.g or group) do
					if j.itemID == itemID then
						if j.u and not j.crs then
							tinsert(info, { left = L["UNOBTAINABLE_ITEM_REASONS"][j.u][2] });
							break;
						end
					end
				end
				if sourceID then
					local sourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
					if sourceInfo then
						if app.Settings:GetTooltipSetting("SharedAppearances") then
							local text;
							if app.Settings:GetTooltipSetting("OnlyShowRelevantSharedAppearances") then
								-- The user doesn't want to see Shared Appearances that don't match the item's requirements.
								for i, otherSourceID in ipairs(C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
									if otherSourceID == sourceID then
										if app.Settings:GetTooltipSetting("IncludeOriginalSource") and #group > 0 then
											local link = group[1].link;
											if not link then 
												link = RETRIEVING_DATA;
												working = true;
											end
											if group[1].u then
												local texture = L["UNOBTAINABLE_ITEM_TEXTURES"][L["UNOBTAINABLE_ITEM_REASONS"][group[1].u or 1][1]];
												if texture then
													text = "|T" .. texture .. ":0|t";
												else
													text = "   ";
												end
											else
												text = "   ";
											end
											tinsert(info, { left = text .. link .. (app.Settings:GetTooltipSetting("itemID") and " (*)" or ""), right = GetCollectionIcon(group[1].collected)});
										end
									else
										local otherATTSource = app.SearchForField("s", otherSourceID);
										if otherATTSource then
											otherATTSource = otherATTSource[1];
											
											-- Only show Shared Appearances that match the requirements for this class to prevent people from assuming things.
											if (group[1].f == otherATTSource.f or group[1].f == 2 or otherATTSource.f == 2) and not otherATTSource.nmc and not otherATTSource.nmr then
												local link = otherATTSource.link;
												if not link then 
													link = RETRIEVING_DATA;
													working = true;
												end
												if otherATTSource.u then
													local texture = L["UNOBTAINABLE_ITEM_TEXTURES"][L["UNOBTAINABLE_ITEM_REASONS"][otherATTSource.u or 1][1]];
													if texture then
														text = "|T" .. texture .. ":0|t";
													else
														text = "   ";
													end
												else
													text = "   ";
												end
												tinsert(info, { left = text .. link .. (app.Settings:GetTooltipSetting("itemID") and (" (" .. (otherATTSource.itemID or "???") .. ")") or ""), right = GetCollectionIcon(otherATTSource.collected)});
											end
										else
											local otherSource = C_TransmogCollection_GetSourceInfo(otherSourceID);
											if otherSource then
												local link = select(2, GetItemInfo(otherSource.itemID));
												if not link then 
													link = RETRIEVING_DATA;
													working = true;
												end
												tinsert(info, { left = " |CFFFF0000!|r " .. link .. (app.Settings:GetTooltipSetting("itemID") and (" (" .. (otherSource.itemID or "???") .. ")") or ""), right = GetCollectionIcon(otherSource.isCollected)});
											end
										end
									end
								end
							else
								-- This is where we need to calculate the requirements differently because Unique Mode users are extremely frustrating.
								for i, otherSourceID in ipairs(C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
									if otherSourceID == sourceID then
										if app.Settings:GetTooltipSetting("IncludeOriginalSource") and #group > 0 then
											local link = group[1].link;
											if not link then 
												link = RETRIEVING_DATA;
												working = true;
											end
											if group[1].u then
												local texture = L["UNOBTAINABLE_ITEM_TEXTURES"][L["UNOBTAINABLE_ITEM_REASONS"][group[1].u or 1][1]];
												if texture then
													text = "|T" .. texture .. ":0|t";
												else
													text = "   ";
												end
											else
												text = "   ";
											end
											tinsert(info, { left = text .. link .. (app.Settings:GetTooltipSetting("itemID") and " (*)" or ""), right = GetCollectionIcon(group[1].collected)});
										end
									else
										local otherATTSource = app.SearchForField("s", otherSourceID);
										if otherATTSource then
											otherATTSource = otherATTSource[1];
											
											-- Show information about the appearance:
											local failText = "";
											local link = otherATTSource.link;
											if not link then 
												link = RETRIEVING_DATA;
												working = true;
											end
											if otherATTSource.u then
												local texture = L["UNOBTAINABLE_ITEM_TEXTURES"][L["UNOBTAINABLE_ITEM_REASONS"][otherATTSource.u or 1][1]];
												if texture then
													text = "|T" .. texture .. ":0|t";
												else
													text = "   ";
												end
											else
												text = "   ";
											end
											text = text .. link .. (app.Settings:GetTooltipSetting("itemID") and (" (" .. (otherATTSource.itemID or "???") .. ")") or "");
											
											-- Show all of the reasons why an appearance does not meet given criteria.
											-- Only show Shared Appearances that match the requirements for this class to prevent people from assuming things.
											if group[1].f ~= otherATTSource.f then
												-- This is NOT the same type. Therefore, no credit for you!
												if #failText > 0 then failText = failText .. ", "; end
												failText = failText .. (L["FILTER_ID_TYPES"][otherATTSource.f] or "???");
											elseif otherATTSource.nmc then
												-- This is NOT for your class. Therefore, no credit for you!
												if #failText > 0 then failText = failText .. ", "; end
												-- failText = failText .. "Class Locked";
												for i,classID in ipairs(otherATTSource.c) do
													if i > 1 then failText = failText .. ", "; end
													failText = failText .. (GetClassInfo(classID) or "???");
												end
											elseif otherATTSource.nmr then
												-- This is NOT for your race. Therefore, no credit for you!
												if #failText > 1 then failText = failText .. ", "; end
												failText = failText .. "Race Locked";
											else
												-- Should be fine
											end
											
											if #failText > 0 then text = text .. " |CFFFF0000(" .. failText .. ")|r"; end
											tinsert(info, { left = text, right = GetCollectionIcon(otherATTSource.collected)});
										else
											local otherSource = C_TransmogCollection_GetSourceInfo(otherSourceID);
											if otherSource then
												local name, link = GetItemInfo(string.format("item:%d:::::::::::%d:1:3524", otherSource.itemID, otherSource.modID));
												if not link then 
													link = RETRIEVING_DATA;
													working = true;
												end
												text = " |CFFFF0000!|r " .. link .. (app.Settings:GetTooltipSetting("itemID") and (" (" .. (otherSourceID == sourceID and "*" or otherSource.itemID or "???") .. ")") or "");
												if otherSource.isCollected then SetDataSubMember("CollectedSources", otherSourceID, 1); end
												tinsert(info, { left = text	.. " |CFFFF0000(MISSING IN ATT - " .. otherSourceID .. ")|r", right = GetCollectionIcon(otherSource.isCollected)});
											end
										end
									end
								end
							end
						end
						
						if app.Settings:GetTooltipSetting("visualID") then tinsert(info, { left = L["VISUAL_ID"], right = tostring(sourceInfo.visualID) }); end
						if app.Settings:GetTooltipSetting("sourceID") then tinsert(info, { left = L["SOURCE_ID"], right = sourceID .. " " .. GetCollectionIcon(sourceInfo.isCollected) }); end
					end
				end
				if app.Settings:GetTooltipSetting("itemID") then tinsert(info, { left = L["ITEM_ID"], right = tostring(itemID) }); end
				if app.Settings:GetTooltipSetting("SpecializationRequirements") then
					local specs = GetItemSpecInfo(itemID);
					if specs then
						if #specs > 0 then
							table.sort(specs);
							local spec_label = "";
							local atleastone = false;
							for key, specID in ipairs(specs) do
								local id, name, description, icon, role, class = GetSpecializationInfoByID(specID);
								if class == app.Class then
									spec_label = spec_label .. "  |T" .. icon .. ":0|t " .. name;
									atleastone = true;
								end
							end
							if atleastone then
								tinsert(info, { right = spec_label });
							else
								tinsert(info, { right = "Not available in Personal Loot." });
							end
						else
							tinsert(info, { right = "Not available in Personal Loot." });
						end
					end
				end
				
				local reagentCache = app.GetDataSubMember("Reagents", itemID);
				if reagentCache then
					--[[
					for recipeID,count in pairs(reagentCache[1]) do
						local searchResults = SearchForField("spellID", recipeID);
						if searchResults then
							for i,o in ipairs(searchResults) do
								if not contains(group, o) then
									tinsert(group, o);
								end
							end
						end
					end
					]]--
					if select(14, GetItemInfo(itemID)) == 1 and not app.Settings:Get("DebugMode") then
						if not app.AppliedSkillIDToNPCIDs then
							app.AppliedSkillIDToNPCIDs = true;
							local skillIDMap = {
								[-178] = 202, 											-- Goblin Engineering"Goblin Engineering",
								[-179] = 202, 											-- Gnomish Engineering
								[-180] = 171,				 							-- Alchemy
								[-181] = 164,				 							-- Blacksmithing
								[-182] = 333,				 							-- Enchanting
								[-183] = 202,				 							-- Engineering
								[-184] = 182,				 							-- Herbalism
								[-185] = 773,				 							-- Inscription
								[-186] = 755,				 							-- Jewelcrafting
								[-187] = 165,				 							-- Leatherworking
								[-188] = 186,				 							-- Mining
								[-189] = 393,				 							-- Skinning
								[-190] = 197,				 							-- Tailoring
								[-191] = 794, 										-- Archaeology
								[-192] = 185, 											-- Cooking
								[-193] = 129, 										-- First Aid
								[-194] = 356, 											-- Fishing
							};
							for npcID,skillID in pairs(skillIDMap) do
								local searchResults = app.SearchForField("creatureID", npcID);
								if searchResults then
									for i,o in ipairs(searchResults) do
										o.skillID = skillID;
									end
								end
							end
						end
					
						-- If the reagent itself is BOP, then only show things you can make.
						for itemID,count in pairs(reagentCache[2]) do
							local searchResults = app.SearchForField("itemID", itemID);
							if searchResults then
								for i,o in ipairs(searchResults) do
									if not contains(group, o) then
										local skillID = GetRelativeValue(o, "skillID");
										if not skillID or app.GetTradeSkillCache()[skillID] then
											tinsert(group, o);
										end
									end
								end
							end
						end
					else
						for itemID,count in pairs(reagentCache[2]) do
							local searchResults = app.SearchForField("itemID", itemID);
							if searchResults then
								for i,o in ipairs(searchResults) do
									if not contains(group, o) then
										tinsert(group, o);
									end
								end
							end
						end
					end
				end
			end
		end
		
		-- Create a list of sources
		if app.Settings:GetTooltipSetting("SourceLocations") and (not paramA or (paramA ~= "encounterID" and app.Settings:GetTooltipSetting(paramA == "creatureID" and "SourceLocations:Creatures" or "SourceLocations:Things"))) then
			local temp = {};
			local unfiltered = {};
			local abbrevs = L["ABBREVIATIONS"];
			for i,j in ipairs(group.g or group) do
				if j.parent and not j.parent.hideText and j.parent.parent
					and (app.Settings:GetTooltipSetting("SourceLocations:Completed") or not app.IsComplete(j)) then
					local text = BuildSourceText(paramA ~= "itemID" and j.parent or j, paramA ~= "itemID" and 1 or 0);
					for source,replacement in pairs(abbrevs) do
						text = string.gsub(text, source,replacement);
					end
					if j.u then
						tinsert(unfiltered, text .. " |T" .. L["UNOBTAINABLE_ITEM_TEXTURES"][L["UNOBTAINABLE_ITEM_REASONS"][j.u][1]] .. ":0|t");
					elseif not app.RecursiveClassAndRaceFilter(j.parent) then
						tinsert(unfiltered, text .. " |TInterface\\FriendsFrame\\StatusIcon-Away:0|t");
					elseif not app.RecursiveUnobtainableFilter(j.parent) then
						tinsert(unfiltered, text .. " |TInterface\\FriendsFrame\\StatusIcon-DnD:0|t");
					else
						tinsert(temp, text);
					end
				end
			end
			if (#temp < 1 and not (paramA == "creatureID" or paramA == "encounterID")) or app.Settings:Get("DebugMode") then
				for i,j in ipairs(unfiltered) do
					tinsert(temp, j);
				end
			end
			if #temp > 0 then
				local listing = {};
				local maximum = app.Settings:GetTooltipSetting("Locations");
				table.sort(temp);
				for i,j in ipairs(temp) do
					if not contains(listing, j) then
						tinsert(listing, 1, j);
					end
				end
				local count = #listing;
				if count > maximum + 1 then
					for i=count,maximum + 1,-1 do
						table.remove(listing, 1);
					end
					tinsert(listing, 1, "And " .. (count - maximum) .. " other sources...");
				end
				for i,text in ipairs(listing) do
					local left, right = strsplit(DESCRIPTION_SEPARATOR, text);
					tinsert(info, 1, { left = left, right = right, wrap = not string.find(left, " -> ") });
				end
			end
		end
		
		-- Create an unlinked version of the object.
		if not group.g then
			local merged = {};
			for i,o in ipairs(group) do
				MergeObject(merged, CreateObject(o));
			end
			if #merged == 1 and merged[1][paramA] == paramB then
				group = merged[1];
				local symbolicLink = ResolveSymbolicLink(group);
				if symbolicLink then
					if group.g and #group.g >= 0 then
						for i,o in ipairs(group.g) do
							MergeObject(symbolicLink, CreateObject(o));
						end
					end
					group.g = symbolicLink;
				end
			else
				for i,o in ipairs(merged) do
					local symbolicLink = ResolveSymbolicLink(o);
					if symbolicLink then
						if o.g and #o.g >= 0 then
							for j,k in ipairs(o.g) do
								MergeObject(symbolicLink, CreateObject(k));
							end
						end
						o.g = symbolicLink;
					end
				end
				group = CreateObject({ [paramA] = paramB });
				group.g = merged;
			end
			
			group.progress = 0;
			group.total = 0;
			app.UpdateGroups(group, group.g);
			if group.collectible then
				group.total = group.total + 1;
				if group.collected then
					group.progress = group.progress + 1;
				end
			end
		end
		
		if group.description and app.Settings:GetTooltipSetting("Descriptions") and not group.encounterID and not (paramA == "achievementID" or paramA == "titleID") then
			tinsert(info, 1, { left = group.description, wrap = true, color = "ff66ccff" });
		end
		
		if group.g and #group.g > 0 then
			if app.Settings:GetTooltipSetting("Descriptions") and not (paramA == "achievementID" or paramA == "titleID") then
				for i,j in ipairs(group.g) do
					if j.description and ((j[paramA] and j[paramA] == paramB) or (paramA == "itemID" and group.key == j.key)) then
						tinsert(info, 1, { left = j.description, wrap = true, color = "ff66ccff" });
					end
				end
			end
			if app.Settings:GetTooltipSetting("SummarizeThings") then
				local entries = {};
				BuildContainsInfo(group.g, entries, paramA, paramB, "  ", app.noDepth and 99 or 1);
				if #entries > 0 then
					tinsert(info, { left = "Contains:" });
					if #entries < 25 then
						for i,item in ipairs(entries) do
							tinsert(info, { left = item.prefix .. item.left, right = item.right });
							if item.working then working = true; end
						end
					else
						for i=1,math.min(25, #entries) do
							local item = entries[i];
							tinsert(info, { left = item.prefix .. item.left, right = item.right });
							if item.working then working = true; end
						end
						local more = #entries - 25;
						if more > 0 then tinsert(info, { left = "And " .. more .. " more..." }); end
					end
				end
			end
		end
		
		-- If the item is a recipe, then show which characters know this recipe.
		if group.collectible and group.spellID and group.filterID ~= 100 and app.Settings:GetTooltipSetting("KnownBy") then
			local recipes, knownBy = GetDataMember("CollectedSpellsPerCharacter"), {};
			for key,value in pairs(recipes) do
				if value[group.spellID] then
					table.insert(knownBy, key);
				end
			end
			if #knownBy > 0 then
				table.sort(knownBy);
				local desc = "Known by ";
				local characters = GetDataMember("Characters");
				for i,key in ipairs(knownBy) do
					if i > 1 then desc = desc .. ", "; end
					desc = desc .. (characters[key] or key);
				end
				tinsert(info, { left = desc, wrap = true, color = "ff66ccff" });
			end
		end
		
		-- If the user wants to show the progress of this search result, do so.
		if app.Settings:GetTooltipSetting("Progress") and (not group.spellID or #info > 0) then
			group.collectionText = (app.Settings:GetTooltipSetting("ShowIconOnly") and GetProgressTextForRow or GetProgressTextForTooltip)(group);
		end
		
		-- If there is a note for this group, show it.
		local note = GetNoteForGroup(group);
		if note then
			tinsert(info, { left = "Custom Note:" });
			tinsert(info, { left = "|cffffffff" .. note .. "|r" });
		end
		
		-- If there was any informational text generated, then attach that info.
		if #info > 0 then
			local uniques, dupes = {}, {};
			for i,item in ipairs(info) do
				if not item.left then
					tinsert(uniques, item);
				elseif not dupes[item.left] then
					dupes[item.left] = true;
					tinsert(uniques, item);
				end
			end
			
			group.info = uniques;
			for i,item in ipairs(uniques) do
				if item.color then item.a, item.r, item.g, item.b = HexToARGB(item.color); end
			end
		end
		
		-- Cache the result for a while depending on if there is more work to be done.
		cache[2] = (working and 0.01) or 100000000;
		cache[3] = group;
		return group;
	end
end

-- Lua Constructor Lib
local fieldCache = {};
local CacheFields;
(function()
fieldCache["achievementID"] = {};
fieldCache["currencyID"] = {};
fieldCache["creatureID"] = {};
fieldCache["encounterID"] = {};
fieldCache["instanceID"] = {};
fieldCache["flightPathID"] = {};
fieldCache["objectID"] = {};
fieldCache["itemID"] = {};
fieldCache["mapID"] = {};
fieldCache["questID"] = {};
fieldCache["requireSkill"] = {};
fieldCache["s"] = {};
fieldCache["speciesID"] = {};
fieldCache["spellID"] = {};
fieldCache["titleID"] = {};
fieldCache["toyID"] = {};
local function CacheArrayFieldIDs(group, field, arrayField)
	local firldCache_g = group[arrayField];
	if firldCache_g then
		for i,fieldID in ipairs(firldCache_g) do
			local fieldCache_f = fieldCache[field][fieldID];
			if not fieldCache_f then
				fieldCache_f = {};
				fieldCache[field][fieldID] = fieldCache_f;
			end
			tinsert(fieldCache_f, group);
			--tinsert(fieldCache_f, {["g"] = { group }, ["parent"] = group, [field] = fieldID });
		end
	end
end
local function CacheFieldValue(group, field, value)
	if value then
		local fieldCache_f = fieldCache[field][value];
		if not fieldCache_f then
			fieldCache_f = {};
			fieldCache[field][value] = fieldCache_f;
		end
		tinsert(fieldCache_f, group);
	end
end
local function CacheFieldID(group, field)
	CacheFieldValue(group, field, group[field]);
end
local function CacheSubFieldID(group, field, subfield)
	local firldCache_g = group[subfield];
	if firldCache_g then
		local fieldCache_f = fieldCache[field][firldCache_g];
		if not fieldCache_f then
			fieldCache_f = {};
			fieldCache[field][firldCache_g] = fieldCache_f;
		end
		tinsert(fieldCache_f, group);
		-- tinsert(fieldCache_f, {["g"] = { group }, ["parent"] = group, [subfield] = firldCache_g });
	end
end
CacheFields = function(group)
	CacheFieldID(group, "achievementID");
	CacheFieldID(group, "creatureID");
	CacheFieldID(group, "currencyID");
	CacheArrayFieldIDs(group, "creatureID", "crs");
	CacheArrayFieldIDs(group, "creatureID", "qgs");
	CacheFieldID(group, "encounterID");
	CacheFieldID(group, "instanceID");
	CacheFieldID(group, "flightPathID");
	CacheFieldID(group, "objectID");
	CacheFieldID(group, "itemID");
	CacheFieldID(group, "titleID");
	CacheFieldID(group, "questID");
	CacheSubFieldID(group, "questID", "altQuestID");
	CacheFieldID(group, "requireSkill");
	CacheFieldID(group, "s");
	CacheFieldID(group, "speciesID");
	CacheFieldID(group, "spellID");
	CacheFieldID(group, "mapID");
	CacheArrayFieldIDs(group, "mapID", "maps");
	if group.filterID == 102 and group.itemID then CacheFieldValue(group, "toyID", group.itemID); end
	if group.c and not containsValue(group.c, app.ClassIndex) then
		group.nmc = true;	-- "Not My Class"
	end
	if group.r and group.r ~= app.FactionID then
		group.nmr = true;	-- "Not My Race"
	elseif group.races and not containsValue(group.races, app.RaceIndex) then
		group.nmr = true;	-- "Not My Race"
	end
	if group.g then
		for i,subgroup in ipairs(group.g) do
			CacheFields(subgroup);
		end
	end
end
end)();
local function SearchForFieldRecursively(group, field, value)
	if group.g then
		-- Go through the sub groups and determine if any of them have a response.
		local first = nil;
		for i, subgroup in ipairs(group.g) do
			local g = SearchForFieldRecursively(subgroup, field, value);
			if g then
				if first then
					-- Merge!
					for j,data in ipairs(g) do
						tinsert(first, data);
					end
				else
					-- Cool! (This should be the most common occurance)
					first = g;
				end
			end
		end
		if group[field] == value then
			-- OH BOY, WE FOUND IT!
			if first then
				return tinsert(first, group);
			else
				return { group };
			end
		end
		return first;
	elseif group[field] == value then
		-- OH BOY, WE FOUND IT!
		return { group };
	end
end
local function SearchForFieldContainer(field)
	if field then return fieldCache[field]; end
end
local function SearchForField(field, id)
	if field and id then
		local group = app:GetDataCache();
		if fieldCache[field] then return fieldCache[field][id]; end
		return SearchForFieldRecursively(group, field, id);
	end
end
app.SearchForField = SearchForField;

-- Item Information Lib
local function SearchForSourceIDQuickly(sourceID)
	if sourceID and sourceID > 0 and app:GetDataCache() then
		local group = fieldCache["s"][sourceID];
		if group and #group > 0 then return group[1]; end
	end
end
local function SearchForLink(link)
	if string.match(link, "item") then
		-- Parse the link and get the itemID and bonus ids.
		local itemString = string.match(link, "item[%-?%d:]+") or link;
		if itemString then
			local _, itemID, enchantId, gemId1, gemId2, gemId3, gemId4, suffixId, uniqueId,
				linkLevel, specializationID, upgradeId, modID = strsplit(":", link);
			if itemID then
				itemID = tonumber(itemID) or 0;
				local sourceID = select(3, GetItemInfo(link)) ~= LE_ITEM_QUALITY_ARTIFACT and GetSourceID(link, itemID);
				if sourceID then
					_ = SearchForField("s", sourceID);
					if _ then return _; end
				end
				
				-- Search for the item ID.
				_ = SearchForField("itemID", itemID);
				if _ and modID and modID ~= "" then
					modID = tonumber(modID or "1");
					local onlyMatchingModIDs = {};
					for i,o in ipairs(_) do
						if o.modID then
							if o.modID == modID then
								tinsert(onlyMatchingModIDs, o);
							end
						else
							tinsert(onlyMatchingModIDs, o);
						end
					end
					if #onlyMatchingModIDs > 0 then
						return onlyMatchingModIDs;
					end
				end
				return _;
			end
		end
	else
		local kind, id, paramA, paramB = strsplit(":", link);
		kind = string.lower(kind);
		if string.sub(kind,1,2) == "|c" then
			kind = string.sub(kind,11);
		end
		if string.sub(kind,1,2) == "|h" then
			kind = string.sub(kind,3);
		end
		if id then id = tonumber(select(1, strsplit("|[", id)) or id); end
		--print(kind, id, paramA, paramB);
		--print(string.gsub(string.gsub(link, "|c", "c"), "|h", "h"));
		if kind == "itemid" then
			return SearchForField("itemID", id);
		elseif kind == "questid" or kind == "quest" then
			return SearchForField("questID", id);
		elseif kind == "creatureid" or kind == "npcid" then
			return SearchForField("creatureID", id);
		elseif kind == "achievementid" or kind == "achievement" then
			return SearchForField("achievementID", id);
		elseif kind == "currencyid" or kind == "currency" then
			return SearchForField("currencyID", id);
		elseif kind == "spellid" or kind == "spell" or kind == "enchant" or kind == "talent" then
			return SearchForField("spellID", id);
		elseif kind == "speciesid" or kind == "species" or kind == "battlepet" then
			return SearchForField("speciesID", id);
		else
			return SearchForField(string.gsub(kind, "id", "ID"), id);
		end
	end
end
local function SearchForMissingItemsRecursively(group, listing)
	if group.visible then
		if (group.collectible or (group.itemID and group.total and group.total > 0)) and (not group.b or group.b == 2 or group.b == 3) then
			table.insert(listing, group);
		end
		if group.g and group.expanded then
			-- Go through the sub groups and determine if any of them have a response.
			for i, subgroup in ipairs(group.g) do
				SearchForMissingItemsRecursively(subgroup, listing);
			end
		end
	end
end
local function SearchForMissingItems(group)
	local listing = {}; 
	SearchForMissingItemsRecursively(group, listing);
	return listing; 
end
local function SearchForMissingItemNames(group)
	-- Auctionator needs unique Item Names. Nothing else.
	local uniqueNames = {};
	for i,group in ipairs(SearchForMissingItems(group)) do
		local name = group.name;
		if name then uniqueNames[name] = 1; end
	end
	
	-- Build the array of names.
	local arr = {};
	for key,value in pairs(uniqueNames) do
		table.insert(arr, key);
	end
	return arr; 
end
local function UpdateSearchResults(searchResults)
	if searchResults and #searchResults > 0 then
		-- Attempt to cleanly refresh the data.
		local fresh = false;
		
		-- Mark all results as marked. This prevents a double +1 on parents.
		for i,result in ipairs(searchResults) do
			if result.visible and result.parent and result.parent.total then
				result.marked = true;
			end
		end
		
		-- Only unmark and +1 marked search results.
		for i,result in ipairs(searchResults) do
			if result.marked then
				result.marked = nil;
				if result.total then
					-- This is an item that has a relative set of groups
					app.UpdateParentProgress(result);
					
					-- If this is NOT a group...
					if not result.g then
						-- If we've collected the item, use the "Show Collected Items" filter.
						result.visible = app.CollectedItemVisibilityFilter(result);
					end
				else	
					app.UpdateParentProgress(result.parent);
					
					-- If we've collected the item, use the "Show Collected Items" filter.
					result.visible = app.CollectedItemVisibilityFilter(result);
				end
				fresh = true;
			end
		end
		
		-- If the data is fresh, don't force a refresh.
		app:RefreshData(fresh, true);
	end
end
app.SearchForLink = SearchForLink;

-- Map Information Lib
local function AddTomTomWaypoint(group, auto)
	if TomTom and group.visible then
		if group.coords or group.coord then
			if auto then
				if C_Map.GetMapInfo(app.GetCurrentMapID()).mapType ~= 3 then return end -- only set waypoints if the current map is a zone
				local waypointFilters = GetDataMember("WaypointFilters")
				for headerID, enabled in pairs(waypointFilters) do
					if (UnitOnTaxi("player") and not GetDataMember("EnableTomTomWaypointsOnTaxi"))
					   or (app.RecursiveIsDescendantOfParentWithValue(group, "npcID", headerID) and not enabled)
					   or (GetDataMember("TomTomIgnoreCompletedObjects") and app.IsComplete(group))
					then
						return
					end
				end
			end
			local opt = {
				title = group.text or group.link,
				persistent = nil,
				minimap = true,
				world = true
			};
			if group.title then opt.title = opt.title .. "\n" .. group.title; end
			if group.criteriaID then opt.title = opt.title .. "\nCriteria for " .. GetAchievementLink(group.achievementID); end
			local defaultMapID = GetRelativeMap(group, app.GetCurrentMapID());
			local displayID = GetDisplayID(group);
			if displayID then
				opt.minimap_displayID = displayID;
				opt.worldmap_displayID = displayID;
			end
			if group.icon then
				opt.minimap_icon = group.icon;
				opt.worldmap_icon = group.icon;
			end
			if group.coords then
				for i, coord in ipairs(group.coords) do
					TomTom:AddWaypoint(coord[3] or defaultMapID, coord[1] / 100, coord[2] / 100, opt);
				end
			end
			if group.coord then TomTom:AddWaypoint(group.coord[3] or defaultMapID, group.coord[1] / 100, group.coord[2] / 100, opt); end
		end
		if group.g then
			for i,subgroup in ipairs(group.g) do
				AddTomTomWaypoint(subgroup, auto);
			end
		end
	end
end
local function ExportDataRecursively(group, indent)
	if group.itemID then return ""; end
	if group.g then
		if group.instanceID then
			EJ_SelectInstance(group.instanceID);
			EJ_SetLootFilter(0, 0);
			EJ_SetSlotFilter(0);
			local str = indent .. "c(" .. group.instanceID .. "--[[" .. select(1, EJ_GetInstanceInfo()) .. "]], {\n";
			for i,subgroup in ipairs(group.g) do
				str = str .. ExportDataRecursively(subgroup, indent .. "\t");
			end
			return str .. indent .. "}),\n"
		end
		if group.difficultyID then
			EJ_SetDifficulty(group.difficultyID);
			EJ_SetLootFilter(0, 0);
			EJ_SetSlotFilter(0);
			local str = indent .. "d(" .. group.difficultyID .. "--[[" .. select(1, GetDifficultyInfo(group.difficultyID)) .. "]], {\n";
			for i,subgroup in ipairs(group.g) do
				str = str .. ExportDataRecursively(subgroup, indent .. "\t");
			end
			return str .. indent .. "}),\n"
		end
		if group.encounterID then
			EJ_SelectEncounter(group.encounterID);
			EJ_SetLootFilter(0, 0);
			EJ_SetSlotFilter(0);
			local str = indent .. "e(" .. group.encounterID .. "--[[" .. select(1, EJ_GetEncounterInfo(group.encounterID)) .. "]], {\n";
			local numLoot = EJ_GetNumLoot();
			for i = 1,numLoot do
				local itemID = EJ_GetLootInfoByIndex(i);
				str = str .. indent .. "\ti(" .. itemID .. "--[[" .. select(1, GetItemInfo(itemID)) .. "]]),\n";
			end
			return str .. indent .. "}),\n"
		end
	end
	return "";
end
local function ExportData(group)
	if group.instanceID then
		EJ_SetLootFilter(0, 0);
		EJ_SetSlotFilter(0);
		SetDataMember("EXPORT_DATA", ExportDataRecursively(group, ""));
	end
end
local function OpenMainList()
	app:OpenWindow("Prime");
end
local function RefreshSavesCoroutine()
	local waitTimer = 30;
	while waitTimer > 0 do
		coroutine.yield();
		waitTimer = waitTimer - 1;
	end
	
	-- While the player is in combat, wait for combat to end.
	while InCombatLockdown() do coroutine.yield(); end
	
	-- While the player is still logging in, wait.
	while not app.GUID do coroutine.yield(); end
	
	-- While the player is still waiting for information, wait.
	-- NOTE: Usually, this is only 1 wait.
	local counter = 0;
	while GetNumSavedInstances() < 1 do
		coroutine.yield();
		counter = counter + 1;
		if counter > 600 then
			app.refreshingSaves = false;
			coroutine.yield(false);
		end
	end
	
	-- Cache the lockouts across your account.
	local serverTime = GetServerTime();
	local lockouts = GetDataMember("lockouts");
	local myLockouts = GetTempDataMember("lockouts");
	
	-- Check to make sure that the old instance data has expired
	for character,locks in pairs(lockouts) do
		local lockCount = 0;
		for name,instance in pairs(locks) do
			local count = 0;
			for difficulty,lock in pairs(instance) do
				if serverTime >= lock.reset then
					-- Clean this up.
					instance[difficulty] = nil;
				else
					count = count + 1;
				end
			end
			if count == 0 then
				-- Clean this up.
				locks[name] = nil;
			else
				lockCount = lockCount + 1;
			end
		end
		if lockCount == 0 then
			-- Clean this up.
			lockouts[character] = nil;
		end
	end
	
	-- Update Saved Instances
	local converter = L["SAVED_TO_DJ_INSTANCES"];
	for instanceIter=1,GetNumSavedInstances() do
		local name, id, reset, difficulty, locked, _, _, isRaid, _, _, numEncounters = GetSavedInstanceInfo(instanceIter);
		if locked then
			-- Update the name of the instance and cache the locks for this instance
			name = converter[name] or name;
			reset = serverTime + reset;
			local locks = myLockouts[name];
			if not locks then
				locks = {};
				myLockouts[name] = locks;
			end
			
			-- Create the lock for this difficulty
			local lock = locks[difficulty];
			if not lock then
				lock = { ["id"] = id, ["reset"] = reset, ["encounters"] = {}};
				locks[difficulty] = lock;
			else
				lock.id = id;
				lock.reset = reset;
			end
			
			-- If this is LFR, then don't share.
			if difficulty == 7 or difficulty == 17 then
				if #lock.encounters == 0 then
					-- Check Encounter locks
					for encounterIter=1,numEncounters do
						local name, _, isKilled = GetSavedInstanceEncounterInfo(instanceIter, encounterIter);
						table.insert(lock.encounters, { ["name"] = name, ["isKilled"] = isKilled });
					end
				else
					-- Check Encounter locks
					for encounterIter=1,numEncounters do
						local name, _, isKilled = GetSavedInstanceEncounterInfo(instanceIter, encounterIter);
						if not lock.encounters[encounterIter] then
							table.insert(lock.encounters, { ["name"] = name, ["isKilled"] = isKilled });
						elseif isKilled then
							lock.encounters[encounterIter].isKilled = true;
						end
					end
				end
			else
				-- Create the pseudo "shared" lock
				local shared = locks["shared"];
				if not shared then
					shared = {};
					shared.id = id;
					shared.reset = reset;
					shared.encounters = {};
					locks["shared"] = shared;
					
					-- Check Encounter locks
					for encounterIter=1,numEncounters do
						local name, _, isKilled = GetSavedInstanceEncounterInfo(instanceIter, encounterIter);
						table.insert(lock.encounters, { ["name"] = name, ["isKilled"] = isKilled });
						
						-- Shared Encounter is always assigned if this is the first lock seen for this instance
						table.insert(shared.encounters, { ["name"] = name, ["isKilled"] = isKilled });
					end
				else
					-- Check Encounter locks
					for encounterIter=1,numEncounters do
						local name, _, isKilled = GetSavedInstanceEncounterInfo(instanceIter, encounterIter);
						if not lock.encounters[encounterIter] then
							table.insert(lock.encounters, { ["name"] = name, ["isKilled"] = isKilled });
						elseif isKilled then
							lock.encounters[encounterIter].isKilled = true;
						end
						if not shared.encounters[encounterIter] then
							table.insert(shared.encounters, { ["name"] = name, ["isKilled"] = isKilled });
						elseif isKilled then
							shared.encounters[encounterIter].isKilled = true;
						end
					end
				end
			end
		end
	end
	
	-- Mark that we're done now.
	app:UpdateWindows(nil, true);
end
local function RefreshSaves()
	StartCoroutine("RefreshSaves", RefreshSavesCoroutine);
end
local function RefreshCollections()
	StartCoroutine("RefreshingCollections", function()
		while InCombatLockdown() do coroutine.yield(); end
		app.print("Refreshing collection...");
		app.events.QUEST_LOG_UPDATE();
		
		-- Harvest Illusion Collections
		local collectedIllusions = GetDataMember("CollectedIllusions", {});
		for i,illusion in ipairs(C_TransmogCollection_GetIllusions()) do
			if illusion.isCollected then collectedIllusions[illusion.sourceID] = 1; end
		end
		
		-- Harvest Title Collections
		local collectedTitles = GetTempDataMember("CollectedTitles", {});
		for i=1,GetNumTitles(),1 do
			if IsTitleKnown(i) then collectedTitles[i] = 1; end
		end
		
		-- Refresh Mounts / Pets
		local collectedSpells = GetDataMember("CollectedSpells", {});
		local collectedSpellsPerCharacter = GetTempDataMember("CollectedSpells", {});
		for i,mountID in ipairs(C_MountJournal.GetMountIDs()) do
			local _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal_GetMountInfoByID(mountID);
			if spellID and isCollected then
				collectedSpells[spellID] = 1;
				collectedSpellsPerCharacter[spellID] = 1;
			end
		end
		
		-- Wait a frame before harvesting item collection status.
		coroutine.yield();
		
		-- Harvest Item Collections that are used by the addon.
		app:GetDataCache();
		
		-- Refresh Toys from Cache
		local collectedToys = GetDataMember("CollectedToys", {});
		for id,group in pairs(fieldCache["toyID"]) do
			if not collectedToys[id] and PlayerHasToy(id) then
				collectedToys[id] = 1;
			end
		end
		
		-- Refresh Sources from Cache
		local collectedSources = GetDataMember("CollectedSources");
		if app.Settings:Get("Completionist") then
			-- Completionist Mode can simply use the *fast* blizzard API.
			for id,group in pairs(fieldCache["s"]) do
				if not collectedSources[id] then
					if C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance(id) then
						collectedSources[id] = 1;
					end
				end
			end
		else
			-- Unique Mode requires a lot more calculation.
			for id,group in pairs(fieldCache["s"]) do
				if not collectedSources[id] then
					if C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance(id) then
						collectedSources[id] = 1;
					else
						local sourceInfo = C_TransmogCollection_GetSourceInfo(id);
						if sourceInfo and app.ItemSourceFilter(sourceInfo, C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) then
							collectedSources[id] = 2;
						end
					end
				end
			end
		end
		
		-- Refresh the Collection Windows!
		app:RefreshData(false, false, true);
		collectgarbage();
		
		-- Report success.
		app.print("Done refreshing collection.");
	end);
end
local function RefreshMountCollection()
	StartCoroutine("RefreshMountCollection", function()
		while InCombatLockdown() do coroutine.yield(); end
		
		-- Cache current counts
		local previousProgress = app:GetDataCache().progress or 0;
		
		-- Refresh Mounts
		local collectedSpells = GetDataMember("CollectedSpells", {});
		local collectedSpellsPerCharacter = GetTempDataMember("CollectedSpells", {});
		for i,mountID in ipairs(C_MountJournal.GetMountIDs()) do
			local _, spellID, _, _, _, _, _, _, _, _, isCollected = C_MountJournal_GetMountInfoByID(mountID);
			if spellID and isCollected then
				collectedSpells[spellID] = 1;
				collectedSpellsPerCharacter[spellID] = 1;
			end
		end
		
		-- Wait a frame before harvesting item collection status.
		coroutine.yield();
		
		-- Refresh the Collection Windows!
		app:RefreshData(false, true);
		
		-- Wait 2 frames before refreshing states.
		coroutine.yield();
		coroutine.yield();
		
		-- Compare progress
		local progress = app:GetDataCache().progress or 0;
		if progress < previousProgress then
			app:PlayRemoveSound();
		elseif progress > previousProgress then
			app:PlayFanfare();
		end
		wipe(searchCache);
		collectgarbage();
	end);
end
app.GetCurrentMapID = function()
	local uiMapID = C_Map_GetBestMapForUnit("player");
	
	-- Onyxia's Lair fix
	local text_to_mapID = app.L["ZONE_TEXT_TO_MAP_ID"];
	if text_to_mapID then
		local otherMapID = (GetRealZoneText() and text_to_mapID[GetRealZoneText()]) or (GetSubZoneText() and text_to_mapID[GetSubZoneText()]);
		if otherMapID then uiMapID = otherMapID; end
	end
	
	-- print("Current UI Map ID: ", uiMapID);
	return uiMapID;
end
app.GetMapName = function(mapID)
	if mapID and mapID > 0 then
		local info = C_Map.GetMapInfo(mapID);
		return (info and info.name) or ("Map ID #" .. mapID);
	else
		return "Map ID #???";
	end
end
app.ToggleMainList = function()
	app:ToggleWindow("Prime");
end
app.RefreshCollections = RefreshCollections;
app.RefreshSaves = RefreshSaves;
app.OpenMainList = OpenMainList;

-- Tooltip Functions
local function AttachTooltipRawSearchResults(self, group)
	if group then
		-- If there was info text generated for this search result, then display that first.
		if group.info then
			for i,entry in ipairs(group.info) do
				if entry.right then
					self:AddDoubleLine(entry.left or " ", entry.right);
				elseif entry.r then
					if entry.wrap then
						self:AddLine(entry.left, entry.r / 255, entry.g / 255, entry.b / 255, 1);
					else
						self:AddLine(entry.left, entry.r / 255, entry.g / 255, entry.b / 255);
					end
				else
					if entry.wrap then
						self:AddLine(entry.left, nil, nil, nil, 1);
					else
						self:AddLine(entry.left);
					end
				end
			end
		end
		
		-- If the user has Show Collection Progress turned on.
		if group.collectionText and self:NumLines() > 0 then
			local rightSide = _G[self:GetName() .. "TextRight1"];
			if rightSide then
				rightSide:SetText(group.collectionText);
				rightSide:Show();
			end
		end
	end
end
local function AttachTooltipSearchResults(self, search, method, paramA, paramB, ...)
	AttachTooltipRawSearchResults(self, GetCachedSearchResults(search, method, paramA, paramB, ...));
end
local function AttachTooltip(self)
	if not self.AllTheThingsProcessing then
		self.AllTheThingsProcessing = true;
		if (not InCombatLockdown() or app.Settings:GetTooltipSetting("DisplayInCombat")) and app.Settings:GetTooltipSetting("Enabled") then
			local numLines = self:NumLines();
			if numLines > 0 then
				--[[--
				-- Debug all of the available fields on the tooltip.
				for i,j in pairs(self) do
					self:AddDoubleLine(tostring(i), tostring(j));
				end
				self:Show();
				self:AddDoubleLine("GetItem", tostring(select(2, self:GetItem()) or "nil"));
				self:AddDoubleLine("GetSpell", tostring(select(2, self:GetSpell()) or "nil"));
				self:AddDoubleLine("GetUnit", tostring(select(2, self:GetUnit()) or "nil"));
				--]]--
				
				-- Does the tooltip have an owner?
				local owner = self:GetOwner();
				if owner then
					if owner.SpellHighlightTexture then
						-- Actionbars, don't want that.
						return true;
					end
					if owner.cooldownWrapper then
						local parent = owner:GetParent();
						if parent then
							parent = parent:GetParent();
							if parent and parent.fanfareToys then
								-- Toy Box, don't want that.
								return true;
							end
						end
					end
				end
				
				-- Does the tooltip have a target?
				local target = select(2, self:GetUnit());
				if target then
					-- Yes.
					target = UnitGUID(target);
					if target then
						local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",target);
						-- print(target, type, npc_id);
						if type == "Player" then
							if target == "Player-76-0895E23B" then
								local leftSide = _G[self:GetName() .. "TextLeft1"];
								if leftSide then
									leftSide:SetText("|cffff8000" .. leftSide:GetText() .. "|r");
								end
								local rightSide = _G[self:GetName() .. "TextRight2"];
								leftSide = _G[self:GetName() .. "TextLeft2"];
								if leftSide and rightSide then
									leftSide:SetText(L["TITLE"]);
									leftSide:Show();
									rightSide:SetText("Author");
									rightSide:Show();
								else
									self:AddDoubleLine(L["TITLE"], "Author");
								end
							end
						elseif type == "Creature" or type == "Vehicle" then
							if app.Settings:GetTooltipSetting("creatureID") then self:AddDoubleLine(L["CREATURE_ID"], tostring(npc_id)); end
							AttachTooltipSearchResults(self, "creatureID:" .. npc_id, SearchForField, "creatureID", tonumber(npc_id));
						end
						return true;
					end
				end
				
				-- Does the tooltip have a spell? [Mount Journal, Action Bars, etc]
				local spellID = select(2, self:GetSpell());
				if spellID then
					AttachTooltipSearchResults(self, "spellID:" .. spellID, SearchForField, "spellID", spellID);
					self:Show();
					if owner and owner.ActiveTexture then
						self.AllTheThingsProcessing = nil;
					end
					return true;
				end
				
				-- Does the tooltip have an itemlink?
				local link = select(2, self:GetItem());
				if link then AttachTooltipSearchResults(self, link, SearchForLink, link); end
				
				-- Does the tooltip have an owner?
				if owner then
					-- If the owner has a ref, it's an ATT row. Ignore it.
					if owner.ref then return true; end
					
					--[[--
					-- Debug all of the available fields on the owner.
					self:AddDoubleLine("GetOwner", tostring(owner:GetName()));
					for i,j in pairs(owner) do
						self:AddDoubleLine(tostring(i), tostring(j));
					end
					self:Show();
					--]]--
					
					local encounterID = owner.encounterID;
					if encounterID and not owner.itemID then
						if app.Settings:GetTooltipSetting("encounterID") then self:AddDoubleLine(L["ENCOUNTER_ID"], tostring(encounterID)); end
						AttachTooltipSearchResults(self, "encounterID:" .. encounterID, SearchForField, "encounterID", tonumber(encounterID));
						return;
					end
					
					local gf;
					if owner.lastNumMountsNeedingFanfare then
						-- Collections
						gf = app:GetWindow("Prime").data;
					elseif owner.NewAdventureNotice then
						-- Adventure Guide
						gf = app:GetWindow("Prime").data.g[1];
					elseif owner.tooltipText then
						if owner.tooltipText == DUNGEONS_BUTTON then
							-- Group Finder
							gf = app:GetWindow("Prime").data.g[4];
						elseif owner.tooltipText == BLIZZARD_STORE then
							-- Shop
							gf = app:GetWindow("Prime").data.g[15];
						elseif string.sub(owner.tooltipText, 1, string.len(ACHIEVEMENT_BUTTON)) == ACHIEVEMENT_BUTTON then
							-- Achievements
							gf = app:GetWindow("Prime").data.g[5];
						end
					end
					if gf then
						app.noDepth = true;
						AttachTooltipSearchResults(self, owner:GetName(), (function() return gf; end), owner:GetName(), 1);
						app.noDepth = nil;
						self:Show();
					end
				end
				
				-- Addons Menu?
				if numLines == 2 then
					local leftSide = _G[self:GetName() .. "TextLeft1"];
					if leftSide and leftSide:GetText() == "AllTheThings" then
						leftSide:SetText(L["TITLE"]);
						local reference = app:GetDataCache();
						local rightSide = _G[self:GetName() .. "TextRight1"];
						if rightSide then
							rightSide:SetText(GetProgressColorText(reference.progress, reference.total));
							rightSide:Show();
						end
						self:AddDoubleLine(app.Settings:GetModeString(), app.GetNumberOfItemsUntilNextPercentage(reference.progress, reference.total), 1, 1, 1);
						return true;
					end
				end
			end
		end
	end
end
local function AttachBattlePetTooltip(self, data, quantity, detail)
	if not data or data.att or not data.speciesID then return end
	data.att = 1;
	
	-- GameTooltip_ShowCompareItem
	local searchResults = SearchForField("speciesID", data.speciesID);
	local owned = C_PetJournal.GetOwnedBattlePetString(data.speciesID);
	self.Owned:SetText(owned);
	if owned == nil then
		if self.Delimiter then
			-- if .Delimiter is present it requires special handling (FloatingBattlePetTooltip)
			self:SetSize(260,150 + h)
			self.Delimiter:ClearAllPoints()
			self.Delimiter:SetPoint("TOPLEFT",self.SpeedTexture,"BOTTOMLEFT",-6,-5)
		else
			self:SetSize(260,122)
		end
	else
		local h = self.Owned:GetHeight() or 0;
		if self.Delimiter then
			self:SetSize(260,150 + h)
			self.Delimiter:ClearAllPoints()
			self.Delimiter:SetPoint("TOPLEFT",self.SpeedTexture,"BOTTOMLEFT",-6,-(5 + h))
		else
			self:SetSize(260,122 + h)
		end
	end
	self:Show()
	return true;
end
local function ClearTooltip(self)
	self.AllTheThingsProcessing = nil;
end

-- Tooltip Hooks
(function()
	--[[
	for name,func in pairs(getmetatable(GameTooltip).__index) do
		print(name);
		if type(func) == "function" and name ~= "IsOwned" and name ~= "GetOwner" then
			(function(n,f) GameTooltip[n] = function(...) 
					print("GameTooltip", n, ...);
					return f(...);
				end
			end)(name, func);
		end
	end
	]]--
	local GameTooltip_SetCurrencyByID = GameTooltip.SetCurrencyByID;
	GameTooltip.SetCurrencyByID = function(self, currencyID, count)
		-- Make sure to call to base functionality
		GameTooltip_SetCurrencyByID(self, currencyID, count);
		
		if (not InCombatLockdown() or app.Settings:GetTooltipSetting("DisplayInCombat")) and app.Settings:GetTooltipSetting("Enabled") then
			AttachTooltipSearchResults(self, "currencyID:" .. currencyID, SearchForField, "currencyID", currencyID);
			if app.Settings:GetTooltipSetting("currencyID") then self:AddDoubleLine(L["CURRENCY_ID"], tostring(currencyID)); end
			self:Show();
		end
	end
	local GameTooltip_SetCurrencyToken = GameTooltip.SetCurrencyToken;
	GameTooltip.SetCurrencyToken = function(self, tokenID)
		-- Make sure to call to base functionality
		GameTooltip_SetCurrencyToken(self, tokenID);
		
		if (not InCombatLockdown() or app.Settings:GetTooltipSetting("DisplayInCombat")) and app.Settings:GetTooltipSetting("Enabled") then
			-- Determine what kind of list data this is. (Blizzard is whack and using this API call for headers too...)
			local name, isHeader = GetCurrencyListInfo(tokenID);
			if not isHeader then
				-- Determine which currencyID is the one that we're dealing with.
				local cache = SearchForFieldContainer("currencyID");
				if cache then
					-- We only care about currencies in the addon at the moment.
					for currencyID, _ in pairs(cache) do
						-- Compare the name of the currency vs the name of the token
						if select(1, GetCurrencyInfo(currencyID)) == name then
							AttachTooltipSearchResults(self, "currencyID:" .. currencyID, SearchForField, "currencyID", currencyID);
							if app.Settings:GetTooltipSetting("currencyID") then self:AddDoubleLine(L["CURRENCY_ID"], tostring(currencyID)); end
							self:Show();
							break;
						end
					end
				end
			end
		end
	end
	local GameTooltip_SetLFGDungeonReward = GameTooltip.SetLFGDungeonReward;
	GameTooltip.SetLFGDungeonReward = function(self, dungeonID, rewardID)
		-- Only call to the base functionality if it is unknown.
		GameTooltip_SetLFGDungeonReward(self, dungeonID, rewardID);
		if (not InCombatLockdown() or app.Settings:GetTooltipSetting("DisplayInCombat")) and app.Settings:GetTooltipSetting("Enabled") then
			local name, texturePath, quantity, isBonusReward, spec, itemID = GetLFGDungeonRewardInfo(dungeonID, rewardID);
			if itemID then
				if spec == "item" then
					AttachTooltipSearchResults(self, "itemID:" .. itemID, SearchForField, "itemID", itemID);
					self:Show();
				elseif spec == "currency" then
					AttachTooltipSearchResults(self, "currencyID:" .. itemID, SearchForField, "currencyID", itemID);
					self:Show();
				end
			end
		end
	end
	local GameTooltip_SetLFGDungeonShortageReward = GameTooltip.SetLFGDungeonShortageReward;
	GameTooltip.SetLFGDungeonShortageReward = function(self, dungeonID, shortageSeverity, lootIndex)
		-- Only call to the base functionality if it is unknown.
		GameTooltip_SetLFGDungeonShortageReward(self, dungeonID, shortageSeverity, lootIndex);
		if (not InCombatLockdown() or app.Settings:GetTooltipSetting("DisplayInCombat")) and app.Settings:GetTooltipSetting("Enabled") then
			local name, texturePath, quantity, isBonusReward, spec, itemID = GetLFGDungeonShortageRewardInfo(dungeonID, shortageSeverity, lootIndex);
			if itemID then
				if spec == "item" then
					AttachTooltipSearchResults(self, "itemID:" .. itemID, SearchForField, "itemID", itemID);
					self:Show();
				elseif spec == "currency" then
					AttachTooltipSearchResults(self, "currencyID:" .. itemID, SearchForField, "currencyID", itemID);
					self:Show();
				end
			end
		end
	end
	--[[
	local GameTooltip_SetToyByItemID = GameTooltip.SetToyByItemID;
	GameTooltip.SetToyByItemID = function(self, itemID)
		GameTooltip_SetToyByItemID(self, itemID);
		if (not InCombatLockdown() or app.Settings:GetTooltipSetting("DisplayInCombat")) and app.Settings:GetTooltipSetting("Enabled") then
			AttachTooltipSearchResults(self, "itemID:" .. itemID, SearchForField, "itemID", itemID);
			self:Show();
		end
	end
	]]--
end)();

-- Paragon Hook
hooksecurefunc("ReputationParagonFrame_SetupParagonTooltip",function(frame)
	-- Source: //Interface//FrameXML//ReputationFrame.lua Line 360
	-- Using hooksecurefunc because of how Blizzard coded the frame.  Couldn't get GameTooltip to work like the above ones.
	-- //Interface//FrameXML//ReputationFrame.lua Segment code
	--[[
		function ReputationParagonFrame_SetupParagonTooltip(frame)
			EmbeddedItemTooltip.owner = frame;
			EmbeddedItemTooltip.factionID = frame.factionID;

			local factionName, _, standingID = GetFactionInfoByID(frame.factionID);
			local gender = UnitSex("player");
			local factionStandingtext = GetText("FACTION_STANDING_LABEL"..standingID, gender);
			local currentValue, threshold, rewardQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(frame.factionID);

			if ( tooLowLevelForParagon ) then
				EmbeddedItemTooltip:SetText(PARAGON_REPUTATION_TOOLTIP_TEXT_LOW_LEVEL);
			else
				EmbeddedItemTooltip:SetText(factionStandingtext);
				local description = PARAGON_REPUTATION_TOOLTIP_TEXT:format(factionName);
				if ( hasRewardPending ) then
					local questIndex = GetQuestLogIndexByID(rewardQuestID);
					local text = GetQuestLogCompletionText(questIndex);
					if ( text and text ~= "" ) then
						description = text;
					end
				end
				EmbeddedItemTooltip:AddLine(description, HIGHLIGHT_FONT_COLOR.r, HIGHLIGHT_FONT_COLOR.g, HIGHLIGHT_FONT_COLOR.b, 1);
				if ( not hasRewardPending ) then
					local value = mod(currentValue, threshold);
					-- show overflow if reward is pending
					if ( hasRewardPending ) then
						value = value + threshold;
					end
					GameTooltip_ShowProgressBar(EmbeddedItemTooltip, 0, threshold, value, REPUTATION_PROGRESS_FORMAT:format(value, threshold));
				end
				GameTooltip_AddQuestRewardsToTooltip(EmbeddedItemTooltip, rewardQuestID);
			end
			EmbeddedItemTooltip:Show();
		end
	--]]
	local currentValue, threshold, paragonQuestID, hasRewardPending, tooLowLevelForParagon = C_Reputation.GetFactionParagonInfo(frame.factionID)
	-- Let's make sure the user isn't in combat and if they are do they have In Combat turned on.  Finally check to see if Tootltips are turned on.
	if (not InCombatLockdown() or app.Settings:GetTooltipSetting("DisplayInCombat")) and app.Settings:GetTooltipSetting("Enabled") then
		
	local paragonCacheID = {
		-- Paragon Cache Rewards
		-- [QuestID] = [ItemCacheID"]	-- Faction // Quest Title
		[54454] = 166300,	-- 7th Legion // Supplies from the 7th Legion
		[48976] = 152922,	-- Argussian Reach // Paragon of the Argussian Reach
		[46777] = 152108,	-- Armies of Legionfall // The Bounties of Legionfall
		[48977] = 152923,	-- Army of the Light // Paragon of the Army of the Light
		[54453] = 166298,	-- Champions of Azeroth // Supplies from Magni
		[46745] = 152102,	-- Court of Farondis // Supplies from the Court
		[46747] = 152103,	-- Dreamweavers // Supplies from the Dreamweavers
		[46743] = 152104,	-- Highmountain Tribes // Supplies from Highmountain
		[54455] = 166299,	-- Honorbound // Supplies from the Honorbound
		[54456] = 166297,	-- Order of Embers // Supplies from the Order of Embers
		[54458] = 166295,	-- Proudmoore Admiralty // Supplies from the Proudmoore Admiralty
		[54457] = 166294,	-- Storm's Wake // Supplies from Storm's Wake
		[54460] = 166282,	-- Talanji's Expedition // Supplies from Talanji's Expedition
		[46748] = 152105,	-- The Nightfallen // Supplies from the Nightfallen
		[46749] = 152107,	-- The Wardens // Supplies from the Wardens
		[54451] = 166245,	-- Tortollan Seekers // Baubles from the Seekers
		[46746] = 152106,	-- Valarjar // Supplies from the Valarjar
		[54461] = 166290,	-- Voldunai // Supplies from the Voldunai
		[54462] = 166292,	-- Zandalari Empire // Supplies from the Zandalari Empire
	};
	
	-- Grab Item Link Info
	local iName, sLink, iRarity, iLevel, iMinLevel, sType, sSubType, iStackCount = GetItemInfo(paragonCacheID[paragonQuestID])
		if sLink ~= nil then
			-- Attach tooltip to the Paragon Frame
			GameTooltip:SetOwner(EmbeddedItemTooltip, "ANCHOR_NONE")
			-- Using TOPRIGHT for now so that it hooks slightly better into other addon's that take up a lot of the vertical distance.  As well as when you scroll towards the bottom of the frame it doesn't cause potential cutoffs.	
			GameTooltip:SetPoint("TOPLEFT", EmbeddedItemTooltip, "TOPRIGHT")
			-- TOP/BOTTOM + LEFT/RIGHT attaches it to that particular spot of the corresponding paragon tooltip
			-- Populate Tooltip with the Paragon Cache Rewards
			GameTooltip:SetHyperlink(sLink)
		end
	end
end
);

-- Hide Paragon Tooltip when cleared
hooksecurefunc("ReputationParagonFrame_OnLeave",function(self)
	GameTooltip:Hide();
end
);

-- Achievement Lib
app.AchievementFilter = 4;
app.BaseAchievement = {
	__index = function(t, key)
		if key == "achievementID" then
			local achievementID = t.altAchID and app.FactionID == 2 and t.altAchID or t.achID;
			if achievementID then
				rawset(t, "achievementID", achievementID);
				return achievementID;
			end
		elseif key == "text" then
			--local IDNumber, Name, Points, Completed, Month, Day, Year, Description, Flags, Image, RewardText, isGuildAch = GetAchievementInfo(t.achievementID);
			return GetAchievementLink(t.achievementID) or select(2, GetAchievementInfo(t.achievementID)) or ("Achievement #" .. t.achievementID);
		elseif key == "key" then
			return "achievementID";
		elseif key == "link" then
			return GetAchievementLink(t.achievementID);
		elseif key == "icon" then
			return select(10, GetAchievementInfo(t.achievementID));
		elseif key == "collectible" then
			return app.CollectibleAchievements;
		elseif key == "collected" then
			return select(app.AchievementFilter, GetAchievementInfo(t.achievementID));
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateAchievement = function(id, t)
	return setmetatable(constructor(id, t, "achID"), app.BaseAchievement);
end

-- Achievement Criteria Lib
app.BaseAchievementCriteria = { 
	__index = function(t, key)
		if key == "achievementID" then
			local achievementID = t.altAchID and app.FactionID == 2 and t.altAchID or t.achID;
			if achievementID then
				rawset(t, "achievementID", achievementID);
				return achievementID;
			end
			return t.parent and (t.parent.achievementID or (t.parent.parent and t.parent.parent.achievementID));
		elseif key == "key" then
			return "criteriaID";
		elseif key == "text" then
			if t["isRaid"] then return "|cffff8000" .. t.name .. "|r"; end
			return t.name;
		elseif key == "name" then
			if t.itemID then
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.text = link;
					t.link = link;
					t.icon = icon;
					return link;
				end
			end
			if t.encounterID then
				return select(1, EJ_GetEncounterInfo(t.encounterID)) or "";
			end
			local m = GetAchievementNumCriteria(t.achievementID);
			if m and t.criteriaID <= m then
				return GetAchievementCriteriaInfo(t.achievementID,t.criteriaID, true);
			end
			return "You might need to be on the other faction to view this.";
		elseif key == "description" then
			if t.encounterID then
				return select(2, EJ_GetEncounterInfo(t.encounterID)) or "";
			end
		elseif key == "link" then
			if t.itemID then
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.text = link;
					t.link = link;
					t.icon = icon;
					return link;
				end
			end
		elseif key == "displayID" then
			if t.encounterID then
				-- local id, name, description, displayInfo, iconImage = EJ_GetCreatureInfo(1, t.encounterID);
				return select(4, EJ_GetCreatureInfo(t.index, t.encounterID));
			end
		elseif key == "displayInfo" then
			if t.encounterID then
				local displayInfos, displayInfo = {};
				for i=1,MAX_CREATURES_PER_ENCOUNTER do
					displayInfo = select(4, EJ_GetCreatureInfo(i, t.encounterID));
					if displayInfo then
						tinsert(displayInfos, displayInfo);
					else
						break;
					end
				end
				return displayInfos;
			end
		elseif key == "icon" then
			return select(10, GetAchievementInfo(t.achievementID));
		elseif key == "trackable" then
			return true;
		elseif key == "collectible" then
			return app.CollectibleAchievements;
		elseif key == "saved" or key == "collected" then
			if select(app.AchievementFilter, GetAchievementInfo(t.achievementID)) then
				return true;
			elseif t.criteriaID then
				local m = GetAchievementNumCriteria(t.achievementID);
				if m and t.criteriaID <= m then
					return select(3, GetAchievementCriteriaInfo(t.achievementID, t.criteriaID, true));
				--elseif t.achievementID ~= 12891 and t.achievementID ~= 12479 and t.achievementID ~= 12593 and t.achievementID ~= 12455 then
				--	print(t.achievementID, t.criteriaID, " > ", m); 
				end
			end
		elseif key == "index" then
			return 1;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateAchievementCriteria = function(id, t)
	return setmetatable(constructor(id, t, "criteriaID"), app.BaseAchievementCriteria);
end

(function()
local transmogSlotIcons = { "axe_17", "axe_09", "weapon_bow_05", "weapon_rifle_01", "mace_02", "hammer_16", "spear_04", "sword_04", "sword_07", "weapon_glave_01", "staff_27", nil, nil, "misc_monsterclaw_02", nil, "weapon_shortblade_01", nil, nil, "weapon_crossbow_01","wand_02", "shield_06", "helmet_03", "shoulder_05", "misc_cape_11", "chest_chain", "shirt_grey_01", "misc_tournaments_tabard_gnome", "bracer_07", "gauntlets_24", "belt_24", "pants_09", "boots_09", "misc_orb_01" }
local transmogArmorSlots = { INVTYPE_HEAD, INVTYPE_NECK, INVTYPE_SHOULDER, INVTYPE_CLOAK, INVTYPE_CHEST, INVTYPE_BODY, INVTYPE_TABARD, INVTYPE_WRIST, INVTYPE_HAND, INVTYPE_WAIST, INVTYPE_LEGS, INVTYPE_FEET, INVTYPE_RING, INVTYPE_TRINKET, INVTYPE_HOLDABLE };
app.BaseTransmogCategory = {
  __index = function(t, key)
    if key == "text" then
      if t.itemSubClass < 20 then
        return GetItemSubClassInfo(2, t.itemSubClass);
      elseif t.itemSubClass == 21 then return GetItemSubClassInfo(4,6);
      elseif t.itemSubClass <21 then
        return transmogArmorSlots[t.itemSubClass - 20]
      end
    elseif key == "icon" then
        return "Interface\\Icons\\inv_"..transmogSlotIcons[t.itemSubClass];
    else
      return table[key];
    end
  end
};
end)();
app.CreateTransmogCategory = function(id, t)
  return setmetatable(constructor(id, t, "category"), app.BaseTransmogCategory);
end
    
-- Artifact Lib
(function()
local artifactItemIDs = {
	[841] = 133755, -- Underlight Angler [Base Skin]
	[988] = 133755, -- Underlight Angler [Fisherfriend of the Isles]
	[989] = 133755, -- Underlight Angler [Fisherfriend of the Isles]
};
app.BaseArtifact = {
	__index = function(t, key)
		if key == "key" then
			return "artifactID";
		elseif key == "f" then
			return 11;
		elseif key == "collectible" then
			return app.CollectibleTransmog;
		elseif key == "collected" then
			if GetDataSubMember("CollectedArtifacts", t.artifactID) then return true; end
			if not GetRelativeField(t, "nmc", true) and select(5, C_ArtifactUI_GetAppearanceInfoByID(t.artifactID)) then
				SetDataSubMember("CollectedArtifacts", t.artifactID, 1);
				return true;
			end
		elseif key == "text" then
			return t.parent and t.parent.itemID and t.variantText or t.appearanceText;
		elseif key == "title" then
			return t.parent and t.parent.itemID and t.appearanceText or t.variantText;
		elseif key == "variantText" then
			return Colorize("Variant " .. t.info[4], RGBToHex(t.info[9] * 255, t.info[10] * 255, t.info[11] * 255));
		elseif key == "appearanceText" then
			return "|cffe6cc80" .. (t.info[3] or "???") .. "|r";
		elseif key == "description" then
			return t.info[6] or "Awarded for completing the introductory quest for this Artifact.";
		elseif key == "atlas" then
			return "Forge-ColorSwatchBorder";
		elseif key == "atlas-background" then
			return "Forge-ColorSwatchBackground";
		elseif key == "atlas-border" then
			return "Forge-ColorSwatch";
		elseif key == "atlas-color" then
			return { t.info[9], t.info[10], t.info[11], 1.0 };
		elseif key == "model" then
			return t.parent and GetRelativeValue(t.parent, key);
		elseif key == "modelScale" then
			return t.parent and GetRelativeValue(t.parent, key) or 0.95;
		elseif key == "modelRotation" then
			return t.parent and GetRelativeValue(t.parent, key) or 45;
		elseif key == "info" then
			--[[
			local setID, appearanceID, appearanceName, displayIndex, appearanceUnlocked, unlockConditionText, 
				uiCameraID, altHandUICameraID, swatchR, swatchG, swatchB, 
				modelAlpha, modelDesaturation, suppressGlobalAnim = C_ArtifactUI_GetAppearanceInfoByID(t.artifactID);
			]]--
			local info = { C_ArtifactUI_GetAppearanceInfoByID(t.artifactID) };
			rawset(t, "info", info);
			return info;
		elseif key == "silentLink" then
			local itemID = artifactItemIDs[t.artifactID];
			if itemID then
				return select(2, GetItemInfo(string.format("item:%d::::::::::256:::%d", itemID, t.artifactID))), itemID;
			elseif t.parent and t.parent.npcID and (t.parent.npcID <= -5200 and t.parent.npcID >= -5205) then
				itemID = GetRelativeValue(t.parent, "itemID");
				artifactItemIDs[t.artifactID] = itemID;
				return select(2, GetItemInfo(string.format("item:%d::::::::::256:::%d", itemID, t.artifactID))), itemID;
			end
		elseif key == "s" then
			local s, itemID = t.silentLink;
			if s then
				s = app.GetSourceID(s, itemID);
				if s then
					rawset(t, "s", s);
					return s;
				end
			end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
end)();
app.CreateArtifact = function(id, t)
	return setmetatable(constructor(id, t, "artifactID"), app.BaseArtifact);
end

-- Category Lib
app.BaseCategory = {
	__index = function(t, key)
		if key == "key" then
			return "categoryID";
		elseif key == "text" then
			local info = app.GetDataSubMember("Categories", t.categoryID);
			if info then return info; end
			return "Open your Professions to Cache";
		elseif key == "icon" then
			return "Interface/ICONS/INV_Garrison_Blueprints1";
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateCategory = function(id, t)
	return setmetatable(constructor(id, t, "categoryID"), app.BaseCategory);
end

-- Character Class Lib
(function()
local class_id_cache = {};
for i=1,GetNumClasses() do
	class_id_cache[select(2, GetClassInfo(i))] = i;
end
local classIcons = {
	[1] = "Interface\\Icons\\ClassIcon_Warrior",
	[2] = "Interface\\Icons\\ClassIcon_Paladin",
	[3] = "Interface\\Icons\\ClassIcon_Hunter",
	[4] = "Interface\\Icons\\ClassIcon_Rogue",
	[5] = "Interface\\Icons\\ClassIcon_Priest",
	[6] = "Interface\\Icons\\ClassIcon_DeathKnight",
	[7] = "Interface\\Icons\\ClassIcon_Shaman",
	[8] = "Interface\\Icons\\ClassIcon_Mage",
	[9] = "Interface\\Icons\\ClassIcon_Warlock",
	[10] = "Interface\\Icons\\ClassIcon_Monk",
	[11] = "Interface\\Icons\\ClassIcon_Druid",
	[12] = "Interface\\Icons\\ClassIcon_DemonHunter",
};
app.BaseCharacterClass = {
	__index = function(t, key)
		if key == "key" then
			return "classID";
		elseif key == "text" then
			local text = GetClassInfo(t.classID);
			if t.mapID then
				text = app.GetMapName(t.mapID) .. " (" .. text .. ")";
			elseif t.maps then
				text = app.GetMapName(t.maps[1]) .. " (" .. text .. ")";
			end
			text = "|c" .. t.classColors.colorStr .. text .. "|r";
			rawset(t, "text", text);
			return text;
		elseif key == "icon" then
			return classIcons[t.classID];
		elseif key == "c" then
			local c = { t.classID };
			rawset(t, "c", c);
			return c;
		elseif key == "classColors" then
			return RAID_CLASS_COLORS[select(2, GetClassInfo(t.classID))];
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateCharacterClass = function(id, t)
	return setmetatable(constructor(id, t, "classID"), app.BaseCharacterClass);
end
app.BaseUnit = {
	__index = function(t, key)
		if key == "key" then
			return "unit";
		elseif key == "text" then
			if t.isGUID then return nil; end
			local name, realm = UnitName(t.unit);
			if name then
				if realm and realm ~= "" then name = name .. "-" .. realm; end
				local classID = select(3, UnitClass(t.unit));
				if classID then
					name = "|c" .. RAID_CLASS_COLORS[select(2, GetClassInfo(classID))].colorStr .. name .. "|r";
				end
				rawset(t, "text", name);
				return name;
			end
			return t.unit;
		elseif key == "icon" then
			if t.classID then return classIcons[t.classID]; end
		elseif key == "isGUID" then
			local a = strsplit("-", t.unit);
			if a == "Player" then
				local className, classID, raceName, raceId, gender, name, realm = GetPlayerInfoByGUID(t.unit);
				if name then
					if realm and realm ~= "" then name = name .. "-" .. realm; end
					if classID then
						name = "|c" .. RAID_CLASS_COLORS[classID].colorStr .. name .. "|r";
						t.classID = class_id_cache[classID];
					end
					rawset(t, "text", name);
				end
				rawset(t, "isGUID", true);
				return true;
			else
				rawset(t, "isGUID", false);
			end
		elseif key == "collectible" then
			if t.unit == "player" and app.Settings:Get("DebugMode") then return true; end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateUnit = function(unit, t)
	return setmetatable(constructor(unit, t, "unit"), app.BaseUnit);
end
end)();

-- Currency Lib
app.BaseCurrencyClass = {
	__index = function(t, key)
		if key == "key" then
			return "currencyID";
		elseif key == "text" then
			return GetCurrencyLink(t.currencyID, 1) or select(1, GetCurrencyInfo(t.currencyID));
		elseif key == "icon" then
			return select(3, GetCurrencyInfo(t.currencyID));
		elseif key == "icon" then
			return select(3, GetCurrencyInfo(t.currencyID));
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateCurrencyClass = function(id, t)
	return setmetatable(constructor(id, t, "currencyID"), app.BaseCurrencyClass);
end

-- Difficulty Lib
app.DifficultyColors = {
	[2] = "ff0070dd",
	[5] = "ff0070dd",
	[6] = "ff0070dd",
	[7] = "ff9d9d9d",
	[15] = "ff0070dd",
	[16] = "ffa335ee",
	[17] = "ff9d9d9d",
	[23] = "ffa335ee",
	[24] = "ffe6cc80",
	[33] = "ffe6cc80",
};
app.DifficultyIcons = {
	[-1] = "Interface\\Addons\\AllTheThings\\assets\\LFR",
	[-2] = "Interface\\Addons\\AllTheThings\\assets\\Normal",
	[-3] = "Interface\\Addons\\AllTheThings\\assets\\Heroic",
	[-4] = "Interface\\Addons\\AllTheThings\\assets\\Mythic",
	[1] = "Interface\\Addons\\AllTheThings\\assets\\Normal",
	[2] = "Interface\\Addons\\AllTheThings\\assets\\Heroic",
	[3] = "Interface\\Addons\\AllTheThings\\assets\\Normal",
	[4] = "Interface\\Addons\\AllTheThings\\assets\\Normal",
	[5] = "Interface\\Addons\\AllTheThings\\assets\\Heroic",
	[6] = "Interface\\Addons\\AllTheThings\\assets\\Heroic",
	[7] = "Interface\\Addons\\AllTheThings\\assets\\LFR",
	[9] = "Interface\\Addons\\AllTheThings\\assets\\Mythic",
	[11] = "Interface\\Addons\\AllTheThings\\assets\\Normal",
	[12] = "Interface\\Addons\\AllTheThings\\assets\\Heroic",
	[14] = "Interface\\Addons\\AllTheThings\\assets\\Normal",
	[15] = "Interface\\Addons\\AllTheThings\\assets\\Heroic",
	[16] = "Interface\\Addons\\AllTheThings\\assets\\Mythic",
	[17] = "Interface\\Addons\\AllTheThings\\assets\\LFR",
	[23] = "Interface\\Addons\\AllTheThings\\assets\\Mythic",
	[24] = "Interface\\Addons\\AllTheThings\\assets\\Timewalking",
	[33] = "Interface\\Addons\\AllTheThings\\assets\\Timewalking",
};
app.BaseDifficulty = {
	__index = function(t, key)
		if key == "key" then
			return "difficultyID";
		elseif key == "text" then
			return L["CUSTOM_DIFFICULTIES"][t.difficultyID] or GetDifficultyInfo(t.difficultyID) or "Unknown Difficulty";
		elseif key == "icon" then
			return app.DifficultyIcons[t.difficultyID];
		elseif key == "saved" then
			return t.locks;
		elseif key == "locks" and t.parent then
			local locks = t.parent.locks;
			if locks then
				if t.parent.isLockoutShared and not (t.difficultyID == 7 or t.difficultyID == 17) then
					rawset(t, key, locks.shared);
					return locks.shared;
				else
					-- Look for this difficulty's lockout.
					for difficultyKey, lock in pairs(locks) do
						if difficultyKey == "shared" then
							-- ignore this one
						elseif difficultyKey == t.difficultyID then
							rawset(t, key, lock);
							return lock;
						end
					end
				end
			end
		elseif key == "u" then
			if t.difficultyID == 24 or t.difficultyID == 33 then
				return 42;
			end
		elseif key == "description" then
			if t.difficultyID == 24 or t.difficultyID == 33 then
				return "Timewalking difficulties needlessly create new Source IDs for items despite having the exact same name, appearance, and display in the Collections Tab.\n\nA plea to the Blizzard Devs: Please clean up the Source ID database and have your Timewalking / Titanforged item variants use the same Source ID as their base assuming the appearances and names are exactly the same. Not only will this make your database much cleaner, but it will also make Completionists excited for rather than dreading the introduction of more Timewalking content.\n\n - Crieve, the Very Bitter Account Completionist that had 99% Ulduar completion and now only has 64% because your team duplicated the Source IDs rather than reuse the existing one.";
			end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateDifficulty = function(id, t)
	return setmetatable(constructor(id, t, "difficultyID"), app.BaseDifficulty);
end

-- Encounter Lib
app.BaseEncounter = {
	__index = function(t, key)
		if key == "key" then
			return "encounterID";
		elseif key == "text" then
			if t["isRaid"] then return "|cffff8000" .. t.name .. "|r"; end
			return t.name;
		elseif key == "name" then
			return select(1, EJ_GetEncounterInfo(t.encounterID)) or "";
		elseif key == "description" then
			return select(2, EJ_GetEncounterInfo(t.encounterID)) or "";
		elseif key == "link" then
			return select(5, EJ_GetEncounterInfo(t.encounterID)) or "";
		elseif key == "displayID" then
			-- local id, name, description, displayInfo, iconImage = EJ_GetCreatureInfo(1, t.encounterID);
			return select(4, EJ_GetCreatureInfo(t.index, t.encounterID));
		elseif key == "displayInfo" then
			local displayInfos, displayInfo = {};
			for i=1,MAX_CREATURES_PER_ENCOUNTER do
				displayInfo = select(4, EJ_GetCreatureInfo(i, t.encounterID));
				if displayInfo then
					tinsert(displayInfos, displayInfo);
				else
					break;
				end
			end
			return displayInfos;
		elseif key == "icon" then
			return "Interface\\Icons\\INV_Misc_Head_Human_01";
		elseif key == "trackable" then
			return t.questID;
		elseif key == "saved" then
			if IsQuestFlaggedCompleted(t.questID) or IsQuestFlaggedCompleted(t.altQuestID) then
				return true;
			end
		elseif key == "index" then
			return 1;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateEncounter = function(id, t)
	return setmetatable(constructor(id, t, "encounterID"), app.BaseEncounter);
end

-- Faction Lib
(function()
app.FACTION_RACES = {
	[1] = {
		1,	-- Human
		3,	-- Dwarf
		4,	-- Night Elf
		7,	-- Gnome
		11,	-- Draenei
		22,	-- Worgen
		25,	-- Pandaren [Alliance]
		29,	-- Void Elf
		30,	-- Lightforged
		32,	-- Kul Tiran
		34,	-- Dark Iron
	},
	[2] = {
		2,	-- Orc
		5,	-- Undead
		6,	-- Tauren
		8,	-- Troll
		9,	-- Goblin
		10,	-- Blood Elf
		26,	-- Pandaren [Horde]
		27,	-- Nightborne
		28,	-- Highmountain
		31,	-- Zandalari
		36,	-- Mag'har
	}
};
app.BaseFaction = {
	-- name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(factionIndex)
	-- friendID, friendRep, friendMaxRep, friendName, friendText, friendTexture, friendTextLevel, friendThreshold, nextFriendThreshold = GetFriendshipReputation(factionID)
	__index = function(t, key)
		if key == "achievementID" then
			local achievementID = t.altAchID and app.FactionID == 2 and t.altAchID or t.achID;
			if achievementID then
				rawset(t, "achievementID", achievementID);
				return achievementID;
			end
		elseif key == "key" then
			return "factionID";
		elseif key == "filterID" then
			return 112;
		elseif key == "trackable" or key == "collectible" then
			return app.CollectibleReputations;
		elseif key == "saved" or key == "collected" then
			if app.AccountWideReputations then
				if GetDataSubMember("CollectedFactions", t.factionID) then return 1; end
			else
				if GetTempDataSubMember("CollectedFactions", t.factionID) then return 1; end
			end
			if t.isFriend and not select(9, GetFriendshipReputation(t.factionID)) or t.standing == 8 then
				SetTempDataSubMember("CollectedFactions", t.factionID, 1);
				SetDataSubMember("CollectedFactions", t.factionID, 1);
				return 1;
			end
			if t.achievementID then
				return select(4, GetAchievementInfo(t.achievementID));
			end
		elseif key == "text" then
			local rgb = FACTION_BAR_COLORS[t.standing + (t.isFriend and 2 or 0)];
			return Colorize(select(1, GetFactionInfoByID(t.factionID)) or (t.creatureID and NPCNameFromID[t.creatureID]) or ("Faction #" .. t.factionID), RGBToHex(rgb.r * 255, rgb.g * 255, rgb.b * 255));
		elseif key == "title" then
			return t.isFriend and select(7, GetFriendshipReputation(t.factionID)) or _G["FACTION_STANDING_LABEL" .. t.standing];
		elseif key == "description" then
			return select(2, GetFactionInfoByID(t.factionID)) or "Not all reputations can be viewed on a single character. IE: Warsong Outriders cannot be viewed by an Alliance Player and Silverwing Sentinels cannot be viewed by a Horde Player.";
		elseif key == "link" then
			return t.achievementID and GetAchievementLink(t.achievementID);
		elseif key == "icon" then
			return t.achievementID and select(10, GetAchievementInfo(t.achievementID)) or t.isFriend and select(6, GetFriendshipReputation(t.factionID));
		elseif key == "isFriend" then
			if select(1, GetFriendshipReputation(t.factionID)) then
				rawset(t, "isFriend", true);
				return true;
			else
				rawset(t, "isFriend", false);
				return false;
			end
		elseif key == "standing" then
			return select(3, GetFactionInfoByID(t.factionID)) or 4;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateFaction = function(id, t)
	return setmetatable(constructor(id, t, "factionID"), app.BaseFaction);
end
end)();

-- Flight Path Lib
(function()
	local arrOfNodes = {
		1,		-- Durotar (All of Kalimdor)
		36,		-- Burning Steppes (All of Eastern Kingdoms)
		94,     -- Eversong Woods (and Ghostlands + Isle of Quel'Danas)
		97,     -- Azuremyst Isle (and Bloodmyst)
		100,	-- Hellfire Peninsula (All of Outland)
		118,	-- Icecrown (All of Northrend)
		422,	-- Dread Wastes (All of Pandaria)
		525,	-- Frostfire Ridge (All of Draenor)
		630,	-- Azsuna (All of Broken Isles)
		882,	-- Mac'Aree (All of Argus)
		862,	-- Zuldazar (All of Zuldazar)
		896,	-- Drustvar (All of Kul Tiras)
	};
	local cachedNodeData = {};
	app.CacheFlightPathData = function()
		for i,mapID in ipairs(arrOfNodes) do
			local allNodeData = C_TaxiMap.GetTaxiNodesForMap(mapID);
			if allNodeData then
				for j,nodeData in ipairs(allNodeData) do
					local node = cachedNodeData[nodeData.nodeID];
					if not node then
						node = {};
						cachedNodeData[nodeData.nodeID] = node;
					end
					if nodeData.faction then node["faction"] = nodeData.faction; end
					if nodeData.nodeID then node["nodeID"] = nodeData.nodeID; end
					if nodeData.name then node["text"] = nodeData.name; end
				end
			end
		end
	end
	app.CacheFlightPathDataForCurrentNode = function()
		local allNodeData = C_TaxiMap.GetAllTaxiNodes(app.GetCurrentMapID());
		if allNodeData then
			local knownNodeIDs = {};
			for j,nodeData in ipairs(allNodeData) do
				local node = cachedNodeData[nodeData.nodeID];
				if not node then
					node = {};
					cachedNodeData[nodeData.nodeID] = node;
				end
				if nodeData.nodeID then node["nodeID"] = nodeData.nodeID; end
				if nodeData.name then node["text"] = nodeData.name; end
				if nodeData.state and nodeData.state < 2 then
					table.insert(knownNodeIDs, nodeData.nodeID);
				end
			end
			
			if app.AccountWideFlightPaths then
				for i,nodeID in ipairs(knownNodeIDs) do
					if not GetDataSubMember("FlightPaths", nodeID) then
						SetDataSubMember("FlightPaths", nodeID, 1);
						SetPersonalDataSubMember("FlightPaths", nodeID, 1);
						UpdateSearchResults(SearchForField("flightPathID", nodeID));
					end
				end
			else
				for i,nodeID in ipairs(knownNodeIDs) do
					if not GetPersonalDataSubMember("FlightPaths", nodeID) then
						SetDataSubMember("FlightPaths", nodeID, 1);
						SetPersonalDataSubMember("FlightPaths", nodeID, 1);
						UpdateSearchResults(SearchForField("flightPathID", nodeID));
					end
				end
			end
		end
	end
	app.events.TAXIMAP_OPENED = app.CacheFlightPathDataForCurrentNode;
	app.BaseFlightPath = {
		__index = function(t, key)
			if key == "key" then
				return "flightPathID";
			elseif key == "collectible" then
				return app.CollectibleFlightPaths;
			elseif key == "collected" then
				if app.AccountWideFlightPaths then
					return GetDataSubMember("FlightPaths", t.flightPathID);
				end
				return GetPersonalDataSubMember("FlightPaths", t.flightPathID);
			elseif key == "text" then
				local info = t.info;
				return info and info.text or "Visit the Flight Master to cache.";
			elseif key == "nmr" then
				local info = t.info;
				if info and info.faction then
					return info.faction == app.FactionID;
				end
			elseif key == "info" then
				return cachedNodeData[t.flightPathID];
			elseif key == "description" then
				return "Flight paths are cached when you look at the flight master on each continent. We refresh the collection status when you look at the Flight Map. (blizzard limitation, not by choice... sorry!)\n\nHave fun!\n - Crieve";
			elseif key == "icon" then
				local info = t.info;
				if info and info.faction and info.faction == 2 then
					return "Interface/ICONS/Ability_Rogue_Sprint_Blue";
				end
				return "Interface/ICONS/Ability_Rogue_Sprint";
			else
				-- Something that isn't dynamic.
				return table[key];
			end
		end
	};
	app.CreateFlightPath = function(id, t)
		return setmetatable(constructor(id, t, "flightPathID"), app.BaseFlightPath);
	end
end)();

-- Filter Lib
app.BaseFilter = {
	__index = function(t, key)
		if key == "key" then
			return "filterID";
		elseif key == "text" then
			return L["FILTER_ID_TYPES"][t.filterID];
		elseif key == "icon" then
			return L["FILTER_ID_ICONS"][t.filterID];
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateFilter = function(id, t)
	return setmetatable(constructor(id, t, "filterID"), app.BaseFilter);
end

-- Follower Lib
app.BaseFollower = {
	__index = function(t, key)
		if key == "key" then
			return "followerID";
		elseif key == "collectible" then
			return app.CollectibleFollowers;
		elseif key == "collected" then
			if app.AccountWideFollowers then
				if GetDataSubMember("CollectedFollowers", t.followerID) then return 1; end
			else
				if GetTempDataSubMember("CollectedFollowers", t.followerID) then return 1; end
			end
			if C_Garrison.IsFollowerCollected(t.followerID) then
				SetTempDataSubMember("CollectedFollowers", t.followerID, 1);
				SetDataSubMember("CollectedFollowers", t.followerID, 1);
				return 1;
			end
		elseif key == "text" then
			local info = t.info;
			return info and info.name;
		elseif key == "description" then
			return "Followers can be collected Account Wide. Unlocking them on one toon will count as collected across all your characters in ATT. \n\nYou must manually refresh the addon by Shift+Left clicking the header for this to be detected.";
		elseif key == "info" then
			-- https://wow.gamepedia.com/API_C_Garrison.GetFollowerInfo
			return C_Garrison.GetFollowerInfo(t.followerID);
		elseif key == "icon" then
			local info = t.info;
			return info and info.portraitIconID;
		elseif key == "displayID" then
			local info = t.info;
			return info and info.displayID;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateFollower = function(id, t)
	return setmetatable(constructor(id, t, "followerID"), app.BaseFollower);
end

-- /dump C_Garrison.GetBuildingInfo(1)
-- Garrison Building Lib
-- id, name, texPrefix, icon, description, rank, currencyID, currencyQty, goldQty, buildTime, needsPlan, isPrebuilt, possSpecs, upgrades, canUpgrade, isMaxLevel, hasFollowerSlot = C_Garrison.GetBuildingInfo(BuildingID)
-- https://wow.gamepedia.com/API_C_Garrison.GetBuildingInfo
app.BaseGarrisonBuilding = {
	__index = function(t, key)
		if key == "key" then
			return "buildingID";
		elseif key == "filterID" then
			if t.itemID then return 200; end
		elseif key == "text" then
			return t.link or select(2, C_Garrison.GetBuildingInfo(t.buildingID));
		elseif key == "icon" then
			if t.itemID then
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.link = link;
					t.icon = icon;
					return link;
				end
			end
			return select(4, C_Garrison.GetBuildingInfo(t.buildingID));
		elseif key == "link" then
			if t.itemID then
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.link = link;
					t.icon = icon;
					return link;
				end
			end
		elseif key == "description" then
			return select(5, C_Garrison.GetBuildingInfo(t.buildingID));
		elseif key == "collectible" then
			return t.itemID and app.CollectibleRecipes;
		elseif key == "collected" then
			if app.AccountWideRecipes then
				if GetDataSubMember("CollectedBuildings", t.buildingID) then return 1; end
			else
				if GetTempDataSubMember("CollectedBuildings", t.buildingID) then return 1; end
			end
			if not select(11, C_Garrison.GetBuildingInfo(t.buildingID)) then
				SetTempDataSubMember("CollectedBuildings", t.buildingID, 1);
				SetDataSubMember("CollectedBuildings", t.buildingID, 1);
				return 1;
			end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateGarrisonBuilding = function(id, t)
	return setmetatable(constructor(id, t, "buildingID"), app.BaseGarrisonBuilding);
end

-- Garrison Mission Lib
app.BaseGarrisonMission = {
	__index = function(t, key)
		if key == "key" then
			return "missionID";
		elseif key == "text" then
			return C_Garrison.GetMissionName(t.missionID);
		elseif key == "icon" then
			return "Interface/ICONS/INV_Icon_Mission_Complete_Order";
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateGarrisonMission = function(id, t)
	return setmetatable(constructor(id, t, "missionID"), app.BaseGarrisonMission);
end

-- Garrison Talent Lib
app.BaseGarrisonTalent = {
	__index = function(t, key)
		if key == "key" then
			return "talentID";
		elseif key == "text" then
			local info = t.info;
			if info.name then return info.name; end
		elseif key == "trackable" then
			return true;
		elseif key == "saved" then
			if t.questID then return IsQuestFlaggedCompleted(t.questID) or IsQuestFlaggedCompleted(t.altQuestID); end
			local info = t.info;
			if info.researched then return info.researched; end
		elseif key == "icon" then
			local info = t.info;
			if info.icon then return info.icon; end
			return "Interface/ICONS/INV_Icon_Mission_Complete_Order";
		elseif key == "description" then
			local info = t.info;
			if info.description then return info.description; end
		elseif key == "info" then
			-- TODO: Add "perkSpellID"
			return C_Garrison.GetTalent(t.talentID);
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateGarrisonTalent = function(id, t)
	return setmetatable(constructor(id, t, "talentID"), app.BaseGarrisonTalent);
end

-- Heirloom Lib
(function()
local isWeapon = { 20, 29, 28,  21, 22, 23, 24, 25, 26,  50, 57, 34, 35, 27,  33, 32, 31 };
local armorTextures = {
	"Interface/ICONS/INV_Icon_HeirloomToken_Armor01",
	"Interface/ICONS/INV_Icon_HeirloomToken_Armor02",
	"Interface/ICONS/Inv_leather_draenordungeon_c_01shoulder",
	"Interface/ICONS/inv_mail_draenorquest90_b_01shoulder"
};
local weaponTextures = {
	"Interface/ICONS/INV_Icon_HeirloomToken_Weapon01",
	"Interface/ICONS/INV_Icon_HeirloomToken_Weapon02",
	"Interface/ICONS/inv_weapon_shortblade_112",
	"Interface/ICONS/inv_weapon_shortblade_111"
};
app.BaseHeirloomUnlocked = {
	__index = function(t, key)
		if key == "collectible" then
			return app.CollectibleHeirlooms;
		elseif key == "collected" then
			return C_Heirloom.PlayerHasHeirloom(t.parent.itemID);
		elseif key == "text" then
			return "Unlocked Heirloom";
		elseif key == "description" then
			return "This indicates whether or not you have acquired or purchased the heirloom yet.";
		elseif key == "icon" then
			return "Interface/ICONS/Achievement_GuildPerk_WorkingOvertime_Rank2";
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.BaseHeirloomLevel = {
	__index = function(t, key)
		if key == "collectible" then
			return app.CollectibleHeirlooms;
		elseif key == "collected" then
			return t.level <= (select(5, C_Heirloom.GetHeirloomInfo(t.parent.itemID)) or 0);
		elseif key == "text" then
			return t.link or ("Upgrade Level " .. t.level);
		elseif key == "link" then
			local itemLink = t.itemID;
			if itemLink then
				if t.bonusID then
					if t.bonusID > 0 then
						itemLink = string.format("item:%d::::::::::::1:%d", itemLink, t.bonusID);
					else
						itemLink = string.format("item:%d:::::::::::::", itemLink);
					end
				elseif t.modID then
					itemLink = string.format("item:%d:::::::::::%d:1:3524", itemLink, t.modID);
				end
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(itemLink);
				if link then
					t.link = link;
					t.icon = icon;
					t.retries = nil;
					return link;
				else
					if t.retries then
						t.retries = t.retries + 1;
						if t.retries > app.MaximumItemInfoRetries then
							local itemName = "Item #" .. t.itemID .. "*";
							t.title = "Failed to acquire item information. The item made be invalid or may not have been cached on your server yet.";
							t.icon = "Interface\\Icons\\INV_Misc_QuestionMark";
							t.link = "";
							t.s = nil;
							t.text = itemName;
							return itemName;
						end
					else
						t.retries = 1;
					end
				end
			end
		elseif key == "description" then
			return "This indicates whether or not you have upgraded the heirloom to a certain level.\n\nR.I.P. Gold.\n - Crieve";
		elseif key == "icon" then
			if t.isWeapon then
				return weaponTextures[t.level];
			else
				return armorTextures[t.level];
			end
		elseif key == "level" then
			return 0;
		elseif key == "isWeapon" then
			if t.parent.f and contains(isWeapon, t.parent.f) then
				rawset(t, "isWeapon", true);
				return true;
			end
			rawset(t, "isWeapon", false);
			return false;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.BaseHeirloom = {
	__index = function(t, key)
		if key == "key" then
			return "itemID";
		elseif key == "filterID" then
			return 109;
		elseif key == "collectible" then
			if t.factionID then return app.CollectibleReputations; end
			return t.s and t.s > 0 and app.CollectibleTransmog;
		elseif key == "collected" then
			if t.s and t.s > 0 and GetDataSubMember("CollectedSources", t.s) then return 1; end
			if t.factionID then
				if t.repeatable then
					-- This is used by reputation tokens.
					if app.AccountWideReputations then
						if GetDataSubMember("CollectedFactions", t.factionID) then
							return 1;
						end
					else
						if GetTempDataSubMember("CollectedFactions", t.factionID) then
							return 1;
						end
					end
					
					if select(1, GetFriendshipReputation(t.factionID)) and not select(9, GetFriendshipReputation(t.factionID)) or select(3, GetFactionInfoByID(t.factionID)) == 8 then
						SetTempDataSubMember("CollectedFactions", t.factionID, 1);
						SetDataSubMember("CollectedFactions", t.factionID, 1);
						return 1;
					end
				else
					-- This is used for the Grand Commendations unlocking Bonus Reputation
					if GetDataSubMember("CollectedFactionBonusReputation", t.factionID) then return 1; end
					if select(15, GetFactionInfoByID(t.factionID)) then
						SetTempDataSubMember("CollectedFactionBonusReputation", t.factionID, 1);
						SetDataSubMember("CollectedFactionBonusReputation", t.factionID, 1);
						return 1;
					end
				end
			end
		elseif key == "modID" then
			return 1;
		elseif key == "b" then
			return 2;
		elseif key == "text" then
			return t.link;
		elseif key == "link" then
			return C_Heirloom.GetHeirloomLink(t.itemID) or select(2, GetItemInfo(t.itemID));
		elseif key == "g" then
			if app.CollectibleHeirlooms then
				local total = C_Heirloom.GetHeirloomMaxUpgradeLevel(t.itemID);
				if total then
					local armorTokens = {
						app.CreateItem(167731),	-- Battle-Hardened Heirloom Armor Casing
						app.CreateItem(151614),	-- Weathered Heirloom Armor Casing
						app.CreateItem(122340),	-- Timeworn Heirloom Armor Casing
						app.CreateItem(122338),	-- Ancient Heirloom Armor Casing
					};
					local weaponTokens = {
						app.CreateItem(167732),	-- Battle-Hardened Heirloom Scabbard
						app.CreateItem(151615),	-- Weathered Heirloom Scabbard
						app.CreateItem(122341),	-- Timeworn Heirloom Scabbard
						app.CreateItem(122339),	-- Ancient Heirloom Scabbard
					};
					for i,item in ipairs(armorTokens) do
						CacheFields(item);
						item.g = {};
					end
					for i,item in ipairs(weaponTokens) do
						CacheFields(item);
						item.g = {};
					end
					g = {};
					tinsert(g, setmetatable({ ["parent"] = t }, app.BaseHeirloomUnlocked));
					for i=1,total,1 do
						local l = setmetatable({ ["level"] = i, ["parent"] = t, ["u"] = t.u }, app.BaseHeirloomLevel);
						local c = setmetatable({ ["level"] = i, ["itemID"] = t.itemID, ["parent"] = t, ["u"] = t.u, ["f"] = t.f }, app.BaseHeirloomLevel);
						if l.isWeapon then
							tinsert(weaponTokens[total + 1 - i].g, c);
						else
							tinsert(armorTokens[total + 1 - i].g, c);
						end
						tinsert(g, l);
					end
					BuildGroups(t, g);
					app.UpdateGroups(t, g);
					rawset(t, "g", g);
					return g;
				end
			end
		elseif key == "icon" then
			return select(4, C_Heirloom.GetHeirloomInfo(t.itemID));
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateHeirloom = function(id, t)
	return setmetatable(constructor(id, t, "itemID"), app.BaseHeirloom);
end
end)();

-- Holiday Lib
(function()
local function GetHolidayCache()
	local cache = GetTempDataMember("HOLIDAY_CACHE");
	if not cache then
		cache = {};
		SetTempDataMember("HOLIDAY_CACHE", cache);
		SetDataMember("HOLIDAY_CACHE", cache);
		local date = C_Calendar.GetDate();
		C_Calendar.SetAbsMonth(date.month, date.year);
		for month=1,12,1 do
			C_Calendar.SetMonth(1);
			for day=1,31,1 do
				local numEvents = C_Calendar.GetNumDayEvents(0, day);
				if numEvents > 0 then
					for index=1,numEvents,1 do
						local event = C_Calendar.GetDayEvent(0, day, index)
						if event and event.calendarType == "HOLIDAY" and event.sequenceType == "START" then
							if event.iconTexture then
								local t = cache[event.iconTexture];
								if not t then
									t = {
										["name"] = event.title,
										["icon"] = event.iconTexture,
										["times"] = {},
									};
									cache[event.iconTexture] = t;
								elseif event.iconTexture == 235465 then
									-- Harvest Festival and Pilgrims Bounty use the same icon...
									t = {
										["name"] = event.title,
										["icon"] = event.iconTexture,
										["times"] = {},
									};
									cache[235466] = t;
								end
								tinsert(t.times,
								{
									["start"] = time({
										year=event.startTime.year,
										month=event.startTime.month,
										day=event.startTime.monthDay,
										hour=event.startTime.hour,
										minute=event.startTime.minute,
									}),
									["end"] = time({
										year=event.endTime.year,
										month=event.endTime.month,
										day=event.endTime.monthDay,
										hour=event.endTime.hour,
										minute=event.endTime.minute,
									}),
									["startTime"] = event.startTime,
									["endTime"] = event.endTime,
								});
							end
						end
					end
				end
			end
		end
		C_Calendar.SetAbsMonth(date.month, date.year);
	end
	return cache;
end
app.BaseHoliday = {
	__index = function(t, key)
		if key == "key" then
			return "holidayID";
		elseif key == "icon" then
			if t.holidayID == 235466 then return 235465; end
			return t.holidayID;
		elseif key == "text" then
			return t.info and t.info.name;
		elseif key == "eventType" then
			return 4294967295;
		elseif key == "texcoord" then
			return { 0.0, 0.7109375, 0.0, 0.7109375 };
		elseif key == "info" then
			local info = GetHolidayCache()[t.holidayID];
			if info then
				rawset(t, "info", info);
				return info;
			end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateHoliday = function(id, t)
	return setmetatable(constructor(id, t, "holidayID"), app.BaseHoliday);
end
end)();

-- Illusion Lib
app.BaseIllusion = {
	__index = function(t, key)
		if key == "key" then
			return "illusionID";
		elseif key == "filterID" then
			return 103;
		elseif key == "collectible" then
			return app.CollectibleIllusions;
		elseif key == "collected" then
			return GetDataSubMember("CollectedIllusions", t.illusionID);
		elseif key == "text" then
			if t.itemID then
				local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.link = link;
					t.text = "|cffff80ff[" .. name .. "]|r";
					return t.text;
				end
			end
			return t.silentLink;
		elseif key == "link" then
			if t.itemID then
				local name, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.link = link;
					return link;
				end
			end
		elseif key == "silentLink" then
			return select(3, C_TransmogCollection_GetIllusionSourceInfo(t.illusionID));
		elseif key == "icon" then
			return "Interface/ICONS/INV_Enchant_Disenchant";
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateIllusion = function(id, t)
	return setmetatable(constructor(id, t, "illusionID"), app.BaseIllusion);
end

-- Gear Set Lib
app.BaseGearSet = {
	__index = function(t, key)
		if key == "key" then
			return "setID";
		elseif key == "info" then
			return C_TransmogSets_GetSetInfo(t.setID);
		elseif key == "text" then
			local info = t.info;
			if info then return info.name; end
		elseif key == "description" then
			local info = t.info;
			if info then
				if info.description then
					if info.label then return info.label .. " (" .. info.description .. ")"; end
					return info.description;
				end
				return info.label;
			end
		elseif key == "title" then
			local info = t.info;
			if info then return info.requiredFaction; end
		elseif key == "icon" then
			if t.sources then
				for sourceID, value in pairs(t.sources) do
					local sourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
					if sourceInfo and sourceInfo.invType == 2 then
						local icon = select(5, GetItemInfoInstant(sourceInfo.itemID));
						if icon then rawset(t, "icon", icon); end
						return icon;
					end
				end
			end
			return QUESTION_MARK_ICON;
		elseif key == "sources" then
			local sources = C_TransmogSets.GetSetSources(t.setID);
			if sources then
				rawset(t, "sources", sources);
				return sources;
			end
		elseif key == "header" then
			local info = t.info;
			if info then return info.label; end
		elseif key == "subheader" then
			local info = t.info;
			if info then return info.description; end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateGearSet = function(id, t)
	return setmetatable(constructor(id, t, "setID"), app.BaseGearSet);
end
app.BaseGearSource = {
	__index = function(t, key)
		if key == "collectible" then
			return true;
		elseif key == "info" then
			return C_TransmogCollection_GetSourceInfo(t.s);
		elseif key == "itemID" then
			local info = t.info;
			if info then
				rawset(t, "itemID", info.itemID);
				return info.itemID;
			end
		elseif key == "text" then
			return select(2, GetItemInfo(t.itemID));
		elseif key == "link" then
			return select(2, GetItemInfo(t.itemID));
		elseif key == "invType" then
			local info = t.info;
			if info then return info.invType; end
			return 99;
		elseif key == "icon" then
			return select(5, GetItemInfoInstant(t.itemID));
		elseif key == "specs" then
			return GetItemSpecInfo(t.itemID);
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateGearSource = function(id)
	return setmetatable({ s = id}, app.BaseGearSource);
end
app.BaseGearSetHeader = {
	__index = function(t, key)
		if key == "achievementID" then
			local achievementID = t.altAchID and app.FactionID == 2 and t.altAchID or t.achID;
			if achievementID then
				rawset(t, "achievementID", achievementID);
				return achievementID;
			end
		elseif key == "key" then
			return "setHeaderID";
		elseif key == "text" then
			local info = C_TransmogSets_GetSetInfo(t.setHeaderID);
			if info then return info.label; end
		elseif key == "link" then
			return t.achievementID and GetAchievementLink(t.achievementID);
		elseif key == "icon" then
			return t.achievementID and select(10, GetAchievementInfo(t.achievementID));
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateGearSetHeader = function(id, t)
	return setmetatable(constructor(id, t, "setHeaderID"), app.BaseGearSetHeader);
end
app.BaseGearSetSubHeader = {
	__index = function(t, key)
		if key == "achievementID" then
			local achievementID = t.altAchID and app.FactionID == 2 and t.altAchID or t.achID;
			if achievementID then
				rawset(t, "achievementID", achievementID);
				return achievementID;
			end
		elseif key == "key" then
			return "setSubHeaderID";
		elseif key == "text" then
			local info = C_TransmogSets_GetSetInfo(t.setSubHeaderID);
			if info then return info.description; end
		elseif key == "link" then
			return t.achievementID and GetAchievementLink(t.achievementID);
		elseif key == "icon" then
			return t.achievementID and select(10, GetAchievementInfo(t.achievementID));
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateGearSetSubHeader = function(id, t)
	return setmetatable(constructor(id, t, "setSubHeaderID"), app.BaseGearSetSubHeader);
end

-- Instance Lib
app.BaseInstance = {
	__index = function(t, key)
		if key == "key" then
			return "instanceID";
		elseif key == "text" then
			if t["isRaid"] then return "|cffff8000" .. t.name .. "|r"; end
			return t.name;
		elseif key == "name" then
			return select(1, EJ_GetInstanceInfo(t.instanceID)) or "";
		elseif key == "description" then
			return select(2, EJ_GetInstanceInfo(t.instanceID)) or "";
		elseif key == "icon" then
			return select(6, EJ_GetInstanceInfo(t.instanceID)) or "";
		--elseif key == "link" then
		--	return select(8, EJ_GetInstanceInfo(t.instanceID)) or "";
		elseif key == "saved" then
			return t.locks;
		elseif key == "locks" then
			local locks = GetTempDataSubMember("lockouts", t.name);
			if locks then
				rawset(t, key, locks);
				return locks;
			end
		elseif key == "isLockoutShared" then
			return false;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateInstance = function(id, t)
	return setmetatable(constructor(id, t, "instanceID"), app.BaseInstance);
end

-- Item Lib
app.BaseItem = {
	__index = function(t, key)
		if key == "key" then
			return "itemID";
		elseif key == "collectible" then
			return (t.s and app.CollectibleTransmog) or (t.questID and not t.repeatable and not t.isBreadcrumb and app.CollectibleQuests) or (t.factionID and app.CollectibleReputations);
		elseif key == "collected" then
			if t.s and t.s ~= 0 and GetDataSubMember("CollectedSources", t.s) then
				return 1;
			end
			if t.factionID then
				if t.repeatable then
					-- This is used by reputation tokens.
					if app.AccountWideReputations then
						if GetDataSubMember("CollectedFactions", t.factionID) then
							return 1;
						end
					else
						if GetTempDataSubMember("CollectedFactions", t.factionID) then
							return 1;
						end
					end
					
					if select(1, GetFriendshipReputation(t.factionID)) and not select(9, GetFriendshipReputation(t.factionID)) or select(3, GetFactionInfoByID(t.factionID)) == 8 then
						SetTempDataSubMember("CollectedFactions", t.factionID, 1);
						SetDataSubMember("CollectedFactions", t.factionID, 1);
						return 1;
					end
				else
					-- This is used for the Grand Commendations unlocking Bonus Reputation
					if GetDataSubMember("CollectedFactionBonusReputation", t.factionID) then return 1; end
					if select(15, GetFactionInfoByID(t.factionID)) then
						SetTempDataSubMember("CollectedFactionBonusReputation", t.factionID, 1);
						SetDataSubMember("CollectedFactionBonusReputation", t.factionID, 1);
						return 1;
					end
				end
			end
			return t.saved;
		elseif key == "text" then
			return t.link;
		elseif key == "link" then
			local itemLink = t.itemID;
			if itemLink then
				if t.bonusID then
					if t.bonusID > 0 then
						itemLink = string.format("item:%d::::::::::::1:%d", itemLink, t.bonusID);
					else
						itemLink = string.format("item:%d:::::::::::::", itemLink);
					end
				elseif t.modID then
					itemLink = string.format("item:%d:::::::::::%d:1:3524", itemLink, t.modID);
				end
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(itemLink);
				if link then
					t.link = link;
					t.icon = icon;
					t.retries = nil;
					return link;
				else
					if t.retries then
						t.retries = t.retries + 1;
						if t.retries > app.MaximumItemInfoRetries then
							local itemName = "Item #" .. t.itemID .. "*";
							t.title = "Failed to acquire item information. The item made be invalid or may not have been cached on your server yet.";
							t.icon = "Interface\\Icons\\INV_Misc_QuestionMark";
							t.link = "";
							t.s = nil;
							t.text = itemName;
							return itemName;
						end
					else
						t.retries = 1;
					end
				end
			end
		elseif key == "trackable" then
			return t.questID;
		elseif key == "repeatable" then
			return t.isDaily or t.isWeekly;
		elseif key == "saved" then
			return IsQuestFlaggedCompleted(t.questID) or IsQuestFlaggedCompleted(t.altQuestID);
		elseif key == "modID" then
			return 1;
		elseif key == "name" then
			return t.link and GetItemInfo(t.link);
		elseif key == "specs" then
			return GetItemSpecInfo(t.itemID);
		elseif key == "tsm" then
			local itemLink = t.itemID;
			if itemLink then
				if t.bonusID then
					if t.bonusID > 0 then
						return string.format("i:%d:0:1:%d", itemLink, t.bonusID);
					else
						return string.format("i:%d", itemLink);
					end
				--elseif t.modID then
					-- NOTE: At this time, TSM3 does not support modID. (RIP)
					--return string.format("i:%d:%d:1:3524", itemLink, t.modID);
				end
				return string.format("i:%d", itemLink);
			end
		elseif key == "b" then
			return 2;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateItem  = function(id, t)
	return setmetatable(constructor(id, t, "itemID"), app.BaseItem);
end

-- Item Source Lib
app.BaseItemSource = {
	__index = function(t, key)
		if key == "key" then
			return "s";
		elseif key == "collectible" then
			return app.CollectibleTransmog;
		elseif key == "collected" then
			return GetDataSubMember("CollectedSources", t.s);
		elseif key == "text" then
			return t.link;
		elseif key == "link" then
			local itemLink = t.itemID;
			if itemLink then
				if t.bonusID then
					if t.bonusID > 0 then
						itemLink = string.format("item:%d::::::::::::1:%d", itemLink, t.bonusID);
					else
						itemLink = string.format("item:%d:::::::::::::", itemLink);
					end
				elseif t.modID then
					itemLink = string.format("item:%d:::::::::::%d:1:3524", itemLink, t.modID);
				end
			end
			local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(itemLink);
			if link then
				t.link = link;
				t.icon = icon;
				t.retries = nil;
				return link;
			else
				if t.retries then
					t.retries = t.retries + 1;
					if t.retries > app.MaximumItemInfoRetries then
						local itemName = "Item #" .. t.itemID .. "*";
						t.title = "Failed to acquire item information. The item made be invalid or may not have been cached on your server yet.";
						t.icon = "Interface\\Icons\\INV_Misc_QuestionMark";
						t.link = "";
						t.text = itemName;
						return itemName;
					end
				else
					t.retries = 1;
				end
			end
		elseif key == "modID" then
			return 1;
		elseif key == "name" then
			return t.link and GetItemInfo(t.link);
		elseif key == "specs" then
			return GetItemSpecInfo(t.itemID);
		elseif key == "tsm" then
			local itemLink = t.itemID;
			if itemLink then
				if t.bonusID then
					if t.bonusID > 0 then
						return string.format("i:%d:0:1:%d", itemLink, t.bonusID);
					else
						return string.format("i:%d", itemLink);
					end
				--elseif t.modID then
					-- NOTE: At this time, TSM3 does not support modID. (RIP)
					--return string.format("i:%d:%d:1:3524", itemLink, t.modID);
				end
				return string.format("i:%d", itemLink);
			end
		elseif key == "s" then
			return 0;
		elseif key == "b" then
			return 2;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateItemSource = function(sourceID, itemID, t)
	t = setmetatable(constructor(sourceID, t, "s"), app.BaseItemSource);
	t.itemID = itemID;
	return t;
end

-- Map Lib
app.BaseMap = {
	__index = function(t, key)
		if key == "achievementID" then
			local achievementID = t.altAchID and app.FactionID == 2 and t.altAchID or t.achID;
			if achievementID then
				rawset(t, "achievementID", achievementID);
				return achievementID;
			end
		elseif key == "key" then
			return "mapID";
		elseif key == "text" then
			if t["isRaid"] then return "|cffff8000" .. app.GetMapName(t.mapID) .. "|r"; end
			return app.GetMapName(t.mapID);
		elseif key == "link" then
			return t.achievementID and GetAchievementLink(t.achievementID);
		elseif key == "icon" then
			return t.achievementID and select(10, GetAchievementInfo(t.achievementID)) or "Interface/ICONS/INV_Misc_Map09";
		elseif key == "lvl" then
			return select(1, C_Map.GetMapLevels(t.mapID));
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateMap = function(id, t)
	return setmetatable(constructor(id, t, "mapID"), app.BaseMap);
end

-- Mount Lib
app.BaseMount = {
	__index = function(t, key)
		if key == "key" then
			return "spellID";
		elseif key == "filterID" then
			return 100;
		elseif key == "collectible" then
			return app.CollectibleMounts;
		elseif key == "collected" then
			if app.RecipeChecker("CollectedSpells", t.spellID) then
				return GetTempDataSubMember("CollectedSpells", t.spellID) and 1 or 2;
			end
			if IsSpellKnown(t.spellID) or (t.questID and IsQuestFlaggedCompleted(t.questID) or IsQuestFlaggedCompleted(t.altQuestID)) then
				SetTempDataSubMember("CollectedSpells", t.spellID, 1);
				SetDataSubMember("CollectedSpells", t.spellID, 1);
				return 1;
			end
		elseif key == "b" then
			return (t.parent and t.parent.b) or 1;
		elseif key == "text" then
			return "|cffb19cd9" .. (select(1, GetSpellInfo(t.spellID)) or "???") .. "|r";
			--return select(1, GetSpellLink(t.spellID)) or select(1, GetSpellInfo(t.spellID)) or ("Spell #" .. t.spellID);
		elseif key == "description" then
			local mountID = t.mountID;
			if mountID then return select(2, C_MountJournal_GetMountInfoExtraByID(mountID)); end
		elseif key == "link" then
			if t.itemID then
				local link = select(2, GetItemInfo(t.itemID));
				if link then
					t.link = link;
					return link;
				end
			end
			return select(1, GetSpellLink(t.spellID));
		elseif key == "icon" then
			return select(3, GetSpellInfo(t.spellID));
		elseif key == "displayID" then
			local mountID = t.mountID;
			if mountID then return select(1, C_MountJournal_GetMountInfoExtraByID(mountID)); end
		elseif key == "mountID" then
			local temp = GetTempDataMember("MOUNT_SPELLID_TO_MOUNTID");
			if not temp then
				-- Harvest the Spell IDs for Conversion.
				temp = GetTempDataMember("MOUNT_SPELLID_TO_MOUNTID", {});
				for i,mountID in ipairs(C_MountJournal.GetMountIDs()) do
					local spellID = select(2, C_MountJournal_GetMountInfoByID(mountID));
					if spellID then temp[spellID] = mountID; end
				end
				
				-- Assign to the temporary data container.
				SetTempDataMember("MOUNT_SPELLID_TO_MOUNTID", temp);
			end
			
			local mountID = temp[t.spellID];
			if mountID then return mountID; end
		elseif key == "name" then
			local mountID = t.mountID;
			if mountID then return C_MountJournal_GetMountInfoByID(mountID); end
		elseif key == "tsm" then
			if t.itemID then return string.format("i:%d", t.itemID); end
			if t.parent and t.parent.itemID then return string.format("i:%d", t.parent.itemID); end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateMount = function(id, t)
	return setmetatable(constructor(id, t, "spellID"), app.BaseMount);
end

-- Music Roll Lib
(function()
local completed = false;
local frame = CreateFrame("FRAME", nil, app);
frame:SetSize(1, 1);
frame:Hide();
frame.events = {};
frame:SetScript("OnEvent", function(self, e, ...)
	if IsQuestFlaggedCompleted(38356) or IsQuestFlaggedCompleted(37961) then
		completed = true;
		frame:UnregisterAllEvents();
	end
end);
frame:RegisterEvent("PLAYER_LOGIN");
frame:RegisterEvent("QUEST_TURNED_IN");
frame:RegisterEvent("QUEST_LOG_UPDATE");
app.BaseMusicRoll = {
	__index = function(t, key)
		if key == "key" then
			return "questID";
		elseif key == "filterID" then
			return 108;
		elseif key == "collectible" or key == "trackable" then
			return app.CollectibleMusicRolls;
		elseif key == "collected" or key == "saved" then
			if app.AccountWideMusicRolls then
				if GetDataSubMember("CollectedMusicRolls", t.questID) then
					return 1;
				end
			else
				if GetTempDataSubMember("CollectedMusicRolls", t.questID) then
					return 1;
				end
			end
			if IsQuestFlaggedCompleted(t.questID) then
				SetTempDataSubMember("CollectedMusicRolls", t.questID, 1);
				SetDataSubMember("CollectedMusicRolls", t.questID, 1);
				return 1;
			end
		elseif key == "lvl" then
			return 100;
		elseif key == "text" then
			return t.link;
		elseif key == "link" then
			local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
			if link then
				t.link = link;
				t.icon = icon;
				return link;
			end
		elseif key == "description" then
			local description = "These are unlocked per-character and are not currently shared across your account. If someone at Blizzard is reading this, it would be really swell if you made these account wide.\n\nYou must manually refresh the addon by Shift+Left clicking the header for this to be detected.";
			if not completed then
				description = description .. "\n\nYou must first unlock the Music Rolls by completing the Bringing the Bass quest in your garrison for this item to drop.";
			end
			return description;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
end)();
app.CreateMusicRoll = function(questID, t)
	return setmetatable(constructor(questID, t, "questID"), app.BaseMusicRoll);
end

-- NPC Lib
app.BaseNPC = {
	__index = function(t, key)
		if key == "achievementID" then
			local achievementID = t.altAchID and app.FactionID == 2 and t.altAchID or t.achID;
			if achievementID then
				rawset(t, "achievementID", achievementID);
				return achievementID;
			end
		elseif key == "key" then
			return "npcID";
		elseif key == "text" then
			if t["isRaid"] and t.name then return "|cffff8000" .. t.name .. "|r"; end
			return t.name;
		elseif key == "name" then
			if t.npcID > 0 then
				return t.npcID > 0 and NPCNameFromID[t.npcID];
			else
				return L["NPC_ID_NAMES"][t.npcID];
			end
		elseif key == "title" then
			if t.npcID > 0 then return NPCTitlesFromID[t.npcID]; end
		elseif key == "link" then
			return (t.achievementID and GetAchievementLink(t.achievementID));
		elseif key == "icon" then
			return L["NPC_ID_ICONS"][t.npcID] 
				or (t.achievementID and select(10, GetAchievementInfo(t.achievementID))) 
				or (t.parent and t.parent.npcID == -2 and "Interface\\Icons\\Achievement_Character_Human_Male")
				or "Interface\\Icons\\INV_Misc_Head_Human_01";
		elseif key == "creatureID" then
			return t.npcID;
		elseif key == "trackable" then
			return t.questID;
		elseif key == "collectible" then
			return t.questID and not t.repeatable and not t.isBreadcrumb and app.CollectibleQuests;
		elseif key == "saved" then
			if t.questID and IsQuestFlaggedCompleted(t.questID) then
				return 1;
			end
			if t.altQuestID and IsQuestFlaggedCompleted(t.altQuestID) then
				return 1;
			end
		elseif key == "collected" then
			return t.saved;
		elseif key == "repeatable" then
			return t.isDaily or t.isWeekly;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateNPC = function(id, t)
	return setmetatable(constructor(id, t, "npcID"), app.BaseNPC);
end

-- Object Lib (as in "World Object")
app.BaseObject = {
	__index = function(t, key)
		if key == "key" then
			return "objectID";
		elseif key == "text" then
			local name = L["OBJECT_ID_NAMES"][t.objectID] or ("Object ID #" .. t.objectID);
			if t["isRaid"] then name = "|cffff8000" .. name .. "|r"; end
			rawset(t, "text", name);
			return name;
		elseif key == "icon" then
			return L["OBJECT_ID_ICONS"][t.objectID] or "Interface\\Icons\\INV_Misc_Bag_10";
		elseif key == "collectible" then
			return (t.questID and not t.repeatable and not t.isBreadcrumb and app.CollectibleQuests);
		elseif key == "collected" then
			return t.saved;
		elseif key == "trackable" then
			return t.questID;
		elseif key == "saved" then
			return IsQuestFlaggedCompleted(t.questID) or IsQuestFlaggedCompleted(t.altQuestID);
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateObject = function(id, t)
	return setmetatable(constructor(id, t, "objectID"), app.BaseObject);
end

-- Pet Ability Lib
app.BasePetAbility = {
	__index = function(t, key)
		if key == "key" then
			return "petAbilityID";
		elseif key == "text" then
			return select(2, C_PetBattles.GetAbilityInfoByID(t.petAbilityID));
		elseif key == "icon" then
			return select(3, C_PetBattles.GetAbilityInfoByID(t.petAbilityID));
		elseif key == "description" then
			return select(5, C_PetBattles.GetAbilityInfoByID(t.petAbilityID));
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreatePetAbility = function(id, t)
	return setmetatable(constructor(id, t, "petAbilityID"), app.BasePetAbility);
end

-- Pet Type Lib
app.BasePetType = {
	__index = function(t, key)
		if key == "key" then
			return "petTypeID";
		elseif key == "filterID" then
			return 101;
		elseif key == "text" then
			return _G["BATTLE_PET_NAME_" .. t.petTypeID];
		elseif key == "icon" then
			return "Interface\\Icons\\Icon_PetFamily_"..PET_TYPE_SUFFIX[t.petTypeID];
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreatePetType = function(id, t)
	return setmetatable(constructor(id, t, "petTypeID"), app.BasePetType);
end

-- Profession Lib
local SkillIDToSpellID = setmetatable({
	[171] = 2259,	-- Alchemy
	[794] = 158762,	-- Arch
	[164] = 2018,	-- Blacksmithing
	[185] = 2550,	-- Cooking
	[333] = 7411,	-- Enchanting
	[202] = 4036,	-- Engineering
	[356] = 7620,	-- Fishing
	[129] = 3273,	-- First Aid
	[182] = 2366,	-- Herb Gathering
	[773] = 45357,	-- Inscription
	[755] = 25229,	-- Jewelcrafting
	[165] = 2108,	-- Leatherworking
	[186] = 2575,	-- Mining
	[393] = 8613,	-- Skinning
	[197] = 3908,	-- Tailoring
	[960] = 53428,  -- Runeforging
}, {__index = function(t,k) return(106727) end})
app.BaseProfession = {
	__index = function(t, key)
		if key == "key" then
			return "requireSkill";
		elseif key == "text" then
			if t.requireSkill == 129 then return select(1, GetSpellInfo(t.spellID)); end
			return C_TradeSkillUI.GetTradeSkillDisplayName(t.requireSkill);
		elseif key == "icon" then
			if t.requireSkill == 129 then return select(3, GetSpellInfo(t.spellID)); end
			return C_TradeSkillUI.GetTradeSkillTexture(t.requireSkill);
		elseif key == "spellID" then
			return SkillIDToSpellID[t.requireSkill];
		elseif key == "skillID" then
			return t.requireSkill;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateProfession = function(id, t)
	return setmetatable(constructor(id, t, "requireSkill"), app.BaseProfession);
end

-- Quest Lib
app.BaseQuest = {
	__index = function(t, key)
		if key == "key" then
			return "questID";
		elseif key == "text" then
			if rawget(t, "title") then
				rawset(t, "text", rawget(t, "title"));
				t.title = false;
				return t.text;
			end
			local questName = t.questName;
			if t.retries and t.retries > 120 then
				if t.npcID then
					if t.npcID > 0 then
						return t.npcID > 0 and NPCNameFromID[t.npcID];
					else
						return L["NPC_ID_NAMES"][t.npcID];
					end
				end
			end
			return questName;
		elseif key == "questName" then
			local questID = t.altQuestID and app.FactionID == 2 and t.altQuestID or t.questID;
			local questName = QuestTitleFromID[questID];
			if questName then
				t.retries = nil;
				t.title = nil;
				return "[" .. questName .. "]";
			end
			if t.retries and t.retries > 120 then
				return "[Quest #" .. questID .. "*]";
			else
				t.retries = (t.retries or 0) + 1;
			end
		elseif key == "link" then
			return "quest:" .. (t.altQuestID and app.FactionID == 2 and t.altQuestID or t.questID);
		elseif key == "icon" then
			return "Interface\\Icons\\Achievement_Quests_Completed_08";
		elseif key == "trackable" then
			return true;
		elseif key == "collectible" then
			return not t.repeatable and not t.isBreadcrumb and app.CollectibleQuests;
		elseif key == "collected" then
			return t.saved;
		elseif key == "repeatable" then
			return t.isDaily or t.isWeekly;
		elseif key == "saved" then
			if IsQuestFlaggedCompleted(t.questID) then
				return 1;
			end
			if t.altQuestID and IsQuestFlaggedCompleted(t.altQuestID) then
				return 1;
			end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateQuest = function(id, t)
	return setmetatable(constructor(id, t, "questID"), app.BaseQuest);
end

-- Recipe Lib
app.BaseRecipe = {
	__index = function(t, key)
		if key == "key" then
			return "spellID";
		elseif key == "filterID" then
			return 200;
		elseif key == "text" then
			return t.link;
		elseif key == "icon" then
			if t.itemID then
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.link = link;
					t.icon = icon;
					return link;
				end
			end
			return select(3, GetSpellInfo(t.spellID)) or (t.requireSkill and select(3, GetSpellInfo(t.requireSkill)));
		elseif key == "link" then
			if t.itemID then
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.link = link;
					t.icon = icon;
					return link;
				end
			end
			return select(1, GetSpellLink(t.spellID));
		elseif key == "collectible" then
			return app.CollectibleRecipes;
		elseif key == "collected" then
			if app.RecipeChecker("CollectedSpells", t.spellID) then
				return GetTempDataSubMember("CollectedSpells", t.spellID) and 1 or 2;
			end
			if IsSpellKnown(t.spellID) then
				SetTempDataSubMember("CollectedSpells", t.spellID, 1);
				SetDataSubMember("CollectedSpells", t.spellID, 1);
				return 1;
			end
		elseif key == "name" then
			return t.itemID and GetItemInfo(t.itemID);
		elseif key == "specs" then
			if t.itemID then
				return GetItemSpecInfo(t.itemID);
			end
		elseif key == "tsm" then
			if t.itemID then
				return string.format("i:%d", t.itemID);
			end
		elseif key == "skillID" then
			return t.requireSkill;
		elseif key == "b" then
			return t.itemID and app.AccountWideRecipes and 2;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateRecipe = function(id, t)
	return setmetatable(constructor(id, t, "spellID"), app.BaseRecipe);
end

-- Selfie Filters Lib
app.BaseSelfieFilter = {
	__index = function(t, key)
		if key == "key" then
			return "questID";
		elseif key == "text" then
			if t.npcID then
				if t.npcID > 0 then
					return t.npcID > 0 and NPCNameFromID[t.npcID];
				else
					return L["NPC_ID_NAMES"][t.npcID];
				end
			end
			return t.questName;
		elseif key == "questName" then
			local questID = t.questID;
			local questName = QuestTitleFromID[questID];
			if questName then
				t.retries = nil;
				t.title = nil;
				return "[" .. questName .. "]";
			end
			if t.retries and t.retries > 120 then
				return "[Quest #" .. questID .. "*]";
			else
				t.retries = (t.retries or 0) + 1;
			end
		elseif key == "link" then
			return "quest:" .. t.questID;
		elseif key == "icon" then
			return "Interface\\Icons\\INV_Misc_ SelfieCamera_02";
		elseif key == "trackable" then
			return true;
		elseif key == "collectible" then
			return app.CollectibleSelfieFilters;
		elseif key == "collected" then
			return t.saved;
		elseif key == "saved" then
			if app.AccountWideSelfieFilters then
				if GetDataSubMember("CollectedSelfieFilters", t.questID) then
					return 1;
				end
			else
				if GetTempDataSubMember("CollectedSelfieFilters", t.questID) then
					return 1;
				end
			end
			if IsQuestFlaggedCompleted(t.questID) then
				SetTempDataSubMember("CollectedSelfieFilters", t.questID, 1);
				SetDataSubMember("CollectedSelfieFilters", t.questID, 1);
				return 1;
			end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateSelfieFilter = function(id, t)
	return setmetatable(constructor(id, t, "questID"), app.BaseSelfieFilter);
end

-- Spell Lib
app.BaseSpell = {
	__index = function(t, key)
		if key == "key" then
			return "spellID";
		elseif key == "text" then
			return t.link;
		elseif key == "icon" then
			return select(3, GetSpellInfo(t.spellID));
		elseif key == "link" then
			if t.itemID and t.filterID ~= 200 and t.f ~= 200 then
				local _, link, _, _, _, _, _, _, _, icon = GetItemInfo(t.itemID);
				if link then
					t.link = link;
					t.icon = icon;
					return link;
				end
			end
			return select(1, GetSpellLink(t.spellID));
		elseif key == "collectible" then
			return false;
		elseif key == "collected" then
			if app.RecipeChecker("CollectedSpells", t.spellID) then
				return GetTempDataSubMember("CollectedSpells", t.spellID) and 1 or 2;
			end
			if IsSpellKnown(t.spellID) then
				SetTempDataSubMember("CollectedSpells", t.spellID, 1);
				SetDataSubMember("CollectedSpells", t.spellID, 1);
				return 1;
			end
		elseif key == "name" then
			return t.itemID and GetItemInfo(t.itemID);
		elseif key == "specs" then
			if t.itemID then
				return GetItemSpecInfo(t.itemID);
			end
		elseif key == "tsm" then
			if t.itemID then
				return string.format("i:%d", t.itemID);
			end
		elseif key == "skillID" then
			return t.requireSkill;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateSpell = function(id, t)
	return setmetatable(constructor(id, t, "spellID"), app.BaseSpell);
end

-- Species Lib
(function()
local collectedSpecies = {};
app.events.NEW_PET_ADDED = function(petID)
	local speciesID = select(1, C_PetJournal.GetPetInfoByPetID(petID));
	--print("NEW_PET_ADDED", petID, speciesID);
	if speciesID and C_PetJournal.GetNumCollectedInfo(speciesID) > 0 and not collectedSpecies[speciesID] then
		collectedSpecies[speciesID] = true;
		UpdateSearchResults(SearchForField("speciesID", speciesID));
		app:PlayFanfare();
		wipe(searchCache);
		collectgarbage();
	end
end
app.events.PET_JOURNAL_PET_DELETED = function(petID)
	-- /dump C_PetJournal.GetPetInfoByPetID("BattlePet-0-00001006503D")
	-- local speciesID = select(1, C_PetJournal.GetPetInfoByPetID(petID));
	-- NOTE: Above APIs do not work in the DELETED API, THANKS BLIZZARD
	-- print("PET_JOURNAL_PET_DELETED", petID);
	
	-- Check against all of the collected species for a species that is no longer 1/X
	local atLeastOne = false;
	for speciesID,collected in pairs(collectedSpecies) do
		if C_PetJournal.GetNumCollectedInfo(speciesID) < 1 then
			atLeastOne = true;
			break;
		end
	end
	if atLeastOne then
		wipe(collectedSpecies);
		app:PlayRemoveSound();
		
		-- Refresh the Collection Windows!
		app:RefreshData(false, true);
		wipe(searchCache);
		collectgarbage();
	end
end
app.BaseSpecies = {
	__index = function(t, key)
		if key == "key" then
			return "speciesID";
		elseif key == "filterID" then
			return 101;
		elseif key == "collectible" then
			return app.CollectibleBattlePets;
		elseif key == "collected" then
			if collectedSpecies[t.speciesID] or select(1, C_PetJournal.GetNumCollectedInfo(t.speciesID)) > 0 then
				collectedSpecies[t.speciesID] = true;
				return 1;
			end
		elseif key == "text" then
			return "|cff0070dd" .. (select(1, C_PetJournal.GetPetInfoBySpeciesID(t.speciesID)) or "???") .. "|r";
		elseif key == "icon" then
			return select(2, C_PetJournal.GetPetInfoBySpeciesID(t.speciesID));
		elseif key == "description" then
			return select(6, C_PetJournal.GetPetInfoBySpeciesID(t.speciesID));
		elseif key == "displayID" then
			return select(12, C_PetJournal.GetPetInfoBySpeciesID(t.speciesID));
		elseif key == "name" then
			return select(1, C_PetJournal.GetPetInfoBySpeciesID(t.speciesID));
		elseif key == "link" then
			if t.itemID then
				local link = select(2, GetItemInfo(t.itemID));
				if link then
					t.link = link;
					return link;
				end
			end
		elseif key == "tsm" then
			return string.format("p:%d:1:3", t.speciesID);
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateSpecies = function(id, t)
	return setmetatable(constructor(id, t, "speciesID"), app.BaseSpecies);
end
end)();

-- Tier Lib
(function()
	local tierIcons = {
		"Interface\\Icons\\expansionicon_classic", 					-- Classic
		"Interface\\Icons\\expansionicon_burningcrusade",			-- Burning Crusade
		"Interface\\Icons\\expansionicon_wrathofthelichking",		-- Wrath
		"Interface\\Icons\\expansionicon_cataclysm",				-- Cata
		"Interface\\Icons\\expansionicon_mistsofpandaria",			-- Mists
		"Interface\\Icons\\Achievement_boss_hellfire_archimonde",	-- WoD
		"Interface\\Icons\\achievements_zone_brokenshore",			-- Legion
		"Interface\\Icons\\achievement_cloudnine",					-- Battle For Azeroth
	};
	local tierLevel = {
		1, 		-- Classic
		57,		-- Burning Crusade
		57,		-- Wrath
		77,		-- Cata
		77,		-- Mists
		90,		-- WoD
		98,		-- Legion
		108,	-- Battle For Azeroth
	};
	local tierDescription = {
		"Four years after the Battle of Mount Hyjal, tensions between the Alliance & the Horde begin to arise once again. Intent on settling the arid region of Durotar, Thrall's new Horde expanded its ranks, inviting the undead Forsaken to join orcs, tauren, & trolls. Meanwhile, dwarves, gnomes & the ancient night elves pledged their loyalties to a reinvigorated Alliance, guided by the human kingdom of Stormwind. After Stormwind's king, Varian Wrynn, mysteriously disappeared, Highlord Bolvar Fordragon served as Regent but his service was marred by the manipulations & mind control of the Onyxia, who ruled in disguise as a human noblewoman. As heroes investigated Onyxia's manipulations, ancient foes surfaced in lands throughout the world to menace Horde & Alliance alike.", 					-- Classic
		"The Burning Crusade is the first expansion. Its main features include an increase of the level cap up to 70, the introduction of the blood elves & the draenei as playable races, & the addition of the world of Outland, along with many new zones, dungeons, items, quests, & monsters.",			-- Burning Crusade
		"Wrath of the Lich King is the second expansion. The majority of the expansion content takes place in Northrend & centers around the plans of the Lich King. Content highlights include the increase of the level cap from 70 to 80, the introduction of the death knight Hero class, & new PvP/World PvP content.",		-- Wrath
		"Cataclysm is the third expansion. Set primarily in a dramatically reforged Kalimdor & Eastern Kingdoms on the world of Azeroth, the expansion follows the return of Deathwing, who causes a new Sundering as he makes his cataclysmic re-entrance into the world from Deepholm. Cataclysm returns players to the two continents of Azeroth for most of their campaigning, opening new zones such as Mount Hyjal, the sunken world of Vashj'ir, Deepholm, Uldum and the Twilight Highlands. It includes two new playable races, the worgen & the goblins. The expansion increases level cap to 85, adds the ability to fly in Kalimdor & Eastern Kingdoms, introduces Archaeology & reforging, & restructures the world itself.",				-- Cata
		"Mists of Pandaria is the fourth expansion pack. The expansion refocuses primarily on the war between the Alliance & Horde, in the wake of the accidental rediscovery of Pandaria. Adventurers rediscover the ancient pandaren people, whose wisdom will help guide them to new destinies; the Pandaren Empire's ancient enemy, the mantid; and their legendary oppressors, the enigmatic mogu. The land changes over time & the conflict between Varian Wrynn & Garrosh Hellscream escalates. As civil war wracks the Horde, the Alliance & forces in the Horde opposed to Hellscream's violent uprising join forces to take the battle directly to Hellscream & his Sha-touched allies in Orgrimmar.",			-- Mists
		"Warlords of Draenor is the fifth expansion. Across Draenor's savage jungles & battle-scarred plains, Azeroth's heroes will engage in a mythic conflict involving mystical draenei champions & mighty orc clans, & cross axes with the likes of Grommash Hellscream, Blackhand, & Ner’zhul at the height of their primal power. Players will need to scour this unwelcoming land in search of allies to help build a desperate defense against the old Horde’s formidable engine of conquest, or else watch their own world’s bloody, war-torn history repeat itself.",	-- WoD
		"Legion is the sixth expansion. Gul'dan is expelled into Azeroth to reopen the Tomb of Sargeras & the gateway to Argus, commencing the third invasion of the Burning Legion. After the defeat at the Broken Shore, the defenders of Azeroth search for the Pillars of Creation, which were Azeroth's only hope for closing the massive demonic portal at the heart of the Tomb. However, the Broken Isles came with their own perils to overcome, from Xavius, to God-King Skovald, to the nightborne, & to Tidemistress Athissa. Khadgar moved Dalaran to the shores of this land, the city serves as a central hub for the heroes. The death knights of Acherus also took their floating necropolis to the Isles. The heroes of Azeroth sought out legendary artifact weapons to wield in battle, but also found unexpected allies in the form of the Illidari. Ongoing conflict between the Alliance & the Horde led to the formation of the class orders, with exceptional commanders putting aside faction to lead their classes in the fight against the Legion.",-- Legion
		"Battle for Azeroth is the seventh expansion. Azeroth paid a terrible price to end the apocalyptic march of the Legion's crusade—but even as the world's wounds are tended, it is the shattered trust between the Alliance and Horde that may prove the hardest to mend. In Battle for Azeroth, the fall of the Burning Legion sets off a series of disastrous incidents that reignites the conflict at the heart of the Warcraft saga. As a new age of warfare begins, Azeroth's heroes must set out on a journey to recruit new allies, race to claim the world's mightiest resources, and fight on several fronts to determine whether the Horde or Alliance will lead Azeroth into its uncertain future.", -- BfA
	};
	app.BaseTier = {
		__index = function(t, key)
			if key == "key" then
				return "tierID";
			elseif key == "text" then
				return EJ_GetTierInfo(t.tierID);
			elseif key == "icon" then
				return tierIcons[t.tierID];
			elseif key == "description" then
				return tierDescription[t.tierID];
			elseif key == "lvl" then
				return tierLevel[t.tierID];
			else
				-- Something that isn't dynamic.
				return table[key];
			end
		end
	};
	app.CreateTier = function(id, t)
		return setmetatable(constructor(id, t, "tierID"), app.BaseTier);
	end
end)();

-- Title Lib
app.BaseTitle = {
	__index = function(t, key)
		if key == "key" then
			return "titleID";
		elseif key == "filterID" then
			return 110;
		elseif key == "icon" then
			return "Interface\\Icons\\Achievement_Guild_DoctorIsIn";
		elseif key == "description" then
			return "Titles are tracked across your account, however, your individual character must qualify for certain titles to be usable on that character.";
		elseif key == "text" then
			local name = t.playerTitle;
			if name then
				name = "|cff00ccff" .. name .. "|r";
				rawset(t, "name", name);
				return name;
			end
		elseif key == "playerTitle" then
			local name = GetTitleName(t.titleID);
			if name then
				local style = t.style;
				if style == 0 then
					-- Prefix
					return name .. UnitName("player");
				elseif style == 1 then
					-- Player Name First
					return UnitName("player") .. name;
				elseif style == 2 then
					-- Player Name First (with space)
					return UnitName("player") .. " " .. name;
				elseif style == 3 then
					-- Comma Separated
					return UnitName("player") .. ", " .. name;
				end
			end
		elseif key == "style" then
			local name = GetTitleName(t.titleID);
			if name then
				local first = string.sub(name, 1, 1);
				if first == " " then
					-- Suffix
					first = string.sub(name, 2, 2);
					if first == string.upper(first) then
						-- Comma Separated
						return 3;
					end
					
					-- Player Name First
					return 1;
				else
					local last = string.sub(name, -1);
					if last == " " then
						-- Prefix
						return 0;
					end
				
					-- Suffix
					if first == string.lower(first) then
						-- Player Name First with a space
						return 2;
					end
					
					-- Comma Separated
					return 3;
				end
			end
			
			return 1;	-- Player Name First
		elseif key == "collectible" then
			return app.CollectibleTitles;
		elseif key == "trackable" then
			return true;
		elseif key == "saved" or key == "collected" then
			if app.AccountWideTitles then
				if GetDataSubMember("CollectedTitles", t.titleID) then
					return 1;
				end
			else
				if GetTempDataSubMember("CollectedTitles", t.titleID) then
					return 1;
				end
			end
			if IsTitleKnown(t.titleID) then
				SetTempDataSubMember("CollectedTitles", t.titleID, 1);
				SetDataSubMember("CollectedTitles", t.titleID, 1);
				return 1;
			end
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateTitle = function(id, t)
	return setmetatable(constructor(id, t, "titleID"), app.BaseTitle);
end

-- Toy Lib
app.BaseToy = {
	__index = function(t, key)
		if key == "key" then
			return "itemID";
		elseif key == "filterID" then
			return 102;
		elseif key == "collectible" then
			return app.CollectibleToys;
		elseif key == "collected" then
			return GetDataSubMember("CollectedToys", t.itemID);
		elseif key == "isToy" then
			return true;
		elseif key == "text" then
			return C_ToyBox_GetToyLink(t.itemID);
		elseif key == "link" then
			return C_ToyBox_GetToyLink(t.itemID);
		elseif key == "icon" then
			return select(3, C_ToyBox_GetToyInfo(t.itemID));
		elseif key == "name" then
			return select(2, C_ToyBox_GetToyInfo(t.itemID));
		elseif key == "tsm" then
			return string.format("i:%d", t.itemID);
		elseif key == "b" then
			return 2;
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateToy = function(id, t)
	return setmetatable(constructor(id, t, "itemID"), app.BaseToy);
end

-- Vignette Lib
app.BaseVignette = {
	__index = function(t, key)
		if key == "key" then
			return "questID";
		elseif key == "text" then
			if t.qgs then
				local all = true;
				for i,qg in ipairs(t.qgs) do
					if not NPCNameFromID[qg] then
						all = false;
					end
				end
				if all then
					t.name = nil;
					local count = #t.qgs;
					for i=1,count,1 do
						local qg = t.qgs[i];
						if t.name then
							t.name = t.name .. (i < count and ", " or " & ") .. NPCNameFromID[qg];
						else
							t.name = NPCNameFromID[qg];
						end
						if not t.title then
							t.title = NPCTitlesFromID[qg];
						end
					end
					return t.name;
				end
			elseif t.crs then
				local all = true;
				for i,cr in ipairs(t.crs) do
					if not NPCNameFromID[cr] then
						all = false;
					end
				end
				if all then
					t.name = nil;
					local count = #t.crs;
					for i=1,count,1 do
						local cr = t.crs[i];
						if t.name then
							t.name = t.name .. (i < count and ", " or " & ") .. NPCNameFromID[cr];
						else
							t.name = NPCNameFromID[cr];
						end
						if not t.title then
							t.title = NPCTitlesFromID[cr];
						end
					end
					return t.name;
				end
			elseif t.qg then
				if NPCNameFromID[t.qg] then
					t.name = NPCNameFromID[t.qg];
					if not t.title then
						t.title = NPCTitlesFromID[t.qg];
					end
					return t.name;
				end
			elseif t.creatureID then
				if t.creatureID > 0 then
					if NPCNameFromID[t.creatureID] then
						t.name = NPCNameFromID[t.creatureID];
						if not t.title then
							t.title = NPCTitlesFromID[t.creatureID];
						end
						return t.name;
					end
				else
					t.name = L["NPC_ID_NAMES"][t.creatureID];
					return t.name;
				end
			end
			return t.questName;
		elseif key == "questName" then
			local questID = t.altQuestID and app.FactionID == 2 and t.altQuestID or t.questID;
			local questName = QuestTitleFromID[questID];
			if questName then
				t.retries = nil;
				t.title = nil;
				return "[" .. questName .. "]";
			end
			if t.retries and t.retries > 120 then
				return "[Quest #" .. questID .. "*]";
			else
				t.retries = (t.retries or 0) + 1;
			end
		elseif key == "link" then
			return "quest:" .. (t.altQuestID and app.FactionID == 2 and t.altQuestID or t.questID);
		elseif key == "icon" then
			return "Interface\\Icons\\INV_Misc_Head_Dragon_Black";
		elseif key == "collectible" then
			return not t.repeatable and app.CollectibleQuests;
		elseif key == "collected" then
			return t.collectible and t.saved;
		elseif key == "repeatable" then
			return t.isDaily or t.isWeekly;
		elseif key == "saved" then
			return IsQuestFlaggedCompleted(t.questID) or IsQuestFlaggedCompleted(t.altQuestID);
		else
			-- Something that isn't dynamic.
			return table[key];
		end
	end
};
app.CreateVignette = function(id, t)
	return setmetatable(constructor(id, t, "questID"), app.BaseVignette);
end

-- Filtering
function app.Filter()
	-- Meaning "Don't display."
	return false;
end
function app.NoFilter()
	-- Meaning "Display as expected."
	return true;
end
function app.FilterGroupsByLevel(group)
	return app.Level >= (group.lvl or 0);
end
function app.FilterGroupsByCompletion(group)
	return group.progress < group.total;
end
function app.FilterItemBind(item)
	return item.b == 2 or item.b == 3; -- BoE
end
function app.FilterItemClass(item)
	if app.UnobtainableItemFilter(item) and app.SeasonalItemFilter(item) then
		if app.ItemBindFilter(item) then return true; end
		return app.ItemTypeFilter(item)
			and app.RequireBindingFilter(item)
			and app.RequiredSkillFilter(item.requireSkill)
			and app.ClassRequirementFilter(item)
			and app.RaceRequirementFilter(item);
	end
end
function app.FilterItemClass_RequireClasses(item)
	return not item.nmc;
end
function app.FilterItemClass_RequireItemFilter(item)
	if item.f then
		if app.Settings:GetFilter(item.f) then
			return true;
		else
			return false;
		end
	else
		return true;
	end
end
function app.FilterItemClass_RequirePersonalLoot(item)
	local specs = item.specs;
	if specs then return #specs > 0; end
	return true;
end
function app.FilterItemClass_RequirePersonalLootCurrentSpec(item)
    local specs = item.specs;
    if specs then
        for i, v in ipairs(specs) do
            if v == app.Spec then return true; end
        end
        return false;
    end
    return true;
end
function app.FilterItemClass_RequireRaces(item)
	return not item.nmr;
end
function app.FilterItemClass_SeasonalItem(item)
   if item.u and L["UNOBTAINABLE_ITEM_REASONS"][item.u][1] > 4 then
      return GetDataSubMember("SeasonalFilters", item.u);
   else
      return true
   end
end
function app.FilterItemClass_UnobtainableItem(item)
	if item.u and L["UNOBTAINABLE_ITEM_REASONS"][item.u][1] < 5 then
	   return GetDataSubMember("UnobtainableItemFilters", item.u);
	else
		return true;
	end
end
function app.FilterItemClass_RequireBinding(item)
	if item.b and (item.b == 2 or item.b == 3) then
		return false;
	else
		return true;
	end
end
function app.FilterItemClass_RequiredSkill(requireSkill)
	if requireSkill then
		return app.GetTradeSkillCache()[requireSkill];
	else
		return true;
	end
end
function app.FilterItemSource(sourceInfo)
	return sourceInfo.isCollected;
end
function app.FilterItemSourceUnique(sourceInfo, allSources)
	if sourceInfo.isCollected then
		-- NOTE: This makes it so that the loop isn't necessary.
		return true;
	else
		-- If at least one of the sources of this visual ID was collected, that means that we've acquired the base appearance.
		local item = SearchForSourceIDQuickly(sourceInfo.sourceID);
		if item then
			if item.races then
				-- If the first item is EXPLICITLY race locked...
				for i, sourceID in ipairs(allSources or C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
					if sourceID ~= sourceInfo.sourceID and C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance(sourceID) then
						local otherItem = SearchForSourceIDQuickly(sourceID);
						if otherItem then
							if item.f == otherItem.f or item.f == 2 or otherItem.f == 2 then
								local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
								if otherSource.categoryID == sourceInfo.categoryID and (otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType)) then
									if otherItem.races then
										-- If the second item is EXPLICITLY race locked...
										if containsAny(otherItem.races, item.races) then
											-- return true;
											-- Okay, great! Is the first item class locked?
											if item.c then
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													if containsAny(otherItem.c, item.c) then
														-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
														return true;
													end
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											else
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													-- Sorry bro, you can't do that. That would be cheating.... Or Unique Mode (Main Only).
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											end
										end
									elseif otherItem.r then
										-- If the second item is FACTION race locked
										if otherItem.r == item.r or containsAny(app.FACTION_RACES[otherItem.r], item.races) then
											-- return true;
											-- Okay, great! Is the first item class locked?
											if item.c then
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													if containsAny(otherItem.c, item.c) then
														-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
														return true;
													end
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											else
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													-- Sorry bro, you can't do that. That would be cheating.... Or Unique Mode (Main Only).
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											end
										end
									else
										-- If the second item is not race locked...
										-- Okay, great! Is the first item class locked?
										if item.c then
											-- If the first item is class locked...
											if otherItem.c then
												-- If this item is class locked...
												if containsAny(otherItem.c, item.c) then
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											else
												-- This item is not class locked.
												-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
												return true;
											end
										else
											-- If the first item is class locked...
											if otherItem.c then
												-- If this item is class locked...
												-- Sorry bro, you can't do that. That would be cheating.... Or Unique Mode (Main Only).
											else
												-- This item is not class locked.
												-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
												return true;
											end
										end
									end
								end
							end
						else
							-- OH NOES! It doesn't exist!
							local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
							if otherSource.categoryID == sourceInfo.categoryID then
								if otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType) then
									-- print("OH NOES! MISSING SOURCE ID ", sourceID, " FOUND THAT YOU HAVE COLLECTED, BUT ATT DOESNT HAVE!!!!");
									return true;
								else
									-- print(otherSource.sourceID, sourceInfo.sourceID, "share appearances, but one is ", sourceInfo.invType, "and the other is", otherSource.invType, sourceInfo.categoryID);
								end
							end
						end
					end
				end
			elseif item.r then
				-- If the first item is FACTION race locked...
				for i, sourceID in ipairs(allSources or C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
					if sourceID ~= sourceInfo.sourceID and C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance(sourceID) then
						local otherItem = SearchForSourceIDQuickly(sourceID);
						if otherItem then
							if item.f == otherItem.f or item.f == 2 or otherItem.f == 2 then
								local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
								if otherSource.categoryID == sourceInfo.categoryID and (otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType)) then
									if otherItem.r then
										-- If the second item is FACTION race locked
										if otherItem.r == item.r then
											-- return true;
											-- Okay, great! Is the first item class locked?
											if item.c then
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													if containsAny(otherItem.c, item.c) then
														-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
														return true;
													end
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											else
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													-- Sorry bro, you can't do that. That would be cheating.... Or Unique Mode (Main Only).
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											end
										end
									elseif otherItem.races then
										-- If the second item is EXPLICITLY race locked...
										if containsAny(otherItem.races, app.FACTION_RACES[item.r]) then
											-- return true;
											-- Okay, great! Is the first item class locked?
											if item.c then
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													if containsAny(otherItem.c, item.c) then
														-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
														return true;
													end
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											else
												-- If the first item is class locked...
												if otherItem.c then
													-- If this item is class locked...
													-- Sorry bro, you can't do that. That would be cheating.... Or Unique Mode (Main Only).
												else
													-- This item is not class locked.
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											end
										end
									else
										-- If the second item is not race locked...
										-- Okay, great! Is the first item class locked?
										if item.c then
											-- If the first item is class locked...
											if otherItem.c then
												-- If this item is class locked...
												if containsAny(otherItem.c, item.c) then
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											else
												-- This item is not class locked.
												-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
												return true;
											end
										else
											-- If the first item is class locked...
											if otherItem.c then
												-- If this item is class locked...
												-- Sorry bro, you can't do that. That would be cheating.... Or Unique Mode (Main Only).
											else
												-- This item is not class locked.
												-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
												return true;
											end
										end
									end
								end
							end
						else
							-- OH NOES! It doesn't exist!
							local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
							if otherSource.categoryID == sourceInfo.categoryID then
								if otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType) then
									-- print("OH NOES! MISSING SOURCE ID ", sourceID, " FOUND THAT YOU HAVE COLLECTED, BUT ATT DOESNT HAVE!!!!");
									return true;
								else
									-- print(otherSource.sourceID, sourceInfo.sourceID, "share appearances, but one is ", sourceInfo.invType, "and the other is", otherSource.invType, sourceInfo.categoryID);
								end
							end
						end
					end
				end
			else
				-- If the first item is not race locked...
				-- Okay, great! Is the first item class locked?
				if item.c then
					for i, sourceID in ipairs(allSources or C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
						if sourceID ~= sourceInfo.sourceID and C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance(sourceID) then
							local otherItem = SearchForSourceIDQuickly(sourceID);
							if otherItem then
								if item.f == otherItem.f or item.f == 2 or otherItem.f == 2 then
									local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
									if otherSource.categoryID == sourceInfo.categoryID and (otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType)) then
										if not otherItem.r and not otherItem.races then
											-- If this item is not race or faction locked...
											if otherItem.c then
												-- If this item is class locked...
												if containsAny(otherItem.c, item.c) then
													-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
													return true;
												end
											else
												-- This item is not class locked.
												-- Since the source item is locked to the same race and class, you unlock the source ID. Congrats, mate!
												return true;
											end
										end
									end
								end
							else
								-- OH NOES! It doesn't exist!
								local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
								if otherSource.categoryID == sourceInfo.categoryID then
									if otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType) then
										-- print("OH NOES! MISSING SOURCE ID ", sourceID, " FOUND THAT YOU HAVE COLLECTED, BUT ATT DOESNT HAVE!!!!");
										return true;
									else
										-- print(otherSource.sourceID, sourceInfo.sourceID, "share appearances, but one is ", sourceInfo.invType, "and the other is", otherSource.invType, sourceInfo.categoryID);
									end
								end
							end
						end
					end
				else
					for i, sourceID in ipairs(allSources or C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
						if sourceID ~= sourceInfo.sourceID and C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance(sourceID) then
							local otherItem = SearchForSourceIDQuickly(sourceID);
							if otherItem then
								if item.f == otherItem.f or item.f == 2 or otherItem.f == 2 then
									local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
									if otherSource.categoryID == sourceInfo.categoryID and (otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType)) then
										if not otherItem.r and not otherItem.races and not otherItem.c then
											-- If this item is not class, race or faction locked, you unlock the source ID. Congrats, mate!
											return true;
										end
									end
								end
							else
								-- OH NOES! It doesn't exist!
								local otherSource = C_TransmogCollection_GetSourceInfo(sourceID);
								if otherSource.categoryID == sourceInfo.categoryID then
									if otherSource.invType == sourceInfo.invType or sourceInfo.categoryID == 4 --[[CHEST: Robe vs Armor]] or C_Transmog.GetSlotForInventoryType(otherSource.invType) == C_Transmog.GetSlotForInventoryType(sourceInfo.invType) then
										-- print("OH NOES! MISSING SOURCE ID ", sourceID, " FOUND THAT YOU HAVE COLLECTED, BUT ATT DOESNT HAVE!!!!");
										return true;
									else
										-- print(otherSource.sourceID, sourceInfo.sourceID, "share appearances, but one is ", sourceInfo.invType, "and the other is", otherSource.invType, sourceInfo.categoryID);
									end
								end
							end
						end
					end
				end
			end
		end
		return false;
	end
end
function app.FilterItemSourceUniqueOnlyMain(sourceInfo, allSources)
	if sourceInfo.isCollected then
		-- NOTE: This makes it so that the loop isn't necessary.
		return true;
	else
		-- If at least one of the sources of this visual ID was collected, that means that we've acquired the base appearance.
		local item = SearchForSourceIDQuickly(sourceInfo.sourceID);
		if item and not item.nmc and not item.nmr then
			-- This item is for my race and class.
			for i, sourceID in ipairs(allSources or C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
				if sourceID ~= sourceInfo.sourceID and C_TransmogCollection_PlayerHasTransmogItemModifiedAppearance(sourceID) then
					local otherItem = SearchForSourceIDQuickly(sourceID);
					if otherItem and (item.f == otherItem.f or item.f == 2 or otherItem.f == 2) and not otherItem.nmc and not otherItem.nmr then
						return true; -- Okay, fine. You are this class/race. Enjoy your +1, cheater. D:
					end
				end
			end
		end
		return false;
	end
end
function app.FilterItemTrackable(group)
	return group.trackable;
end
function app.ObjectVisibilityFilter(group)
	return group.visible;
end

-- Default Filter Settings (changed in VARIABLES_LOADED and in the Options Menu)
app.VisibilityFilter = app.ObjectVisibilityFilter;
app.GroupFilter = app.FilterItemClass;
app.GroupRequirementsFilter = app.NoFilter;
app.GroupVisibilityFilter = app.NoFilter;
app.ItemBindFilter = app.FilterItemBind;
app.ItemSourceFilter = app.FilterItemSource;
app.ItemTypeFilter = app.NoFilter;
app.CollectedItemVisibilityFilter = app.NoFilter;
app.ClassRequirementFilter = app.NoFilter;
app.RaceRequirementFilter = app.NoFilter;
app.RequireBindingFilter = app.NoFilter;
app.SeasonalItemFilter = app.NoFilter;
app.UnobtainableItemFilter = app.NoFilter;
app.RequiredSkillFilter = app.NoFilter;
app.ShowIncompleteThings = app.Filter;

-- Recursive Checks
app.RecursiveClassAndRaceFilter = function(group)
	if app.ClassRequirementFilter(group) and app.RaceRequirementFilter(group) then
		if group.parent then return app.RecursiveClassAndRaceFilter(group.parent); end
		return true;
	end
	return false;
end
app.RecursiveUnobtainableFilter = function(group)
	if app.UnobtainableItemFilter(group) then
		if group.parent then return app.RecursiveUnobtainableFilter(group.parent); end
		return true;
	end
	return false;
end
app.RecursiveIsDescendantOfParentWithValue = function(group, field, value)
	if group then
		if group[field] and group[field] == value then
			return true
		else
			if group.parent then
				return app.RecursiveIsDescendantOfParentWithValue(group.parent, field, value)
			end
		end
	end
	return false;
end

-- Processing Functions (Coroutines)
local UpdateGroup, UpdateGroups;
UpdateGroup = function(parent, group)
	-- Determine if this user can enter the instance or acquire the item.
	if app.GroupRequirementsFilter(group) then
		-- Check if this is a group
		if group.g then
			-- If this item is collectible, then mark it as such.
			if group.collectible then
				-- An item is a special case where it may have both an appearance and a set of items
				group.progress = group.collected and 1 or 0;
				group.total = 1;
			elseif group.s and group.s < 1 then
				-- This item is missing its source ID. :(
				group.progress = 0;
				group.total = 1;
			else
				-- Default to 0 for both
				group.progress = 0;
				group.total = 0;
			end
			
			-- Update the subgroups recursively...
			UpdateGroups(group, group.g);
			
			-- If the 'can equip' filter says true
			if app.GroupFilter(group) then
				-- Increment the parent group's totals.
				parent.total = (parent.total or 0) + group.total;
				parent.progress = (parent.progress or 0) + group.progress;
				
				-- If this group is trackable, then we should show it.
				if group.total > 0 and app.GroupVisibilityFilter(group) then
					group.visible = true;
				elseif app.ShowIncompleteThings(group) then
					group.visible = not group.saved;
				else
					group.visible = false;
				end
			else
				-- Hide this group. We aren't filtering for it.
				group.visible = false;
			end
		else
			-- If the 'can equip' filter says true
			if app.GroupFilter(group) then
				if group.collectible then
					-- Increment the parent group's totals.
					parent.total = (parent.total or 0) + 1;
					
					-- If we've collected the item, use the "Show Collected Items" filter.
					if group.collected then
						group.visible = app.CollectedItemVisibilityFilter(group);
						parent.progress = (parent.progress or 0) + 1;
					else
						group.visible = true;
					end
				elseif group.trackable then
					-- If this group is trackable, then we should show it.
					if app.ShowIncompleteThings(group) then
						group.visible = not group.saved;
					else
						-- Hide this group. We aren't filtering for it.
						group.visible = false;
					end
				else
					-- Hide this group.
					group.visible = false;
				end
			else
				-- Hide this group. We aren't filtering for it.
				group.visible = false;
			end
		end
	else
		-- This group doesn't meet requirements.
		group.visible = false;
	end
	
	if group.OnUpdate then group:OnUpdate(); end
end
UpdateGroups = function(parent, g)
	if g then
		for key, group in ipairs(g) do
			UpdateGroup(parent, group);
		end
	end
end
local function UpdateParentProgress(group)
	group.progress = group.progress + 1;
	
	-- Continue on to this object's parent.
	if group.parent then
		if group.visible then
			-- If we were initially visible, then update the parent.
			UpdateParentProgress(group.parent);
			
			-- If this group is trackable, then we should show it.
			if app.GroupVisibilityFilter(group) then
				group.visible = true;
			elseif app.ShowIncompleteThings(group) then
				group.visible = not group.saved;
			else
				group.visible = false;
			end
		end
	end
end
app.UpdateGroups = UpdateGroups;
app.UpdateParentProgress = UpdateParentProgress;

-- Helper Methods
-- The following Helper Methods are used when you obtain a new appearance.
function app.CompletionistItemCollectionHelper(sourceID, oldState)
	-- Search ATT for the related sources.
	local searchResults = SearchForField("s", sourceID);
	if searchResults and #searchResults > 0 then
		-- Show the collection message.
		if app.Settings:GetTooltipSetting("Report:Collected") then
			local firstMatch = searchResults[1];
			print(format(L["ITEM_ID_ADDED"], firstMatch.text or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), firstMatch.itemID));
		end
		
		-- Attempt to cleanly refresh the data.
		local fresh = false;
		
		-- Mark all results as marked. This prevents a double +1 on parents.
		for i,result in ipairs(searchResults) do
			if result.visible and result.parent and result.parent.total then
				result.marked = true;
			end
		end
		
		-- Only unmark and +1 marked search results.
		for i,result in ipairs(searchResults) do
			if result.marked then
				result.marked = nil;
				if result.total then
					-- This is an item that has a relative set of groups
					UpdateParentProgress(result);
					
					-- If this is NOT a group...
					if not result.g then
						-- If we've collected the item, use the "Show Collected Items" filter.
						result.visible = app.CollectedItemVisibilityFilter(result);
					end
				else	
					UpdateParentProgress(result.parent);
					
					-- If we've collected the item, use the "Show Collected Items" filter.
					result.visible = app.CollectedItemVisibilityFilter(result);
				end
				fresh = true;
			end
		end
		
		-- If the data is fresh, don't force a refresh.
		app:RefreshData(fresh, true);
	else
		-- Show the collection message.
		if app.Settings:GetTooltipSetting("Report:Collected") then
			-- Use the Blizzard API... We don't have this item in the addon.
			-- NOTE: The itemlink that gets passed is BASE ITEM LINK, not the full item link.
			-- So this may show green items where an epic was obtained. (particularly with Legion drops)
			-- This is okay since items of this type share their appearance regardless of the power of the item.
			local sourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
			if sourceInfo then
				local name, link = GetItemInfo(sourceInfo.itemID);
				print(format(L["ITEM_ID_ADDED_MISSING"], link or name or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), sourceInfo.itemID));
			else
				print(format(L["ITEM_ID_ADDED_MISSING"], "|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r", "???"));
			end
		end
	end
end
function app.UniqueModeItemCollectionHelperBase(sourceID, oldState, filter)
	-- Get the source info for this source ID.
	local sourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
	if sourceInfo then
		-- Go through all of the shared appearances and see if we're "unlocked" any of them.
		local unlockedSourceIDs, allSources = {}, C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID);
		for i, otherSourceID in ipairs(allSources) do
			-- If this isn't the source we already did work on and we haven't already completed it
			if otherSourceID ~= sourceID and not GetDataSubMember("CollectedSources", otherSourceID) then
				local otherSourceInfo = C_TransmogCollection_GetSourceInfo(otherSourceID);
				if otherSourceInfo and filter(otherSourceInfo, allSources) then
					SetDataSubMember("CollectedSources", otherSourceID, otherSourceInfo.isCollected and 1 or 2);
					tinsert(unlockedSourceIDs, otherSourceID);
				end
			end
		end
		
		-- Attempt to cleanly refresh the data.
		local fresh, searchResults = false, nil;
		if #unlockedSourceIDs > 0 then
			for i, otherSourceID in ipairs(unlockedSourceIDs) do
				-- Search ATT for this source ID.
				searchResults = SearchForField("s", otherSourceID);
				if searchResults and #searchResults > 0 then
					for j,result in ipairs(searchResults) do
						if result.visible and result.parent and result.parent.total then
							if result.total then
								-- This is an item that has a relative set of groups
								UpdateParentProgress(result);
								
								-- If this is NOT a group...
								if not result.g then
									-- If we've collected the item, use the "Show Collected Items" filter.
									result.visible = app.CollectedItemVisibilityFilter(result);
								end
							else	
								UpdateParentProgress(result.parent);
								
								-- If we've collected the item, use the "Show Collected Items" filter.
								result.visible = app.CollectedItemVisibilityFilter(result);
							end
							fresh = true;
						end
					end
				end
			end
		end
		
		-- Search for the item that actually was unlocked.
		searchResults = SearchForField("s", sourceID);
		if searchResults and #searchResults > 0 then
			if oldState == 0 then
				for i,result in ipairs(searchResults) do
					if result.visible and result.parent and result.parent.total then
						if result.total then
							-- This is an item that has a relative set of groups
							UpdateParentProgress(result);
							
							-- If this is NOT a group...
							if not result.g then
								-- If we've collected the item, use the "Show Collected Items" filter.
								result.visible = app.CollectedItemVisibilityFilter(result);
							end
						else	
							UpdateParentProgress(result.parent);
							
							-- If we've collected the item, use the "Show Collected Items" filter.
							result.visible = app.CollectedItemVisibilityFilter(result);
						end
						fresh = true;
					end
				end
			end
			
			-- Show the collection message.
			if app.Settings:GetTooltipSetting("Report:Collected") then
				local firstMatch = searchResults[1];
				print(format(L[#unlockedSourceIDs > 0 and "ITEM_ID_ADDED_SHARED" or "ITEM_ID_ADDED"], 
					firstMatch.text or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), firstMatch.itemID, #unlockedSourceIDs));
			end
		else
			-- Show the collection message.
			if app.Settings:GetTooltipSetting("Report:Collected") then
				-- Use the Blizzard API... We don't have this item in the addon.
				-- NOTE: The itemlink that gets passed is BASE ITEM LINK, not the full item link.
				-- So this may show green items where an epic was obtained. (particularly with Legion drops)
				-- This is okay since items of this type share their appearance regardless of the power of the item.
				local name, link = GetItemInfo(sourceInfo.itemID);
				print(format(L[#unlockedSourceIDs > 0 and "ITEM_ID_ADDED_SHARED_MISSING" or "ITEM_ID_ADDED_MISSING"], 
					link or name or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), sourceInfo.itemID, #unlockedSourceIDs));
			end
		end
		
		-- If the data is fresh, don't force a refresh.
		app:RefreshData(fresh, true);
	end
end
function app.UniqueModeItemCollectionHelper(sourceID, oldState)
	return app.UniqueModeItemCollectionHelperBase(sourceID, oldState, app.FilterItemSourceUnique);
end
function app.UniqueModeItemCollectionHelperOnlyMain(sourceID, oldState)
	return app.UniqueModeItemCollectionHelperBase(sourceID, oldState, app.FilterItemSourceUniqueOnlyMain);
end
app.ActiveItemCollectionHelper = app.CompletionistItemCollectionHelper;

function app.CompletionistItemRemovalHelper(sourceID, oldState)
	-- Search ATT for the related sources.
	local searchResults = SearchForField("s", sourceID);
	if searchResults and #searchResults > 0 then
		-- Show the collection message.
		if app.Settings:GetTooltipSetting("Report:Collected") then
			local firstMatch = searchResults[1];
			print(format(L["ITEM_ID_ADDED"], firstMatch.text or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), firstMatch.itemID));
		end
		
		-- Attempt to cleanly refresh the data.
		local fresh = false;
		for i,result in ipairs(searchResults) do
			if result.visible and result.parent and result.parent.total then
				if result.total then
					-- This is an item that has a relative set of groups
					UpdateParentProgress(result);
					
					-- If this is NOT a group...
					if not result.g then
						-- If we've collected the item, use the "Show Collected Items" filter.
						result.visible = app.CollectedItemVisibilityFilter(result);
					end
				else	
					UpdateParentProgress(result.parent);
					
					-- If we've collected the item, use the "Show Collected Items" filter.
					result.visible = app.CollectedItemVisibilityFilter(result);
				end
				fresh = true;
			end
		end
		
		-- If the data is fresh, don't force a refresh.
		app:RefreshData(fresh, true);
	else
		-- Show the collection message.
		if app.Settings:GetTooltipSetting("Report:Collected") then
			-- Use the Blizzard API... We don't have this item in the addon.
			-- NOTE: The itemlink that gets passed is BASE ITEM LINK, not the full item link.
			-- So this may show green items where an epic was obtained. (particularly with Legion drops)
			-- This is okay since items of this type share their appearance regardless of the power of the item.
			local sourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
			if sourceInfo then
				local name, link = GetItemInfo(sourceInfo.itemID);
				print(format(L["ITEM_ID_ADDED_MISSING"], link or name or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), sourceInfo.itemID));
			else
				print(format(L["ITEM_ID_ADDED_MISSING"], "|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r", "???"));
			end
		end
		
		-- If the item isn't in the list, then don't bother refreshing the data.
		-- app:RefreshData(true, true);
	end
end
function app.UniqueModeItemRemovalHelperBase(sourceID, oldState, filter)
	-- Get the source info for this source ID.
	local sourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
	if sourceInfo then
		-- Go through all of the shared appearances and see if we're "unlocked" any of them.
		local unlockedSourceIDs, allSources = {}, C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID);
		for i, otherSourceID in ipairs(allSources) do
			-- If this isn't the source we already did work on and we haven't already completed it
			if otherSourceID ~= sourceID and not GetDataSubMember("CollectedSources", otherSourceID) then
				local otherSourceInfo = C_TransmogCollection_GetSourceInfo(otherSourceID);
				if otherSourceInfo and filter(otherSourceInfo, allSources) then
					SetDataSubMember("CollectedSources", otherSourceID, otherSourceInfo.isCollected and 1 or 2);
					tinsert(unlockedSourceIDs, otherSourceID);
				end
			end
		end
		
		-- Attempt to cleanly refresh the data.
		local fresh, searchResults = false, nil;
		if #unlockedSourceIDs > 0 then
			for i, otherSourceID in ipairs(unlockedSourceIDs) do
				-- Search ATT for this source ID.
				searchResults = SearchForField("s", otherSourceID);
				if searchResults and #searchResults > 0 then
					for j,result in ipairs(searchResults) do
						if result.visible and result.parent and result.parent.total then
							if result.total then
								-- This is an item that has a relative set of groups
								UpdateParentProgress(result);
								
								-- If this is NOT a group...
								if not result.g then
									-- If we've collected the item, use the "Show Collected Items" filter.
									result.visible = app.CollectedItemVisibilityFilter(result);
								end
							else	
								UpdateParentProgress(result.parent);
								
								-- If we've collected the item, use the "Show Collected Items" filter.
								result.visible = app.CollectedItemVisibilityFilter(result);
							end
							fresh = true;
						end
					end
				end
			end
		end
		
		-- Search for the item that actually was unlocked.
		searchResults = SearchForField("s", sourceID);
		if searchResults and #searchResults > 0 then
			if oldState == 0 then
				for i,result in ipairs(searchResults) do
					if result.visible and result.parent and result.parent.total then
						if result.total then
							-- This is an item that has a relative set of groups
							UpdateParentProgress(result);
							
							-- If this is NOT a group...
							if not result.g then
								-- If we've collected the item, use the "Show Collected Items" filter.
								result.visible = app.CollectedItemVisibilityFilter(result);
							end
						else	
							UpdateParentProgress(result.parent);
							
							-- If we've collected the item, use the "Show Collected Items" filter.
							result.visible = app.CollectedItemVisibilityFilter(result);
						end
						fresh = true;
					end
				end
			end
			
			-- Show the collection message.
			if app.Settings:GetTooltipSetting("Report:Collected") then
				local firstMatch = searchResults[1];
				print(format(L[#unlockedSourceIDs > 0 and "ITEM_ID_ADDED_SHARED" or "ITEM_ID_ADDED"], 
					firstMatch.text or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), firstMatch.itemID, #unlockedSourceIDs));
			end
		else
			-- Show the collection message.
			if app.Settings:GetTooltipSetting("Report:Collected") then
				-- Use the Blizzard API... We don't have this item in the addon.
				-- NOTE: The itemlink that gets passed is BASE ITEM LINK, not the full item link.
				-- So this may show green items where an epic was obtained. (particularly with Legion drops)
				-- This is okay since items of this type share their appearance regardless of the power of the item.
				local name, link = GetItemInfo(sourceInfo.itemID);
				print(format(L[#unlockedSourceIDs > 0 and "ITEM_ID_ADDED_SHARED_MISSING" or "ITEM_ID_ADDED_MISSING"], 
					link or name or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), sourceInfo.itemID, #unlockedSourceIDs));
			end
		end
		
		-- If the data is fresh, don't force a refresh.
		app:RefreshData(fresh, true);
	end
end
function app.UniqueModeItemRemovalHelper(sourceID, oldState)
	return app.UniqueModeItemRemovalHelperBase(sourceID, oldState, app.FilterItemSourceUnique);
end
function app.UniqueModeItemRemovalHelperOnlyMain(sourceID, oldState)
	return app.UniqueModeItemRemovalHelperBase(sourceID, oldState, app.FilterItemSourceUniqueOnlyMain);
end
app.ActiveItemRemovalHelper = app.CompletionistItemRemovalHelper;

function app.GetNumberOfItemsUntilNextPercentage(progress, total)
	if total <= progress then
		return "|c" .. GetProgressColor(1) .. "YOU DID IT!|r";
	else
		local originalPercent = progress / total;
		local nextPercent = math.ceil(originalPercent * 100);
		local roundedPercent = nextPercent * 0.01;
		local diff = math.ceil(total * (roundedPercent - originalPercent));
		if diff < 1 then
			return "|c" .. GetProgressColor(1) .. (total - progress) .. " THINGS UNTIL 100%|r";
		elseif diff == 1 then
			return "|c" .. GetProgressColor(roundedPercent) .. diff .. " THING UNTIL " .. nextPercent .. "%|r";
		else
			return "|c" .. GetProgressColor(roundedPercent) .. diff .. " THINGS UNTIL " .. nextPercent .. "%|r";
		end
	end
end
function app.QuestCompletionHelper(questID)
	-- Search ATT for the related quests.
	local searchResults = SearchForField("questID", questID);
	if searchResults and #searchResults > 0 then
		-- Only increase progress for Quests as Collectible users.
		if app.CollectibleQuests then
			-- Attempt to cleanly refresh the data.
			for i,result in ipairs(searchResults) do
				if result.visible and result.parent and result.parent.total then
					result.marked = true;
				end
			end
			for i,result in ipairs(searchResults) do
				if result.marked then
					result.marked = nil;
					if result.total then
						-- This is an item that has a relative set of groups
						UpdateParentProgress(result);
						
						-- If this is NOT a group...
						if not result.g and result.collectible then
							-- If we've collected the item, use the "Show Collected Items" filter.
							result.visible = app.CollectedItemVisibilityFilter(result);
						end
					else
						UpdateParentProgress(result.parent);
						
						if result.collectible then
							-- If we've collected the item, use the "Show Collected Items" filter.
							result.visible = app.CollectedItemVisibilityFilter(result);
						end
					end
				end
			end
		end
		
		-- Don't force a full refresh.
		app:RefreshData(true, true);
	end
end

local function MinimapButtonOnClick(self, button)
	if button == "RightButton" then
		-- Right Button opens the Options menu.
		if InterfaceOptionsFrame:IsVisible() then
			InterfaceOptionsFrame_Show();
		else
			InterfaceOptionsFrame_OpenToCategory(app:GetName());
			InterfaceOptionsFrame_OpenToCategory(app:GetName());
		end
	else
		-- Left Button
		if IsShiftKeyDown() then
			app.RefreshCollections();
		elseif IsAltKeyDown() or IsControlKeyDown() then
			app.ToggleMiniListForCurrentZone();
		else
			app.ToggleMainList();
		end
	end
end
local function MinimapButtonOnEnter(self)
	local reference = app:GetDataCache();
	GameTooltip:SetOwner(self, "ANCHOR_LEFT");
	GameTooltip:ClearLines();
	GameTooltip:AddDoubleLine(L["TITLE"], GetProgressColorText(reference.progress, reference.total));
	GameTooltip:AddDoubleLine(app.Settings:GetModeString(), app.GetNumberOfItemsUntilNextPercentage(reference.progress, reference.total), 1, 1, 1);
	GameTooltip:AddLine(L["DESCRIPTION"], 0.4, 0.8, 1, 1);
	GameTooltip:AddLine(L["MINIMAP_MOUSEOVER_TEXT"], 1, 1, 1);
	GameTooltip:Show();
	GameTooltipIcon:SetSize(72,72);
	GameTooltipIcon:ClearAllPoints();
	GameTooltipIcon:SetPoint("TOPRIGHT", GameTooltip, "TOPLEFT", 0, 0);
	GameTooltipIcon.icon:SetTexture(reference.preview or reference.icon);
	local texcoord = reference.previewtexcoord or reference.texcoord;
	if texcoord then
		GameTooltipIcon.icon:SetTexCoord(texcoord[1], texcoord[2], texcoord[3], texcoord[4]);
	else
		GameTooltipIcon.icon:SetTexCoord(0, 1, 0, 1);
	end
	GameTooltipIcon:Show();
end
local function MinimapButtonOnLeave()
	GameTooltip:Hide();
	GameTooltipIcon.icon.Background:Hide();
	GameTooltipIcon.icon.Border:Hide();
	GameTooltipIcon:Hide();
	GameTooltipModel:Hide();
end
local function CreateMinimapButton()
	-- Create the Button for the Minimap frame. Create a local and non-local copy.
	local size = app.Settings:GetTooltipSetting("MinimapSize");
	local button = CreateFrame("BUTTON", app:GetName() .. "-Minimap", Minimap);
	button:SetPoint("CENTER", 0, 0);
	button:SetFrameStrata("HIGH");
	button:SetMovable(true);
	button:EnableMouse(true);
	button:RegisterForDrag("LeftButton", "RightButton");
	button:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	button:SetSize(size, size);
	
	-- Create the Button Texture
	local texture = button:CreateTexture(nil, "BACKGROUND");
	texture:SetATTSprite("base_36x36", 429, 141, 36, 36, 512, 256);
	texture:SetPoint("CENTER", 0, 0);
	texture:SetAllPoints();
	button.texture = texture;
	
	-- Create the Button Texture
	local oldtexture = button:CreateTexture(nil, "BACKGROUND");
	oldtexture:SetPoint("CENTER", 0, 0);
	oldtexture:SetTexture(L["LOGO_SMALL"]);
	oldtexture:SetSize(21, 21);
	oldtexture:SetTexCoord(0,1,0,1);
	button.oldtexture = oldtexture;
	
	-- Create the Button Tracking Border
	local border = button:CreateTexture(nil, "BORDER");
	border:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder");
	border:SetPoint("CENTER", 12, -12);
	border:SetSize(56, 56);
	button.border = border;
	button.UpdateStyle = function(self)
		if app.Settings:GetTooltipSetting("MinimapStyle") then
			self:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight", "ADD");
			self:GetHighlightTexture():SetTexCoord(0,1,0,1);
			self:GetHighlightTexture():SetAlpha(1);
			self.texture:Hide();
			self.oldtexture:Show();
			self.border:Show();
		else
			self:SetATTHighlightSprite("epic_36x36", 429, 179, 36, 36, 512, 256):SetAlpha(0.2);
			self.texture:Show();
			self.oldtexture:Hide();
			self.border:Hide();
		end
	end
	button:UpdateStyle();
	
	-- Button Configuration
	button.update = function(self)
		local position = GetDataMember("Position", -10.31);
		self:SetPoint("CENTER", "Minimap", "CENTER", -78 * cos(position), 78 * sin(position));
	end
	local update = function(self)
		local w, x = GetCursorPosition();
		local y, z = Minimap:GetLeft(), Minimap:GetBottom();
		local s = UIParent:GetScale();
		w = y - w / s + 70; x = x / s - z - 70;
		SetDataMember("Position", math.deg(math.atan2(x, w)));
		self:Raise();
		self:update();
	end

	-- Register for Frame Events
	button:SetScript("OnDragStart", function(self)
		self:SetScript("OnUpdate", update);
	end);
	button:SetScript("OnDragStop", function(self)
		self:SetScript("OnUpdate", nil);
	end);
	button:SetScript("OnEnter", MinimapButtonOnEnter);
	button:SetScript("OnLeave", MinimapButtonOnLeave);
	button:SetScript("OnClick", MinimapButtonOnClick);
	button:update();
	button:Show();
	return button;
end
app.CreateMinimapButton = CreateMinimapButton;

-- Row Helper Functions
local CreateRow;
local function CreateMiniListForGroup(group)
	-- Pop Out Functionality! :O
	local suffix = BuildSourceTextForChat(group, 0) .. " -> " .. (group.text or "");
	local popout = app.Windows[suffix];
	if not popout then
		popout = app:GetWindow(suffix);
		popout.shouldFullRefresh = true;
		if group.s then
			popout.data = CloneData(group);
			popout.data.collectible = true;
			popout.data.visible = true;
			popout.data.progress = 0;
			popout.data.total = 0;
			if not popout.data.g then
				popout.data.g = {};
			end
			
			-- Attempt to get information about the source ID.
			local sourceInfo = C_TransmogCollection_GetSourceInfo(group.s);
			if sourceInfo then
				-- Show a list of all of the Shared Appearances.
				local g = {};
				
				-- Go through all of the shared appearances and see if we're "unlocked" any of them.
				for i, otherSourceID in ipairs(C_TransmogCollection_GetAllAppearanceSources(sourceInfo.visualID)) do
					-- If this isn't the source we already did work on and we haven't already completed it
					if otherSourceID ~= group.s then
						local attSearch = SearchForSourceIDQuickly(otherSourceID);
						if attSearch then
							attSearch = CloneData(attSearch);
							attSearch.collectible = true;
							attSearch.hideText = true;
							tinsert(g, attSearch); 
						else
							local otherSourceInfo = C_TransmogCollection_GetSourceInfo(otherSourceID);
							if otherSourceInfo then
								local newItem = app.CreateItemSource(otherSourceID, otherSourceInfo.itemID);
								if otherSourceInfo.isCollected then
									SetDataSubMember("CollectedSources", otherSourceID, 1);
									newItem.collected = true;
								end
								tinsert(g, newItem);
							end
						end
					end
				end
				if #g > 0 then
					table.insert(popout.data.g, {
						["text"] = "Shared Appearances",
						["description"] = "The items in this list are shared appearances for the above item. In Unique Appearance Mode, this list can help you understand why or why not a specific item would be marked Collected.",
						["icon"] = "Interface\\Icons\\Achievement_GarrisonFollower_ItemLevel650.blp",
						["g"] = g
					});
				else
					table.insert(popout.data.g, setmetatable({
						["text"] = "Unique Appearance",
						["description"] = "This item has a Unique Appearance. You must collect this item specifically to earn the appearance.",
						["icon"] = "Interface\\Icons\\ACHIEVEMENT_GUILDPERK_EVERYONES A HERO.blp",
						["collectible"] = true,
					}, { __index = group }));
				end
			end
			
			-- Determine if this source is part of a set or two.
			local allSets = GetDataMember("Sets", {});
			local sourceSets = GetDataMember("SourceSets", {});
			local GetVariantSets = C_TransmogSets.GetVariantSets;
			local GetAllSourceIDs = C_TransmogSets.GetAllSourceIDs;
			for i,data in ipairs(C_TransmogSets.GetAllSets()) do
				local sources = GetAllSourceIDs(data.setID);
				if #sources > 0 then allSets[data.setID] = sources; end
				for j,sourceID in ipairs(sources) do
					local s = sourceSets[sourceID];
					if not s then
						s = {};
						sourceSets[sourceID] = s;
					end
					s[data.setID] = 1;
				end
				local variants = GetVariantSets(data.setID);
				if type(variants) == "table" then
					for j,data in ipairs(variants) do
						local sources = GetAllSourceIDs(data.setID);
						if #sources > 0 then allSets[data.setID] = sources; end
						for k, sourceID in ipairs(sources) do
							local s = sourceSets[sourceID];
							if not s then
								s = {};
								sourceSets[sourceID] = s;
							end
							s[data.setID] = 1;
						end
					end
				end
			end
			local data = sourceSets[group.s];
			if data then
				for setID,value in pairs(data) do
					local g = {};
					setID = tonumber(setID);
					for i,sourceID in ipairs(allSets[setID]) do
						local attSearch = SearchForSourceIDQuickly(sourceID);
						if attSearch then
							attSearch = CloneData(attSearch);
							attSearch.collectible = true;
							attSearch.hideText = true;
							tinsert(g, attSearch); 
						else
							local otherSourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
							if otherSourceInfo then
								local newItem = app.CreateItemSource(sourceID, otherSourceInfo.itemID);
								if otherSourceInfo.isCollected then
									SetDataSubMember("CollectedSources", sourceID, 1);
									newItem.collected = true;
								end
								tinsert(g, newItem);
							end
						end
					end
					table.insert(popout.data.g, app.CreateGearSet(setID, { ["visible"] = true, ["g"] = g }));
				end
			end
			local oldUpdate = popout.Update;
			popout.Update = function(self, ...)
				-- Turn off all filters momentarily.
				local GroupFilter = app.GroupFilter;
				local GroupVisibilityFilter = app.GroupVisibilityFilter;
				local CollectedItemVisibilityFilter = app.CollectedItemVisibilityFilter;
				local CollectedItemVisibilityFilter = app.CollectedItemVisibilityFilter;
				app.GroupFilter = app.NoFilter;
				app.GroupVisibilityFilter = app.NoFilter;
				app.CollectedItemVisibilityFilter = app.NoFilter;
				app.CollectedItemVisibilityFilter = app.NoFilter;
				oldUpdate(self, ...);
				app.GroupFilter = GroupFilter;
				app.GroupVisibilityFilter = GroupVisibilityFilter;
				app.CollectedItemVisibilityFilter = CollectedItemVisibilityFilter;
				app.CollectedItemVisibilityFilter = CollectedItemVisibilityFilter;
			end;
		elseif group.questID or group.sourceQuests then
			-- This is a quest object. Let's show prereqs and breadcrumbs.
			local mainQuest = CloneData(group);
			mainQuest.collectible = true;
			local g = { mainQuest };
			
			-- Show Quest Prereqs
			if mainQuest.sourceQuests then
				local breakafter = 0;
				local sourceQuests, sourceQuest, subSourceQuests, prereqs = mainQuest.sourceQuests;
				while sourceQuests and #sourceQuests > 0 do
					subSourceQuests = {}; prereqs = {};
					for i,sourceQuestID in ipairs(sourceQuests) do
						sourceQuest = sourceQuestID < 1 and SearchForField("creatureID", math.abs(sourceQuestID)) or SearchForField("questID", sourceQuestID);
						if sourceQuest and #sourceQuest > 0 then
							local found = nil;
							for i=1,#sourceQuest,1 do
								-- Only care about the first search result.
								local sq = sourceQuest[i];
								if sq and app.GroupFilter(sq) and not sq.isBreadcrumb then
									if sq.altQuestID then
										-- Alt Quest IDs are always Horde.
										if app.FactionID == 2 then
											if sq.altQuestID == sourceQuestID then
												found = sq;
												break;
											end
										elseif sq.questID == sourceQuestID then
											found = sq;
											break;
										end
									elseif app.RecursiveClassAndRaceFilter(sq) then
										found = sq;
										break;
									end
								end
							end
							if found then
								sourceQuest = CloneData(found);
								sourceQuest.collectible = true;
								sourceQuest.visible = true;
								sourceQuest.hideText = true;
								if found.sourceQuests and #found.sourceQuests > 0 and (not found.saved or app.CollectedItemVisibilityFilter(sourceQuest)) then
									-- Mark the sub source quest IDs as marked (as the same sub quest might point to 1 source quest ID)
									for j, subsourceQuests in ipairs(found.sourceQuests) do
										subSourceQuests[subsourceQuests] = true;
									end
								end
							else
								sourceQuest = nil;
							end
						elseif sourceQuestID > 0 then
							-- Create a Quest Object.
							sourceQuest = app.CreateQuest(sourceQuestID, { ['visible'] = true, ['collectible'] = true, ['hideText'] = true });
						else
							-- Create a NPC Object.
							sourceQuest = app.CreateNPC(math.abs(sourceQuestID), { ['visible'] = true, ['hideText'] = true });
						end
						
						-- If the quest was valid, attach it.
						if sourceQuest then tinsert(prereqs, sourceQuest); end
					end
					
					-- Convert the subSourceQuests table into an array
					sourceQuests = {};
					if #prereqs > 0 then
						for sourceQuestID,i in pairs(subSourceQuests) do
							tinsert(sourceQuests, tonumber(sourceQuestID));
						end
						
						-- Insert the header for the source quest
						if #prereqs > 0 then
							tinsert(prereqs, {
								["text"] = "Upon Completion",
								["description"] = "The above quests need to be completed before being able to complete the quest(s) listed below.",
								["icon"] = "Interface\\Icons\\Spell_Holy_MagicalSentry.blp",
								["visible"] = true,
								["expanded"] = true,
								["g"] = g,
								["hideText"] = true
							});
						else
							local prereq = prereqs[1];
							if prereq.g then
								for i,group in ipairs(prereq.g) do
									tinsert(g, 1, group);
								end
							end
							prereq["g"] = g;
						end
						g = prereqs;
						breakafter = breakafter + 1;
						if breakafter >= 100 then
							app.print("Likely just broke out of an infinite source quest loop. Please report this to the ATT Discord!");
							break;
						end
					end
				end
				
				-- Clean up the recursive hierarchy. (this removed duplicates)
				sourceQuests = {};
				prereqs = g;
				local orig = g;
				while prereqs and #prereqs > 0 do
					for i=#prereqs,1,-1 do
						local o = prereqs[i];
						if o.key then
							sourceQuest = o.key .. o[o.key];
							if sourceQuests[sourceQuest] then
								-- Already exists in the hierarchy. Uh oh.
								table.remove(prereqs, i);
							else
								sourceQuests[sourceQuest] = true;
							end
						end
					end
					
					if #prereqs > 1 then
						prereqs = prereqs[#prereqs];
						if prereqs then prereqs = prereqs.g; end
						orig = prereqs;
					else
						prereqs = prereqs[#prereqs];
						if prereqs then prereqs = prereqs.g; end
						orig[#orig].g = prereqs;
					end
				end
				
				-- Clean up standalone "Upon Completion" headers.
				prereqs = g;
				repeat
					local orig = prereqs;
					if #orig == 2 then
						prereqs = orig[1].g;
						if not prereqs or #prereqs < 1 then
							prereqs = orig[2].g;
							orig[1].g = prereqs;
							table.remove(orig, 2);
						else
							sourceQuests = orig[2].g;
							table.remove(orig, 2);
							if #sourceQuests == 2 then
								sourceQuests[1].g = sourceQuests[2].g;
								table.remove(sourceQuests, 2);
							end
							for i,sourceQuest in ipairs(sourceQuests) do
								table.insert(prereqs, sourceQuest);
							end
						end
					else
						prereqs = orig[#orig].g;
					end
				until not prereqs or #prereqs < 1;
			end
			popout.data = {
				["text"] = "Quest Chain Requirements",
				["description"] = "The following quests need to be completed before being able to complete the final quest.",
				["icon"] = "Interface\\Icons\\Spell_Holy_MagicalSentry.blp",
				["g"] = g,
				["hideText"] = true
			};
		elseif group.g then
			-- This is already a container with accurate numbers.
			popout.data = group;
		else
			-- This is a standalone item
			group.visible = true;
			popout.data = {
				["text"] = "Standalone Item",
				["icon"] = "Interface\\Icons\\Achievement_Garrison_blueprint_medium.blp",
				["g"] = { group },
			};
		end
		
		-- Clone the data and then insert it into the Raw Data table.
		popout.data = CloneData(popout.data);
		popout.data.hideText = true;
		popout.data.visible = true;
		popout.data.indent = 0;
		popout.data.total = 0;
		popout.data.progress = 0;
		BuildGroups(popout.data, popout.data.g);
		UpdateGroups(popout.data, popout.data.g);
		table.insert(app.RawData, popout.data);
	end
	if IsAltKeyDown() then
		AddTomTomWaypoint(popout.data, false);
	else
		if not popout.data.expanded then
			ExpandGroupsRecursively(popout.data, true, true);
		end
		popout:Toggle(true);
	end
end
local function ClearRowData(self)
	self.ref = nil;
	self.Background:Hide();
	self.Texture:Hide();
	self.Texture.Background:Hide();
	self.Texture.Border:Hide();
	self.Indicator:Hide();
	self.Summary:Hide();
	self.Label:Hide();
end
local function CalculateRowBack(data)
	if data.back then return data.back; end
	if data.parent then
		return CalculateRowBack(data.parent) * 0.5;
	else
		return 0;
	end
end
local function CalculateRowIndent(data)
	if data.indent then return data.indent; end
	if data.parent then
		return CalculateRowIndent(data.parent) + 1;
	else
		return 0;
	end
end
local function SetRowData(self, row, data)
	ClearRowData(row);
	if data then
		local text = data.text;
		if not text or text == RETRIEVING_DATA then
			text = RETRIEVING_DATA;
			self.processingLinks = true;
		elseif string.find(text, "%[%]") then
			-- This means the link is still rendering
			text = RETRIEVING_DATA;
			self.processingLinks = true;
		elseif data.s and data.s < 1 then
			-- If it doesn't, the source ID will need to be harvested.
			local s, dressable = GetSourceID(text, data.itemID);
			if s and s > 0 then
				data.s = s;
				if data.collected then
					data.parent.progress = data.parent.progress + 1;
				end
				local item = AllTheThingsHarvestItems[data.itemID];
				if not item then
					item = {};
					AllTheThingsHarvestItems[data.itemID] = item;
				end
				if data.bonusID then
					local bonuses = item.bonuses;
					if not bonuses then
						bonuses = {};
						item.bonuses = bonuses;
					end
					bonuses[data.bonusID] = s;
				else
					local mods = item.mods;
					if not mods then
						mods = {};
						item.mods = mods;
					end
					mods[data.modID or 1] = s;
				end
				--print("NEW SOURCE ID!", text);
			else
				--print("NARP", text);
				data.s = nil;
				data.parent.total = data.parent.total - 1;
			end
		end
		local leftmost = row;
		local relative = "LEFT";
		local x = ((CalculateRowIndent(data) * 8) or 0) + 8;
		local back = CalculateRowBack(data);
		row.ref = data;
		if back then
			row.Background:SetAlpha(back or 0.2);
			row.Background:Show();
		end
		if data.u then
			local reason = L["UNOBTAINABLE_ITEM_REASONS"][data.u or 1];
			if reason then
				local texture = L["UNOBTAINABLE_ITEM_TEXTURES"][reason[1]];
				if texture then
					row.Indicator:SetTexture(texture);
					row.Indicator:SetPoint("RIGHT", leftmost, relative, x, 0);
					row.Indicator:Show();
				end
			end
		end
		if data.saved then
			if data.parent and data.parent.locks or data.isDaily then
				row.Indicator:SetTexture("Interface\\Addons\\AllTheThings\\assets\\known");
			else
				row.Indicator:SetTexture("Interface\\Addons\\AllTheThings\\assets\\known_green");
			end
			row.Indicator:SetPoint("RIGHT", leftmost, relative, x, 0);
			row.Indicator:Show();
		end
		if SetPortraitIcon(row.Texture, data) then
			row.Texture.Background:SetPoint("LEFT", leftmost, relative, x, 0);
			row.Texture.Border:SetPoint("LEFT", leftmost, relative, x, 0);
			row.Texture:SetPoint("LEFT", leftmost, relative, x, 0);
			row.Texture:Show();
			leftmost = row.Texture;
			relative = "RIGHT";
			x = 4;
		end
		local summary = GetProgressTextForRow(data);
		if not summary then
			if data.g and not data.expanded and #data.g > 0 then
				summary = "+++";
			else
				summary = "---";
			end
		end
		local specs = data.specs;
		if specs and #specs > 0 then
			table.sort(specs);
			for i,spec in ipairs(specs) do
				local id, name, description, icon, role, class = GetSpecializationInfoByID(spec);
				if class == app.Class then summary = "|T" .. icon .. ":0|t " .. summary; end
			end
		end
		row.Summary:SetText(summary);
		row.Summary:Show();
		row.Label:SetPoint("LEFT", leftmost, relative, x, 0);
		if row.Summary and row.Summary:IsShown() then
			row.Label:SetPoint("RIGHT", row.Summary, "LEFT", 0, 0);
		else
			row.Label:SetPoint("RIGHT");
		end
		row.Label:SetText(text);
		if data.font then
			row.Label:SetFontObject(data.font);
			row.Summary:SetFontObject(data.font);
		else
			row.Label:SetFontObject("GameFontNormal");
			row.Summary:SetFontObject("GameFontNormal");
		end
		row:SetHeight(select(2, row.Label:GetFont()) + 4);
		row.Label:Show();
		row:Show();
	else
		row:Hide();
	end
end
local function UpdateRowProgress(group)
	if group.collectible then
		group.progress = group.collected and 1 or 0;
		group.total = 1;
	else
		group.progress = 0;
		group.total = 0;
	end
	if group.g then
		for i,subgroup in ipairs(group.g) do
			UpdateRowProgress(subgroup);
			if subgroup.total then
				group.progress = group.progress + subgroup.progress;
				group.total = group.total + subgroup.total;
			end
		end
	end
end
local function UpdateVisibleRowData(self)
	-- If there is no raw data, then return immediately.
	if not self.rowData then return; end
	if self:GetHeight() > 64 then self.ScrollBar:Show(); else self.ScrollBar:Hide(); end
	
	-- Make it so that if you scroll all the way down, you have the ability to see all of the text every time.
	local totalRowCount = #self.rowData;
	if totalRowCount > 0 then
		-- Fill the remaining rows up to the (visible) row count.
		local container, rowCount, totalHeight = self.Container, 0, 0;
		local current = math.max(1, math.min(self.ScrollBar.CurrentValue, totalRowCount));
		
		-- Ensure that the first row doesn't move out of position.
		local row = container.rows[1] or CreateRow(container);
		SetRowData(self, row, self.rowData[1]);
		totalHeight = totalHeight + row:GetHeight();
		current = current + 1;
		rowCount = rowCount + 1;
		
		for i=2,totalRowCount do
			row = container.rows[i] or CreateRow(container);
			SetRowData(self, row, self.rowData[current]);
			totalHeight = totalHeight + row:GetHeight();
			if totalHeight > container:GetHeight() then
				break;
			else
				current = current + 1;
				rowCount = rowCount + 1;
			end
		end
		
		-- Hide the extra rows if any exist
		for i=math.max(2, rowCount + 1),#container.rows do
			ClearRowData(container.rows[i]);
			container.rows[i]:Hide();
		end
		
		totalRowCount = totalRowCount + 1;
		self.ScrollBar:SetMinMaxValues(1, math.max(1, totalRowCount - rowCount));
		
		-- If the rows need to be processed again, do so next update.
		if self.processingLinks then
			StartCoroutine(self:GetName(), function()
				while self.processingLinks do
					self.processingLinks = nil;
					coroutine.yield();
					UpdateVisibleRowData(self);
				end
				if self.UpdateDone then
					StartCoroutine(self:GetName()..":UpdateDone", function()
						coroutine.yield();
						StartCoroutine(self:GetName()..":UpdateDoneP2", function()
							coroutine.yield();
							self:UpdateDone();
						end);
					end);
				end
			end);
		elseif self.UpdateDone and rowCount > 5 then
			StartCoroutine(self:GetName()..":UpdateDone", function()
				coroutine.yield();
				StartCoroutine(self:GetName()..":UpdateDoneP2", function()
					coroutine.yield();
					self:UpdateDone();
				end);
			end);
		end
	else
		self:Hide();
	end
end
local function HideParent(self)
	self:GetParent():Toggle();
end
local function IsSelfOrChild(self, focus)
	-- This function helps validate that the focus is within the local hierarchy.
	return focus and (self == focus or IsSelfOrChild(self, focus:GetParent()));
end
local function StopMovingOrSizing(self)
	if self.isMoving then
		self:StopMovingOrSizing();
		self.isMoving = false;
	end
end
local function StartMovingOrSizing(self, fromChild)
	if not self:IsMovable() and not self:IsResizable() then
		return
	end
	if self.isMoving then
		StopMovingOrSizing(self);
	else
		self.isMoving = true;
		if ((select(2, GetCursorPosition()) / self:GetEffectiveScale()) < math.max(self:GetTop() - 40, self:GetBottom() + 10)) then
			self:StartSizing();
			Push(self, "StartMovingOrSizing (Sizing)", function()
				if self.isMoving then
					--self:Update();
					UpdateVisibleRowData(self);
					return true;
				end
			end);
		else
			self:StartMoving();
			Push(app, "StartMovingOrSizing (Moving)", function()
				-- This fixes a bug where the window will get stuck on the mouse until you reload.
				if IsSelfOrChild(self, GetMouseFocus()) then
					return true;
				else
					StopMovingOrSizing(self);
				end
			end);
		end
	end
end
local function RowOnClick(self, button)
	local reference = self.ref;
	if reference then
		-- If the row data itself has an OnClick handler... execute that first.
		if reference.OnClick and reference.OnClick(self, button) then
			return true;
		end
		
		if IsShiftKeyDown() then
			-- If we're at the Auction House
			if AuctionFrame and AuctionFrame:IsShown() then
				-- Auctionator Support
				if Atr_SearchAH then
					if reference.g and #reference.g > 0 then
						local missingItems = SearchForMissingItemNames(reference);					
						if #missingItems > 0 then
							Atr_SelectPane(3);
							Atr_SearchAH(L["TITLE"], missingItems, LE_ITEM_CLASS_ARMOR);
							return true;
						end
						app.print("No cached items found in search. Expand the group and view the items to cache the names and try again. Only Bind on Equip items will be found using this search.");
					else
						local name = reference.name;
						if name then
							Atr_SelectPane(3);
							--Atr_SearchAH(name, { name });
							Atr_SetSearchText (name);
							Atr_Search_Onclick ();
							return true;
						end
						app.print("Only Bind on Equip items can be found using this search.");
					end
					return true;
				elseif TSMAPI and TSMAPI.Auction then
					if reference.g and #reference.g > 0 then
						local missingItems = SearchForMissingItems(reference);					
						if #missingItems > 0 then
							local itemList, search = {};
							for i,group in ipairs(missingItems) do
								search = group.tsm or TSMAPI.Item:ToItemString(group.link or group.itemID);
								if search then itemList[search] = BuildSourceTextForTSM(group, 0); end
							end
							app:ShowPopupDialog("Running this command can potentially destroy your existing TSM settings by reassigning items to the " .. L["TITLE"] .. " preset.\n\nWe recommend that you use a different profile when using this feature.\n\nDo you want to proceed anyways?",
							function()
								TSMAPI.Groups:CreatePreset(itemList);
								app.print("Updated the preset successfully.");
								if not TSMAPI.Operations:GetFirstByItem(search, "Shopping") then
									print("The preset is missing a 'Shopping' Operation assignment.");
									print("Type '/tsm operations' to create or assign one.");
								end
							end);
							return true;
						end
						app.print("No cached items found in search. Expand the group and view the items to cache the names and try again. Only Bind on Equip items will be found using this search.");
					else
						-- Attempt to search manually with the link.
						local link = reference.link or reference.silentLink;
						if link and HandleModifiedItemClick(link) then
							AuctionFrameBrowse_Search();
							return true;
						end
					end
					return true;
				else
					if reference.g and #reference.g > 0 and not reference.link then
						app.print("Group-based searches are only supported using Auctionator.");
						return true;
					else
						-- Attempt to search manually with the link.
						local link = reference.link or reference.silentLink;
						if link and HandleModifiedItemClick(link) then
							AuctionFrameBrowse_Search();
							return true;
						end
					end
				end
			elseif TSMAPI_FOUR and false then
				if reference.g and #reference.g > 0 then
					if true then
						app.print("TSM4 not compatible with ATT yet. If you know how to create Presets like we used to do in TSM3, please whisper Crieve on Discord!");
						return true;
					end
					local missingItems = SearchForMissingItems(reference);					
					if #missingItems > 0 then
						app:ShowPopupDialog("Running this command can potentially destroy your existing TSM settings by reassigning items to the " .. L["TITLE"] .. " preset.\n\nWe recommend that you use a different profile when using this feature.\n\nDo you want to proceed anyways?",
						function()
							local itemString, groupPath;
							groupPath = BuildSourceTextForTSM(app:GetWindow("Prime").data, 0);
							if TSMAPI_FOUR.Groups.Exists(groupPath) then
								TSMAPI_FOUR.Groups.Remove(groupPath);
							end
							TSMAPI_FOUR.Groups.AppendOperation(groupPath, "Shopping", operation)
							for i,group in ipairs(missingItems) do
								if (not group.spellID and not group.achID) or group.itemID then
									itemString = group.tsm;
									if itemString then
										groupPath = BuildSourceTextForTSM(group, 0);
										TSMAPI_FOUR.Groups.Create(groupPath);
										if TSMAPI_FOUR.Groups.IsItemInGroup(itemString) then
											TSMAPI_FOUR.Groups.MoveItem(itemString, groupPath)
										else
											TSMAPI_FOUR.Groups.AddItem(itemString, groupPath)
										end
										if i > 10 then break; end
									end
								end
							end
							app.print("Updated the preset successfully.");
						end);
						return true;
					end
					app.print("No cached items found in search. Expand the group and view the items to cache the names and try again. Only Bind on Equip items will be found using this search.");
				else
					-- Attempt to search manually with the link.
					local link = reference.link or reference.silentLink;
					if link and HandleModifiedItemClick(link) then
						AuctionFrameBrowse_Search();
						return true;
					end
				end
				return true;
			else
			
				-- Not at the Auction House
				-- If this reference has a link, then attempt to preview the appearance or write to the chat window.
				local link = reference.link or reference.silentLink;
				if (link and HandleModifiedItemClick(link)) or ChatEdit_InsertLink(link or BuildSourceTextForChat(reference, 0)) then return true; end
				
				-- If you're looking at the Profession Window, Shift Clicking will replace the search string instead.
				if app:GetWindow("Tradeskills"):IsShown() then
					
				elseif button == "LeftButton" then
					-- Default behaviour is to Refresh Collections.
					RefreshCollections(reference);
				end
				return true;
			end
		end
		
		-- Control Click Expands the Groups
		if IsControlKeyDown() then
			-- Illusions are a nasty animal that need to be displayed a special way.
			if reference.illusionID then
				DressUpVisual(DressUpOutfitMixin:GetSlotSourceID("MAINHANDSLOT", LE_TRANSMOG_TYPE_APPEARANCE), 16, reference.illusionID);
			else
				-- If this reference has a link, then attempt to preview the appearance.
				local link = reference.link or reference.silentLink;
				if link and HandleModifiedItemClick(link) then
					return true;
				end
			end
			
			-- If this reference is anything else, expand the groups.
			if reference.g then
				if self.index < 1 and #reference.g > 0 then
					ExpandGroupsRecursively(reference, not reference.g[1].expanded, true);
				else
					ExpandGroupsRecursively(reference, not reference.expanded, true);
				end
				app:UpdateWindows();
				return true;
			end
		end
		
		-- All non-Shift Right Clicks open a mini list or the settings.
		if button == "RightButton" then
			if self.index > 0 then
				CreateMiniListForGroup(self.ref);
			else
				-- Open the Settings Menu
				if InterfaceOptionsFrame:IsVisible() then
					InterfaceOptionsFrame_Show();
				else
					InterfaceOptionsFrame_OpenToCategory(app:GetName());
					InterfaceOptionsFrame_OpenToCategory(app:GetName());
				end
			end
		elseif self.index > 0 then
			reference.expanded = not reference.expanded;
			self:GetParent():GetParent():Update();
		elseif not reference.expanded then
			reference.expanded = true;
			self:GetParent():GetParent():Update();
		else
			-- Allow the First Frame to move the parent.
			local owner = self:GetParent():GetParent();
			self:SetScript("OnMouseUp", function(self)
				self:SetScript("OnMouseUp", nil);
				StopMovingOrSizing(owner);
			end);
			StartMovingOrSizing(owner, true);
		end
	end
end
local function RowOnEnter(self)
	local reference = self.ref; -- NOTE: This is the good ref value, not the parasitic one.
	if reference and GameTooltip then
		GameTooltipIcon.icon.Background:Hide();
		GameTooltipIcon.icon.Border:Hide();
		GameTooltipIcon:Hide();
		GameTooltipModel:Hide();
		GameTooltip:ClearLines();
		GameTooltipIcon:ClearAllPoints();
		GameTooltipModel:ClearAllPoints();
		if self:GetCenter() > (UIParent:GetWidth() / 2) and (not AuctionFrame or not AuctionFrame:IsVisible()) then
			GameTooltip:SetOwner(self, "ANCHOR_LEFT");
			GameTooltipIcon:SetPoint("TOPRIGHT", GameTooltip, "TOPLEFT", 0, 0);
			GameTooltipModel:SetPoint("TOPRIGHT", GameTooltip, "TOPLEFT", 0, 0);
		else
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT");
			GameTooltipIcon:SetPoint("TOPLEFT", GameTooltip, "TOPRIGHT", 0, 0);
			GameTooltipModel:SetPoint("TOPLEFT", GameTooltip, "TOPRIGHT", 0, 0);
		end
		
		-- NOTE: Order matters, we "fall-through" certain values in order to pass this information to the item ID section.
		if not reference.creatureID then
			if reference.itemID then
				local link = reference.link;
				if link and link ~= "" then
					GameTooltip:SetHyperlink(link);
				else
					GameTooltip:AddLine("Item #" .. reference.itemID);
					if reference and reference.u then GameTooltip:AddLine(L["UNOBTAINABLE_ITEM_REASONS"][reference.u][2], 1, 1, 1, true); end
					AttachTooltipSearchResults(GameTooltip, "itemID:" .. reference.itemID, SearchForField, "itemID", reference.itemID);
				--elseif reference.speciesID then
					-- Do nothing.
				--elseif not reference.artifactID then
					--GameTooltip:AddDoubleLine(self.Label:GetText(), "---");
					--if reference and reference.u then GameTooltip:AddLine(L["UNOBTAINABLE_ITEM_REASONS"][reference.u][2], 1, 1, 1, true); end
					--for key, value in pairs(reference) do
					--	GameTooltip:AddDoubleLine(key, tostring(value));
					--end	
				end
			elseif reference.currencyID then
				GameTooltip:SetCurrencyByID(reference.currencyID, 1);
			elseif not reference.encounterID then
				local link = reference.link;
				if link then pcall(GameTooltip.SetHyperlink, GameTooltip, link); end
			end
		end
		
		-- Miscellaneous fields
		if GameTooltip:NumLines() < 1 then GameTooltip:AddLine(self.Label:GetText()); end
		if app.Settings:GetTooltipSetting("Progress") then
			if reference.trackable and reference.total and reference.total >= 2 then
				GameTooltip:AddDoubleLine("Tracking Progress", GetCompletionText(reference.saved));
			end
		end
		
		-- Relative ATT location
		if reference.parent and not reference.itemID then
			if reference.parent.parent then
				GameTooltip:AddDoubleLine(reference.parent.parent.text or RETRIEVING_DATA, reference.parent.text or RETRIEVING_DATA);
			else
				--GameTooltip:AddLine(reference.parent.text or RETRIEVING_DATA, 1, 1, 1);
			end
		end
		
		local title = reference.title;
		if title then
			local left, right = strsplit(DESCRIPTION_SEPARATOR, title);
			if right then
				GameTooltip:AddDoubleLine(left, right);
			else
				GameTooltip:AddLine(title, 1, 1, 1);
			end
		elseif reference.retries then
			GameTooltip:AddLine("Failed to acquire information. This quest may have been removed from the game. " .. tostring(reference.retries), 1, 1, 1);
		end
		local lvl = reference.lvl or 0;
		if lvl > 1 then GameTooltip:AddDoubleLine(L["REQUIRES_LEVEL"], tostring(lvl)); end
		if reference.b and app.Settings:GetTooltipSetting("binding") then GameTooltip:AddDoubleLine("Binding", tostring(reference.b)); end
		if reference.requireSkill then GameTooltip:AddDoubleLine(L["REQUIRES"], tostring(GetSpellInfo(SkillIDToSpellID[reference.requireSkill] or 0))); end
		if reference.f and reference.f > 0 and app.Settings:GetTooltipSetting("filterID") then GameTooltip:AddDoubleLine(L["FILTER_ID"], tostring(L["FILTER_ID_TYPES"][reference.f])); end
		if reference.achievementID and app.Settings:GetTooltipSetting("achievementID") then GameTooltip:AddDoubleLine(L["ACHIEVEMENT_ID"], tostring(reference.achievementID)); end
		if reference.artifactID and app.Settings:GetTooltipSetting("artifactID") then GameTooltip:AddDoubleLine(L["ARTIFACT_ID"], tostring(reference.artifactID)); end
		if reference.difficultyID and app.Settings:GetTooltipSetting("difficultyID") then GameTooltip:AddDoubleLine(L["DIFFICULTY_ID"], tostring(reference.difficultyID)); end
		if app.Settings:GetTooltipSetting("creatureID") then 
			if reference.creatureID then
				GameTooltip:AddDoubleLine(L["CREATURE_ID"], tostring(reference.creatureID));
			elseif reference.npcID and reference.npcID > 0 then
				GameTooltip:AddDoubleLine(L["NPC_ID"], tostring(reference.npcID));
			end
		end
		if reference.encounterID then
			if app.Settings:GetTooltipSetting("encounterID") then GameTooltip:AddDoubleLine(L["ENCOUNTER_ID"], tostring(reference.encounterID)); end
		--	if reference.parent and reference.parent.locks then GameTooltip:AddDoubleLine("Instance Progress", GetCompletionText(reference.saved)); end
		--elseif reference.creatureID or (reference.npcID and reference.npcID > 0) then
		--	if reference.parent and reference.parent.locks then GameTooltip:AddDoubleLine("Instance Progress", GetCompletionText(reference.saved)); end
		end
		if reference.factionID and app.Settings:GetTooltipSetting("factionID") then GameTooltip:AddDoubleLine(L["FACTION_ID"], tostring(reference.factionID)); end
		if reference.illusionID and app.Settings:GetTooltipSetting("illusionID") then GameTooltip:AddDoubleLine(L["ILLUSION_ID"], tostring(reference.illusionID)); end
		if reference.instanceID then
			if app.Settings:GetTooltipSetting("instanceID") then GameTooltip:AddDoubleLine(L["INSTANCE_ID"], tostring(reference.instanceID)); end
			GameTooltip:AddDoubleLine(L["LOCKOUT"], L[reference.isLockoutShared and "SHARED" or "SPLIT"]);
		end
		if reference.objectID and app.Settings:GetTooltipSetting("objectID") then GameTooltip:AddDoubleLine(L["OBJECT_ID"], tostring(reference.objectID)); end
		if reference.speciesID and app.Settings:GetTooltipSetting("speciesID") then GameTooltip:AddDoubleLine(L["SPECIES_ID"], tostring(reference.speciesID)); end
		if reference.spellID and app.Settings:GetTooltipSetting("spellID") then GameTooltip:AddDoubleLine(L["SPELL_ID"], tostring(reference.spellID)); end
		if reference.tierID and app.Settings:GetTooltipSetting("tierID") then GameTooltip:AddDoubleLine(L["EXPANSION_ID"], tostring(reference.tierID)); end
		if reference.setID then GameTooltip:AddDoubleLine(L["SET_ID"], tostring(reference.setID)); end
		if reference.setHeaderID then GameTooltip:AddDoubleLine(L["SET_ID"], tostring(reference.setHeaderID)); end
		if reference.setSubHeaderID then GameTooltip:AddDoubleLine(L["SET_ID"], tostring(reference.setSubHeaderID)); end
		
		if reference.mapID and app.Settings:GetTooltipSetting("mapID") then GameTooltip:AddDoubleLine(L["MAP_ID"], tostring(reference.mapID)); end
		if reference.coords and app.Settings:GetTooltipSetting("Coordinates") then
			local j = 0;
			for i,coord in ipairs(reference.coords) do
				local x = coord[1];
				local y = coord[2];
				local str;
				local mapID = coord[3];
				if mapID then
					str = tostring(mapID);
					if mapID == app.GetCurrentMapID() then str = str .. "*"; end
					str = str .. ": ";
				else
					str = "";
				end
				GameTooltip:AddDoubleLine(j == 0 and "Coordinates" or " ", 
					str.. GetNumberWithZeros(math.floor(x * 10) * 0.1, 1) .. ", " .. GetNumberWithZeros(math.floor(y * 10) * 0.1, 1), 1, 1, 1, 1, 1, 1);
				j = j + 1;
			end
		end
		if reference.coord and app.Settings:GetTooltipSetting("Coordinates") then
			GameTooltip:AddDoubleLine("Coordinate",
				GetNumberWithZeros(math.floor(reference.coord[1] * 10) * 0.1, 1) .. ", " .. 
				GetNumberWithZeros(math.floor(reference.coord[2] * 10) * 0.1, 1), 1, 1, 1, 1, 1, 1);
		end
		if reference.bonusID and app.Settings:GetTooltipSetting("bonusID") then GameTooltip:AddDoubleLine("Bonus ID", tostring(reference.bonusID)); end
		if reference.modID and app.Settings:GetTooltipSetting("modID") then GameTooltip:AddDoubleLine("Mod ID", tostring(reference.modID)); end
		if reference.dr then GameTooltip:AddDoubleLine(L["DROP_RATE"], "|c" .. GetProgressColor(reference.dr * 0.01) .. tostring(reference.dr) .. "%|r"); end
		if not reference.itemID then
			if reference.speciesID then
				AttachTooltipSearchResults(GameTooltip, "speciesID:" .. reference.speciesID, SearchForField, "speciesID", reference.speciesID);
			else
				if reference.description and app.Settings:GetTooltipSetting("Descriptions") then
					local found = false;
					for i=1,GameTooltip:NumLines() do
						if _G["GameTooltipTextLeft"..i]:GetText() == reference.description then
							found = true;
							break;
						end
					end
					if not found then GameTooltip:AddLine(reference.description, 0.4, 0.8, 1, 1); end
				end
				if reference.u then
					GameTooltip:AddLine(L["UNOBTAINABLE_ITEM_REASONS"][reference.u][2], 1, 1, 1, 1, true);
				end
			end
		end
		if reference.speciesID then
			local progress, total = C_PetJournal.GetNumCollectedInfo(reference.speciesID);
			if total then GameTooltip:AddLine(tostring(progress) .. " / " .. tostring(total) .. " Collected"); end
		end
		if reference.titleID then
			if app.Settings:GetTooltipSetting("titleID") then GameTooltip:AddDoubleLine(L["TITLE_ID"], tostring(reference.titleID)); end
			GameTooltip:AddDoubleLine(" ", L[IsTitleKnown(reference.titleID) and "KNOWN_ON_CHARACTER" or "UNKNOWN_ON_CHARACTER"]);
			AttachTooltipSearchResults(GameTooltip, "titleID:" .. reference.titleID, SearchForField, "titleID", reference.titleID, true);
		end
		if reference.questID then
			if app.Settings:GetTooltipSetting("questID") then
				GameTooltip:AddDoubleLine(L["QUEST_ID"], tostring(reference.questID));
				if reference.altQuestID then GameTooltip:AddDoubleLine(" ", tostring(reference.altQuestID)); end
			end
		end
		if reference.qgs and app.Settings:GetTooltipSetting("QuestGivers") then
			if app.Settings:GetTooltipSetting("creatureID") then 
				for i,qg in ipairs(reference.qgs) do
					GameTooltip:AddDoubleLine(i == 1 and L["QUEST_GIVER"] or " ", tostring(qg > 0 and NPCNameFromID[qg] or "") .. " (" .. qg .. ")");
				end
			else
				for i,qg in ipairs(reference.qgs) do
					GameTooltip:AddDoubleLine(i == 1 and L["QUEST_GIVER"] or " ", tostring(qg > 0 and NPCNameFromID[qg] or qg));
				end
			end
		end
		if reference.crs and app.Settings:GetTooltipSetting("creatures") then
			if app.Settings:GetTooltipSetting("creatureID") then 
				for i,cr in ipairs(reference.crs) do
					GameTooltip:AddDoubleLine(i == 1 and CREATURE or " ", tostring(cr > 0 and NPCNameFromID[cr] or "") .. " (" .. cr .. ")");
				end
			else
				for i,cr in ipairs(reference.crs) do
					GameTooltip:AddDoubleLine(i == 1 and CREATURE or " ", tostring(cr > 0 and NPCNameFromID[cr] or cr));
				end
			end
		end
		if reference.c and app.Settings:GetTooltipSetting("ClassRequirements") then
			local str = "";
			for i,cl in ipairs(reference.c) do
				if i > 1 then str = str .. ", "; end
				str = str .. C_CreatureInfo.GetClassInfo(cl).className;
			end
			GameTooltip:AddDoubleLine("Classes", str);
		end
		if app.Settings:GetTooltipSetting("RaceRequirements") then
			if reference.races then
				local str = "";
				for i,race in ipairs(reference.races) do
					if i > 1 then str = str .. ", "; end
					str = str .. C_CreatureInfo.GetRaceInfo(race).raceName;
				end
				GameTooltip:AddDoubleLine("Races", str);
			elseif reference.r and reference.r > 0 then
				GameTooltip:AddDoubleLine("Races", (reference.r == 1 and "Alliance Only") or (reference.r == 2 and "Horde Only") or "Unknown");
			end
		end
		if reference.isDaily then GameTooltip:AddLine("This can be completed daily."); end
		if reference.isWeekly then GameTooltip:AddLine("This can be completed weekly."); end
		if not GameTooltipModel:TrySetModel(reference) and reference.icon then
			GameTooltipIcon:SetSize(72,72);
			GameTooltipIcon.icon:SetTexture(reference.preview or reference.icon);
			local texcoord = reference.previewtexcoord or reference.texcoord;
			if texcoord then
				GameTooltipIcon.icon:SetTexCoord(texcoord[1], texcoord[2], texcoord[3], texcoord[4]);
			else
				GameTooltipIcon.icon:SetTexCoord(0, 1, 0, 1);
			end
			GameTooltipIcon:Show();
		elseif reference.displayID or reference.modelID or reference.model then
			if app.Settings:GetTooltipSetting("fileID") then
				GameTooltip:AddDoubleLine("File ID", GameTooltipModel.Model:GetModelFileID());
			end
			if app.Settings:GetTooltipSetting("displayID") then
				if reference.displayID or reference.modelID then
					GameTooltip:AddDoubleLine("Display ID", reference.displayID);
				end
				if reference.modelID then
					GameTooltip:AddDoubleLine("Model ID", reference.modelID);
				end
			end
		end
		if reference.cost then
			local cost = tostring(reference.cost);
			if reference.parent and (reference.parent.currencyID or reference.parent.itemID) then
				cost = (reference.parent.icon and ("|T" .. reference.parent.icon .. ":0|t") or "") .. (reference.parent.text or "???") .. " x" .. cost;
			end
			GameTooltip:AddDoubleLine("Cost", cost); 
		end
		if reference.criteriaID and reference.achievementID then
			GameTooltip:AddDoubleLine("Criteria for", GetAchievementLink(reference.achievementID));
		end
		if reference.achievementID then AttachTooltipSearchResults(GameTooltip, "achievementID:" .. reference.achievementID, SearchForField, "achievementID", reference.achievementID, reference.criteriaID); end
		if app.Settings:GetTooltipSetting("Progress") then
			local right = (app.Settings:GetTooltipSetting("ShowIconOnly") and GetProgressTextForRow or GetProgressTextForTooltip)(reference);
			if right and right ~= "" and right ~= "---" then
				GameTooltipTextRight1:SetText(right);
				GameTooltipTextRight1:Show();
			end
		end
		
		-- Show Quest Prereqs
		if reference.sourceQuests and not reference.saved then
			local prereqs, bc = {}, {};
			for i,sourceQuestID in ipairs(reference.sourceQuests) do
				if sourceQuestID > 0 and not IsQuestFlaggedCompleted(sourceQuestID) then
					local sqs = SearchForField("questID", sourceQuestID);
					if sqs and #sqs > 0 then
						local sq = sqs[1];
						if sq and sq.isBreadcrumb then
							table.insert(bc, sqs[1]);
						else
							table.insert(prereqs, sqs[1]);
						end
					else
						table.insert(prereqs, {questID = sourceQuestID});
					end
				end
			end
			if prereqs and #prereqs > 0 then
				GameTooltip:AddLine("This quest has an incomplete prerequisite quest that you need to complete first.");
				for i,prereq in ipairs(prereqs) do
					GameTooltip:AddLine("   " .. prereq.questID .. ": " .. (prereq.text or RETRIEVING_DATA));
				end
			end
			if bc and #bc > 0 then
				GameTooltip:AddLine("This quest has a breadcrumb quest that you may be unable to complete after completing this one.");
				for i,prereq in ipairs(bc) do
					GameTooltip:AddLine("   " .. prereq.questID .. ": " .. (prereq.text or RETRIEVING_DATA));
				end
			end
		end
		
		-- Show lockout information
		if reference.instanceID then
			-- Contains information about an Instance (Raid or Dungeon)
			local locks = reference.locks;
			if locks then
				if reference.isLockoutShared and locks.shared then
					GameTooltip:AddDoubleLine("Shared", date("%c", locks.shared.reset));
					for encounterIter,encounter in pairs(locks.shared.encounters) do
						GameTooltip:AddDoubleLine(" " .. encounter.name, GetCompletionIcon(encounter.isKilled));
					end
				else
					for key,value in pairs(locks) do
						if key == "shared" then
							-- Skip
						else
							GameTooltip:AddDoubleLine(Colorize(GetDifficultyInfo(key), app.DifficultyColors[key] or "ff1eff00"), date("%c", value.reset));
							for encounterIter,encounter in pairs(value.encounters) do
								GameTooltip:AddDoubleLine(" " .. encounter.name, GetCompletionIcon(encounter.isKilled));
							end
						end
					end
				end
			end
		elseif reference.difficultyID then
			-- Contains information about a Difficulty
			local locks = reference.locks;
			if locks then
				GameTooltip:AddDoubleLine("Resets", date("%c", locks.reset));
				for encounterIter,encounter in pairs(locks.encounters) do
					GameTooltip:AddDoubleLine(" " .. encounter.name, GetCompletionIcon(encounter.isKilled));
				end
			end
		end
		
		if reference.g then
			-- If we're at the Auction House
			if AuctionFrame and AuctionFrame:IsShown() then
				GameTooltip:AddLine(L[(self.index > 0 and "OTHER_ROW_INSTRUCTIONS_AH") or "TOP_ROW_INSTRUCTIONS_AH"], 1, 1, 1);
			else
				GameTooltip:AddLine(L[(self.index > 0 and "OTHER_ROW_INSTRUCTIONS") or "TOP_ROW_INSTRUCTIONS"], 1, 1, 1);
			end
		end
		if not reference.itemID then
			-- If there is a note for this item, show it.
			local note = GetNoteForGroup(reference);
			if note then
				GameTooltip:AddLine("Custom Note:");
				GameTooltip:AddLine(note, 1, 1, 1);
			end
		end
		GameTooltip:Show();
	end
end
local function RowOnLeave(self)
	if GameTooltip then
		GameTooltip:ClearLines();
		GameTooltip:Hide();
		GameTooltipIcon.icon.Background:Hide();
		GameTooltipIcon.icon.Border:Hide();
		GameTooltipIcon:Hide();
		GameTooltipModel:Hide();
	end
end
CreateRow = function(self)
	local row = CreateFrame("Button", nil, self);
	row.index = #self.rows;
	if row.index == 0 then
		-- This means relative to the parent.
		row:SetPoint("TOPLEFT");
		row:SetPoint("TOPRIGHT");
	else
		-- This means relative to the row above this one.
		row:SetPoint("TOPLEFT", self.rows[row.index], "BOTTOMLEFT");
		row:SetPoint("TOPRIGHT", self.rows[row.index], "BOTTOMRIGHT");
	end
	table.insert(self.rows, row);
	
	-- Setup highlighting and event handling
	row:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight", "ADD");
	row:RegisterForClicks("LeftButtonDown","RightButtonDown");
	row:SetScript("OnClick", RowOnClick);
	row:SetScript("OnEnter", RowOnEnter);
	row:SetScript("OnLeave", RowOnLeave);
	row:EnableMouse(true);
	
	-- Label is the text information you read.
	row.Label = row:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	row.Label:SetJustifyH("LEFT");
	row.Label:SetPoint("BOTTOM");
	row.Label:SetPoint("TOP");
	row:SetHeight(select(2, row.Label:GetFont()) + 4);
	
	-- Summary is the completion summary information. (percentage text)
	row.Summary = row:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	row.Summary:SetJustifyH("CENTER");
	row.Summary:SetPoint("BOTTOM");
	row.Summary:SetPoint("RIGHT");
	row.Summary:SetPoint("TOP");
	
	-- Background is used by the Map Highlight functionality.
	row.Background = row:CreateTexture(nil, "BACKGROUND");
	row.Background:SetPoint("LEFT", 4, 0);
	row.Background:SetPoint("BOTTOM");
	row.Background:SetPoint("RIGHT");
	row.Background:SetPoint("TOP");
	row.Background:SetTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight");
	
	-- Indicator is used by the Instance Saves functionality.
	row.Indicator = row:CreateTexture(nil, "ARTWORK");
	row.Indicator:SetPoint("BOTTOM");
	row.Indicator:SetPoint("TOP");
	row.Indicator:SetWidth(row:GetHeight());
	
	-- Texture is the icon.
	row.Texture = row:CreateTexture(nil, "ARTWORK");
	row.Texture:SetPoint("BOTTOM");
	row.Texture:SetPoint("TOP");
	row.Texture:SetWidth(row:GetHeight());
	row.Texture.Background = row:CreateTexture(nil, "BACKGROUND");
	row.Texture.Background:SetPoint("BOTTOM");
	row.Texture.Background:SetPoint("TOP");
	row.Texture.Background:SetWidth(row:GetHeight());
	row.Texture.Border = row:CreateTexture(nil, "BORDER");
	row.Texture.Border:SetPoint("BOTTOM");
	row.Texture.Border:SetPoint("TOP");
	row.Texture.Border:SetWidth(row:GetHeight());
	
	-- Clear the Row Data Initially
	ClearRowData(row);
	return row;
end

-- Collection Window Creation
app.Windows = {};
local function OnScrollBarMouseWheel(self, delta)
	self.ScrollBar:SetValue(self.ScrollBar.CurrentValue - delta);
end
local function OnScrollBarValueChanged(self, value)
	local un = math.floor(value);
	local up = un + 1;
	self.CurrentValue = (up - value) > (-(un - value)) and un or up;
	--self:GetParent():Update();
	UpdateVisibleRowData(self:GetParent());
end
local function SetWindowVisibility(self, show)
	if show then
		self:Show();
		self:Update();
	else
		self:Hide();
		for i, self in pairs(app.Windows) do
			if self:IsVisible() then
				return;
			end
		end
	end
	
	-- Return that at least one window is visible...
	return true;
end
local function ToggleWindow(self)
	return SetWindowVisibility(self, not self:IsVisible());
end
function app:OpenWindow(suffix)
	local window = app.Windows[suffix];
	if window then SetWindowVisibility(window, true); end
end
function app:ToggleWindow(suffix)
	local window = app.Windows[suffix];
	if window then ToggleWindow(window); end
end
local function ProcessGroup(data, object)
	if app.VisibilityFilter(object) then
		tinsert(data, object);
		if object.g and object.expanded then
			for j, group in ipairs(object.g) do
				ProcessGroup(data, group);
			end
		end
	end
end
local function UpdateWindow(self, force, got)
	-- If this window doesn't have data, do nothing.
	if not self.data then return; end
	if not self.rowData then
		self.rowData = {};
	else
		wipe(self.rowData);
	end
	if self.data and (force or self:IsVisible()) then
		self.data.expanded = true;
		if self.shouldFullRefresh and (force or got) then
			self.data.progress = 0;
			self.data.total = 0;
			UpdateGroups(self.data, self.data.g);
		end
		ProcessGroup(self.rowData, self.data);
		
		-- Does this user have everything?
		if self.data.total then
			if self.data.total <= self.data.progress then
				if #self.rowData < 1 then
					self.data.back = 1;
					tinsert(self.rowData, self.data);
				end
				if self.missingData then
					if got then app:PlayCompleteSound(); end
					self.missingData = nil;
				end
				tinsert(self.rowData, {
					["text"] = "No entries matching your filters were found.",
					["description"] = "If you believe this was in error, try activating 'Debug Mode'. One of your filters may be restricting the visibility of the group.",
					["collectible"] = 1,
					["collected"] = 1,
					["back"] = 0.7
				});
			else
				self.missingData = true;
			end
		else
			self.missingData = nil;
		end
		
		UpdateVisibleRowData(self);
		return true;
	else
		UpdateVisibleRowData(self);
	end
end
local function UpdateWindowColor(self, suffix)
	self:SetBackdropBorderColor(1, 1, 1, 1);
	self:SetBackdropColor(0, 0, 0, 1);
end
function app:UpdateWindows(force, got)
	local anyUpdated = false;
	for name, window in pairs(app.Windows) do
		if window:Update(force, got) then
			--print(name .. ": Updated");
			anyUpdated = true;
		end
	end
	return anyUpdated;
end
function app:UpdateWindowColors()
	for suffix, window in pairs(app.Windows) do
		UpdateWindowColor(window, suffix);
	end
end
function app:GetDataCache()
	-- Update the Row Data by filtering raw data
	local allData = app:GetWindow("Prime").data;
	if not allData or not allData.total and app.Categories then
		allData = setmetatable({}, {
			__index = function(t, key)
				if key == "title" then
					return app.Settings:GetModeString() .. DESCRIPTION_SEPARATOR .. app.GetNumberOfItemsUntilNextPercentage(t.progress, t.total);
				else
					-- Something that isn't dynamic.
					return table[key];
				end
			end
		});
		allData.expanded = true;
		allData.icon = "Interface\\Addons\\AllTheThings\\assets\\content_20190216_1";
		allData.texcoord = {429 / 512, (429 + 36) / 512, 141 / 256, (141 + 36) / 256};
		allData.previewtexcoord = {1 / 512, (1 + 72) / 512, 75 / 256, (75 + 72) / 256};
		allData.text = L["TITLE"];
		allData.description = L["DESCRIPTION"];
		allData.visible = true;
		allData.font = "GameFontNormalLarge";
		allData.progress = 0;
		allData.total = 0;
		local g, db = {};
		allData.g = g;
		table.insert(app.RawData, allData);
		
		-- Dungeons & Raids
		db = {};
		db.expanded = false;
		db.text = GROUP_FINDER;
		db.icon = "Interface\\LFGFRAME\\LFGIcon-ReturntoKarazhan";
		db.g = app.Categories.Instances;
		table.insert(g, db);
		
		-- Zones
		if app.Categories.Zones then
			db = app.CreateAchievement(46, app.Categories.Zones);
			db.expanded = false;
			db.text = BUG_CATEGORY2;
			db.icon = "Interface\\ICONS\\Achievement_Zone_Outland_01"
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- World Drops
		if app.Categories.WorldDrops then
			db = {};
			db.expanded = false;
			db.text = TRANSMOG_SOURCE_4;
			db.icon = "Interface\\ICONS\\INV_Misc_Map02";
			db.g = app.Categories.WorldDrops;
			table.insert(g, db);
		end
	
		-- Group Finder
		if app.Categories.GroupFinder then
			db = app.CreateAchievement(4476, app.Categories.GroupFinder);	-- Looking for More
			db.expanded = false;
			db.text = DUNGEONS_BUTTON;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Achievements
		if app.Categories.Achievements then
			db = app.CreateAchievement(4496, app.Categories.Achievements);	-- It's Over Nine Thousand
			db.expanded = false;
			db.text = TRACKER_HEADER_ACHIEVEMENTS;
			db.npcID = -4;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Expansion Features
		if app.Categories.ExpansionFeatures then
			db = {};
			db.lvl = 67;
			db.expanded = false;
			db.text = GetCategoryInfo(15301);
			db.icon = "Interface\\ICONS\\Achievement_Battleground_TempleOfKotmogu_02_Green";
			db.g = app.Categories.ExpansionFeatures;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- World Events
		if app.Categories.WorldEvents then
			db = app.CreateAchievement(12827, app.Categories.WorldEvents);
			db.expanded = false;
			db.text = EVENTS_LABEL;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Anniversary
		if app.Categories.Anniversary then
			db = app.CreateAchievement(12827, app.Categories.Anniversary);
			db.expanded = false;
			db.text = "WoW Anniversary";
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Holidays
		if app.Categories.Holidays then
			db = app.CreateAchievement(2144, app.Categories.Holidays);
			db.expanded = false;
			db.text = GetItemSubClassInfo(15,3);
			db.npcID = -3;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Pet Battles
		if app.Categories.PetBattles then
			db = app.CreateAchievement(6559, app.Categories.PetBattles); -- Traveling Pet Mauler
			db.lvl = 5; -- Must be 5 to train
			db.expanded = false;
			db.text = SHOW_PET_BATTLES_ON_MAP_TEXT; -- Pet Battles
			db.g = app.Categories.PetBattles;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- PvP
		if app.Categories.PVP then
			db = {};
			db.expanded = false;
			db.text = STAT_CATEGORY_PVP;
			db.icon = "Interface\\Icons\\Achievement_PVP_Legion08";
			db.g = app.Categories.PVP;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Craftables
		if app.Categories.Craftables then
			db = app.CreateAchievement(5035, {});
			db.expanded = false;
			db.text = LOOT_JOURNAL_LEGENDARIES_SOURCE_CRAFTED_ITEM;
			db.icon = "Interface\\ICONS\\ability_repair";
			db.g = app.Categories.Craftables;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Professions
		if app.Categories.Professions then
			db = app.CreateAchievement(10583, {});
			db.expanded = false;
			db.text = TRADE_SKILLS;
			db.icon = "Interface\\ICONS\\INV_Scroll_04";
			db.g = app.Categories.Professions;
			db.collectible = false;
			table.insert(g, db);
		end
		
		-- Gear Sets
		if app.Categories.GearSets then
			db = app.CreateAchievement(11761, app.Categories.GearSets);
			db.expanded = false;
			db.text = LOOT_JOURNAL_ITEM_SETS;
			db.icon = "Interface\\ICONS\\Achievement_Transmog_Collections";
			table.insert(g, db);
		end
		
		-- In-Game Store
		if app.Categories.InGameShop then
			db = { };
			db.expanded = false;
			db.text = BATTLE_PET_SOURCE_10;
			db.icon = "Interface\\ICONS\\INV_Misc_Map02";
			db.g = app.Categories.InGameShop;
			table.insert(g, db);
		end
		
		-- Illusions
		if app.Categories.Illusions then
			db = {};
			db.expanded = false;
			db.text = "Illusions";
			db.group = app.Categories.Illusions;
			table.insert(g, db);
		end
		
		-- Factions
		if app.Categories.Factions then
			db = app.CreateAchievement(11177, app.Categories.Factions);
			db.expanded = false;
			db.text = "Factions";
			table.insert(g, db);
		end
		
		-- Mounts
		if app.Categories.Mounts then
			db = app.CreateAchievement(app.FactionID == 2 and 12934 or 12933, app.Categories.Mounts);
			db.expanded = false;
			db.text = MOUNTS;
			table.insert(g, db);
		end
		
		-- Pet Journal
		if app.Categories.PetJournal then
			db = app.CreateAchievement(12958, app.Categories.PetJournal);
			db.f = 101;
			db.expanded = false;
			db.text = PET_JOURNAL;
			db.icon = "Interface\\ICONS\\INV_Pet_BattlePetTraining";
			table.insert(g, db);
		end
		
		-- Titles
		if app.Categories.Titles then
			db = app.CreateAchievement(2188, app.Categories.Titles);
			db.expanded = false;
			db.text = "Titles";
			table.insert(g, db);
		end
		
		-- Toys
		if app.Categories.Toys then
			db = app.CreateAchievement(12996, app.Categories.Toys);
			db.icon = "Interface\\ICONS\\INV_Misc_Toy_10";
			db.expanded = false;
			db.text = TOY_BOX; -- Toy Box
			table.insert(g, db);
		end
		
		-- Yourself.
		table.insert(g, app.CreateUnit("player", {
			["collected"] = 1,
			["description"] = "Awarded for logging in.\n\nGood job! YOU DID IT!\n\nOnly visible while in Debug Mode.",
		}));
		
		--[[
		-- Never Implemented
		if app.Categories.NeverImplemented then
			db = {};
			db.expanded = false;
			db.g = app.Categories.NeverImplemented;
			db.text = "Never Implemented";
			table.insert(g, db);
		end
		
		-- Unsorted
		if app.Categories.Unsorted then
			db = {};
			db.g = app.Categories.Unsorted;
			db.expanded = false;
			db.text = "Unsorted";
			table.insert(g, db);
		end
		
		-- Models (Dynamic)
		db = app.CreateAchievement(9924, (function()
			local cache = GetTempDataMember("MODEL_CACHE");
			if not cache then
				cache = {};
				SetTempDataMember("MODEL_CACHE", cache);
				for i=1,78092,1 do
					tinsert(cache, {["displayID"] = i,["text"] = "Model #" .. i});
				end
			end
			return cache;
		end)());
		db.expanded = false;
		db.text = "Models (Dynamic)";
		table.insert(g, db);
		--]]
		
		-- Illusions (Dynamic)
		--[[
		db = {};
		db.g = (function()
			local cache = GetTempDataMember("ILLUSION_CACHE");
			if not cache then
				cache = {};
				SetTempDataMember("ILLUSION_CACHE", cache);
				for i=1,10000,1 do
					local visualID = select(1, C_TransmogCollection.GetIllusionSourceInfo(i));
					if visualID and visualID > 0 then
						tinsert(cache, app.CreateIllusion(i));
					end
				end
			end
			return cache;
		end)();
		db.expanded = false;
		db.text = "Illusions (Dynamic)";
		table.insert(g, db);
		--]]
		-- Items (Dynamic)
		--[[
		db = {};
		db.g = (function()
			local cache = GetTempDataMember("ITEM_CACHE");
			if not cache then
				cache = {};
				SetTempDataMember("ITEM_CACHE", cache);
				for i=166000,1,-1 do
					tinsert(cache, app.CreateItem(i));
				end
			end
			return cache;
		end)();
		db.expanded = false;
		db.text = "All Items (Dynamic)";
		table.insert(g, db);
		]]--
		
		-- Mounts (Dynamic)
		--[[
		db = app.CreateAchievement(app.FactionID == 2 and 10355 or 10356, GetTempDataMember("MOUNT_CACHE"));
		db.expanded = false;
		db.text = "Mounts (Dynamic)";
		table.insert(g, db);
		--]]
		
		--[[
		-- SUPER SECRETTTT!
		-- Artifacts (Dynamic)
		db = app.CreateAchievement(11171, (function()
			local cache = GetTempDataMember("ARTIFACT_CACHE");
			if not cache then
				cache = {};
				SetTempDataMember("ARTIFACT_CACHE", cache);
				for i=1,10000,1 do
					if C_ArtifactUI_GetAppearanceInfoByID(i) then
						tinsert(cache, app.CreateArtifact(i));
					end
				end
			end
			return cache;
		end)());
		db.expanded = false;
		db.text = "Artifacts (Dynamic)";
		table.insert(g, db);
		
		-- Titles (Dynamic)
		db = app.CreateAchievement(2188, (function()
			local cache = GetTempDataMember("TITLE_CACHE");
			if not cache then
				cache = {};
				SetTempDataMember("TITLE_CACHE", cache);
				for i=1,10000,1 do
					if GetTitleName(i) then
						tinsert(cache, app.CreateTitle(i));
					end
				end
			end
			return cache;
		end)());
		db.expanded = false;
		db.text = "Titles (Dynamic)";
		table.insert(g, db);
		
		-- Factions (Dynamic)
		db = app.CreateAchievement(11177, (function()
			local cache = GetTempDataMember("FACTION_CACHE");
			if not cache then
				cache = {};
				SetTempDataMember("FACTION_CACHE", cache);
				for i=1,5000,1 do
					tinsert(cache, app.CreateFaction(i));
				end
			end
			return cache;
		end)());
		db.expanded = false;
		db.text = "Factions (Dynamic)";
		table.insert(g, db);
		
		-- Gear Sets
		function SortGearSetInformation(a,b)
			local first = a.uiOrder - b.uiOrder;
			if first == 0 then return a.setID < b.setID; end
			return first < 0;
		end
		function SortGearSetSources(a,b)
			local first = a.invType - b.invType;
			if first == 0 then return a.invType < b.invType; end
			return first < 0;
		end
		table.insert(g, (function()
			--if true then return nil; end
			local db = GetTempDataMember("GEAR_SET_CACHE", nil);
			if not db then
				db = {};
				db.expanded = false;
				db.text = "Item Sets";
				SetTempDataMember("GEAR_SET_CACHE", db);
			end
			
			-- Rebuild the cache every time.
			cache = {};
			db.g = cache;
			--SetDataMember("GEAR_SET_CACHE", cache);
			local sets = C_TransmogSets.GetAllSets();
			if sets then
				local gearSets = {};
				for index = 1,#sets do
					local s = sets[index];
					if s then
						local sources = {};
						tinsert(gearSets, setmetatable({ ["setID"] = s.setID, ["uiOrder"] = s.uiOrder, ["g"] = sources }, app.BaseGearSet));
						for sourceID, value in pairs(C_TransmogSets.GetSetSources(s.setID)) do
							local _, appearanceID = C_TransmogCollection_GetAppearanceSourceInfo(sourceID);
							if appearanceID then
								for i, otherSourceID in ipairs(C_TransmogCollection_GetAllAppearanceSources(appearanceID)) do
									tinsert(sources, setmetatable({ s = otherSourceID }, app.BaseGearSource));
								end
							else
								tinsert(sources, setmetatable({ s = sourceID }, app.BaseGearSource));
							end
						end
						table.sort(sources, SortGearSetSources);
					end
				end
				table.sort(gearSets, SortGearSetInformation);
				
				-- Let's build some headers!
				local headers = {};
				local header, subheader, lastHeader, lastSubHeader, lastHeaderText, lastSubHeaderText;
				for i, gearSet in ipairs(gearSets) do
					header = gearSet.header;
					if header then
						if header ~= lastHeaderText then
							if headers[header] then
								lastHeader = headers[header];
							else
								lastHeader = setmetatable({ ["setHeaderID"] = gearSet.setID, ["subheaders"] = {}, ["g"] = {} }, app.BaseGearSetHeader);
								tinsert(cache, lastHeader);
								lastHeader = lastHeader;
								headers[header] = lastHeader;
							end
							lastHeaderText = header;
							lastSubHeaderText = nil;
						end
					else
						lastHeader = cache;
						lastHeaderText = header;
					end
					subheader = gearSet.subheader;
					if subheader then
						if subheader ~= lastSubHeaderText then
							if lastHeader and lastHeader.subheaders then
								if lastHeader.subheaders[subheader] then
									lastSubHeader = lastHeader.subheaders[subheader];
								else
									lastSubHeader = setmetatable({ ["setSubHeaderID"] = gearSet.setID, ["g"] = { } }, app.BaseGearSetSubHeader);
									tinsert(lastHeader and lastHeader.g or lastHeader, lastSubHeader);
									lastSubHeader = lastSubHeader;
									lastHeader.subheaders[subheader] = lastSubHeader;
								end
							else
								lastSubHeader = setmetatable({ ["setSubHeaderID"] = gearSet.setID, ["g"] = { } }, app.BaseGearSetSubHeader);
								tinsert(lastHeader and lastHeader.g or lastHeader, lastSubHeader);
								lastSubHeader = lastSubHeader;
							end
							lastSubHeaderText = subheader;
						end
					else
						lastSubHeader = lastHeader;
						lastSubHeaderText = subheader;
					end
					gearSet.uiOrder = nil;
					tinsert(lastSubHeader and lastSubHeader.g or lastSubHeader, gearSet);
				end
			end
			return db;
		end)());
		--]]
		
		-- Raw Source Data (Oh god)
		--[[
		db = {};
		db.expanded = false;
		db.g = (function()
			local cache = GetTempDataMember("RAW_DATA_CACHE");
			if not cache then
				cache = {};
				SetTempDataMember("RAW_DATA_CACHE", cache);
				local sCache = fieldCache["s"];
				for s=1,100000 do
					if not sCache[s] then
						local t = app.CreateGearSource(s);
						if t.info then
							tinsert(cache, t);
						end
					end
				end
			end
			return cache;
		end)();
		db.text = "Raw Source Data (Dynamic)";
		table.insert(g, db);
		--]]
		--[[
		-- SUPER DUPER SECRET
		if app.Categories.NaughtySecrets then
			db = app.CreateAchievement(12478, app.Categories.NaughtySecrets);
			db.expanded = false;
			db.text = "Naughty Secrets";
			table.insert(g, db);
		end
		--]]
		
		-- The Main Window's Data
		app.refreshDataForce = true;
		BuildGroups(allData, allData.g);
		app:GetWindow("Prime").data = allData;
		CacheFields(allData);
		
		-- Now build the hidden "Unsorted" Window's Data
		allData = {};
		allData.expanded = true;
		allData.icon = "Interface\\Addons\\AllTheThings\\assets\\content_20190216_1";
		allData.texcoord = {429 / 512, (429 + 36) / 512, 141 / 256, (141 + 36) / 256};
		allData.previewtexcoord = {1 / 512, (1 + 72) / 512, 75 / 256, (75 + 72) / 256};
		allData.font = "GameFontNormalLarge";
		allData.text = L["TITLE"];
		allData.title = "Unsorted";
		allData.description = "This data hasn't been implemented yet.";
		allData.visible = true;
		allData.progress = 0;
		allData.total = 0;
		local g, db = {};
		allData.g = g;
		table.insert(app.RawData, allData);
		
		-- Never Implemented
		if app.Categories.NeverImplemented then
			db = {};
			db.expanded = false;
			db.g = app.Categories.NeverImplemented;
			db.text = "Never Implemented";
			table.insert(g, db);
		end
		
		-- Unsorted
		if app.Categories.Unsorted then
			db = {};
			db.g = app.Categories.Unsorted;
			db.expanded = false;
			db.text = "Unsorted";
			table.insert(g, db);
		end
		BuildGroups(allData, allData.g);
		app:GetWindow("Unsorted").data = allData;
		CacheFields(allData);
		
		-- Uncomment this section if you need to Harvest Display IDs:
		--[[
		local displayData = {};
		displayData.visible = true;
		displayData.expanded = true;
		displayData.progress = 0;
		displayData.total = 0;
		displayData.icon = "Interface\\Icons\\Spell_Warlock_HarvestofLife";
		displayData.text = "Harvesting All Display IDs";
		displayData.description = "If you're seeing this window outside of Git, please yell loudly in Crieve's ear.";
		displayData.g = {};
		for model,groups in pairs(fieldCache["model"]) do
			tinsert(displayData.g, {visible = true, model = model, text = model});
		end
		for i=1,78092,1 do
			tinsert(displayData.g, {["displayID"] = i,["text"] = "Model #" .. i});
		end
		displayData.rows = displayData.g;
		BuildGroups(displayData, displayData.g);
		UpdateGroups(displayData, displayData.g);
		
		-- Assign the missing data table to the harvester.
		local popout = app:GetWindow("DisplayIDs");
		popout.data = displayData;
		popout.ScrollBar:SetValue(1);
		popout:SetVisible(true);
		popout.fileIDs = {};
		popout.UpdateDone = function(self)
			print("UpdateDone");
			local progress = 0;
			local total = 0;
			local tries = 0;
			for i,group in ipairs(displayData.g) do
				total = total + 1;
				if not group.fileID then
					if tries < 10 and (not group.tries or group.tries < 5) then
						tries = tries + 1;
						group.tries = (group.tries or 0) + 1;
						if GameTooltipModel:TrySetModel(group) then
							group.fileID = GameTooltipModel.Model:GetModelFileID();
						end
					end
				end
				
				if group.fileID then
					if group.displayID then
						popout.fileIDs[group.fileID] = group.displayID;
					elseif popout.fileIDs[group.fileID] then
						group.displayID = popout.fileIDs[group.fileID];
					end
				end
				
				if not group.displayID or not group.fileID then
					group.visible = true;
					group.saved = false;
					group.trackable = true;
				else
					group.saved = true;
					group.trackable = true;
					if group.model then
						group.visible = true;
					else
						group.visible = false;
					end
					progress = progress + 1;
				end
			end
			if self.rowData then
				local count = #self.rowData;
				if count > 1 then
					self.rowData[1].progress = progress;
					self.rowData[1].total = total;
				end
				self.processingLinks = false;
			end
			UpdateVisibleRowData(self);
		end
		]]--
		
		-- Uncomment this section if you need to Harvest Source IDs:
		--[[--
		local harvestData = {};
		harvestData.visible = true;
		harvestData.expanded = true;
		harvestData.progress = 0;
		harvestData.total = 0;
		harvestData.icon = "Interface\\Icons\\Spell_Warlock_HarvestofLife";
		harvestData.text = "Harvesting All Items";
		harvestData.description = "If you're seeing this window outside of Git, please yell loudly in Crieve's ear.";
		harvestData.g = {};
		
		local mID = 1;
		local modIDs = {};
		local bonusIDs = {};
		app.MaximumItemInfoRetries = 40;
		for itemID,groups in pairs(fieldCache["itemID"]) do
			for i,group in ipairs(groups) do
				if (not group.s or group.s == 0) then	--  and (not group.f or group.filterID == 109 or group.f < 50)
					if group.bonusID and not bonusIDs[group.bonusID] then
						bonusIDs[group.bonusID] = true;
						tinsert(harvestData.g, setmetatable({visible = true, s = 0, itemID = tonumber(itemID), bonusID = group.bonusID}, app.BaseItem));
					else
						mID = group.modID or 1;
						if not modIDs[mID] then
							modIDs[mID] = true;
							tinsert(harvestData.g, setmetatable({visible = true, s = 0, itemID = tonumber(itemID), modID = mID}, app.BaseItem));
						end
					end
				end
			end
			wipe(modIDs);
			wipe(bonusIDs);
		end
		harvestData.rows = harvestData.g;
		BuildGroups(harvestData, harvestData.g);
		UpdateGroups(harvestData, harvestData.g);
		
		-- Assign the missing data table to the harvester.
		local popout = app:GetWindow("Harvester");
		popout.data = harvestData;
		popout.ScrollBar:SetValue(1);
		popout:SetVisible(true);
		popout.UpdateDone = function(self)
			local progress = 0;
			local total = 0;
			for i,group in ipairs(harvestData.g) do
				total = total + 1;
				if group.s and group.s == 0 then
					group.visible = true;
				else
					group.visible = false;
					progress = progress + 1;
				end
			end
			if self.rowData then
				local count = #self.rowData;
				if count > 1 then
					self.rowData[1].progress = progress;
					self.rowData[1].total = total;
					for i=count,1,-1 do
						if self.rowData[i] and not self.rowData[i].visible then
							table.remove(self.rowData, i);
						end
					end
				end
			end
			UpdateVisibleRowData(self);
		end
		--]]--
	end
	return allData;
end
function app:RefreshData(lazy, got, manual)
	--print("RefreshData(" .. tostring(lazy or false) .. ", " .. tostring(got or false) .. ")");
	app.refreshDataForce = app.refreshDataForce or not lazy;
	app.countdown = manual and 0 or 30;
	StartCoroutine("RefreshData", function()
		-- While the player is in combat, wait for combat to end.
		while InCombatLockdown() do coroutine.yield(); end
		
		-- Wait 1/2 second. For multiple simultaneous requests, each one will reapply the delay. [This should fix a lot of lag with ensembles.]
		while app.countdown > 0 do
			app.countdown = app.countdown - 1;
			coroutine.yield();
		end
		
		-- Send an Update to the Windows to Rebuild their Row Data
		if app.refreshDataForce then
			app.refreshDataForce = nil;
			app:GetDataCache();
			for i,data in ipairs(app.RawData) do
				data.progress = 0;
				data.total = 0;
				UpdateGroups(data, data.g);
			end
			
			-- Forcibly update the windows.
			app:UpdateWindows(true, got);
		else
			app:UpdateWindows(nil, got);
		end
		wipe(searchCache);
		collectgarbage();
	end);
end
function app:GetWindow(suffix, parent, onUpdate)
	local window = app.Windows[suffix];
	if not window then
		-- Create the window instance.
		window = CreateFrame("FRAME", app:GetName() .. "-Window-" .. suffix, parent or UIParent);
		app.Windows[suffix] = window;
		window.Suffix = suffix;
		window.Toggle = ToggleWindow;
		window.Update = onUpdate or UpdateWindow;
		window.SetVisible = SetWindowVisibility;
		window:SetScript("OnMouseWheel", OnScrollBarMouseWheel);
		window:SetScript("OnMouseDown", StartMovingOrSizing);
		window:SetScript("OnMouseUp", StopMovingOrSizing);
		window:SetScript("OnHide", StopMovingOrSizing);
		window:SetBackdrop(backdrop);
		UpdateWindowColor(window, suffix);
		window:SetClampedToScreen(true);
		window:SetToplevel(true);
		window:EnableMouse(true);
		window:SetMovable(true);
		window:SetResizable(true);
		window:SetPoint("CENTER");
		window:SetMinResize(32, 32);
		window:SetSize(300, 300);
		window:SetUserPlaced(true);
		window.data = {
			['text'] = suffix,
			['icon'] = "Interface\\Icons\\Ability_Spy.blp", 
			['visible'] = true, 
			['expanded'] = true,
			['g'] = {
				{
					['text'] = "No data linked to listing.", 
					['visible'] = true
				}
			}
		};
		window:Hide();
		window.AddObject = function(self, info)
			-- Bubble Up the Maps
			local mapInfo;
			local mapID = app.GetCurrentMapID();
			if mapID then
				local pos = C_Map.GetPlayerMapPosition(mapID, "player");
				if pos then
					local px, py = pos:GetXY();
					info.coord = { px * 100, py * 100 };
				end
				repeat
					mapInfo = C_Map.GetMapInfo(mapID);
					if mapInfo then
						info = { ["mapID"] = mapInfo.mapID, ["g"] = { info } };
						mapID = mapInfo.parentMapID
					end
				until not mapInfo or not mapID;
			end
			
			MergeObject(self.data.g, CreateObject(info));
			MergeObject(self.rawData, info);
			self:Update();
		end
		window.Clear = function(self)
			if self.rawData then
				wipe(self.rawData);
			else
				self.rawData = {};
			end
			app.SetDataMember(self.Suffix, self.rawData);
			wipe(self.data.g);
			self:Update();
		end
		
		-- The Close Button. It's assigned as a local variable so you can change how it behaves.
		window.CloseButton = CreateFrame("Button", nil, window, "UIPanelCloseButton");
		window.CloseButton:SetPoint("TOPRIGHT", window, "TOPRIGHT", 4, 3);
		window.CloseButton:SetScript("OnClick", HideParent);
		
		-- The Scroll Bar.
		local scrollbar = CreateFrame("Slider", nil, window, "UIPanelScrollBarTemplate");
		scrollbar:SetPoint("TOP", window.CloseButton, "BOTTOM", 0, -10);
		scrollbar:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT", -4, 36);
		scrollbar:SetScript("OnValueChanged", OnScrollBarValueChanged);
		scrollbar.back = scrollbar:CreateTexture(nil, "BACKGROUND");
		scrollbar.back:SetColorTexture(0,0,0,0.4)
		scrollbar.back:SetAllPoints(scrollbar);
		scrollbar:SetMinMaxValues(1, 1);
		scrollbar:SetValueStep(1);
		scrollbar.CurrentValue = 1;
		scrollbar:SetWidth(16);
		scrollbar:EnableMouseWheel(true);
		window:EnableMouseWheel(true);
		window.ScrollBar = scrollbar;
		
		-- The Corner Grip. (this isn't actually used, but it helps indicate to players that they can do something)
		local grip = window:CreateTexture(nil, "ARTWORK");
		grip:SetTexture("Interface\\AddOns\\AllTheThings\\assets\\grip");
		grip:SetSize(16, 16);
		grip:SetTexCoord(0,1,0,1);
		grip:SetPoint("BOTTOMRIGHT", -5, 5);
		
		-- The Row Container. This contains all of the row frames.
		local container = CreateFrame("FRAME", nil, window);
		container:SetPoint("TOPLEFT", window, "TOPLEFT", 0, -6);
		container:SetPoint("RIGHT", scrollbar, "LEFT", 0, 0);
		container:SetPoint("BOTTOM", window, "BOTTOM", 0, 6);
		window.Container = container;
		container.rows = {};
		scrollbar:SetValue(1);
		container:Show();
		window:Update(true);
	end
	return window;
end

-- Create the Primary Collection Window (this allows you to save the size and location)
app:GetWindow("Prime"):SetSize(425, 305);
app:GetWindow("Unsorted");
(function()
	app:GetWindow("CosmicInfuser", UIParent, function(self)
		if not self.initialized then
			self.initialized = true;
			self.data = {
				['text'] = "Cosmic Infuser",
				['icon'] = "Interface\\Icons\\INV_Misc_Celestial Map.blp", 
				["description"] = "This window helps debug when we're missing map IDs in the addon.",
				['visible'] = true, 
				['expanded'] = true,
				['OnUpdate'] = function(data) 
					data.visible = true;
				end,
				['g'] = {
					{
						['text'] = "Check for missing maps now!",
						['icon'] = "Interface\\Icons\\INV_Misc_Map_01",
						['description'] = "This function will check for missing mapIDs in ATT.",
						['OnClick'] = function(data, button)
							Push(self, "Rebuild", self.Rebuild);
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
				},
			};
			self.Rebuild = function(self)
				-- Rebuild all the datas
				local temp = self.data.g[1];
				wipe(self.data.g);
				tinsert(self.data.g, temp);
				
				-- Go through all of the possible maps
				for mapID=1,3000,1 do
					local mapInfo = C_Map.GetMapInfo(mapID);
					if mapInfo then
						local results = SearchForField("mapID", mapID);
						local mapObject = { ["mapID"] = mapID, ["collectible"] = true };
						if results and #results > 0 then
							mapObject.collected = true;
						else	
							mapObject.collected = false;
						end
						
						-- Recurse up the map chain and build the full hierarchy
						local parentMapID = mapInfo.parentMapID;
						while parentMapID do
							mapInfo = C_Map.GetMapInfo(parentMapID);
							if mapInfo then
								mapObject = { ["mapID"] = parentMapID, ["collectible"] = true, ["g"] = { mapObject } };
								parentMapID = mapInfo.parentMapID;
							else
								break;
							end
						end
						
						-- Merge it into the listing.
						MergeObject(self.data.g, CreateObject(mapObject));
					end
				end
				
				self:Update();
			end
		end
		
		-- Update the window and all of its row data
		self.data.progress = 0;
		self.data.total = 0;
		self.data.indent = 0;
		self.data.back = 1;
		BuildGroups(self.data, self.data.g);
		UpdateGroups(self.data, self.data.g);
		UpdateWindow(self, true);
	end);
end)();
--[[--
-- Uncomment this section if you need to enable Debugger:
app:GetWindow("Debugger", UIParent, function(self)
	if not self.initialized then
		self.initialized = true;
		self.data = {
			['text'] = "Session History",
			['icon'] = "Interface\\Icons\\Achievement_Dungeon_GloryoftheRaider.blp", 
			["description"] = "This keeps a visual record of all of the quests, maps, loot, and vendors that you have come into contact with since the session was started.",
			['visible'] = true, 
			['expanded'] = true,
			['back'] = 1,
			['options'] = {
				{
					['text'] = "Clear History",
					['icon'] = "Interface\\Icons\\Ability_Rogue_FeignDeath.blp", 
					["description"] = "Click this to fully clear this window.\n\nNOTE: If you click this by accident, use the dynamic Restore Buttons that this generates to reapply the data that was cleared.\n\nWARNING: If you reload the UI, the data stored in the Reload Button will be lost forever!",
					['visible'] = true,
					['count'] = 0,
					['OnClick'] = function(row, button)
						local copy = {};
						for i,o in ipairs(self.rawData) do
							tinsert(copy, o);
						end
						if #copy < 1 then
							app.print("There is nothing to clear.");
							return true;
						end
						row.ref.count = row.ref.count + 1;
						tinsert(self.data.options, {
							['text'] = "Restore Button " .. row.ref.count,
							['icon'] = "Interface\\Icons\\ability_monk_roll.blp", 
							["description"] = "Click this to restore your cleared data.\n\nNOTE: Each Restore Button houses different data.\n\nWARNING: This data will be lost forever when you reload your UI!",
							['visible'] = true,
							['data'] = copy,
							['OnClick'] = function(row, button)
								for i,info in ipairs(row.ref.data) do
									MergeObject(self.data.g, CreateObject(info));
									MergeObject(self.rawData, info);
								end
								self:Update();
								return true;
							end,
						});
						wipe(self.rawData);
						wipe(self.data.g);
						for i=#self.data.options,1,-1 do
							tinsert(self.data.g, 1, self.data.options[i]);
						end
						self:Update();
						return true;
					end,
				},
			},
			['g'] = {},
		};
		self.rawData = {};
		
		-- Setup Event Handlers and register for events
		self:SetScript("OnEvent", function(self, e, ...)
			print(e, ...);
			if e == "PLAYER_LOGIN" then
				if not AllTheThingsDebugData then
					AllTheThingsDebugData = app.GetDataMember("Debugger", {});
					app.SetDataMember("Debugger", nil);
				end
				self.rawData = AllTheThingsDebugData;
				self.data.g = CreateObject(self.rawData);
				for i=#self.data.options,1,-1 do
					tinsert(self.data.g, 1, self.data.options[i]);
				end
				self:Update();
			elseif e == "ZONE_CHANGED_NEW_AREA" or e == "NEW_WMO_CHUNK" then
				-- Bubble Up the Maps
				local mapInfo, info;
				local mapID = app.GetCurrentMapID();
				if mapID then
					repeat
						mapInfo = C_Map.GetMapInfo(mapID);
						if mapInfo then
							info = { ["mapID"] = mapInfo.mapID, ["g"] = { info } };
							mapID = mapInfo.parentMapID
						end
					until not mapInfo or not mapID;
					
					MergeObject(self.data.g, CreateObject(info));
					MergeObject(self.rawData, info);
					self:Update();
				end
			elseif e == "MERCHANT_SHOW" or e == "MERCHANT_UPDATE" then
				MerchantFrame_SetFilter(MerchantFrame, 1);
				C_Timer.After(0.6, function()
					local guid = UnitGUID("npc");
					local ty, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid;
					if guid then ty, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid); end
					if npc_id then
						npc_id = tonumber(npc_id);
						
						-- Ignore vendor mount...
						if npc_id == 62822 then
							return true;
						end
						
						local numItems = GetMerchantNumItems();
						print("MERCHANT DETAILS", ty, npc_id, numItems);
						
						local rawGroups = {};
						for i=1,numItems,1 do
							local link = GetMerchantItemLink(i);
							if link then
								local parent = rawGroups;
								local name, texture, cost, quantity, numAvailable, isPurchasable, isUsable, extendedCost = GetMerchantItemInfo(i);
								-- print(link, cost, extendedCost);
								if extendedCost then
									local itemCount = GetMerchantItemCostInfo(i);
									for j=1,itemCount,1 do
										local itemTexture, itemValue, itemLink = GetMerchantItemCostItem(i, j);
										if itemLink then
											-- print("  ", itemValue, itemLink, gsub(itemLink, "\124", "\124\124"));
											local m = itemLink:match("currency:(%d+)");
											if m then
												-- Parse as a CURRENCY LINK.
												parent = MergeObject(parent, {["currencyID"] = tonumber(m), ["g"] = {}}).g;
												cost = itemValue;
											else
												-- Parse as an ITEM LINK.
												m = itemLink:match("item:(%d+)");
												if m then
													cost = itemValue;
													parent = MergeObject(parent, {["itemID"] = tonumber(m), ["g"] = {}}).g;
												end
											end
										end
									end
								end
								
								-- Parse as an ITEM LINK.
								m = link:match("item:(%d+)");
								if m then
									m = tonumber(m);
									local found = false;
									local searchResults = SearchForField("itemID", m);
									if searchResults and #searchResults > 0 then
										for j,k in ipairs(searchResults) do
											if k.parent and (k.parent.creatureID == npc_id or (k.parent.parent and k.parent.parent.creatureID == npc_id)) then
												found = true;
											end
										end
									end
									if not found then
										table.insert(parent, {["itemID"] = m, ["cost"] = cost});
									end
								end
								--[===[
								local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice = GetItemInfo(link);
								print(" ", itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture, itemSellPrice);
								]===]--
							end
						end
						
						local info = { [(ty == "GameObject") and "objectID" or "npcID"] = npc_id };
						info.faction = UnitFactionGroup("npc");
						info.text = UnitName("npc");
						info.g = rawGroups;
						self:AddObject(info);
					end
				end);
			elseif e == "TRADE_SKILL_LIST_UPDATE" then
				local tradeSkillID = AllTheThings.GetTradeSkillLine();
				local currentCategoryGroup, currentCategoryID, categories = {}, -1, {};
				local categoryList, rawGroups = {}, {};
				local categoryIDs = { C_TradeSkillUI.GetCategories() };
				for i = 1,#categoryIDs do
					currentCategoryID = categoryIDs[i];
					local categoryData = C_TradeSkillUI.GetCategoryInfo(currentCategoryID);
					if categoryData then
						if not categories[currentCategoryID] then
							local category = { 
								["parentCategoryID"] = categoryData.parentCategoryID,
								["categoryID"] = currentCategoryID,
								["name"] = categoryData.name,
								["g"] = {}
							};
							categories[currentCategoryID] = category;
							table.insert(categoryList, category);
						end
					end
				end
				
				local recipeIDs = C_TradeSkillUI.GetAllRecipeIDs();
				for i = 1,#recipeIDs do
					local spellRecipeInfo = {};
					if C_TradeSkillUI.GetRecipeInfo(recipeIDs[i], spellRecipeInfo) then
						currentCategoryID = spellRecipeInfo.categoryID;
						if not categories[currentCategoryID] then
							local categoryData = C_TradeSkillUI.GetCategoryInfo(currentCategoryID);
							if categoryData then
								local category = { 
									["parentCategoryID"] = categoryData.parentCategoryID,
									["categoryID"] = currentCategoryID,
									["name"] = categoryData.name, 
									["g"] = {}
								};
								categories[currentCategoryID] = category;
								table.insert(categoryList, category);
							end
						end
						local recipe = {
							["recipeID"] = spellRecipeInfo.recipeID,
							["requireSkill"] = tradeSkillID,
							["name"] = spellRecipeInfo.name,
						};
						if spellRecipeInfo.previousRecipeID then
							recipe.previousRecipeID = spellRecipeInfo.previousRecipeID;
						end
						if spellRecipeInfo.nextRecipeID then
							recipe.nextRecipeID = spellRecipeInfo.nextRecipeID;
						end
						table.insert(categories[currentCategoryID].g, recipe);
					end
				end
				
				-- Make each category parent have children. (not as gross as that sounds)
				for i=#categoryList,1,-1 do
					local category = categoryList[i];
					if category.parentCategoryID then
						local parentCategory = categories[category.parentCategoryID];
						category.parentCategoryID = nil;
						if parentCategory then
							table.insert(parentCategory.g, 1, category); 
							table.remove(categoryList, i);
						end
					end
				end
				
				-- Now merge the categories into the raw groups table.
				for i,category in ipairs(categoryList) do
					table.insert(rawGroups, category);
				end
				local info = { 
					["professionID"] = tradeSkillID, 
					["icon"] = C_TradeSkillUI.GetTradeSkillTexture(tradeSkillID),
					["name"] = C_TradeSkillUI.GetTradeSkillDisplayName(tradeSkillID),
					["g"] = rawGroups
				};
				MergeObject(self.data.g, CreateObject(info));
				MergeObject(self.rawData, info);
				self:Update();
			elseif e == "QUEST_DETAIL" then
				local questStartItemID = ...;
				local questID = GetQuestID();
				if questID == 0 then return false; end
				local npc = "questnpc";
				local guid = UnitGUID(npc);
				if not guid then
					npc = "npc";
					guid = UnitGUID(npc);
				end
				local type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid;
				if guid then type, zero, server_id, instance_id, zone_uid, npc_id, spawn_uid = strsplit("-",guid); end
				print("QUEST_DETAIL", questStartItemID, " => Quest #", questID, type, npc_id);
				
				local rawGroups = {};
				for i=1,GetNumQuestRewards(),1 do
					local link = GetQuestItemLink("reward", i);
					if link then table.insert(rawGroups, { ["itemID"] = GetItemInfoInstant(link) }); end
				end
				for i=1,GetNumQuestChoices(),1 do
					local link = GetQuestItemLink("choice", i);
					if link then table.insert(rawGroups, { ["itemID"] = GetItemInfoInstant(link) }); end
				end
				for i=1,GetNumQuestLogRewardSpells(questID),1 do
					local texture, name, isTradeskillSpell, isSpellLearned, hideSpellLearnText, isBoostSpell, garrFollowerID, genericUnlock, spellID = GetQuestLogRewardSpell(i, questID);
					if garrFollowerID then
						table.insert(rawGroups, { ["followerID"] = garrFollowerID, ["name"] = name });
					elseif spellID then
						if isTradeskillSpell then
							table.insert(rawGroups, { ["recipeID"] = spellID, ["name"] = name });
						else
							table.insert(rawGroups, { ["spellID"] = spellID, ["name"] = name });
						end
					end
				end
				
				local info = { ["questID"] = questID, ["g"] = rawGroups };
				if questStartItemID and questStartItemID > 0 then info.itemID = questStartItemID; end
				if npc_id then
					npc_id = tonumber(npc_id);
					if type == "GameObject" then
						info = { ["objectID"] = npc_id, ["text"] = UnitName(npc), ["g"] = { info } };
					else
						info.qgs = {npc_id};
						info.name = UnitName(npc);
					end
					info.faction = UnitFactionGroup(npc);
				end
				self:AddObject(info);
			elseif e == "CHAT_MSG_LOOT" then
				local msg, player, a, b, c, d, e, f, g, h, i, j, k, l = ...;
				local itemString = string.match(msg, "item[%-?%d:]+");
				if itemString then
					local rawGroups = {};
					local itemID = GetItemInfoInstant(itemString);
					table.insert(rawGroups, { ["itemID"] = itemID, ["s"] = app.GetSourceID(itemString, itemID) });
					self:AddObject({ ["unit"] = j, ["g"] = rawGroups });
				end
			end
		end);
		self:RegisterEvent("PLAYER_LOGIN");
		self:RegisterEvent("QUEST_DETAIL");
		self:RegisterEvent("QUEST_LOOT_RECEIVED");
		self:RegisterEvent("TRADE_SKILL_LIST_UPDATE");
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		self:RegisterEvent("NEW_WMO_CHUNK");
		self:RegisterEvent("MERCHANT_SHOW");
		self:RegisterEvent("MERCHANT_UPDATE");
		self:RegisterEvent("CHAT_MSG_LOOT");
		--self:RegisterAllEvents();
	end
	
	-- Update the window and all of its row data
	if self.data.OnUpdate then self.data.OnUpdate(self.data); end
	for i,g in ipairs(self.data.g) do
		if g.OnUpdate then g.OnUpdate(g); end
	end
	self.data.index = 0;
	self.data.back = 1;
	self.data.indent = 0;
	BuildGroups(self.data, self.data.g);
	UpdateWindow(self, true);
end):Show();
--]]--
(function()
	local IsSameMap = function(data, results)
		if data.mapID then
			-- Exact same map?
			if data.mapID == results.mapID then
				return true;
			end
			
			-- Does the result map have an array of associated maps and this map is in there?
			if results.maps and contains(results.maps, data.mapID) then
				return true;
			end
		end
		if data.maps then
			-- Does the old map data contain this map?
			if contains(data.maps, results.mapID) then
				return true;
			end
			
			-- Does the result map have an array of associated maps and this map is in there?
			if results.maps and containsAny(results.maps, data.maps) then
				return true;
			end
		end
	end
	app:GetWindow("CurrentInstance", UIParent, function(self, force, got)
		if not self.initialized then
			self.initialized = true;
			self.openedOnLogin = false;
			self.data = app.CreateMap(946, {
				['text'] = "Mini List",
				['icon'] = "Interface\\Icons\\INV_Misc_Map06.blp", 
				["description"] = "This list contains the relevant information for your current zone.",
				['visible'] = true, 
				['expanded'] = true,
				['g'] = {
					{
						['text'] = "Update Location Now",
						['icon'] = "Interface\\Icons\\INV_Misc_Map_01",
						['description'] = "If you wish to forcibly refresh the data without changing zones, click this button now!",
						['visible'] = true,
						['OnClick'] = function(row, button)
							Push(self, "Rebuild", self.Rebuild);
							return true;
						end,
					},
				},
			});
			table.insert(app.RawData, self.data);
			self.rawData = {};
			self.Rebuild = function(self)
				local results = SearchForField("mapID", self.mapID);
				if results then
					-- Simplify the returned groups
					local groups, holiday = {}, {};
					local header = app.CreateMap(self.mapID, { g = groups });
					for i, group in ipairs(results) do
						local clone = {};
						for key,value in pairs(group) do
							if key == "maps" then
								local maps = {};
								for i,mapID in ipairs(value) do
									tinsert(maps, mapID);
								end
								clone[key] = maps;
							elseif key == "g" then
								local g = {};
								for i,o in ipairs(value) do
									o = CloneData(o);
									ExpandGroupsRecursively(o, false);
									tinsert(g, o);
								end
								clone[key] = g;
							else
								clone[key] = value;
							end
						end
						setmetatable(clone, getmetatable(group));
						group = clone;
						
						-- If this is relative to a holiday, let's do something special
						if GetRelativeField(group, "npcID", -3) then
							if group.achievementID then
								if group.criteriaID then
									if group.parent.achievementID then
										group = app.CreateAchievement(group.parent.achievementID, 
											{ g = { group }, total = group.total, progress = group.progress, 
												u = group.parent.u, races = group.parent.races, r = group.r, c = group.parent.c, nmc = group.parent.nmc, nmr = group.parent.nmr });
									else
										group = app.CreateAchievement(group.achievementID,
											{ g = { group }, total = group.total, progress = group.progress,
												u = group.u, races = group.races, r = group.r, c = group.c, nmc = group.nmc, nmr = group.nmr });
									end
								end
							elseif group.criteriaID and group.parent.achievementID then
								group = app.CreateAchievement(group.parent.achievementID, { g = { group }, total = group.total, progress = group.progress, 
									u = group.parent.u, races = group.parent.races, r = group.r, c = group.parent.c, nmc = group.parent.nmc, nmr = group.parent.nmr });
							end
							
							local holidayID = GetRelativeValue(group, "holidayID");
							local u = group.u or GetRelativeValue(group, "u");
							if group.key == "npcID" then
								if GetRelativeField(group, "npcID", -4) then	-- It's an Achievement. (non-Holiday)
									if group.npcID ~= -4 then group = app.CreateNPC(-4, { g = { group }, u = u }); end
								elseif GetRelativeField(group, "npcID", -2) or GetRelativeField(group, "npcID", -173) then	-- It's a Vendor. (or a timewaking vendor)
									if group.npcID ~= -2 then group = app.CreateNPC(-2, { g = { group }, u = u }); end
								elseif GetRelativeField(group, "npcID", -17) then	-- It's a Quest.
									if group.npcID ~= -17 then group = app.CreateNPC(-17, { g = { group }, u = u }); end
								end
							elseif group.key == "questID" then
								if group.npcID ~= -17 then group = app.CreateNPC(-17, { g = { group }, u = u }); end
							end
							if holidayID then group = app.CreateHoliday(holidayID, { g = { group }, u = u }); end
							MergeObject(holiday, group);
						elseif group.key == "instanceID" or group.key == "mapID" or group.key == "classID" then
							header.key = group.key;
							header[group.key] = group[group.key];
							MergeObject({header}, group);
						elseif group.key == "npcID" then
							if GetRelativeField(group, "npcID", -4) then	-- It's an Achievement. (non-Holiday)
								MergeObject(groups, app.CreateNPC(-4, { g = { group } }), 1);
							elseif GetRelativeField(group, "npcID", -2) or GetRelativeField(group, "npcID", -173) then	-- It's a Vendor. (or a timewaking vendor)
								MergeObject(groups, app.CreateNPC(-2, { g = { group } }), 1);
							elseif GetRelativeField(group, "npcID", -17) then	-- It's a Quest.
								MergeObject(groups, app.CreateNPC(-17, { g = { group } }), 1);
							else
								MergeObject(groups, group);
							end
						elseif group.key == "questID" then
							MergeObject(groups, app.CreateNPC(-17, { g = { group } }), 1);
						else
							MergeObject(groups, group);
						end
					end
					
					if #holiday > 0 then
						-- Search for Holiday entries that are not within a holidayID and attempt to find the appropriate group for them.
						local holidays, unlinked = {}, {};
						for i=#holiday,1,-1 do
							local group = holiday[i];
							if group.holidayID then
								if group.u then holidays[group.u] = group; end
							elseif group.u then
								local temp = unlinked[group.u];
								if not temp then
									temp = {};
									unlinked[group.u] = temp;
								end
								table.insert(temp, group);
								table.remove(holiday, i);
							end
						end
						for u,temp in pairs(unlinked) do
							local h = holidays[u];
							if h then
								for i,data in ipairs(temp) do
									MergeObject(h.g, data);
								end
							else
								-- Attempt to scan for the main holiday header.
								local done = false;
								for j,o in ipairs(SearchForField("npcID", -3)) do
									if o.g and #o.g > 5 and o.g[1].holidayID then
										for k,group in ipairs(o.g) do
											if group.holidayID and group.u == u then
												MergeObject(holiday, app.CreateHoliday(group.holidayID, { g = temp, u = u }));
												done = true;
											end
										end
										break;
									end
								end
								if not done then
									for i,data in ipairs(temp) do
										MergeObject(holiday, data);
									end
								end
							end
						end
						
						tinsert(groups, 1, app.CreateNPC(-3, { g = holiday, description = "A specific holiday may need to be active for you to complete the referenced Things within this section." }));
					end
					
					-- Swap out the map data for the header.
					results = header;
					
					if IsSameMap(self.data, results) then
						ReapplyExpand(self.data.g, results.g);
					else
						ExpandGroupsRecursively(results, true);
					end
					
					for key,value in pairs(self.data) do
						self.data[key] = nil;
					end
					for key,value in pairs(results) do
						self.data[key] = value;
					end
					
					self.data.u = nil;
					self.data.mapID = self.mapID;
					setmetatable(self.data,
						self.data.instanceID and app.BaseInstance
						or self.data.classID and app.BaseCharacterClass
						or app.BaseMap);
					
					-- If we have determined that we want to expand this section, then do it
					if results.g then
						local bottom = {};
						local top = {};
						for i=#results.g,1,-1 do
							local o = results.g[i];
							if o.difficultyID then
								table.remove(results.g, i);
								table.insert(bottom, 1, o);
							elseif o.isRaid then
								table.remove(results.g, i);
								table.insert(top, o);
							end
						end
						for i,o in ipairs(top) do
							table.insert(results.g, 1, o);
						end
						for i,o in ipairs(bottom) do
							table.insert(results.g, o);
						end
						
						-- if enabled minimize rows based on difficulty 
						if app.Settings:GetTooltipSetting("Expand:Difficulty") then
							local difficultyID = select(3, GetInstanceInfo());
							if difficultyID and difficultyID > 0 and results.g then
								for _, row in ipairs(results.g) do
									if row.difficultyID or row.difficulties then
										if row.difficultyID == difficultyID or (row.difficulties and containsValue(row.difficulties, difficultyID)) then
											if not row.expanded then ExpandGroupsRecursively(row, true); end
										elseif row.expanded then 
											ExpandGroupsRecursively(row, false);
										end
									end
								end
							end
						end
						if app.Settings:GetTooltipSetting("Warn:Difficulty") then
							local difficultyID = select(3, GetInstanceInfo());
							if difficultyID and difficultyID > 0 and results.g then
								local completed,other = true, nil;
								for _, row in ipairs(results.g) do
									if row.difficultyID or row.difficulties then
										if row.difficultyID == difficultyID or (row.difficulties and containsValue(row.difficulties, difficultyID)) then
											if row.total and row.progress < row.total then
												completed = false;
											end
										else 
											if row.total and row.progress < row.total then
												other = row.text;
											end
										end
									end
								end
								if completed and other then
									print("You have collected everything from this difficulty. Switch to " .. other .. " instead.");
								end
							end
						end
					end
					
					-- Check to see completion...
					BuildGroups(self.data, self.data.g);
					UpdateGroups(self.data, self.data.g);
				end
				
				-- If we don't have any map data on this area, report it to the chat window.
				if not results or not results.g or #results.g < 1 then
					local mapID = self.mapID;
					local mapInfo = C_Map.GetMapInfo(mapID);
					local mapPath = mapInfo.name or ("Map ID #" .. mapID);
					mapID = mapInfo.parentMapID;
					while mapID do
						mapInfo = C_Map.GetMapInfo(mapID);
						if mapInfo then
							mapPath = (mapInfo.name or ("Map ID #" .. mapID)) .. " -> " .. mapPath;
							mapID = mapInfo.parentMapID;
						else
							break;
						end
					end
					print("No map found for this location ", app.GetMapName(self.mapID), " [", self.mapID, "]");
					print("Path: ", mapPath);
					print("Please report this to the ATT Discord! Thanks! ", GetAddOnMetadata("AllTheThings", "Version"));
				end
			end
			local function OpenMiniList(id, show)
				-- Determine whether or not to forcibly reshow the mini list.
				local self = app:GetWindow("CurrentInstance");
				if not self:IsVisible() then
					if app.Settings:GetTooltipSetting("Auto:MiniList") then
						if not self.openedOnLogin and not show then
							self.openedOnLogin = true;
							show = true;
						end
					else
						self.openedOnLogin = false;
					end
					if show then self:Show(); end
				else
					show = true;
				end
				
				-- Cache that we're in the current map ID.
				self.mapID = id;
				self:Update();
			end
			local function OpenMiniListForCurrentZone()
				OpenMiniList(app.GetCurrentMapID(), true);
			end
			local function RefreshLocationCoroutine()
				-- Wait for a few moments for the map to update.
				local waitTimer = 30;
				while waitTimer > 0 do
					coroutine.yield();
					waitTimer = waitTimer - 1;
				end
				
				-- While the player is in combat, wait for combat to end.
				while InCombatLockdown() do coroutine.yield(); end
				
				-- Acquire the new map ID.
				local mapID = app.GetCurrentMapID();
				while not mapID or mapID < 0 do
					coroutine.yield();
					mapID = app.GetCurrentMapID();
				end
				OpenMiniList(mapID);
			end
			local function RefreshLocation()
				if app.Settings:GetTooltipSetting("Auto:MiniList") or app:GetWindow("CurrentInstance"):IsVisible() then
					StartCoroutine("RefreshLocation", RefreshLocationCoroutine);
				end
			end
			local function ToggleMiniListForCurrentZone()
				local self = app:GetWindow("CurrentInstance");
				if self:IsVisible() then
					self:Hide();
				else
					OpenMiniListForCurrentZone();
				end
			end
			app.OpenMiniListForCurrentZone = OpenMiniListForCurrentZone;
			app.ToggleMiniListForCurrentZone = ToggleMiniListForCurrentZone;
			app.RefreshLocation = RefreshLocation;
			self:SetScript("OnEvent", function(self, e, ...)
				RefreshLocation();
			end);
			self:RegisterEvent("PLAYER_LOGIN");
			self:RegisterEvent("NEW_WMO_CHUNK");
			self:RegisterEvent("SCENARIO_UPDATE");
			self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
		end
		
		-- Update the window and all of its row data
		if self.mapID ~= self.displayedMapID then
			self.displayedMapID = self.mapID;
			self:Rebuild();
		end
		self.data.progress = 0;
		self.data.total = 0;
		self.data.back = 1;
		self.data.indent = 0;
		UpdateGroups(self.data, self.data.g);
		self.data.visible = true;
		UpdateWindow(self, true, got);
	end);
end)();
app:GetWindow("RaidAssistant", UIParent, function(self)
	if not self.initialized then
		self.initialized = true;
		
		-- Define the different window configurations that the mini list will switch to based on context.
		local raidassistant, lootspecialization, dungeondifficulty, raiddifficulty, legacyraiddifficulty;
		
		-- Raid Assistant
		local difficultyLookup = {
			personalloot = "Personal Loot",
			group = "Group Loot",
			master = "Master Loot",
		};
		local difficultyDescriptions = {
			personalloot = "Each player has an independent chance at looting an item useful for their class...\n\n... Or useless things like rings.\n\nClick twice to create a group automatically if you're by yourself.",
			group = "Group loot, round-robin for normal items, rolling for special ones.\n\nClick twice to create a group automatically if you're by yourself.",
			master = "Master looter, designated player distributes loot.\n\nClick twice to create a group automatically if you're by yourself.",
		};
		local switchDungeonDifficulty = function(row, button)
			self.data = raidassistant;
			SetDungeonDifficultyID(row.ref.difficultyID);
			self:Update(true);
			return true;
		end
		local switchRaidDifficulty = function(row, button)
			self.data = raidassistant;
			local myself = self;
			local difficultyID = row.ref.difficultyID;
			if not self.running then
				self.running = true;
			else
				self.running = false;
			end
			
			SetRaidDifficultyID(difficultyID);
			StartCoroutine("RaidDifficulty", function()
				while InCombatLockdown() do coroutine.yield(); end
				while myself.running do
					for i=0,150,1 do
						if myself.running then
							coroutine.yield();
						else
							break;
						end
					end
					if app.RaidDifficulty == difficultyID then
						myself.running = false;
						break;
					else
						SetRaidDifficultyID(difficultyID);
					end
				end
			end);
			self:Update(true);
			return true;
		end
		local switchLegacyRaidDifficulty = function(row, button)
			self.data = raidassistant;
			local myself = self;
			local difficultyID = row.ref.difficultyID;
			if not self.legacyrunning then
				self.legacyrunning = true;
			else
				self.legacyrunning = false;
			end
			SetLegacyRaidDifficultyID(difficultyID);
			StartCoroutine("LegacyRaidDifficulty", function()
				while InCombatLockdown() do coroutine.yield(); end
				while myself.legacyrunning do
					for i=0,150,1 do
						if myself.legacyrunning then
							coroutine.yield();
						else
							break;
						end
					end
					if app.LegacyRaidDifficulty == difficultyID then
						myself.legacyrunning = false;
						break;
					else
						SetLegacyRaidDifficultyID(difficultyID);
					end
				end
			end);
			self:Update(true);
			return true;
		end
		raidassistant = {
			['text'] = "Raid Assistant",
			['icon'] = "Interface\\Icons\\Achievement_Dungeon_GloryoftheRaider.blp", 
			["description"] = "Never enter the instance with the wrong settings again! Verify that everything is as it should be!",
			['visible'] = true, 
			['expanded'] = true,
			['back'] = 1,
			['g'] = {
				{
					['text'] = "Loot Specialization Unknown",
					['title'] = "Loot Specialization",
					["description"] = "In Personal Loot dungeons, raids, and outdoor encounters, this setting will dictate which items are available for you.\n\nClick this row to change it now!",
					['visible'] = true,
					['OnClick'] = function(row, button)
						self.data = lootspecialization;
						self:Update(true);
						return true;
					end,
					['OnUpdate'] = function(data)
						if app.Spec then
							local id, name, description, icon, role, class = GetSpecializationInfoByID(app.Spec);
							if name then
								if GetLootSpecialization() == 0 then name = name .. " (Automatic)"; end
								data.text = name;
								data.icon = icon;
							end
						end
					end,
				},
				{
					['text'] = "Reset Instances",
					['icon'] = "Interface\\Icons\\Ability_Priest_VoidShift",
					['basedescription'] = "Click here to reset your instances.",
					['visible'] = true,
					['OnClick'] = function(row, button)
						ResetInstances();
						return true;
					end,
					['OnUpdate'] = function(data)
						local locks = GetTempDataMember("lockouts");
						if locks then
							local description = data.basedescription .. "\n\nCurrent Instance Locks:";
							for name, instance in pairs(locks) do
								description = description .. "\n  " .. name;
								if instance.shared then
									-- shared raid lockout
									local count, total = 0, 0;
									for i,encounter in ipairs(instance.shared.encounters) do
										if encounter.isKilled then count = count + 1; end
										total = total + 1;
									end
									description = description .. " (" .. count .. " / " .. total .. ")";
								else
									-- specific difficulties
									description = description .. "\n";
									for difficultyID,difficulty in pairs(instance) do
										description = description .. "    " .. "TODO " .. difficultyID;
										
										local count, total = 0, 0;
										for i,encounter in ipairs(difficulty.encounters) do
											if encounter.isKilled then count = count + 1; end
											total = total + 1;
										end
										description = description .. " (" .. count .. " / " .. total .. ")";
									end
								end
							end
							data.description = description;
							UpdateWindow(self, true);
						elseif not data.description then
							data.description = data.basedescription;
							UpdateWindow(self, true);
						end
					end,
				},
				{
					['text'] = "Delist Group",
					['icon'] = "Interface\\Icons\\Ability_Vehicle_LaunchPlayer",
					['description'] = "Click here to delist the group. If you are by yourself, it will softly leave the group without porting you out of any instance you are in.",
					['visible'] = true,
					['OnClick'] = function(row, button)
						C_LFGList.RemoveListing();
						if GroupFinderFrame:IsVisible() then
							PVEFrame_ToggleFrame("GroupFinderFrame")
						end
						self.data = raidassistant;
						UpdateWindow(self, true);
						return true;
					end,
				},
				{
					['text'] = "Leave Group",
					['icon'] = "Interface\\Icons\\Ability_Vanish",
					['description'] = "Click here to leave the group. In most instances, this will also port you to the nearest graveyard after 60 seconds or so.\n\nNOTE: Only works if you're in a group or if the game thinks you're in a group.",
					['visible'] = true,
					['OnClick'] = function(row, button)
						LeaveParty();
						if GroupFinderFrame:IsVisible() then
							PVEFrame_ToggleFrame("GroupFinderFrame")
						end
						self.data = raidassistant;
						UpdateWindow(self, true);
						return true;
					end,
				},
				app.CreateDifficulty(1, {
					['title'] = "Dungeon Difficulty",
					["description"] = "The difficulty setting for dungeons.\n\nClick this row to change it now!",
					['visible'] = true,
					['OnClick'] = function(row, button)
						self.data = dungeondifficulty;
						self:Update(true);
						return true;
					end,
					['OnUpdate'] = function(data)
						if app.DungeonDifficulty then
							data.difficultyID = app.DungeonDifficulty;
							data.name = GetDifficultyInfo(data.difficultyID) or "???";
							local name, instanceType, instanceDifficulty, difficultyName = GetInstanceInfo();
							if instanceDifficulty and data.difficultyID ~= instanceDifficulty and instanceType == 'party' then
								data.name = data.name .. " (" .. (difficultyName or "???") .. ")";
							end
						end
					end,
				}),
				app.CreateDifficulty(14, {
					['title'] = "Raid Difficulty",
					["description"] = "The difficulty setting for raids.\n\nClick this row to change it now!",
					['visible'] = true,
					['OnClick'] = function(row, button)
						-- Don't allow you to change difficulties when you're in LFR / Raid Finder
						if app.RaidDifficulty == 7 or app.RaidDifficulty == 17 then return true; end
						self.data = raiddifficulty;
						self:Update(true);
						return true;
					end,
					['OnUpdate'] = function(data)
						if app.RaidDifficulty then
							data.difficultyID = app.RaidDifficulty;
							local name, instanceType, instanceDifficulty, difficultyName = GetInstanceInfo();
							if instanceDifficulty and data.difficultyID ~= instanceDifficulty and instanceType == 'raid' then
								data.name = (GetDifficultyInfo(data.difficultyID) or "???") .. " (" .. (difficultyName or "???") .. ")";
							else
								data.name = GetDifficultyInfo(data.difficultyID);
							end
						end
					end,
				}),
				app.CreateDifficulty(5, {
					['title'] = "Legacy Raid Difficulty",
					["description"] = "The difficulty setting for legacy raids.\n\nClick this row to change it now!",
					['visible'] = true,
					['OnClick'] = function(row, button)
						-- Don't allow you to change difficulties when you're in LFR / Raid Finder
						if app.RaidDifficulty == 7 or app.RaidDifficulty == 17 then return true; end
						self.data = legacyraiddifficulty;
						self:Update(true);
						return true;
					end,
					['OnUpdate'] = function(data)
						if app.LegacyRaidDifficulty then
							data.difficultyID = app.LegacyRaidDifficulty;
						end
					end,
				}),
			}
		};
		lootspecialization = {
			['text'] = "Loot Specialization",
			['icon'] = "Interface\\Icons\\INV_7XP_Inscription_TalentTome02.blp",
			["description"] = "In Personal Loot dungeons, raids, and outdoor encounters, this setting will dictate which items are available for you.\n\nClick this row to go back to the Raid Assistant.",
			['OnClick'] = function(row, button)
				self.data = raidassistant;
				self:Update(true);
				return true;
			end,
			['OnUpdate'] = function(data)
				data.g = {};
				local numSpecializations = GetNumSpecializations();
				if numSpecializations and numSpecializations > 0 then
					tinsert(data.g, {
						['text'] = "Current Specialization",
						['title'] = select(2, GetSpecializationInfo(GetSpecialization())),
						['icon'] = "Interface\\Icons\\INV_7XP_Inscription_TalentTome01.blp",
						['id'] = 0,
						["description"] = "If you switch your talents, your loot specialization changes with you.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							self.data = raidassistant;
							SetLootSpecialization(row.ref.id);
							self:Update(true);
						end,
					});
					for i=1,numSpecializations,1 do
						local id, name, description, icon, background, role, primaryStat = GetSpecializationInfo(i);
						tinsert(data.g, {
							['text'] = name,
							['icon'] = icon,
							['id'] = id,
							["description"] = description,
							['visible'] = true,
							['OnClick'] = function(row, button)
								self.data = raidassistant;
								SetLootSpecialization(row.ref.id);
								self:Update(true);
							end,
						});
					end
				end
			end,
			['visible'] = true, 
			['expanded'] = true,
			['back'] = 1,
			['g'] = {},
		};
		dungeondifficulty = {
			['text'] = "Dungeon Difficulty",
			['icon'] = "Interface\\Icons\\Achievement_Dungeon_UtgardePinnacle_10man.blp",
			["description"] = "This setting allows you to customize the difficulty of a dungeon.\n\nClick this row to go back to the Raid Assistant.",
			['OnClick'] = function(row, button)
				self.data = raidassistant;
				self:Update(true);
				return true;
			end,
			['visible'] = true, 
			['expanded'] = true,
			['back'] = 1,
			['g'] = {
				app.CreateDifficulty(1, {
					['OnClick'] = switchDungeonDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
					['back'] = 0.5,
				}),
				app.CreateDifficulty(2, {
					['OnClick'] = switchDungeonDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
					['back'] = 0.5,
				}),
				app.CreateDifficulty(23, {
					['OnClick'] = switchDungeonDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
					['back'] = 0.5,
				})
			},
		};
		raiddifficulty = {
			['text'] = "Raid Difficulty",
			['icon'] = "Interface\\Icons\\Achievement_Dungeon_UtgardePinnacle_10man.blp",
			["description"] = "This setting allows you to customize the difficulty of a raid.\n\nClick this row to go back to the Raid Assistant.",
			['OnClick'] = function(row, button)
				self.data = raidassistant;
				self:Update(true);
				return true;
			end,
			['visible'] = true, 
			['expanded'] = true,
			['back'] = 1,
			['g'] = {
				app.CreateDifficulty(14, {
					['OnClick'] = switchRaidDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
				}),
				app.CreateDifficulty(15, {
					['OnClick'] = switchRaidDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
				}),
				app.CreateDifficulty(16, {
					['OnClick'] = switchRaidDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
				})
			},
		};
		legacyraiddifficulty = {
			['text'] = "Legacy Raid Difficulty",
			['icon'] = "Interface\\Icons\\Achievement_Dungeon_UtgardePinnacle_10man.blp",
			["description"] = "This setting allows you to customize the difficulty of a legacy raid. (Pre-Siege of Orgrimmar)\n\nClick this row to go back to the Raid Assistant.",
			['OnClick'] = function(row, button)
				self.data = raidassistant;
				self:Update(true);
				return true;
			end,
			['visible'] = true, 
			['expanded'] = true,
			['back'] = 1,
			['g'] = {
				app.CreateDifficulty(3, {
					['OnClick'] = switchLegacyRaidDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
				}),
				app.CreateDifficulty(5, {
					['OnClick'] = switchLegacyRaidDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
				}),
				app.CreateDifficulty(4, {
					['OnClick'] = switchLegacyRaidDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
				}),
				app.CreateDifficulty(6, {
					['OnClick'] = switchLegacyRaidDifficulty,
					["description"] = "Click to change now. (if available)",
					['visible'] = true,
				}),
			},
		};
		self.data = raidassistant;
		
		-- Setup Event Handlers and register for events
		self:SetScript("OnEvent", function(self, e, ...) self:Update(); end);
		self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED");
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
		self:RegisterEvent("CHAT_MSG_SYSTEM");
		self:RegisterEvent("SCENARIO_UPDATE");
		self:RegisterEvent("ZONE_CHANGED_NEW_AREA");
	end
	
	-- Update the window and all of its row data
	app.LegacyRaidDifficulty = GetLegacyRaidDifficultyID() or 1;
	app.DungeonDifficulty = GetDungeonDifficultyID() or 1;
	app.RaidDifficulty = GetRaidDifficultyID() or 14;
	app.Spec = GetLootSpecialization();
	wipe(app.searchCache);
	if not app.Spec or app.Spec == 0 then
		local s = GetSpecialization();
		if s then app.Spec = select(1, GetSpecializationInfo(s)); end
	end
	if self.data.OnUpdate then self.data.OnUpdate(self.data); end
	for i,g in ipairs(self.data.g) do
		if g.OnUpdate then g.OnUpdate(g); end
	end
	BuildGroups(self.data, self.data.g);
	UpdateWindow(self, true);
end);
(function()
	app:GetWindow("Random", UIParent, function(self)
		if not self.initialized then
			self.initialized = true;
			local function SearchRecursively(group, field, temp)
				if group.visible and not group.saved then
					if group.g then
						for i, subgroup in ipairs(group.g) do
							SearchRecursively(subgroup, field, temp);
						end
					end
					if group[field] then tinsert(temp, group); end
				end
			end
			local function SearchRecursivelyForEverything(group, temp)
				if group.visible and not group.saved then
					if group.g then
						for i, subgroup in ipairs(group.g) do
							SearchRecursivelyForEverything(subgroup, temp);
						end
					end
					tinsert(temp, group);
				end
			end
			local function SearchRecursivelyForValue(group, field, value, temp)
				if group.visible and not group.saved then
					if group.g then
						for i, subgroup in ipairs(group.g) do
							SearchRecursivelyForValue(subgroup, field, value, temp);
						end
					end
					if group[field] and group[field] == value then tinsert(temp, group); end
				end
			end
			function self:SelectAllTheThings()
				if searchCache["randomatt"] then
					return searchCache["randomatt"];
				else
					local searchResults = {};
					for i, subgroup in ipairs(app:GetWindow("Prime").data.g) do
						SearchRecursivelyForEverything(subgroup, searchResults);
					end
					searchCache["randomatt"] = searchResults;
					return searchResults;
				end
			end
			function self:SelectAchievement()
				if searchCache["randomachievement"] then
					return searchCache["randomachievement"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "achievementID", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and not o.saved and o.collectible and not o.mapID then
							tinsert(temp, o);
						end
					end
					searchCache["randomachievement"] = temp;
					return temp;
				end
			end
			function self:SelectItem()
				if searchCache["randomitem"] then
					return searchCache["randomitem"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "itemID", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and o.collectible then
							tinsert(temp, o);
						end
					end
					searchCache["randomitem"] = temp;
					return temp;
				end
			end
			function self:SelectInstance()
				if searchCache["randominstance"] then
					return searchCache["randominstance"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "instanceID", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and (((o.total or 0) - (o.progress or 0)) > 0) then
							tinsert(temp, o);
						end
					end
					searchCache["randominstance"] = temp;
					return temp;
				end
			end
			function self:SelectDungeon()
				if searchCache["randomdungeon"] then
					return searchCache["randomdungeon"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "instanceID", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and not o.isRaid and (((o.total or 0) - (o.progress or 0)) > 0) then
							tinsert(temp, o);
						end
					end
					searchCache["randomdungeon"] = temp;
					return temp;
				end
			end
			function self:SelectRaid()
				if searchCache["randomraid"] then
					return searchCache["randomraid"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "instanceID", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and o.isRaid and (((o.total or 0) - (o.progress or 0)) > 0) then
							tinsert(temp, o);
						end
					end
					searchCache["randomraid"] = temp;
					return temp;
				end
			end
			function self:SelectMount()
				if searchCache["randommount"] then
					return searchCache["randommount"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursivelyForValue(app:GetWindow("Prime").data, "filterID", 100, searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and o.collectible and (not o.achievementID or o.itemID) then
							tinsert(temp, o);
						end
					end
					searchCache["randommount"] = temp;
					return temp;
				end
			end
			function self:SelectPet()
				if searchCache["randompet"] then
					return searchCache["randompet"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "speciesID", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and o.collectible then
							tinsert(temp, o);
						end
					end
					searchCache["randompet"] = temp;
					return temp;
				end
			end
			function self:SelectToy()
				if searchCache["randomtoy"] then
					return searchCache["randomtoy"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "isToy", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and o.collectible then
							tinsert(temp, o);
						end
					end
					searchCache["randomtoy"] = temp;
					return temp;
				end
			end
			local excludedZones = {
				12,	-- Kalimdor
				13, -- Eastern Kingdoms
				101,	-- Outland
				113,	-- Northrend
				424,	-- Pandaria
				948,	-- The Maelstrom
				572,	-- Draenor
				619,	-- The Broken Isles
				905,	-- Argus
				876,	-- Kul'Tiras
				875,	-- Zandalar
			};
			function self:SelectZone()
				if searchCache["randomzone"] then
					return searchCache["randomzone"];
				else
					local searchResults, dict, temp = {}, {} , {};
					SearchRecursively(app:GetWindow("Prime").data, "mapID", searchResults);
					for i,o in pairs(searchResults) do
						if not (o.saved or o.collected) and (((o.total or 0) - (o.progress or 0)) > 0) and not o.instanceID and not contains(excludedZones, o.mapID) then
							tinsert(temp, o);
						end
					end
					searchCache["randomzone"] = temp;
					return temp;
				end
			end
			local mainHeader, filterHeader;
			local rerollOption = {
				['text'] = "Reroll",
				['icon'] = "Interface\\Icons\\ability_monk_roll",
				['description'] = "Click this button to reroll using the active filter.",
				['visible'] = true,
				['OnClick'] = function(row, button)
					self:Reroll();
					return true;
				end,
				['OnUpdate'] = function(data) 
					data.visible = true;
				end,
			};
			filterHeader = {
				['text'] = "Apply a Search Filter",
				['icon'] = "Interface\\Icons\\TRADE_ARCHAEOLOGY.blp", 
				["description"] = "Please select a search filter option.",
				['visible'] = true,
				['expanded'] = true,
				['OnUpdate'] = function(data) 
					data.visible = true;
				end,
				['back'] = 1,
				['g'] = {
					setmetatable({
						['description'] = "Click this button to search... EVERYTHING.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "AllTheThings");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					}, { __index = function(t, key)
						if key == "text" or key == "icon" or key == "preview" or key == "texcoord" or key == "previewtexcoord" then
							return app:GetWindow("Prime").data[key];
						end
					end}),
					{
						['text'] = "Achievement",
						['icon'] = "Interface\\Icons\\Achievement_FeatsOfStrength_Gladiator_10",
						['description'] = "Click this button to select a random achievement based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Achievement");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Item",
						['icon'] = "Interface\\Icons\\INV_Box_02",
						['description'] = "Click this button to select a random item based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Item");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Instance",
						['icon'] = "Interface\\Icons\\Achievement_Dungeon_HEROIC_GloryoftheRaider",
						['description'] = "Click this button to select a random instance based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Instance");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Dungeon",
						['icon'] = "Interface\\Icons\\Achievement_Dungeon_GloryoftheHERO",
						['description'] = "Click this button to select a random dungeon based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Dungeon");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Raid",
						['icon'] = "Interface\\Icons\\Achievement_Dungeon_GloryoftheRaider",
						['description'] = "Click this button to select a random raid based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Raid");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Mount",
						['icon'] = "Interface\\Icons\\Ability_Mount_AlliancePVPMount",
						['description'] = "Click this button to select a random mount based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Mount");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Pet",
						['icon'] = "Interface\\Icons\\INV_Box_02",
						['description'] = "Click this button to select a random pet based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Pet");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Toy",
						['icon'] = "Interface\\Icons\\INV_Misc_Toy_10",
						['description'] = "Click this button to select a random toy based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Toy");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					{
						['text'] = "Zone",
						['icon'] = "Interface\\Icons\\INV_Misc_Map_01",
						['description'] = "Click this button to select a random zone based on what you're missing.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							app.SetDataMember("RandomSearchFilter", "Zone");
							self.data = mainHeader;
							self:Reroll();
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
				},
			};
			mainHeader = {
				['text'] = "Random - Go Get 'Em!",
				['icon'] = "Interface\\Icons\\Ability_Rogue_RolltheBones.blp", 
				["description"] = "This window allows you to randomly select a place or item to get. Go get 'em!",
				['visible'] = true, 
				['expanded'] = true,
				['OnUpdate'] = function(data) 
					data.visible = true;
				end,
				['back'] = 1,
				["indent"] = 0,
				['options'] = {
					{
						['text'] = "Change Search Filter",
						['icon'] = "Interface\\Icons\\TRADE_ARCHAEOLOGY.blp", 
						["description"] = "Click this to change your search filter.",
						['visible'] = true,
						['OnClick'] = function(row, button)
							self.data = filterHeader;
							UpdateWindow(self, true);
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
					rerollOption,
				},
				['g'] = { },
			};
			self.data = mainHeader;
			self.Rebuild = function(self, no)
				-- Rebuild all the datas
				wipe(self.data.g);
				
				-- Call to our method and build a list to draw from
				local method = app.GetDataMember("RandomSearchFilter", "Instance");
				if method then
					rerollOption.text = "Reroll: " .. method;
					method = "Select" .. method;
					local temp = self[method]() or {};
					local totalWeight = 0;
					for i,o in ipairs(temp) do
						totalWeight = totalWeight + ((o.total or 1) - (o.progress or 0));
					end
					if totalWeight > 0 and #temp > 0 then
						local weight, selected = math.random(totalWeight), nil;
						totalWeight = 0;
						for i,o in ipairs(temp) do
							totalWeight = totalWeight + ((o.total or 1) - (o.progress or 0));
							if weight <= totalWeight then
								selected = o;
								break;
							end
						end
						if not selected then selected = temp[#temp - 1]; end
						if selected then
							MergeObject(self.data.g, CreateObject(selected));
						else
							app.print("There was nothing to randomly select from.");
						end
					else
						app.print("There was nothing to randomly select from.");
					end
				else
					app.print("No search method specified.");
				end
				for i=#self.data.options,1,-1 do
					tinsert(self.data.g, 1, self.data.options[i]);
				end
				BuildGroups(self.data, self.data.g);
				if not no then self:Update(); end
			end
			self.Reroll = function(self)
				Push(self, "Rebuild", self.Rebuild);
			end
			for i,o in ipairs(self.data.options) do
				tinsert(self.data.g, o);
			end
			self:RegisterEvent("PLAYER_LOGIN");
			self:SetScript("OnEvent", function(self, e, ...) 
				rerollOption.text = "Reroll: " .. app.GetDataMember("RandomSearchFilter", "Instance");
			end);
		end
		
		-- Update the window and all of its row data
		self.data.progress = 0;
		self.data.total = 0;
		self.data.indent = 0;
		BuildGroups(self.data, self.data.g);
		UpdateGroups(self.data, self.data.g);
		UpdateWindow(self, true);
	end);
end)();
(function()
	app:GetWindow("Tradeskills", UIParent, function(self, ...)
		if not self.initialized then
			self.initialized = true;
			self:SetClampedToScreen(false);
			self:RegisterEvent("TRADE_SKILL_SHOW");
			self:RegisterEvent("TRADE_SKILL_LIST_UPDATE");
			self:RegisterEvent("TRADE_SKILL_CLOSE");
			self:RegisterEvent("NEW_RECIPE_LEARNED");
			self.wait = 5;
			self.data = {
				['text'] = "Profession List",
				['icon'] = "Interface\\Icons\\INV_Scroll_04.blp", 
				["description"] = "Open your professions to cache them.",
				['visible'] = true, 
				['expanded'] = true,
				["indent"] = 0,
				['back'] = 1,
				['g'] = { },
			};
			self.CacheRecipes = function(self)
				-- Cache Learned Spells
				local skillCache = fieldCache["spellID"];
				if skillCache then
					local tradeSkillID = AllTheThings.GetTradeSkillLine();
					if tradeSkillID == self.lastTradeSkillID then
						return false;
					end
					-- If it's not yours, don't take credit for it.
					if C_TradeSkillUI.IsTradeSkillLinked() or C_TradeSkillUI.IsTradeSkillGuild() then
						return false;
					end
					self.lastTradeSkillID = tradeSkillID;
					
					local currentCategoryID, categories = -1, {};
					local categoryIDs = { C_TradeSkillUI.GetCategories() };
					for i = 1,#categoryIDs do
						currentCategoryID = categoryIDs[i];
						local categoryData = C_TradeSkillUI.GetCategoryInfo(currentCategoryID);
						if categoryData then
							if not categories[currentCategoryID] then
								app.SetDataSubMember("Categories", currentCategoryID, categoryData.name);
								categories[currentCategoryID] = true;
							end
						end
					end
					
					-- Cache learned recipes
					local learned = 0;
					local reagentCache = app.GetDataMember("Reagents", {});
					local recipeIDs = C_TradeSkillUI.GetAllRecipeIDs();
					for i = 1,#recipeIDs do
						local spellRecipeInfo = {};
						if C_TradeSkillUI.GetRecipeInfo(recipeIDs[i], spellRecipeInfo) then
							currentCategoryID = spellRecipeInfo.categoryID;
							if not categories[currentCategoryID] then
								local categoryData = C_TradeSkillUI.GetCategoryInfo(currentCategoryID);
								if categoryData then
									app.SetDataSubMember("Categories", currentCategoryID, categoryData.name);
									categories[currentCategoryID] = true;
								end
							end
							if spellRecipeInfo.learned then
								SetTempDataSubMember("CollectedSpells", spellRecipeInfo.recipeID, 1);
								if not GetDataSubMember("CollectedSpells", spellRecipeInfo.recipeID) then
									SetDataSubMember("CollectedSpells", spellRecipeInfo.recipeID, 1);
									learned = learned + 1;
								end
							end
							if not skillCache[spellRecipeInfo.recipeID] then
								--app.print("Missing [" .. (spellRecipeInfo.name or "??") .. "] (Spell ID #" .. spellRecipeInfo.recipeID .. ") in ATT Database. Please report it!");
								skillCache[spellRecipeInfo.recipeID] = { {} };
							end
							local craftedItemID = GetItemInfoInstant(C_TradeSkillUI.GetRecipeItemLink(spellRecipeInfo.recipeID));
							for i=1,C_TradeSkillUI.GetRecipeNumReagents(spellRecipeInfo.recipeID) do
								local reagentName, reagentTexture, reagentCount, playerCount = C_TradeSkillUI.GetRecipeReagentInfo(spellRecipeInfo.recipeID, i);
								local itemID = GetItemInfoInstant(C_TradeSkillUI.GetRecipeReagentItemLink(spellRecipeInfo.recipeID, i));
								--print(spellRecipeInfo.recipeID, itemID, "=>", craftedItemID);
								
								-- Make sure a cache table exists for this item.
								-- Index 1: The Recipe Skill IDs
								-- Index 2: The Crafted Item IDs
								if not reagentCache[itemID] then reagentCache[itemID] = { {}, {} }; end
								reagentCache[itemID][1][spellRecipeInfo.recipeID] = reagentCount;
								if craftedItemID then reagentCache[itemID][2][craftedItemID] = reagentCount; end
							end
						end
					end
					
					-- Open the Tradeskill list for this Profession
					if self.tradeSkillID ~= tradeSkillID then
						self.tradeSkillID = tradeSkillID;
						for i,group in ipairs(app.Categories.Professions) do
							if group.requireSkill == tradeSkillID then
								self.data = setmetatable({ ['visible'] = true, ["indent"] = 0, total = 0, progress = 0 }, { __index = group });
								BuildGroups(self.data, self.data.g);
								app.UpdateGroups(self.data, self.data.g);
								if not self.data.expanded then
									self.data.expanded = true;
									ExpandGroupsRecursively(self.data, true);
								end
								if app.Settings:GetTooltipSetting("Auto:ProfessionList") then
									self:SetVisible(true);
								end
							end
						end
					end
				
					-- If something new was "learned", then refresh the data.
					if learned > 0 then
						app:RefreshData(false, true);
						app.print("Cached " .. learned .. " known recipes!");
						wipe(searchCache);
					end
				end
			end
			self.RefreshRecipes = function(self)
				if app.CollectibleRecipes then
					self.wait = 5;
					StartCoroutine("RefreshingRecipes", function()
						while self.wait > 0 do
							self.wait = self.wait - 1;
							coroutine.yield();
						end
						self:CacheRecipes();
					end);
				end
			end
			
			-- Setup Event Handlers and register for events
			self:SetScript("OnEvent", function(self, e, ...)
				if e == "TRADE_SKILL_LIST_UPDATE" then
					if self:IsVisible() then
						-- If it's not yours, don't take credit for it.
						if C_TradeSkillUI.IsTradeSkillLinked() or C_TradeSkillUI.IsTradeSkillGuild() then
							self:SetVisible(false);
							return false;
						end
						
						-- Check to see if ATT has information about this profession.
						local tradeSkillID = AllTheThings.GetTradeSkillLine();
						if not tradeSkillID or not fieldCache["requireSkill"][tradeSkillID] then
							if self:IsVisible() then
								app.print("You must have a profession open to open the profession mini list.");
							end
							self:SetVisible(false);
							return false;
						end
						
						-- Set the Window to align with the Profession Window
						self:ClearAllPoints();
						self:SetPoint("TOPLEFT", TradeSkillFrame, "TOPRIGHT", 0, 0);
						self:SetPoint("BOTTOMLEFT", TradeSkillFrame, "BOTTOMRIGHT", 0, 0);
						self:Update();
					end
					self:RefreshRecipes();
				elseif e == "TRADE_SKILL_SHOW" then
					if app.Settings:GetTooltipSetting("Auto:ProfessionList") then
						self:SetVisible(true);
					end
					self:RefreshRecipes();
				elseif e == "NEW_RECIPE_LEARNED" then
					local spellID = ...;
					if spellID then
						local previousState = GetDataSubMember("CollectedSpells", spellID);
						SetDataSubMember("CollectedSpells", spellID, 1);
						if not GetTempDataSubMember("CollectedSpells", spellID) then
							SetTempDataSubMember("CollectedSpells", spellID, 1);
							app:RefreshData(true, true);
							if not previousState or not app.Settings:Get("AccountWide:Recipes") then
								app:PlayFanfare();
							end
							wipe(searchCache);
							collectgarbage();
						end
					end
				elseif e == "TRADE_SKILL_CLOSE" then
					self:SetVisible(false);
				end
			end);
		end
		
		-- Update the window and all of its row data
		self.data.progress = 0;
		self.data.total = 0;
		UpdateGroups(self.data, self.data.g);
		UpdateWindow(self, ...);
	end);
end)();
(function()
	local worldMapIDs = {
		14,		-- Arathi Highlands
		62,		-- Darkshore
		875,	-- Zandalar
		876,	-- Kul'Tiras
		619,	-- The Broken Isles
		885,	-- Antoran Wastes
		830,	-- Krokuun
		882,	-- Mac'Aree
	};
	app:GetWindow("WorldQuests", UIParent, function(self)
		if not self.initialized then
			self.initialized = true;
			self.data = {
				['text'] = "World Quests",
				['icon'] = "Interface\\Icons\\INV_Misc_Map08.blp", 
				["description"] = "These are World Quests that are currently available somewhere. Go get 'em!",
				['visible'] = true, 
				['expanded'] = true,
				["indent"] = 0,
				['back'] = 1,
				['g'] = {
					{
						['text'] = "Update World Quests Now",
						['icon'] = "Interface\\Icons\\INV_Misc_Map_01",
						['description'] = "Sometimes the World Quest API is slow or fails to return new data. If you wish to forcibly refresh the data without changing zones, click this button now!",
						['OnClick'] = function(data, button)
							Push(self, "Rebuild", self.Rebuild);
							return true;
						end,
						['OnUpdate'] = function(data) 
							data.visible = true;
						end,
					},
				},
			};
			self.rawData = {};
			local OnUpdateForItem = function(self)
				for i,o in ipairs(self.g) do
					o.visible = false;
				end
			end;
			self.Clear = function(self)
				local temp = self.data.g[1];
				wipe(self.data.g);
				wipe(self.rawData);
				tinsert(self.data.g, temp);
				self:Rebuild();
			end
			self.Rebuild = function(self, no)
				-- Rebuild all World Quest data
				local retry = false;
				local temp = {};
				local showCurrencies = app.Settings:GetTooltipSetting("WorldQuestsList:Currencies");
				for _,mapID in pairs(worldMapIDs) do
					local mapObject = { mapID=mapID,g={},progress=0,total=0};
					local cache = fieldCache["mapID"][mapID];
					if cache then
						for _,data in ipairs(cache) do
							if data.mapID and data.icon then
								mapObject.icon = data.icon;
								mapObject.lvl = data.lvl;
								mapObject.description = data.description;
								break;
							end
						end
					end
					
					local pois = C_TaskQuest.GetQuestsForPlayerByMapID(mapID);
					if pois then
						for i,poi in ipairs(pois) do
							local questObject = {questID=poi.questId,g={},progress=0,total=0};
							
							local tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex = GetQuestTagInfo(questObject.questID);
							if worldQuestType == LE_QUEST_TAG_TYPE_PVP or worldQuestType == LE_QUEST_TAG_TYPE_BOUNTY then
								questObject.icon = "Interface\\Icons\\Achievement_PVP_P_09";
							elseif worldQuestType == LE_QUEST_TAG_TYPE_PET_BATTLE then
								questObject.icon = "Interface\\Icons\\PetJournalPortrait";
							elseif worldQuestType == LE_QUEST_TAG_TYPE_PROFESSION then
								questObject.icon = "Interface\\Icons\\Trade_BlackSmithing";
							elseif worldQuestType == LE_QUEST_TAG_TYPE_DUNGEON or tagID == 137 then
								-- questObject.icon = "Interface\\Icons\\Achievement_PVP_P_09";
								-- TODO: Add the relevent dungeon icon. (DONE! IN REWARDS!)
							elseif worldQuestType == LE_QUEST_TAG_TYPE_RAID then
								-- questObject.icon = "Interface\\Icons\\Achievement_PVP_P_09";
								-- TODO: Add the relevent dungeon icon.
							elseif worldQuestType == LE_QUEST_TAG_TYPE_INVASION or worldQuestType == LE_QUEST_TAG_TYPE_INVASION_WRAPPER then
								questObject.icon = "Interface\\Icons\\achievements_zone_brokenshore";
							--elseif worldQuestType == LE_QUEST_TAG_TYPE_TAG then
								-- completely useless
								--questObject.icon = "Interface\\Icons\\INV_Misc_QuestionMark";
							--elseif worldQuestType == LE_QUEST_TAG_TYPE_NORMAL then
							--	questObject.icon = "Interface\\Icons\\INV_Misc_QuestionMark";
							end
							
							cache = fieldCache["questID"][questObject.questID];
							if cache then
								for _,data in ipairs(cache) do
									for key,value in pairs(data) do
										if not (key == "g" or key == "parent") then
											questObject[key] = value;
										end
									end
									if data.g then
										for _,entry in ipairs(data.g) do
											tinsert(questObject.g, entry);
										end
									end
								end
							end
							
							local numQuestRewards = GetNumQuestLogRewards (questObject.questID);
							for j=1,numQuestRewards,1 do
								local _, _, _, _, _, itemID, ilvl = GetQuestLogRewardInfo (j, questObject.questID);
								if itemID then
									local modID = tagID == 137 and ((ilvl >= 370 and 23) or (ilvl >= 355 and 2)) or 1;
									if showCurrencies or (itemID ~= 116415 and itemID ~= 163036) then
										-- QuestHarvester:SetQuestLogItem("reward", j, questObject.questID);
										local item = { ["itemID"] = itemID, ["expanded"] = false, };
										cache = fieldCache["itemID"][itemID];
										if cache then
											local ACKCHUALLY;
											for _,data in ipairs(cache) do
												if data.f then
													item.f = data.f;
												end
												if data.s then
													item.s = data.s;
													if data.modID == modID then
														ACKCHUALLY = data.s;
														item.modID = modID;
														if tagID == 137 then
															local parent = data.parent;
															while parent do
																if parent.instanceID then
																	questObject.icon = parent.icon;
																	break;
																end
																parent = parent.parent;
															end
														end
													end
												end
												if data.g and #data.g > 0 then
													if not item.g then
														item.g = {};
														item.progress = 0;
														item.total = 0;
														item.OnUpdate = OnUpdateForItem;
													end
													for __,subdata in ipairs(data.g) do
														MergeObject(item.g, subdata);
													end
												end
											end
											if ACKCHUALLY then
												item.s = ACKCHUALLY;
											end
										end
										MergeObject(questObject.g, item);
									end
								else
									return true;
								end
							end
							
							if showCurrencies then
								local numCurrencies = GetNumQuestLogRewardCurrencies(questObject.questID);
								if numCurrencies > 0 then
									for j=1,numCurrencies,1 do
										local name, texture, numItems, currencyID = GetQuestLogRewardCurrencyInfo(j, questObject.questID);
										if currencyID then
											local item = { ["currencyID"] = currencyID, ["expanded"] = false, };
											cache = fieldCache["currencyID"][currencyID];
											if cache then
												for _,data in ipairs(cache) do
													if data.f then
														item.f = data.f;
													end
													if data.g and #data.g > 0 then
														if not item.g then
															item.g = {};
															item.progress = 0;
															item.total = 0;
															item.OnUpdate = OnUpdateForItem;
														end
														for __,subdata in ipairs(data.g) do
															MergeObject(item.g, subdata);
														end
													end
												end
											end
											if not item.g then
												item.g = {};
												item.progress = 0;
												item.total = 0;
												item.OnUpdate = OnUpdateForItem;
											end
											MergeObject(questObject.g, item);
										else
											return true;
										end
									end
								end
							end
							--print(i, ": ", mapID, " ", poi.mapID, ", ", questObject.questID, timeRemaining);
							--print(tagID, tagName, worldQuestType, rarity, isElite, tradeskillLineIndex, displayTimeLeft);
							if poi.mapID ~= mapID then
								local subMapObject = { mapID=poi.mapID,g={},progress=0,total=0};
								cache = fieldCache["mapID"][poi.mapID];
								if cache then
									for _,data in ipairs(cache) do
										if data.mapID and data.icon then
											subMapObject.icon = data.icon;
											subMapObject.lvl = data.lvl;
											subMapObject.description = data.description;
											break;
										end
									end
								end
								MergeObject(subMapObject.g, questObject);
								MergeObject(mapObject.g, subMapObject);
							else
								MergeObject(mapObject.g, questObject);
							end
						end
						table.sort(mapObject.g, self.Sort);
					end
					if #mapObject.g > 0 then
						MergeObject(temp, mapObject);
					end
				end
				for i,o in ipairs(temp) do
					MergeObject(self.rawData, o);
				end
				for i,o in ipairs(self.rawData) do
					MergeObject(self.data.g, CreateObject(o));
				end
				if not no then self:Update(); end
			end
			self.Sort = function(a, b)
				if a.isRaid then
					if b.isRaid then
						return false;
					else
						return true;
					end
				elseif b.isRaid then
					return false;
				end
				if a.questID then
					if b.questID then
						return a.questID < b.questID;
					else
						return true;
					end
				end
				if a.mapID then
					if b.mapID then
						if a.text and b.text then
							return a.text < b.text;
						else
							return a.mapID < b.mapID;
						end
					else
						return true;
					end
				end
				return false;
			end;
		end
		
		-- Update the window and all of its row data
		self.data.progress = 0;
		self.data.total = 0;
		BuildGroups(self.data, self.data.g);
		UpdateGroups(self.data, self.data.g);
		UpdateWindow(self, true);
	end);
end)();

hooksecurefunc(GameTooltip, "SetToyByItemID", function(self, itemID, ...)
	local link = C_ToyBox_GetToyLink(itemID);
	if link then
		AttachTooltipSearchResults(self, link, SearchForLink, link);
		self:Show();
	end
end)
hooksecurefunc(GameTooltip, "SetRecipeReagentItem", function(self, itemID, reagentID, ...)
	local link = C_TradeSkillUI.GetRecipeReagentItemLink(itemID, reagentID);
	if link then
		AttachTooltipSearchResults(self, link, SearchForLink, link);
		self:Show();
	end
end)
GameTooltip:HookScript("OnTooltipSetQuest", AttachTooltip);
GameTooltip:HookScript("OnTooltipSetItem", AttachTooltip);
GameTooltip:HookScript("OnTooltipSetUnit", AttachTooltip);
GameTooltip:HookScript("OnTooltipCleared", ClearTooltip);
ItemRefTooltip:HookScript("OnShow", AttachTooltip);
ItemRefTooltip:HookScript("OnTooltipSetQuest", AttachTooltip);
ItemRefTooltip:HookScript("OnTooltipSetItem", AttachTooltip);
ItemRefTooltip:HookScript("OnTooltipCleared", ClearTooltip);
ItemRefShoppingTooltip1:HookScript("OnShow", AttachTooltip);
ItemRefShoppingTooltip1:HookScript("OnTooltipSetQuest", AttachTooltip);
ItemRefShoppingTooltip1:HookScript("OnTooltipSetItem", AttachTooltip);
ItemRefShoppingTooltip1:HookScript("OnTooltipCleared", ClearTooltip);
ItemRefShoppingTooltip2:HookScript("OnShow", AttachTooltip);
ItemRefShoppingTooltip2:HookScript("OnTooltipSetQuest", AttachTooltip);
ItemRefShoppingTooltip2:HookScript("OnTooltipSetItem", AttachTooltip);
ItemRefShoppingTooltip2:HookScript("OnTooltipCleared", ClearTooltip);
WorldMapTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetQuest", AttachTooltip);
WorldMapTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetItem", AttachTooltip);
WorldMapTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipSetUnit", AttachTooltip);
WorldMapTooltip.ItemTooltip.Tooltip:HookScript("OnTooltipCleared", ClearTooltip);
WorldMapTooltip:HookScript("OnTooltipSetItem", AttachTooltip);
WorldMapTooltip:HookScript("OnTooltipSetQuest", AttachTooltip);
WorldMapTooltip:HookScript("OnTooltipCleared", ClearTooltip);
WorldMapTooltip:HookScript("OnTooltipCleared", ClearTooltip);
WorldMapTooltip:HookScript("OnShow", AttachTooltip);

--hooksecurefunc("BattlePetTooltipTemplate_SetBattlePet", AttachBattlePetTooltip); -- Not ready yet.

-- Slash Command List
SLASH_AllTheThings1 = "/allthethings";
SLASH_AllTheThings2 = "/things";
SLASH_AllTheThings3 = "/att";
SlashCmdList["AllTheThings"] = function(cmd)
	if not cmd or cmd == "" or cmd == "main" or cmd == "mainlist" then
		app.ToggleMainList();
	elseif cmd == "mini" or cmd == "minilist" then
		app:ToggleMiniListForCurrentZone();
	elseif cmd == "ra" then
		app:GetWindow("RaidAssistant"):Toggle();
	elseif cmd == "ran" or cmd == "rand" or cmd == "random" then
		app:GetWindow("Random"):Toggle();
	elseif cmd == "wq" then
		app:GetWindow("WorldQuests"):Toggle();
	elseif cmd == "unsorted" then
		app:GetWindow("Unsorted"):Toggle();
	else
		-- Search for the Link in the database
		local group = GetCachedSearchResults(cmd, SearchForLink, cmd);
		if group then CreateMiniListForGroup(group); end
	end
end

SLASH_AllTheThingsMAPS1 = "/attmaps";
SlashCmdList["AllTheThingsMAPS"] = function(cmd)
	app:GetWindow("CosmicInfuser"):Toggle();
end

SLASH_AllTheThingsNote1 = "/attnote";
SlashCmdList["AllTheThingsNote"] = function(cmd)
	cmd = cmd or "";
	if cmd == "clear" then
		SetNote("mapID", app.GetCurrentMapID(), nil);
		return nil;
	elseif cmd ~= "" then
		SetNote("mapID", app.GetCurrentMapID(), cmd);
		return nil;
	end
	
	-- Print out help
	print("|cff15abff/attnote|r - Usage:");
	print("|cff15abff/attnote|r |cffff9333clear|r - Clear the note for the current map.");
	print("|cff15abff/attnote|r |cffff9333<note>|r - Write a note for the current map.");
end

SLASH_AllTheThingsRA1 = "/attra";
SlashCmdList["AllTheThingsRA"] = function(cmd)
	app:GetWindow("RaidAssistant"):Toggle();
end

SLASH_AllTheThingsRAN1 = "/attran";
SLASH_AllTheThingsRAN2 = "/attrandom";
SlashCmdList["AllTheThingsRAN"] = function(cmd)
	app:GetWindow("Random"):Toggle();
end

SLASH_AllTheThingsWQ1 = "/attwq";
SlashCmdList["AllTheThingsWQ"] = function(cmd)
	app:GetWindow("WorldQuests"):Toggle();
end

-- Register Events required at the start
app:RegisterEvent("ADDON_LOADED");
app:RegisterEvent("BOSS_KILL");
app:RegisterEvent("PLAYER_LOGIN");
app:RegisterEvent("VARIABLES_LOADED");
app:RegisterEvent("TOYS_UPDATED");
app:RegisterEvent("COMPANION_LEARNED");
app:RegisterEvent("COMPANION_UNLEARNED");
app:RegisterEvent("NEW_PET_ADDED");
app:RegisterEvent("PET_JOURNAL_PET_DELETED");
app:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED");
app:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED");
app:RegisterEvent("TRANSMOG_COLLECTION_SOURCE_ADDED");
app:RegisterEvent("TRANSMOG_COLLECTION_SOURCE_REMOVED");
app:RegisterEvent("HEIRLOOMS_UPDATED");
app:RegisterEvent("PET_BATTLE_OPENING_START")
app:RegisterEvent("PET_BATTLE_CLOSE")

-- Define Event Behaviours
app.events.VARIABLES_LOADED = function()
	AllTheThingsAD = _G["AllTheThingsAD"];	-- For account-wide data.
	if not AllTheThingsAD then
		AllTheThingsAD = { };
		_G["AllTheThingsAD"] = AllTheThingsAD;
	end
	AllTheThingsPCD = _G["AllTheThingsPCD"]; -- For character specific data.
	if not AllTheThingsPCD then
		AllTheThingsPCD = { };
		_G["AllTheThingsPCD"] = AllTheThingsPCD;
	end
	AllTheThingsHarvestItems = {};
	
	app:UpdateWindowColors();
	
	-- Cache information about the player.
	local _, class, classIndex = UnitClass("player");
	local raceName, race = UnitRace("player");
	app.Class = class;
	app.ClassIndex = classIndex;
	app.Level = UnitLevel("player");
	local raceIndex = app.RaceDB[race];
	if type(raceIndex) == "table" then
		local factionGroup = UnitFactionGroup("player");
		raceIndex = raceIndex[factionGroup];
	end
	app.Race = race;
	app.RaceIndex = raceIndex;
	local name, realm = UnitName("player");
	local _, id = GetClassInfo(classIndex);
	app.GUID = UnitGUID("player");
	app.Me = "|c" .. RAID_CLASS_COLORS[id].colorStr .. name .. "-" .. (realm or GetRealmName()) .. "|r";
	app.Faction = UnitFactionGroup("player");
	if app.Faction == "Horde" then
		app.FactionID = 2;
	elseif app.Faction == "Alliance" then
		app.FactionID = 1;
	else
		-- Neutral Pandaren or... something else. Scourge? Neat.
		app.FactionID = 0;
	end
	
	-- Check to see if we have a leftover ItemDB cache
	GetDataMember("CollectedBuildings", {});
	GetDataMember("CollectedFactions", {});
	GetDataMember("CollectedFollowers", {});
	GetDataMember("CollectedMusicRolls", {});
	GetDataMember("CollectedSelfieFilters", {});
	GetDataMember("CollectedTitles", {});
	GetDataMember("CollectedSpells", {});
	GetDataMember("SeasonalFilters", {});
	GetDataMember("UnobtainableItemFilters", {});
	GetDataMember("WaypointFilters", {});
	
	-- Cache your character's lockouts.
	local lockouts = GetDataMember("lockouts", {});
	local myLockouts = GetTempDataMember("lockouts", lockouts[app.GUID]);
	if not myLockouts then
		myLockouts = {};
		lockouts[app.GUID] = myLockouts;
		SetTempDataMember("lockouts", myLockouts);
	end
	
	-- Cache your character's profession data.
	local recipes = GetDataMember("CollectedSpellsPerCharacter", {});
	local myRecipes = GetTempDataMember("CollectedSpells", recipes[app.GUID]);
	if not myRecipes then
		myRecipes = {};
		recipes[app.GUID] = myRecipes;
		SetTempDataMember("CollectedSpells", myRecipes);
	end
	
	-- Cache your character's faction data.
	local factions = GetDataMember("CollectedFactionsPerCharacter", {});
	local myfactions = GetTempDataMember("CollectedFactions", factions[app.GUID]);
	if not myfactions then
		myfactions = {};
		factions[app.GUID] = myfactions;
		SetTempDataMember("CollectedFactions", myfactions);
	end
	
	-- Cache your character's building data.
	local buildings = GetDataMember("CollectedBuildingsPerCharacter", {});
	local myBuildings = GetTempDataMember("CollectedBuildings", buildings[app.GUID]);
	if not myBuildings then
		myBuildings = {};
		buildings[app.GUID] = myBuildings;
		SetTempDataMember("CollectedBuildings", myBuildings);
	end
	
	-- Cache your character's follower data.
	local followers = GetDataMember("CollectedFollowersPerCharacter", {});
	local myFollowers = GetTempDataMember("CollectedFollowers", followers[app.GUID]);
	if not myFollowers then
		myFollowers = {};
		followers[app.GUID] = myFollowers;
		SetTempDataMember("CollectedFollowers", myFollowers);
	end
	
	-- Cache your character's music roll data.
	local musicRolls = GetDataMember("CollectedMusicRollsPerCharacter", {});
	local myMusicRolls = GetTempDataMember("CollectedMusicRolls", musicRolls[app.GUID]);
	if not myMusicRolls then
		myMusicRolls = {};
		musicRolls[app.GUID] = myMusicRolls;
		SetTempDataMember("CollectedMusicRolls", myMusicRolls);
		SetDataMember("WipedCollectedMusicRollsPerCharacter", 1);
	elseif not GetDataMember("WipedCollectedMusicRollsPerCharacter") then
		SetDataMember("WipedCollectedMusicRollsPerCharacter", 1);
		wipe(myMusicRolls);
		wipe(musicRolls);
		musicRolls[app.GUID] = myMusicRolls;
	end
	
	-- Cache your character's selfie filters data.
	local selfieFilters = GetDataMember("CollectedSelfieFiltersPerCharacter", {});
	local mySelfieFilters = GetTempDataMember("CollectedSelfieFilters", selfieFilters[app.GUID]);
	if not mySelfieFilters then
		mySelfieFilters = {};
		selfieFilters[app.GUID] = mySelfieFilters;
		SetTempDataMember("CollectedSelfieFilters", mySelfieFilters);
	end
	
	-- Cache your character's title data.
	local titles = GetDataMember("CollectedTitlesPerCharacter", {});
	local myTitles = GetTempDataMember("CollectedTitles", titles[app.GUID]);
	if not myTitles then
		myTitles = {};
		titles[app.GUID] = myTitles;
		SetTempDataMember("CollectedTitles", myTitles);
	end
	
	-- GUID to Character Name cache
	local characters = GetDataMember("Characters", {});
	if not characters[app.GUID] or true then -- Temporary
		-- Convert old-style "ME" data entries to "GUID" entries.
		local nameF = name .. "%-" .. (realm or GetRealmName());
		local CleanData = function(t, t2)
			for key,data in pairs(t) do
				if string.match(key, nameF) then
					for id,state in pairs(data) do
						t2[id] = state;
					end
					t[key] = nil;
				elseif key ~= app.GUID then
					local isEmpty = true;
					for id,state in pairs(data) do
						isEmpty = false;
						break;
					end
					if isEmpty then
						t[key] = nil;
					end
				end
			end
		end
		CleanData(buildings, myBuildings);
		CleanData(factions, myfactions);
		CleanData(followers, myFollowers);
		CleanData(lockouts, myLockouts);
		CleanData(musicRolls, myMusicRolls);
		CleanData(recipes, myRecipes);
		CleanData(selfieFilters, mySelfieFilters);
		CleanData(titles, myTitles);
		characters[app.GUID] = app.Me;
	end
	
	-- Clean up settings
	local oldsettings = {};
	for i,key in ipairs({"Categories","Characters","CollectedArtifacts","CollectedBuildings","CollectedBuildingsPerCharacter","CollectedFactions","CollectedFactionBonusReputation","CollectedFactionsPerCharacter","CollectedFollowers","CollectedFollowersPerCharacter","CollectedIllusions","CollectedMusicRolls","CollectedMusicRollsPerCharacter","CollectedSelfieFilters","CollectedSelfieFiltersPerCharacter","CollectedSources","CollectedSpells","CollectedSpellsPerCharacter","CollectedTitles","CollectedToys","FilterSeasonal","CollectedTitlesPerCharacter","FilterUnobtainableItems","FlightPaths","lockouts","Notes","Position","RandomSearchFilter","Reagents","RefreshedCollectionsAlready","SeasonalFilters","Sets","SourceSets","UnobtainableItemFilters","WaypointFilters","EnableTomTomWaypointsOnTaxi","TomTomIgnoreCompletedObjects","WipedCollectedMusicRollsPerCharacter"}) do
		oldsettings[key] = AllTheThingsAD[key];
	end
	wipe(AllTheThingsAD);
	for key,value in pairs(oldsettings) do
		AllTheThingsAD[key] = oldsettings[key];
	end

	-- Tooltip Settings
	GetDataMember("EnableTomTomWaypointsOnTaxi", false);
	GetDataMember("TomTomIgnoreCompletedObjects", true);
	app.Settings:Initialize();
end
app.events.PLAYER_LOGIN = function()
	app:UnregisterEvent("PLAYER_LOGIN");
	app.Spec = GetLootSpecialization();
	if not app.Spec or app.Spec == 0 then app.Spec = select(1, GetSpecializationInfo(GetSpecialization())); end
	local reagentCache = app.GetDataMember("Reagents");
	if reagentCache then
		local craftedItem = { {}, {[31890] = 1} };	-- Blessings Deck
		for i,itemID in ipairs({ 31882, 31889, 31888, 31885, 31884, 31887, 31886, 31883 }) do reagentCache[itemID] = craftedItem; end
		craftedItem = { {}, {[31907] = 1} };	-- Furies Deck
		for i,itemID in ipairs({ 31901, 31909, 31908, 31904, 31903, 31906, 31905, 31902 }) do reagentCache[itemID] = craftedItem; end
		craftedItem = { {}, {[31914] = 1} };	-- Lunacy Deck
		for i,itemID in ipairs({ 31910, 31918, 31917, 31913, 31912, 31916, 31915, 31911 }) do reagentCache[itemID] = craftedItem; end
		craftedItem = { {}, {[31891] = 1} };	-- Storms Deck
		for i,itemID in ipairs({ 31892, 31900, 31899, 31895, 31894, 31898, 31896, 31893 }) do reagentCache[itemID] = craftedItem; end
	end
	app:GetDataCache();
	Push(app, "WaitOnMountData", function()
		-- Detect how many pets there are. If 0, Blizzard isn't ready yet.
		if C_PetJournal.GetNumPets() < 1 then return true; end
		
		-- Detect how many mounts there are. If 0, Blizzard isn't ready yet.
		local mountIDs = C_MountJournal.GetMountIDs();
		if #mountIDs < 1 then return true; end
		
		-- Harvest the Spell IDs for Conversion.
		app:UnregisterEvent("PET_JOURNAL_LIST_UPDATE");
		
		-- Mark all previously completed quests.
		local version = GetAddOnMetadata("AllTheThings", "Version");
		GetQuestsCompleted(CompletedQuests);
		wipe(DirtyQuests);
		app:RegisterEvent("QUEST_LOG_UPDATE");
		app:RegisterEvent("QUEST_TURNED_IN");
		RefreshSaves();
		
		app.CacheFlightPathData();
		
		-- NOTE: The auto refresh only happens once.
		if not app.autoRefreshedCollections then
			app.autoRefreshedCollections = true;
			local lastTime = GetDataMember("RefreshedCollectionsAlready");
			if not lastTime or (lastTime ~= version) then
				SetDataMember("RefreshedCollectionsAlready", version);
				wipe(GetDataMember("CollectedSources", {}));	-- This option causes a caching issue, so we have to purge the Source ID data cache.
				RefreshCollections();
				return nil;
			end
		end
		app:RefreshData(false);
	end);
	LibStub:GetLibrary("LibDataBroker-1.1"):NewDataObject(L["TITLE"], {
		type = "launcher",
		icon = "Interface\\Addons\\AllTheThings\\assets\\logo_32x32",
		OnClick = MinimapButtonOnClick,
		OnEnter = MinimapButtonOnEnter,
		OnLeave = MinimapButtonOnLeave,
	});
end
app.events.ADDON_LOADED = function(addonName)
	if addonName == "Blizzard_AuctionUI" then
		app:UnregisterEvent("ADDON_LOADED");
		
		-- Create the Auction Tab for ATT.
		local n = AuctionFrame.numTabs + 1;
		local button = CreateFrame("Button", "AuctionFrameTab" .. n, AuctionFrame, "AuctionTabTemplate");
		button:SetID(n);
		button:SetText(L["AUCTION_TAB"]);
		button:SetPoint("LEFT", _G["AuctionFrameTab" .. n-1], "RIGHT", -8, 0);
		
		PanelTemplates_SetNumTabs (AuctionFrame, n);
		PanelTemplates_EnableTab  (AuctionFrame, n);
		
		-- Create the Auction Frame
		local frame = CreateFrame("FRAME", app:GetName() .. "-AuctionFrame", AuctionFrame );
		frame:SetPoint("TOPLEFT", AuctionFrame, 19, -67);
		frame:SetPoint("BOTTOMRIGHT", AuctionFrame, -8, 36);
		
		-- Create the movable Auction Data window.
		local window = app:GetWindow("AuctionData");
		window.shouldFullRefresh = true;
		window:SetParent(AuctionFrame);
		window:SetPoint("TOPLEFT", AuctionFrame, "TOPRIGHT", 0, -10);
		window:SetPoint("BOTTOMLEFT", AuctionFrame, "BOTTOMRIGHT", 0, 10);
		window.data = {
			["text"] = "Auction Module",
			["visible"] = true,
			["back"] = 1,
			["icon"] = "INTERFACE/ICONS/INV_Misc_Coin_01",
			["description"] = "This is a debug window for all of the auction data that was returned. Turn on 'Account Mode' to show items usable on any character on your account!",
			["options"] = {
				{
					["text"] = "Perform a Full Scan",
					["icon"] = "INTERFACE/ICONS/INV_DARKMOON_EYE",
					["description"] = "Click this button to perform a full scan of the auction house. This information will appear within this window and clear out the existing data.",
					["visible"] = true,
					["OnClick"] = function() 
						if AucAdvanced and AucAdvanced.API then AucAdvanced.API.CompatibilityMode(1, ""); end
					
						-- QueryAuctionItems(name, minLevel, maxLevel, page, isUsable, qualityIndex, getAll, exactMatch, filterData);
						if select(2, CanSendAuctionQuery()) then
							-- Disable the button and register for the event.
							frame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
							frame.descriptionLabel:SetText("Full Scan request sent.\n\nPlease wait while we wait for the server to respond.");
							frame.descriptionLabel:Show();
							QueryAuctionItems("", nil, nil, 0, nil, nil, true, false, nil);
						end
					end,
					['OnUpdate'] = function(data)
						data.visible = true;
					end,
				},
				{
					["text"] = "Toggle Debug Mode",
					["icon"] = "INTERFACE/ICONS/INV_Scarab_Crystal",
					["description"] = "Click this button to toggle debug mode to show everything regardless of filters!",
					["visible"] = true,
					["OnClick"] = function() 
						app.Settings:ToggleDebugMode();
					end,
					['OnUpdate'] = function(data)
						data.visible = true;
						if app.Settings:Get("DebugMode") then
							-- Novaplane made me do it
							data.trackable = true;
							data.saved = true;
						else
							data.trackable = nil;
							data.saved = nil;
						end
					end,
				},
				{
					["text"] = "Toggle Account Mode",
					["icon"] = "INTERFACE/ICONS/INV_Misc_Book_01",
					["description"] = "Turn this setting on if you want to track all of the Things for all of your characters regardless of class and race filters.\n\nUnobtainable filters still apply.",
					["visible"] = true,
					["OnClick"] = function() 
						app.Settings:ToggleAccountMode();
					end,
					['OnUpdate'] = function(data)
						data.visible = true;
						if app.Settings:Get("AccountMode") then
							data.trackable = true;
							data.saved = true;
						else
							data.trackable = nil;
							data.saved = nil;
						end
					end,
				},
				{
					["text"] = "Toggle Unobtainable Items",
					["icon"] = "INTERFACE/ICONS/INV_Misc_Book_01",
					["description"] = "Turn this setting on if you want to show Unobtainable items.",
					["visible"] = true,
					["OnClick"] = function()
						local val = app.GetDataMember("UnobtainableItemFilters");
						val[7] = not val[7];
						app.Settings:Refresh();
						app:RefreshData();
					end,
					['OnUpdate'] = function(data)
						data.visible = true;
						local val = app.GetDataMember("UnobtainableItemFilters");
						if val[7] then
							data.trackable = true;
							data.saved = true;
						else
							data.trackable = nil;
							data.saved = nil;
						end
					end,
				},
			},
			["g"] = {}
		};
		for i,option in ipairs(window.data.options) do
			table.insert(window.data.g, option);
		end
		window:Hide();
		
		-- Cache some functions to make them faster
		local _GetAuctionItemInfo, _GetAuctionItemLink = GetAuctionItemInfo, GetAuctionItemLink;
		local origSideDressUpFrameHide, origSideDressUpFrameShow = SideDressUpFrame.Hide, SideDressUpFrame.Show;
		SideDressUpFrame.Hide = function(...)
			origSideDressUpFrameHide(...);
			window:ClearAllPoints();
			window:SetPoint("TOPLEFT", AuctionFrame, "TOPRIGHT", 0, -10);
			window:SetPoint("BOTTOMLEFT", AuctionFrame, "BOTTOMRIGHT", 0, 10);
		end
		SideDressUpFrame.Show = function(...)
			origSideDressUpFrameShow(...);
			window:ClearAllPoints();
			window:SetPoint("LEFT", SideDressUpFrame, "RIGHT", 0, 0);
			window:SetPoint("TOP", AuctionFrame, "TOP", 0, -10);
			window:SetPoint("BOTTOM", AuctionFrame, "BOTTOM", 0, 10);
		end
		
		-- The ALL THE THINGS Epic Logo!
		local f = frame:CreateTexture(nil, "ARTWORK");
		f:SetATTSprite("base_36x36", 429, 141, 36, 36, 512, 256);
		f:SetPoint("BOTTOMLEFT", frame, "TOPLEFT", 72, 0);
		f:SetSize(36, 36);
		f:SetScale(0.8);
		f:Show();
		frame.logo = f;

		f = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		f:SetPoint("TOPLEFT", frame.logo, "TOPRIGHT", 4, -2);
		f:SetJustifyH("LEFT");
		f:SetText(L["TITLE"]);
		f:SetScale(1.5);
		f:Show();
		frame.title = f;
		
		f = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		f:SetPoint("CENTER", frame.title, "CENTER", 0, 0);
		f:SetPoint("RIGHT", frame, "RIGHT", -8, 0);
		f:SetJustifyH("RIGHT");
		f:SetText("Auction House Module");
		f:Show();
		frame.moduletitle = f;
		
		-- Settings Button
		f = CreateFrame("Button", nil, frame, "OptionsButtonTemplate");
		f:SetPoint("TOPLEFT", frame, "BOTTOMLEFT", 160, 0);
		f:SetText("Settings");
		f:SetWidth(120);
		f:SetHeight(22);
		f:RegisterForClicks("AnyUp");
		f:SetScript("OnClick", function() 
			-- Open the Settings Menu
			if InterfaceOptionsFrame:IsVisible() then
				InterfaceOptionsFrame_Show();
			else
				InterfaceOptionsFrame_OpenToCategory(app:GetName());
				InterfaceOptionsFrame_OpenToCategory(app:GetName());
			end
		end);
		f:SetATTTooltip("Click this button to toggle the settings menu.\n\nThe results displayed in this window will be filtered by your settings.");
		frame.settingsButton = f;
		
		-- Function to Update the State of the Scan button. (Coroutines, do not call manually.)
		local ObjectTypeMetas = {
			["criteriaID"] = setmetatable({	-- Achievements
				["npcID"] = -4,
				["description"] = "All items that can be used to obtain achievements that you are missing are displayed here.",
				["priority"] = 1,
			}, app.BaseNPC),
			["s"] = setmetatable({	-- Appearances
				["npcID"] = -10032,
				["description"] = "All appearances that you need are displayed here.",
				["priority"] = 2,
			}, app.BaseNPC),
			["mountID"] = setmetatable({	-- Mounts
				["filterID"] = 100,
				["description"] = "All mounts that you have not collected yet are displayed here.",
				["priority"] = 3,
			}, app.BaseFilter),
			["speciesID"] = setmetatable({	-- Pets
				["npcID"] = -25,
				["description"] = "All pets that you have not collected yet are displayed here.",
				["priority"] = 4,
			}, app.BaseNPC),
			["recipeID"] = setmetatable({	-- Recipes
				["filterID"] = 200,
				["description"] = "All recipes that you have not collected yet are displayed here.",
				["priority"] = 6,
			}, app.BaseFilter),
			["reagentID"] = {	-- Reagents
				["text"] = "Reagents",
				["icon"] = "Interface/ICONS/INV_Enchant_DustIllusion",
				["description"] = "All items that can be used to craft an item using a profession on your account.",
				["priority"] = 5,
			},
			["itemID"] = {	-- Non-Collectible Items
				["text"] = "Non-Collectible Items",
				["icon"] = "Interface/ICONS/ACHIEVEMENT_GUILDPERK_BARTERING",
				["description"] = "All items that can be used to earn other collectible items, but are not necessarily collectible themselves are displayed here.",
				["priority"] = 7,
			},
		};
		local UpdateScanButtonState = function()
			repeat
				if select(2, CanSendAuctionQuery()) then
					frame.scanButton:Enable();
					return true;
				else
					frame.scanButton:Disable();
					for i=0,60,1 do coroutine.yield(); end
				end
			until not frame:IsVisible();
		end
		local ProcessAuctionData = function()
			-- If we have no auction data, then simply return now.
			if not AllTheThingsAuctionData then return false; end
			local count = #AllTheThingsAuctionData;
			if count < 1 then return false; end
			
			-- Wait a second!
			for i=0,60,1 do coroutine.yield(); end
			
			-- Search the ATT Database for information related to the auction links (items, species, etc)
			local searchResultsByKey, searchResult, searchResults, key, keys, value, data = {};
			for i,itemLink in ipairs(AllTheThingsAuctionData) do
				searchResults = SearchForLink(itemLink);
				if searchResults and #searchResults > 0 then
					searchResult = searchResults[1];
					key = searchResult.key;
					if key == "npcID" then
						if searchResult.itemID then
							key = "itemID";
						end
					end
					value = searchResult[key];
					keys = searchResultsByKey[key];
					
					-- Make sure that the key type is represented.
					if not keys then
						keys = {};
						searchResultsByKey[key] = keys;
					end
					
					-- First time this key value was used.
					data = keys[value];
					if not data then
						data = CreateObject(searchResult);
						for i=2,#searchResults,1 do
							MergeObject(data, CreateObject(searchResults[i]));
						end
						if data.key == "npcID" then setmetatable(data, app.BaseItem); end
						data.auctions = {};
						keys[value] = data;
					end
					table.insert(data.auctions, itemLink);
				end
			end
			
			-- Move all achievementID-based items into criteriaID
			if searchResultsByKey.achievementID then
				local criteria = searchResultsByKey.criteriaID;
				if criteria then
					for key,entry in pairs(searchResultsByKey.achievementID) do
						criteria[key] = entry;
					end
				else
					searchResultsByKey.criteriaID = searchResultsByKey.achievementID;
				end
				searchResultsByKey.achievementID = nil;
			end
			
			-- Apply a sub-filter to items with spellID-based identifiers.
			if searchResultsByKey.spellID then
				local filteredItems = {};
				for key,entry in pairs(searchResultsByKey.spellID) do
					if entry.filterID then
						local filterData = filteredItems[entry.filterID];
						if not filterData then
							filterData = {};
							filteredItems[entry.filterID] = filterData;
						end
						filterData[key] = entry;
					else
						print("Spell " .. entry.spellID .. " (Item ID #" .. (entry.itemID or "???") .. " is missing a filterID?");
					end
				end
				
				if filteredItems[100] then searchResultsByKey.mountID = filteredItems[100]; end	-- Mounts
				if filteredItems[200] then searchResultsByKey.recipeID = filteredItems[200]; end	-- Recipes
				searchResultsByKey.spellID = nil;
			end
			
			if searchResultsByKey.s then
				local filteredItems = {};
				local cachedS = searchResultsByKey.s;
				searchResultsByKey.s = {};
				for sourceID,entry in pairs(cachedS) do
					if entry.f then
						local filterData = filteredItems[entry.f];
						if not filterData then
							filterData = setmetatable({ ["filterID"] = entry.f, ["g"] = {} }, app.BaseFilter);
							filteredItems[entry.f] = filterData;
							table.insert(searchResultsByKey.s, filterData);
						end
						table.insert(filterData.g, entry);
					end
				end
				for f,entry in pairs(filteredItems) do
					table.sort(entry.g, function(a,b)
						return a.u and not b.u;
					end);
				end
			end
			
			-- Process the Non-Collectible Items for Reagents
			local reagentCache = app.GetDataMember("Reagents");
			if reagentCache and searchResultsByKey.itemID then
				local cachedItems = searchResultsByKey.itemID;
				searchResultsByKey.itemID = {};
				searchResultsByKey.reagentID = {};
				for itemID,entry in pairs(cachedItems) do
					if reagentCache[itemID] then
						searchResultsByKey.reagentID[itemID] = entry;
						if not entry.g then entry.g = {}; end
						for itemID2,count in pairs(reagentCache[itemID][2]) do
							local searchResults = app.SearchForField("itemID", itemID2);
							if searchResults and #searchResults > 0 then
								table.insert(entry.g, CloneData(searchResults[1]));
							end
						end
					else
						-- Push it back into the itemID table
						searchResultsByKey.itemID[itemID] = entry;
					end
				end
			end
			
			-- Insert Buttons into the groups.
			wipe(window.data.g);
			for i,option in ipairs(window.data.options) do
				table.insert(window.data.g, option);
			end
			
			-- Display Test for Raw Data + Filtering
			for key, searchResults in pairs(searchResultsByKey) do
				local subdata = {};
				subdata.visible = true;
				if ObjectTypeMetas[key] then
					setmetatable(subdata, { __index = ObjectTypeMetas[key] });
				else
					subdata.description = "Container for '" .. key .. "' object types.";
					subdata.text = key;
				end
				subdata.g = {};
				for i,j in pairs(searchResults) do
					table.insert(subdata.g, j);
				end
				table.insert(window.data.g, subdata);
			end
			table.sort(window.data.g, function(a, b)
				return (b.priority or 0) > (a.priority or 0);
			end);
			BuildGroups(window.data, window.data.g);
			UpdateGroups(window.data, window.data.g);
			window:Show();
			window:Update();
			
			-- Change the message!
			frame.descriptionLabel:SetText("Got the datas!\n\nShift Left click into the search bar on the Browse tab to look for items!");
			frame.descriptionLabel:Show();
		end
		local ProcessAuctions = function()
			-- Gather the Auctions
			AllTheThingsAuctionData = {};
			app.CurrentAuctionIndex = 1;
			if app.CurrentAuctionIndex <= app.CurrentAuctionTotal then
				local iter = 0;
				repeat
					-- Process the Auction
					local link = _GetAuctionItemLink("list", app.CurrentAuctionIndex);
					if link then
						table.insert(AllTheThingsAuctionData, link);
					else
						local name, texture, count, quality, canUse, level, levelColHeader, minBid,
							minIncrement, buyoutPrice, bidAmount, highBidder, bidderFullName, owner,
							ownerFullName, saleStatus, itemID, hasAllInfo = _GetAuctionItemInfo("list", app.CurrentAuctionIndex);
						if itemID and itemID > 0 and saleStatus == 0 then
							table.insert(AllTheThingsAuctionData, "item:" .. itemID);
						end
					end
					
					-- Increment the index and check the iteration variable.
					iter = iter + 1;
					if iter >= 10000 then
						coroutine.yield();
						iter = 0;
					end
					app.CurrentAuctionIndex = app.CurrentAuctionIndex + 1;
				until app.CurrentAuctionIndex > app.CurrentAuctionTotal;
			else
				return false;
			end
			
			-- Process the items
			app.CurrentAuctionIndex = 0;
			app.CurrentAuctionTotal = 0;
			StartCoroutine("ProcessAuctionData", ProcessAuctionData);
		end
		
		-- Scan Button
		f = CreateFrame("Button", nil, frame, "OptionsButtonTemplate");
		f:SetPoint("TOPLEFT", frame.settingsButton, "TOPRIGHT", 2, 0);
		f:SetPoint("BOTTOMLEFT", frame.settingsButton, "BOTTOMRIGHT", 2, 0);
		f:SetText("Scan");
		f:SetWidth(120);
		f:RegisterForClicks("AnyUp");
		f:SetScript("OnClick", function()
			if AucAdvanced and AucAdvanced.API then AucAdvanced.API.CompatibilityMode(1, ""); end
		
			-- QueryAuctionItems(name, minLevel, maxLevel, page, isUsable, qualityIndex, getAll, exactMatch, filterData);
			local CanQuery, CanQueryAll = CanSendAuctionQuery();
			if CanQueryAll then
				-- Disable the button and register for the event.
				frame.scanButton:Disable();
				frame:RegisterEvent("AUCTION_ITEM_LIST_UPDATE");
				frame.descriptionLabel:SetText("Full Scan request sent.\n\nPlease wait while we wait for the server to respond.");
				frame.descriptionLabel:Show();
				QueryAuctionItems("", nil, nil, 0, nil, nil, true, false, nil);
			else
				return false;
			end
			
			-- Update the Scan Button State
			StartCoroutine("UpdateScanButtonState", UpdateScanButtonState);
		end);
		f:SetATTTooltip("Click this button to scan the auction house for collectible Things.\n\nIf you have \"Live Scan\" checked, this will do a scan through common collectible categories using Live data rather than a more efficient Full Scan.\n\nFull Scans have an internal 15 minute cooldown if you invalidate the cache by reloading your UI.");
		frame.scanButton = f;
		f = frame.scanButton:CreateTexture(nil, "BORDER");
		f:SetPoint("TOPRIGHT", frame.scanButton, "TOPLEFT", 6, 1);
		f:SetTexture("Interface\\FrameGeneral\\UI-Frame");
		f:SetTexCoord(0.00781250,0.10937500,0.75781250,0.95312500);
		f:SetSize(13, 25);
		f:Show();
		f = frame.scanButton:CreateTexture(nil, "BORDER");
		f:SetPoint("TOPLEFT", frame.scanButton, "TOPRIGHT", -6, 1);
		f:SetTexture("Interface\\FrameGeneral\\UI-Frame");
		f:SetTexCoord(0.00781250,0.10937500,0.75781250,0.95312500);
		f:SetSize(13, 25);
		f:Show();
		
		-- Close Button
		f = CreateFrame("Button", nil, frame, "OptionsButtonTemplate");
		f:SetPoint("TOPRIGHT", frame, "BOTTOMRIGHT", 0, 0);
		f:SetText("Close");
		f:SetWidth(80);
		f:SetHeight(22);
		f:RegisterForClicks("AnyUp");
		f:SetScript("OnClick", CloseAuctionHouse);
		frame.closeButton = f;
		f = frame.closeButton:CreateTexture(nil, "BORDER");
		f:SetPoint("TOPRIGHT", frame.closeButton, "TOPLEFT", 5, 1);
		f:SetTexture("Interface\\FrameGeneral\\UI-Frame");
		f:SetTexCoord(0.00781250,0.10937500,0.75781250,0.95312500);
		f:SetSize(13, 25);
		f:Show();
		
		f = frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
		f:SetPoint("CENTER", frame, "CENTER", 0, 0);
		f:SetText("No Auction Data.\n\nPress 'Scan' to ask the server for information.");
		f:SetTextColor(1, 1, 1, 1);
		f:SetJustifyH("CENTER");
		f:Show();
		frame.descriptionLabel = f;
		
		-- Register for Events [Only when requests sent by ATT]
		frame:SetScript("OnEvent", function(self, e, ...)
			local numItems = GetNumAuctionItems("list");
			if numItems > 0 then
				-- Unregister, then begin processing the Auction Item List
				self:UnregisterEvent("AUCTION_ITEM_LIST_UPDATE");
				app.CurrentAuctionTotal = numItems;
				app.CurrentAuctionIndex = 0;
				frame.descriptionLabel:SetText("Scan data received. Found " .. numItems .. " auctions.\n\nPlease wait while we determine how useful they all are.");
				frame.descriptionLabel:Show();
				StartCoroutine("ProcessAuctions", ProcessAuctions);
			end
		end);
		hooksecurefunc("AuctionFrameTab_OnClick", function(self)
			-- print("AuctionFrameTab_OnClick", self:GetID());
			if self:GetID() == n then
				--Default AH textures
				AuctionFrameTopLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-TopLeft");
				AuctionFrameTop:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Top");
				AuctionFrameTopRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-TopRight");
				AuctionFrameBotLeft:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotLeft");
				AuctionFrameBot:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Auction-Bot");
				AuctionFrameBotRight:SetTexture("Interface\\AuctionFrame\\UI-AuctionFrame-Bid-BotRight");
				StartCoroutine("UpdateScanButtonState", UpdateScanButtonState);
				if not self.InitialProcess then
					StartCoroutine("ProcessAuctionData", ProcessAuctionData);
					self.InitialProcess = true;
				else
					window:Show();
				end
				
				frame:Show();
			else
				frame:Hide();
			end
		end);
	end
end
app.events.ACTIVE_TALENT_GROUP_CHANGED = function()
	app.Spec = GetLootSpecialization();
	if not app.Spec or app.Spec == 0 then app.Spec = select(1, GetSpecializationInfo(GetSpecialization())); end
end
app.events.PLAYER_LOOT_SPEC_UPDATED = function()
	app.Spec = GetLootSpecialization();
	if not app.Spec or app.Spec == 0 then app.Spec = select(1, GetSpecializationInfo(GetSpecialization())); end
end
app.events.PLAYER_LEVEL_UP = function(newLevel)
	app.Level = newLevel;
	app:UpdateWindows();
	app.Settings:Refresh();
end
app.events.BOSS_KILL = function(id, name, ...)
	-- This is so that when you kill a boss, you can trigger 
	-- an automatic update of your saved instance cache. 
	-- (It does lag a little, but you can disable this if you want.)
	-- Waiting until the LOOT_CLOSED occurs will prevent the failed Auto Loot bug.
	-- print("BOSS_KILL", id, name, ...);
	app:UnregisterEvent("LOOT_CLOSED");
	app:RegisterEvent("LOOT_CLOSED");
end
app.events.LOOT_CLOSED = function()
	-- Once the loot window closes after killing a boss, THEN trigger the update.
	app:UnregisterEvent("LOOT_CLOSED");
	app:UnregisterEvent("UPDATE_INSTANCE_INFO");
	app:RegisterEvent("UPDATE_INSTANCE_INFO");
	RequestRaidInfo();
end
app.events.UPDATE_INSTANCE_INFO = function()
	-- We got new information, not refresh the saves. :D
	app:UnregisterEvent("UPDATE_INSTANCE_INFO");
	RefreshSaves();
end
app.events.COMPANION_LEARNED = function(...)
	--print("COMPANION_LEARNED", ...);
	RefreshMountCollection();
end
app.events.COMPANION_UNLEARNED = function(...)
	--print("COMPANION_UNLEARNED", ...);
	RefreshMountCollection();
end
app.events.HEIRLOOMS_UPDATED = function(itemID, kind, ...)
	if itemID then
		app:RefreshData(false, true);
		app:PlayFanfare();
		wipe(searchCache);
		collectgarbage();
		
		if app.Settings:GetTooltipSetting("Report:Collected") then
			local name, link = GetItemInfo(itemID);
			if link then print(format(L["ITEM_ID_ADDED_RANK"], link, itemID, (select(5, C_Heirloom.GetHeirloomInfo(itemID)) or 1))); end
		end
	end
end
app.events.QUEST_TURNED_IN = function(questID)
	GetQuestsCompleted(CompletedQuests);
	CompletedQuests[questID] = true;
	for questID,completed in pairs(DirtyQuests) do
		app.QuestCompletionHelper(tonumber(questID));
	end
	wipe(DirtyQuests);
end
app.events.QUEST_LOG_UPDATE = function()
	GetQuestsCompleted(CompletedQuests);
	for questID,completed in pairs(DirtyQuests) do
		app.QuestCompletionHelper(tonumber(questID));
	end
	wipe(DirtyQuests);
	app:UnregisterEvent("QUEST_LOG_UPDATE");
end
app.events.PET_BATTLE_OPENING_START = function(...)
	local mini = app:GetWindow("CurrentInstance");
	local main = app:GetWindow("Prime");
		if mini:IsVisible() then
			mini:Toggle();
			app.miniVis = true;
		end
		if main:IsVisible() then
			main:Toggle();
			app.mainVis = true;
		end
end
app.events.PET_BATTLE_CLOSE = function(...)
	if app.miniVis then 
		app:ToggleMiniListForCurrentZone() 
		app.miniVis = false;
	end
	if app.mainVis then 
		app:ToggleMainList() 
		app.mainVis = false;
	end
end
app.events.TOYS_UPDATED = function(itemID, new)
	if itemID and not GetDataSubMember("CollectedToys", itemID) then
		SetDataSubMember("CollectedToys", itemID, true);
		app:RefreshData(false, true);
		app:PlayFanfare();
		wipe(searchCache);
		collectgarbage();
		
		if app.Settings:GetTooltipSetting("Report:Collected") then
			local name, link = GetItemInfo(itemID);
			if link then print(format(L["ITEM_ID_ADDED"], link, itemID)); end
		end
	end
end
app.events.TRANSMOG_COLLECTION_SOURCE_ADDED = function(sourceID)
	if sourceID then
		-- Cache the previous state. This will help keep lag under control.
		local oldState = GetDataSubMember("CollectedSources", sourceID) or 0;
		
		-- Only do work if we weren't already learned.
		-- We check here because Blizzard likes to double notify for items with timers.
		if oldState ~= 1 then
			SetDataSubMember("CollectedSources", sourceID, 1);
			app.ActiveItemCollectionHelper(sourceID, oldState);
			app:PlayFanfare();
			wipe(searchCache);
			collectgarbage();
		end
	end
end
app.events.TRANSMOG_COLLECTION_SOURCE_REMOVED = function(sourceID)
	if sourceID and GetDataSubMember("CollectedSources", sourceID) then
		local sourceInfo = C_TransmogCollection_GetSourceInfo(sourceID);
		SetDataSubMember("CollectedSources", sourceID, nil);
		
		-- If the user is a Completionist
		if app.Settings:Get("Completionist") then
			if app.Settings:GetTooltipSetting("Report:Collected") then
				-- Oh shucks, that was nice of you to give this item to your friend.
				-- WAIT, WHAT? A VENDOR?! OH GOD NO! TODO: Warn a user when they vendor an appearance?
				local name, link = GetItemInfo(sourceInfo.itemID);
				print(format(L["ITEM_ID_REMOVED"], link or name or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), sourceInfo.itemID));
			end
		else
			local shared = 0;
			local categoryID, appearanceID, canEnchant, texture, isCollected, itemLink = C_TransmogCollection_GetAppearanceSourceInfo(sourceID);
			if categoryID then
				for i, otherSourceID in ipairs(C_TransmogCollection_GetAllAppearanceSources(appearanceID)) do
					if GetDataSubMember("CollectedSources", otherSourceID) then
						local otherSourceInfo = C_TransmogCollection_GetSourceInfo(otherSourceID);
						if not otherSourceInfo.isCollected and otherSourceInfo.categoryID == categoryID then
							SetDataSubMember("CollectedSources", otherSourceID, nil);
							shared = shared + 1;
						end
					end
				end
			end
			
			if app.Settings:GetTooltipSetting("Report:Collected") then
				-- Oh shucks, that was nice of you to give this item to your friend.
				-- WAIT, WHAT? A VENDOR?! OH GOD NO! TODO: Warn a user when they vendor an appearance?
				local name, link = GetItemInfo(sourceInfo.itemID);
				print(format(L[shared > 0 and "ITEM_ID_REMOVED_SHARED" or "ITEM_ID_REMOVED"], link or name or ("|cffff80ff|Htransmogappearance:" .. sourceID .. "|h[Source " .. sourceID .. "]|h|r"), sourceInfo.itemID, shared));
			end
		end
		
		-- Refresh the Data and Cry!
		app:RefreshData(false, true);
		app:PlayRemoveSound();
		wipe(searchCache);
		collectgarbage();
	end
end