local addon = ReputationRenown
local Utils = addon.UIUtils

local CARD_WIDTH = 342
local CARD_HEIGHT = 72

local COLUMNS = 2
local COLUMN_GAP = 12
local ROW_GAP = 9

local SCROLL_WIDTH = 704
local SCROLL_HEIGHT = 230
local SCROLL_STEP = 35

local function ScrollBy(list, delta)
  local minimum, maximum =
    list.scrollBar:GetMinMaxValues()

  local nextValue = math.max(
    minimum,
    math.min(
        maximum,
        list.scrollBar:GetValue() - delta * SCROLL_STEP
    )
  )

  list.scrollBar:SetValue(nextValue)
end

function addon:CreateRewardList(parent)
  local list = CreateFrame("Frame", nil, parent)

  list:SetAllPoints(parent)

  -- Section title
  local title = Utils.MakeText( list, "GameFontNormalLarge", "Rewards", "TOPLEFT", list, 52, -293 )

  -- Reward counter
  local count = Utils.MakeText( list, "GameFontHighlightSmall", "", "TOPRIGHT", list, -65, -298 )

  -- Scrollable area
  local scrollFrame = CreateFrame( "ScrollFrame", nil, list )

  scrollFrame:SetSize( SCROLL_WIDTH, SCROLL_HEIGHT )

  scrollFrame:SetPoint( "TOPLEFT", list, "TOPLEFT", 54, -333 )

  -- Content container
  local scrollContent = CreateFrame( "Frame", nil, scrollFrame )

  scrollContent:SetSize( SCROLL_WIDTH, SCROLL_HEIGHT )

  scrollFrame:SetScrollChild(scrollContent)

  -- Scrollbar
  local scrollBar = CreateFrame( "Slider", nil, list, "OptionsSliderTemplate" )

  scrollBar:SetPoint( "TOPLEFT", scrollFrame, "TOPRIGHT", 12, -4 )

  scrollBar:SetSize( 15, SCROLL_HEIGHT - 8 )

  scrollBar:SetOrientation("VERTICAL")
  scrollBar:SetMinMaxValues(0, 0)
  scrollBar:SetValueStep(20)
  scrollBar:SetObeyStepOnDrag(false)

  scrollBar:SetScript("OnValueChanged", function(_, value)
      scrollFrame:SetVerticalScroll(value)
  end)

  -- Mouse wheel navigation
  scrollFrame:EnableMouseWheel(true)

  scrollFrame:SetScript("OnMouseWheel", function(_, delta)
      ScrollBy(list, delta)
  end)

  -- Empty state
  local empty = Utils.MakeText( scrollContent, "GameFontHighlight", "No rewards at this tier.", "TOP", scrollContent, 0, -20 )

  -- Store component references
  list.title = title
  list.count = count
  list.scrollFrame = scrollFrame
  list.scrollContent = scrollContent
  list.scrollBar = scrollBar
  list.empty = empty

  -- Reusable card pool
  list.cards = {}

  scrollBar:Hide()

  return list
end

function addon:UpdateRewardList(list, faction, tier, standing)
  local rewards = faction.rewards[tier] or {}

  local unlocked = self:IsTierUnlocked( tier, standing )

  -- Update section information
  list.title:SetText( self.TIER_NAMES[tier] .. " rewards" )

  list.count:SetText( #rewards .. " rewards" )

  -- Create or reuse cards
  for index, reward in ipairs(rewards) do
    local card = list.cards[index]

    if not card then
      card = self:CreateRewardCard( list.scrollContent, reward, faction, unlocked )

      list.cards[index] = card

      -- Configure wheel scrolling once per card
      card:EnableMouseWheel(true)

      card:SetScript("OnMouseWheel", function(_, delta)
          ScrollBy(list, delta)
      end)
    end

    -- Update card with current reward data
    self:UpdateRewardCard( card, reward, faction, unlocked )

    -- Calculate position
    local column = (index - 1) % COLUMNS

    local row = math.floor( (index - 1) / COLUMNS )

    card:ClearAllPoints()

    card:SetPoint( "TOPLEFT", list.scrollContent, "TOPLEFT", column * (CARD_WIDTH + COLUMN_GAP), -row * (CARD_HEIGHT + ROW_GAP) )
  end

  -- Hide unused cards, keeping them available for reuse
  for index = #rewards + 1, #list.cards do
    list.cards[index]:Hide()
  end

  -- Calculate scrollable content height
  local rows = math.ceil( #rewards / COLUMNS )

  local contentHeight = math.max( SCROLL_HEIGHT, rows * (CARD_HEIGHT + ROW_GAP) )

  list.scrollContent:SetHeight(contentHeight)

  -- Configure scrollbar
  local maxScroll = math.max( 0, contentHeight - SCROLL_HEIGHT )

  list.scrollBar:SetMinMaxValues(0, maxScroll)
  list.scrollBar:SetValue(0)
  list.scrollBar:SetShown(maxScroll > 0)

  -- Empty state visibility
  list.empty:SetShown(#rewards == 0)
end
