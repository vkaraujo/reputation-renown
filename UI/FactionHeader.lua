local addon = ReputationRenown
local Utils = addon.UIUtils

local PROGRESS_WIDTH = 350

function addon:CreateFactionHeader(parent)
  local header = CreateFrame("Frame", nil, parent)

  header:SetSize(780, 170)
  header:SetPoint("TOP", parent, "TOP", 0, -20)

  -- Faction emblem
  local emblem = header:CreateTexture(nil, "ARTWORK")
  emblem:SetSize(55, 55)
  emblem:SetPoint("TOPLEFT", header, "TOPLEFT", 0, -5)

  -- Faction name
  local title = Utils.MakeText( header, "GameFontNormalHuge", "", "TOP", header, 0, -10 )

  -- Faction description
  local subtitle = header:CreateFontString( nil, "OVERLAY", "GameFontHighlight" )

  subtitle:SetPoint("TOP", title, "BOTTOM", 0, -8)
  subtitle:SetWidth(650)
  subtitle:SetJustifyH("CENTER")

  -- Current reputation standing
  local standing = Utils.MakeText( header, "GameFontNormal", "", "TOP", header, 0, -89 )

  -- Progress background
  local progress = Utils.MakePanel( header, PROGRESS_WIDTH, 13, "TOP", header, "TOP", 0, -119, { 0.19, 0.20, 0.18, 1 } )

  -- Progress fill
  local fill = progress:CreateTexture(nil, "ARTWORK")

  fill:SetPoint("TOPLEFT", progress, "TOPLEFT", 0, 0)
  fill:SetPoint("BOTTOMLEFT", progress, "BOTTOMLEFT", 0, 0)
  fill:SetWidth(1)

  -- Progress label
  local progressText = Utils.MakeText( header, "GameFontHighlightSmall", "", "TOP", header, 0, -137 )

  -- Store references for later updates
  header.emblem = emblem
  header.title = title
  header.subtitle = subtitle
  header.standing = standing
  header.progressFill = fill
  header.progressText = progressText

  return header
end

function addon:UpdateFactionHeader(header, faction, reputation)
  local theme = faction.theme

  -- Faction information
  header.title:SetText(faction.name)
  header.subtitle:SetText(faction.description or "")
  header.emblem:SetTexture(theme.emblemTexture)

  -- Current standing
  local standingName = self.TIER_NAMES[reputation.standing] or "Unknown"

  local suffix = reputation.isMock and " (mock)" or ""

  header.standing:SetText( "Current standing: " .. standingName .. suffix )

  -- Progress calculation
  local current = reputation.current or 0
  local maximum = reputation.maximum or 0

  local percentage = 0

  if maximum > 0 then
    percentage = math.max( 0, math.min(1, current / maximum) )
  end

  header.progressFill:SetWidth( math.max(0.001, PROGRESS_WIDTH * percentage) )

  Utils.SetColor( header.progressFill, theme.accent )

  header.progressText:SetText( current .. " / " .. maximum .. suffix )
end
