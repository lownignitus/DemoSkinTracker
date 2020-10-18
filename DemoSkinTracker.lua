-- Title: Demonology Skin Tracker
-- Author: LownIgnitus
-- Version: 1.0.7
-- Desc: Addon to track heads collected for demonology artifact skin

CF = CreateFrame
local addon_name = "DemoSkinTracker"
local head1 = {["name"] = "Damaged Eredar Head", ["id"] = 140661, ["number"] = 1, ["quest"] = 44093}
local head2 = {["name"] = "Deformed Eredar Head", ["id"] = 140662, ["number"] = 2, ["quest"] = 44094}
local head3 = {["name"] = "Malformed Eredar Head", ["id"] = 140663, ["number"] = 3, ["quest"] = 44095}
local head4 = {["name"] = "Deficient Eredar Head", ["id"] = 140664, ["number"] = 4, ["quest"] = 44096}
local head5 = {["name"] = "Nearly Satisfactory Eredar Head", ["id"] = 140665, ["number"] = 5, ["quest"] = 44097}
local artifactSkin = {["name"] = "Visage of the First Wakener", ["id"] = 139576}
local headCount = 0
local elapsedTime = 0.0
SLASH_DEMOSKINTRACKER1 = "/dst" or "/DST" or "/DemoSkinTracker" or "/demoskintracker" or "/DemonologySkinTracker" or "/demonologyskintracker"

-- Defaults
local defaults = {
	["options"] = {
		["dstActivate"] = true,
	},
	["saves"] = {
		["head1Save"] = false,
		["head2Save"] = false,
		["head3Save"] = false,
		["head4Save"] = false,
		["head5Save"] = false,
		["artifactSkinSave"] = false,
	},
}

-- RegisterForEvent table
local dstEvents_table = {}

dstEvents_table.eventFrame = CF("Frame");
dstEvents_table.eventFrame:RegisterEvent("BAG_UPDATE");
dstEvents_table.eventFrame:RegisterEvent("PLAYER_LOGIN")
dstEvents_table.eventFrame:SetScript("OnEvent", function(self, event, ...)
	dstEvents_table.eventFrame[event](self, ...);
end);

function dstEvents_table.eventFrame:ADDON_LOADED(AddOn)
	if AddOn ~= addon_name then
		return -- not my addon
	end
	--print("AddOn")
	-- unregister ADDON_LOADED
	dstEvents_table.eventFrame:UnregisterEvent("ADDON_LOADED")


	local function dstSVCheck(src, dst)
		if type(src) ~= "table" then return {} end
		if type(dst) ~= "table" then dst = {} end
		for k, v in pairs(src) do
			if type(v) == "table" then
				dst[k] = dstSVCheck(v,dst[k])
			elseif type(v) ~= type(dst[k]) then
				dst[k] = v
			end
		end
		return dst
	end

	dstSettings = dstSVCheck(defaults, dstSettings)
	dstOptionsInit();
end

function dstOptionsInit()
	--
end

function dstInitialize()
	--print("dstInitialize")
	headCount = 0
	if dstSettings.saves.head1Save == false or dstSettings == nil then
		--headCount = 0
		--print("HeadCount: " .. headCount)
	else
		headCount = headCount + 1 -- 1
		--print("HeadCount: " .. headCount)
		if dstSettings.saves.head2Save == false then
			--
		else
			headCount = headCount + 1 -- 2
			--print("HeadCount: " .. headCount)
			if dstSettings.saves.head3Save == false then
				--
			else
				headCount = headCount + 1 --3
				--print("HeadCount: " .. headCount)
				if dstSettings.saves.head5Save == false then
					--
				else
					headCount = headCount + 1 --4
					--print("HeadCount: " .. headCount)
					if dstSettings.saves.head5Save == false then
						--
					else
						headCount = headCount + 1 -- 5
						--print("HeadCount: " .. headCount)
						if dstSettings.saves.artifactSkinSave == false then
							--
						else
							headCount = headCount + 1
						end
					end
				end
			end
		end
		if headCount ~= 6 then
			print("|cff9482C9You have collected |r|cffe6cc80" .. headCount .. "|r|cff9482C9 heads for the Demonology hidden skin.|r")
		elseif headCount == 6 then
			print("|cff9482C9You have already collected |r|cffe6cc80" .. artifactSkin.name .. "|r|cff9482C9! Enjoy your game!")
		end
	end
end

function dstEvents_table.eventFrame:PLAYER_LOGIN()
	local class, className = UnitClass("player")
	--print(className)
	if className == "WARLOCK" then
		if not dstSettings then
			local function dstSVCheck(src, dst)
				if type(src) ~= "table" then return {} end
				if type(dst) ~= "table" then dst = {} end
				for k, v in pairs(src) do
					if type(v) == "table" then
						dst[k] = dstSVCheck(v,dst[k])
					elseif type(v) ~= type(dst[k]) then
						dst[k] = v
					end
				end
				return dst
			end

			dstSettings = dstSVCheck(defaults, dstSettings)
		end
		dstInitialize();
		dstQuestCheck()
	else
		--
	end
end

