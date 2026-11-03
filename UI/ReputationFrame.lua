local addon = ReputationRenown
local WINDOW_WIDTH, WINDOW_HEIGHT = 850, 565
local CARD_WIDTH, CARD_HEIGHT = 342, 72
local ROW_GAP = 9
local SCROLL_WIDTH, SCROLL_HEIGHT = 704, 230

local function SetColor(texture, rgba)
    texture:SetColorTexture(rgba[1], rgba[2], rgba[3], rgba[4] or 1)
end

local function MakeText(parent, font, text, anchor, relative, x, y)
    local label = parent:CreateFontString(nil, "OVERLAY", font)
    label:SetPoint(anchor, relative or parent, anchor, x or 0, y or 0)
    label:SetText(text)
    return label
end

local function MakePanel(parent, width, height, point, relative, relativePoint, x, y, color)
    local panel = CreateFrame("Frame", nil, parent)
    panel:SetSize(width, height)
    panel:SetPoint(point, relative, relativePoint, x, y)
    local bg = panel:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    SetColor(bg, color)
    panel.background = bg
    return panel
end

function addon:UpdateRewardList()
    local ui = self.ui
    local faction = self:GetFaction()
    local rewards = faction.rewards[self.selectedTier] or {}
    local unlocked = self:IsTierUnlocked(self.selectedTier, self.mockStanding)

    for _, child in ipairs(ui.rewardCards) do child:Hide() end
    ui.rewardCards = {}
    ui.rewardTitle:SetText(self.TIER_NAMES[self.selectedTier] .. " rewards")
    ui.rewardCount:SetText(#rewards .. " rewards")

    for i, reward in ipairs(rewards) do
        local card = self:CreateRewardCard(ui.scrollContent, reward, faction, unlocked)

        local column = (i - 1) % 2
        local row = math.floor((i - 1) / 2)

        card:SetPoint("TOPLEFT", ui.scrollContent, "TOPLEFT", column * (CARD_WIDTH + 12), -row * (CARD_HEIGHT + ROW_GAP))

        -- Allow scrolling even when hovering over a card.
        card:EnableMouseWheel(true)

        card:SetScript("OnMouseWheel", function(_, delta)
            local minimum, maximum = ui.scrollBar:GetMinMaxValues()

            local nextValue = math.max(
                minimum,
                math.min(
                    maximum,
                    ui.scrollBar:GetValue() - delta * 35
                )
            )

            ui.scrollBar:SetValue(nextValue)
        end)

        ui.rewardCards[#ui.rewardCards + 1] = card
    end

    local rows = math.ceil(#rewards / 2)
    local contentHeight = math.max(SCROLL_HEIGHT, rows * (CARD_HEIGHT + ROW_GAP))
    ui.scrollContent:SetHeight(contentHeight)
    local maxScroll = math.max(0, contentHeight - SCROLL_HEIGHT)
    ui.scrollBar:SetMinMaxValues(0, maxScroll)
    ui.scrollBar:SetValue(0)
    ui.scrollBar:SetShown(maxScroll > 0)
    ui.empty:SetShown(#rewards == 0)
end

function addon:SelectTier(tier)
    self.selectedTier = tier
    local ui = self.ui
    for key, button in pairs(ui.tierButtons) do
        local selected = key == tier
        local unlocked = self:IsTierUnlocked(key, self.mockStanding)
        if selected then
            SetColor(button.background, self:GetFaction().theme.accent)
            button.label:SetTextColor(0.1, 0.08, 0.05, 1)
        elseif unlocked then
            SetColor(button.background, { 0.31, 0.26, 0.16, 1 })
            button.label:SetTextColor(1, 0.85, 0.55, 1)
        else
            SetColor(button.background, { 0.15, 0.16, 0.16, 1 })
            button.label:SetTextColor(0.6, 0.6, 0.6, 1)
        end
    end
    self:UpdateRewardList()
end

function addon:CreateReputationFrame()
    if self.frame then return self.frame end
    local faction = self:GetFaction()
    local theme = faction.theme
    local frame = CreateFrame("Frame", "ReputationRenownFrame", UIParent, "BackdropTemplate")
    frame:SetSize(WINDOW_WIDTH, WINDOW_HEIGHT)
    frame:SetPoint("CENTER")
    frame:SetFrameStrata("DIALOG")
    frame:SetClampedToScreen(true)
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", function(self) self:StartMoving() end)
    frame:SetScript("OnDragStop", function(self) self:StopMovingOrSizing() end)
    frame:SetBackdrop({ edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border", edgeSize = 18 })
    frame:SetBackdropBorderColor(unpack(theme.border))
    local background = frame:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()
    SetColor(background, theme.background)

    local close = CreateFrame("Button", nil, frame, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -3, -3)

    local emblem = frame:CreateTexture(nil, "ARTWORK")
    emblem:SetSize(55, 55)
    emblem:SetPoint("TOPLEFT", frame, "TOPLEFT", 35, -25)
    emblem:SetTexture(theme.emblemTexture)
    local title = MakeText(frame, "GameFontNormalHuge", faction.name, "TOP", frame, 0, -30)
    local subtitle = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    subtitle:SetPoint("TOP", title, "BOTTOM", 0, -8)
    subtitle:SetText(faction.description)

    local standing = MakeText(frame, "GameFontNormal", "Current standing: " .. self.TIER_NAMES[self.mockStanding], "TOP", frame, 0, -109)
    standing:SetText("Current standing: Honored (mock)")
    local progress = MakePanel(frame, 350, 13, "TOP", frame, "TOP", 0, -139, { 0.19, 0.20, 0.18, 1 })
    local fill = progress:CreateTexture(nil, "ARTWORK")
    fill:SetPoint("TOPLEFT", progress, "TOPLEFT", 0, 0)
    fill:SetPoint("BOTTOMLEFT", progress, "BOTTOMLEFT", 0, 0)
    fill:SetWidth(350 * (self.mockProgress / self.mockMaximum))
    SetColor(fill, theme.accent)
    MakeText(frame, "GameFontHighlightSmall", self.mockProgress .. " / " .. self.mockMaximum .. " (mock)", "TOP", frame, 0, -157)

    local tierButtons = {}
    for index, tier in ipairs(self.TIERS) do
        local btn = CreateFrame("Button", nil, frame)
        btn:SetSize(162, 68)
        btn:SetPoint("TOPLEFT", frame, "TOPLEFT", 67 + (index - 1) * 178, -202)
        local bg = btn:CreateTexture(nil, "BACKGROUND")
        bg:SetAllPoints()
        btn.background = bg
        local icon = btn:CreateTexture(nil, "ARTWORK")
        icon:SetSize(26, 26)
        icon:SetPoint("TOP", btn, "TOP", 0, -5)
        icon:SetTexture(theme.tierTextures[tier])
        local label = MakeText(btn, "GameFontNormal", self.TIER_NAMES[tier], "BOTTOM", btn, 0, 9)
        btn.label = label
        btn:SetScript("OnClick", function() addon:SelectTier(tier) end)
        tierButtons[tier] = btn
    end

    local rewardTitle = MakeText(frame, "GameFontNormalLarge", "Rewards", "TOPLEFT", frame, 52, -293)
    local rewardCount = MakeText(frame, "GameFontHighlightSmall", "", "TOPRIGHT", frame, -65, -298)

    local scrollFrame = CreateFrame("ScrollFrame", nil, frame)
    scrollFrame:SetSize(SCROLL_WIDTH, SCROLL_HEIGHT)
    scrollFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", 54, -333)
    local scrollContent = CreateFrame("Frame", nil, scrollFrame)
    scrollContent:SetWidth(SCROLL_WIDTH)
    scrollContent:SetHeight(SCROLL_HEIGHT)
    scrollFrame:SetScrollChild(scrollContent)

    local scrollBar = CreateFrame("Slider", nil, frame, "OptionsSliderTemplate")
    scrollBar:SetPoint("TOPLEFT", scrollFrame, "TOPRIGHT", 12, -4)
    scrollBar:SetSize(15, SCROLL_HEIGHT - 8)
    scrollBar:SetOrientation("VERTICAL")
    scrollBar:SetMinMaxValues(0, 0)
    scrollBar:SetValueStep(20)
    scrollBar:SetObeyStepOnDrag(false)
    scrollBar:SetScript("OnValueChanged", function(_, value)
        scrollFrame:SetVerticalScroll(value)
    end)
    scrollFrame:EnableMouseWheel(true)
    scrollFrame:SetScript("OnMouseWheel", function(_, delta)
        local minimum, maximum = scrollBar:GetMinMaxValues()
        local nextValue = math.max(minimum, math.min(maximum, scrollBar:GetValue() - delta * 35))
        scrollBar:SetValue(nextValue)
    end)

    local empty = MakeText(scrollContent, "GameFontHighlight", "No rewards at this tier.", "TOP", scrollContent, 0, -20)

    self.frame = frame
    self.ui = {
        tierButtons = tierButtons,
        rewardTitle = rewardTitle,
        rewardCount = rewardCount,
        rewardCards = {},
        scrollContent = scrollContent,
        scrollBar = scrollBar,
        empty = empty,
    }
    self:SelectTier("friendly")
    frame:Hide()
    return frame
end

function addon:ToggleReputationFrame()
    local frame = self:CreateReputationFrame()
    if frame:IsShown() then frame:Hide() else frame:Show() end
end
