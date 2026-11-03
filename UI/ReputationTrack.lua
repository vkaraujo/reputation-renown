local addon = ReputationRenown
local Utils = addon.UIUtils

local BUTTON_WIDTH = 162
local BUTTON_HEIGHT = 68
local BUTTON_SPACING = 178

local COLORS = {
    unlocked = { 0.31, 0.26, 0.16, 1 },
    locked = { 0.15, 0.16, 0.16, 1 },

    unlockedText = { 1, 0.85, 0.55, 1 },
    lockedText = { 0.6, 0.6, 0.6, 1 },
    selectedText = { 0.1, 0.08, 0.05, 1 },
}

function addon:CreateReputationTrack(parent, onTierSelected)
  local track = CreateFrame("Frame", nil, parent)

  track:SetSize(700, BUTTON_HEIGHT)
  track:SetPoint( "TOPLEFT", parent, "TOPLEFT", 67, -202 )

  track.buttons = {}

  for index, tier in ipairs(self.TIERS) do
    local button = CreateFrame("Button", nil, track)

    button:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)

    button:SetPoint( "TOPLEFT", track, "TOPLEFT", (index - 1) * BUTTON_SPACING, 0 )

    -- Button background
    local background = button:CreateTexture( nil, "BACKGROUND" )

    background:SetAllPoints()

    -- Reputation icon
    local icon = button:CreateTexture( nil, "ARTWORK" )

    icon:SetSize(26, 26)
    icon:SetPoint("TOP", button, "TOP", 0, -5)

    -- Reputation name
    local label = Utils.MakeText( button, "GameFontNormal", self.TIER_NAMES[tier], "BOTTOM", button, 0, 9 )

    button.background = background
    button.icon = icon
    button.label = label

    button:SetScript("OnClick", function()
        if onTierSelected then
            onTierSelected(tier)
        end
    end)

    track.buttons[tier] = button
  end

  return track
end

function addon:UpdateReputationTrack( track, faction, standing, selectedTier )
  local theme = faction.theme

  for tier, button in pairs(track.buttons) do
    local selected = tier == selectedTier

    local unlocked = self:IsTierUnlocked( tier, standing )

    -- Update faction-specific icon
    button.icon:SetTexture( theme.tierTextures[tier] )

    if selected then
      Utils.SetColor( button.background, theme.accent )

      button.label:SetTextColor( unpack(COLORS.selectedText) )
    elseif unlocked then
      Utils.SetColor( button.background, COLORS.unlocked )

      button.label:SetTextColor( unpack(COLORS.unlockedText) )
    else
      Utils.SetColor( button.background, COLORS.locked )

      button.label:SetTextColor( unpack(COLORS.lockedText) )
    end
  end
end
