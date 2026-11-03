local addon = ReputationRenown

addon.UIUtils = {}

local Utils = addon.UIUtils

function Utils.SetColor(texture, rgba)
  texture:SetColorTexture( rgba[1], rgba[2], rgba[3], rgba[4] or 1 )
end

function Utils.MakeText(parent, font, text, anchor, relative, x, y)
  local label = parent:CreateFontString( nil, "OVERLAY", font )

  label:SetPoint( anchor, relative or parent, anchor, x or 0, y or 0 )

  label:SetText(text or "")

  return label
end

function Utils.MakePanel(parent, width, height, point, relative, relativePoint, x, y, color)
  local panel = CreateFrame("Frame", nil, parent)

  panel:SetSize(width, height)
  panel:SetPoint(point, relative, relativePoint, x, y)

  local background = panel:CreateTexture(nil, "BACKGROUND")
  background:SetAllPoints()

  Utils.SetColor(background, color)

  panel.background = background

  return panel
end
