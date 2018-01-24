-- greeting
print('TunnelVision loaded! Automatically hiding chat and quest tracking when you enter the arena')

local frame = CreateFrame("FRAME","TunnelVision")

-- subs
local function hide()
  DEFAULT_CHAT_FRAME:Hide()

  for i = 1, NUM_CHAT_WINDOWS do
    local f = _G["ChatFrame" ..i]
    if f then f.Hide() end
  end

  ObjectiveTrackerFrame:Hide()
  GeneralDockManager:Hide()
  ChatFrameMenuButton:Hide()
  FriendsMicroButton:Hide()
end

local function show()
  ObjectiveTrackerFrame:Show()
  GeneralDockManager:Show()
  ChatFrameMenuButton:Show()
  FriendsMicroButton:Show()

  DEFAULT_CHAT_FRAME:Show()

  for i = 1, NUM_CHAT_WINDOWS do
    local f = _G["ChatFrame"..i.."Tab"]
    if f then
        if i == 1 then
          f:Show()
        else
          f:Hide()
        end
    end
  end
end

-- onchange
frame:RegisterEvent("ZONE_CHANGED")
frame:RegisterEvent("WORLD_MAP_UPDATE")
frame:RegisterEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterEvent("ZONE_CHANGED_INDOORS")

local function zone_change(self,event,...)
  local is_arena = false
  if GetZonePVPInfo() == 'arena' then is_arena = true end

  if is_arena then
    hide()
  else
    show()
  end
end

frame:SetScript("OnEvent",zone_change)

