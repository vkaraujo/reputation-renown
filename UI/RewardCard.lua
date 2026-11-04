local addon = ReputationRenown

local CARD_WIDTH = 342
local CARD_HEIGHT = 72
local ICON_SIZE = 48

local function SetColor(texture, rgba)
    texture:SetColorTexture(
        rgba[1],
        rgba[2],
        rgba[3],
        rgba[4] or 1
    )
end

-- Refresh an existing card when item data becomes available.
function addon:RefreshRewardCard(card)
    local reward = card.reward

    if not reward then
        return
    end

    local itemInfo = self:GetRewardItemInfo(reward)

    card.icon:SetTexture(itemInfo.icon)
    card.name:SetText(itemInfo.name)

    -- Preserve the distinction between locked and unlocked rewards.
    card.icon:SetDesaturated(not card.unlocked)
end

function addon:UpdateRewardCard(card, reward, faction, unlocked)
    card.reward = reward
    card.unlocked = unlocked

    -- Update visual appearance.
    SetColor(card.background, faction.theme.surface)

    card.category:SetText(reward.category or "")

    -- Update item name, icon and lock state.
    self:RefreshRewardCard(card)

    card:Show()
end

-- Create a reusable reward card.
function addon:CreateRewardCard(parent, reward, faction, unlocked)
    local card = CreateFrame("Button", nil, parent)

    card:SetSize(CARD_WIDTH, CARD_HEIGHT)
    card:EnableMouse(true)

    card.reward = reward
    card.unlocked = unlocked

    -- Background
    local background = card:CreateTexture(nil, "BACKGROUND")
    background:SetAllPoints()

    SetColor(background, faction.theme.surface)

    card.background = background

    -- Item icon
    local icon = card:CreateTexture(nil, "ARTWORK")

    icon:SetSize(ICON_SIZE, ICON_SIZE)
    icon:SetPoint("LEFT", card, "LEFT", 12, 0)

    card.icon = icon

    -- Item name
    local name = card:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontNormal"
    )

    name:SetPoint("TOPLEFT", icon, "TOPRIGHT", 12, -5)
    name:SetPoint("RIGHT", card, "RIGHT", -8, 0)

    name:SetJustifyH("LEFT")

    card.name = name

    -- Item category
    local category = card:CreateFontString(
        nil,
        "OVERLAY",
        "GameFontHighlightSmall"
    )

    category:SetPoint("TOPLEFT", name, "BOTTOMLEFT", 0, -7)
    category:SetText(reward.category or "")

    card.category = category

    -- Native WoW tooltip
    card:SetScript("OnEnter", function(self)
        if not self.reward.itemId then
            return
        end

        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

        if GameTooltip.SetItemByID then
            GameTooltip:SetItemByID(self.reward.itemId)
        else
            GameTooltip:SetHyperlink(
                "item:" .. self.reward.itemId
            )
        end

        GameTooltip:Show()
    end)

    card:SetScript("OnLeave", function(self)
        if GameTooltip:IsOwned(self) then
            GameTooltip:Hide()
        end
    end)

    self:RefreshRewardCard(card)

    return card
end