local messageFrame = CF("MessageFrame", "dstMessageFrame", UIParent)
messageFrame:SetFrameStrata("BACKGROUND")
messageFrame:SetPoint("CENTER", UIParent, "CENTER", 0, 150)
messageFrame:SetWidth(300)
messageFrame:SetHeight(20)
local fontString = messageFrame:CreateFontString(nil, "ARTWORK", "BossEmoteNormalHuge")
fontString:SetPoint("CENTER", messageFrame, "CENTER", 0, 0)

function dstQuestCheck()
	if IsQuestFlaggedCompleted(head1.quest) == false then
		--fontString:SetText("|cff9482C9You just found the |r|cffe6cc80" .. artifactSkin.name .. "|r|cff9482C9!|r")
		--print("|cff9482C9You just found the |r|cffe6cc80" .. artifactSkin.name .. "|r|cff9482C9! Enjoy your new skin!|r")
	else
		if dstSettings.saves.head1Save == true then
			--
		else
			fontString:SetText("|cff9482C9You just found Head |r" .. head1.number .. "|cff9482C9: |r|cffe6cc80" .. head1.name .. "|r|cff9482C9!|r")
			print("|cff9482C9You just found Head |r" .. head1.number .. "|cff9482C9: |r|cffe6cc80" .. head1.name .. "|r|cff9482C9!|r")
			dstSettings.saves.head1Save = true
		end

		if IsQuestFlaggedCompleted(head2.quest) == false then
			--
		else
			if dstSettings.saves.head2Save == true then
				--
			else
				print("|cff9482C9You just found Head |r" .. head2.number .. "|cff9482C9: |r|cffe6cc80" .. head2.name .. "|r|cff9482C9!|r")
				dstSettings.saves.head2Save = true
			end

			if IsQuestFlaggedCompleted(head3.quest) == false then
				--
			else
				if dstSettings.saves.head3Save == true then
					--
				else
					fontString:SetText("|cff9482C9You just found Head |r" .. head3.number .. "|cff9482C9: |r|cffe6cc80" .. head3.name .. "|r|cff9482C9!|r")
					print("|cff9482C9You just found Head |r" .. head3.number .. "|cff9482C9: |r|cffe6cc80" .. head3.name .. "|r|cff9482C9!|r")
					dstSettings.saves.head3Save = true
				end

				if IsQuestFlaggedCompleted(head4.quest) == false then
					--
				else
					if dstSettings.saves.head4Save == true then
						--
					else
						fontString:SetText("|cff9482C9You just found Head |r" .. head4.number .. "|cff9482C9: |r|cffe6cc80" .. head4.name .. "|r|cff9482C9!|r")
						print("|cff9482C9You just found Head |r" .. head4.number .. "|cff9482C9: |r|cffe6cc80" .. head4.name .. "|r|cff9482C9!|r")
						dstSettings.saves.head4Save = true
					end

					if IsQuestFlaggedCompleted(head5.quest) == false then
						--
					else
						if dstSettings.saves.head5Save == true then
							--
						else
							fontString:SetText("|cff9482C9You just found Head |r" .. head5.number .. "|cff9482C9: |r|cffe6cc80" .. head5.name .. "|r|cff9482C9!|r")
							print("|cff9482C9You just found Head |r" .. head5.number .. "|cff9482C9: |r|cffe6cc80" .. head5.name .. "|r|cff9482C9!|r")
							dstSettings.saves.head5Save = true
						end

						if dstSettings.saves.artifactSkinSave == true then
							--
						else
							local count = GetItemCount(artifactSkin.id)
							if count ~= 1 then
								--
							elseif count == 1 then
								fontString:SetText("|cff9482C9You just found the |r|cffe6cc80" .. artifactSkin.name .. "|r|cff9482C9!|r")
								print("|cff9482C9You just found the |r|cffe6cc80" .. artifactSkin.name .. "|r|cff9482C9! Enjoy your new skin!|r")
								dstSettings.saves.artifactSkinSave = true
							end
						end
					end
				end
			end
		end
	end

	messageFrame:SetScript("OnUpdate", dstTime_OnUpdate)
end

function dstTime_OnUpdate(self, elapsed)
	elapsedTime = elapsedTime + elapsed
	if elapsedTime >= 6 then
		messageFrame:SetScript("OnUpdate", nil)
		elapsedTime = 0.0
		fontString:SetText(" ")
	end
end

function dstEvents_table.eventFrame:BAG_UPDATE(number, containerID)
	--print("Bag Update. number: " .. number .. ".")
	local class, className = UnitClass("player")
	if className == "WARLOCK" then
		dstQuestCheck()
	else
		--
	end
end


function SlashCmdList.DEMOSKINTRACKER(msg)
	if msg == "toggle" then
		--
	elseif msg == "test" then
		dstQuestCheck()
	elseif msg == "check" then
		dstInitialize()
	else
		print("|cff9482C9Thank you for using |r" .. GetAddOnMetadata(addon_name, "Title") .. " " .. GetAddOnMetadata(addon_name, "Version"))
		print("|cff9482C9Author: |r" .. GetAddOnMetadata(addon_name, "Author"))
		print("|cff9482C9Type and of the following keywords after /DST:|r")
		print("|cff9482C9  -- check to see current head count|r")
	end

end