-- Reputation Renown
-- Main reputation window

local addon = ReputationRenown

function addon:CreateReputationFrame()
    -- Avoid creating the window more than once
    if self.frame then
        return self.frame
    end

    -- Create the main window
    local frame = CreateFrame(
        "Frame",
        "ReputationRenownFrame",
        UIParent,
        "BackdropTemplate"
    )

    frame:SetSize(600, 450)
    frame:SetPoint("CENTER")

    -- Window background
    frame:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true,
        tileSize = 32,
        edgeSize = 16,
        insets = {
            left = 4,
            right = 4,
            top = 4,
            bottom = 4
        }
    })

    frame:SetBackdropColor(0.05, 0.05, 0.08, 0.95)

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

    -- Window title
    local title = frame:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormalLarge"
    )

    title:SetPoint("TOP", frame, "TOP", 0, -25)
    title:SetText("Reputation Renown")

    -- Faction name
    local faction = frame:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightLarge"
    )

    faction:SetPoint("TOP", title, "BOTTOM", 0, -30)
    faction:SetText("Timbermaw Hold")

    -- Close button
    local closeButton = CreateFrame(
        "Button",
        nil,
        frame,
        "UIPanelCloseButton"
    )

    closeButton:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -5, -5)

    -- Hide on creation
    frame:Hide()

    self.frame = frame

    return frame
end

function addon:ToggleReputationFrame()
    local frame = self:CreateReputationFrame()

    if frame:IsShown() then
        frame:Hide()
    else
        frame:Show()
    end
end
