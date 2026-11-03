local addon = ReputationRenown
local Utils = addon.UIUtils

local WINDOW_WIDTH = 850
local WINDOW_HEIGHT = 565

-- Currently displayed faction
addon.selectedFaction = "timbermaw"

-- Currently selected reward tier
addon.selectedTier = "friendly"

function addon:CreateReputationFrame()
  if self.frame then
    return self.frame
  end

  local faction = self:GetFaction(self.selectedFaction)

  if not faction then
    return nil
  end

  local frame = CreateFrame( "Frame", "ReputationRenownFrame", UIParent, "BackdropTemplate" )

  -- Main window configuration
  frame:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
  frame:SetPoint("CENTER")
  frame:SetFrameStrata("DIALOG")
  frame:SetClampedToScreen(true)

  -- Allow dragging
  frame:SetMovable(true)
  frame:EnableMouse(true)
  frame:RegisterForDrag("LeftButton")

  frame:SetScript("OnDragStart", function(self)
    self:StartMoving()
  end)

  frame:SetScript("OnDragStop", function(self)
    self:StopMovingOrSizing()
  end)

  -- Window border
  frame:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 18, })

  -- Window background
  local background = frame:CreateTexture( nil, "BACKGROUND" )

  background:SetAllPoints()

  -- Close button
  local closeButton = CreateFrame( "Button", nil, frame, "UIPanelCloseButton" )

  closeButton:SetPoint( "TOPRIGHT", frame, "TOPRIGHT", -3, -3 )

  -- Create UI components
  local header = self:CreateFactionHeader(frame)

  local track = self:CreateReputationTrack(
    frame,
    function(tier)
      addon:SelectTier(tier)
    end
  )

  local rewards = self:CreateRewardList(frame)

  -- Store component references
  self.frame = frame
  self.ui = {
    background = background,
    header = header,
    track = track,
    rewards = rewards,

    -- Compatibility with item-loading event handler
    rewardCards = rewards.cards,
  }

  -- Initialize interface
  self:UpdateReputationFrame()

  frame:Hide()

  return frame
end

function addon:GetCurrentReputation()
  -- Temporary implementation until WoW API integration
  return { standing = self.mockStanding, current = self.mockProgress, maximum = self.mockMaximum, isMock = true, }
end

function addon:UpdateReputationFrame()
  if not self.frame or not self.ui then
    return
  end

  local faction = self:GetFaction(self.selectedFaction)

  if not faction then
    return
  end

  local reputation = self:GetCurrentReputation()
  local theme = faction.theme

  -- Update window appearance
  Utils.SetColor( self.ui.background, theme.background )

  self.frame:SetBackdropBorderColor( unpack(theme.border) )

  -- Update faction header
  self:UpdateFactionHeader( self.ui.header, faction, reputation )

  -- Update reputation progression
  self:UpdateReputationTrack( self.ui.track, faction, reputation.standing, self.selectedTier )

  -- Update rewards
  self:UpdateRewardList( self.ui.rewards, faction, self.selectedTier, reputation.standing )
end

function addon:SelectTier(tier)
  if self:GetTierIndex(tier) == 0 then
      return
  end

  self.selectedTier = tier

  self:UpdateReputationFrame()
end

function addon:SelectFaction(factionKey)
  local faction = self:GetFaction(factionKey)

  if not faction then
      return false
  end

  self.selectedFaction = factionKey
  self.selectedTier = "friendly"

  self:UpdateReputationFrame()

  return true
end

function addon:ToggleReputationFrame()
  local frame = self:CreateReputationFrame()

  if not frame then
    return
  end

  if frame:IsShown() then
    frame:Hide()
  else
    self:UpdateReputationFrame()
    frame:Show()
  end
end
