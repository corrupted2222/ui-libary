local UILib = {}

function UILib:CreateWindow(options)
    local CoreGui = game:GetService("CoreGui")
    local UserInputService = game:GetService("UserInputService")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.177, 0, 0.04, 0)
MainFrame.Size = UDim2.new(0, 500, 0, 300)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Active = true
MainFrame.Draggable = true

-- Check if the device is mobile and adjust the position
if UserInputService.TouchEnabled then
    MainFrame.Position = UDim2.new(0.1, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
end
	
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Image = options.Icon or "rbxassetid://17376881029"
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
ToggleButton.BackgroundTransparency = 1
ToggleButton.BorderSizePixel = 0
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

    local ToggleButtoncorners = Instance.new("UICorner")
    ToggleButtoncorners.CornerRadius = UDim.new(0, 4)
    ToggleButtoncorners.Parent = ToggleButton
	
    local MainFrameCorners = Instance.new("UICorner")
    MainFrameCorners.CornerRadius = UDim.new(0, 4)
    MainFrameCorners.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Header.Position = UDim2.new(0, 0, -0.15, 0)
    Header.Size = UDim2.new(0, 500, 0, 36)
    Header.Active = true

    local Title = Instance.new("TextLabel")
    Title.Text = options.Title or "Title"
    Title.Font = Enum.Font.ArialBold
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(40,40,40)
    Title.Size = UDim2.new(0, 200, 0, 36)
    Title.Position = UDim2.new(0.01, 0, 0, 0)
    Title.TextColor3 = Color3.fromRGB(255,255,255)
    Title.TextSize = 17

    local TabsHolder = Instance.new("Frame")
    TabsHolder.Parent = MainFrame
    TabsHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabsHolder.Position = UDim2.new(1.025, 0, 0, 0)
    TabsHolder.Size = UDim2.new(0, 54, 0, 300)

    local GameTitle = Instance.new("TextLabel")
    GameTitle.Parent = Header
    GameTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameTitle.TextSize = 14
    GameTitle.Text = options.Game or "Game Name"
    GameTitle.Font = Enum.Font.ArialBold
    GameTitle.BackgroundTransparency = 0
    local gameTitleWidth = options.GameTitleWidth or 80
    local gameTitleHeight = 30
    GameTitle.Size = UDim2.new(0, gameTitleWidth, 0, gameTitleHeight)
    local gameTitlePosX = options.GameTitlePosX or 0.592
    local gameTitlePosY = 0.09
    GameTitle.Position = UDim2.new(gameTitlePosX, 0, gameTitlePosY, 0)
    GameTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
        if not options.GameTitleWidth then
            GameTitle.Size = UDim2.new(0, GameTitle.TextBounds.X + 10, 0, gameTitleHeight)
        end
    end)

    local GameTitleCorners = Instance.new("UICorner")
    GameTitleCorners.CornerRadius = UDim.new(0, 4)
    GameTitleCorners.Parent = GameTitle

    local HeaderCorners = Instance.new("UICorner")
    HeaderCorners.CornerRadius = UDim.new(0, 4)
    HeaderCorners.Parent = Header

    local TabsHolderCorners = Instance.new("UICorner")
    TabsHolderCorners.CornerRadius = UDim.new(0, 4)
    TabsHolderCorners.Parent = TabsHolder

    local TabsHolderFrame = Instance.new("ScrollingFrame")
    TabsHolderFrame.Parent = TabsHolder
    TabsHolderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabsHolderFrame.Position = UDim2.new(0.15, 0, 0.023, 0)
    TabsHolderFrame.Size = UDim2.new(0, 44, 0, 292)
    TabsHolderFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsHolderFrame.ScrollBarThickness = 0
    TabsHolderFrame.BackgroundTransparency = 1
    TabsHolderFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TabsHolderFrame.Active = true

    local TabsGridLayout = Instance.new("UIGridLayout")
    TabsGridLayout.Parent = TabsHolderFrame
    TabsGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsGridLayout.CellSize = UDim2.new(0, 37, 0, 37)
    TabsGridLayout.CellPadding = UDim2.new(0, 5, 0, 5)
    TabsGridLayout.FillDirection = Enum.FillDirection.Vertical

    local TabHolders = Instance.new("ScrollingFrame")
    TabHolders.Parent = MainFrame
    TabHolders.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TabHolders.Position = UDim2.new(0.0192, 0, 0.023, 0)
    TabHolders.Size = UDim2.new(0, 480, 0, 294)
    TabHolders.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabHolders.ScrollBarThickness = 0
    TabHolders.BackgroundTransparency = 1
    TabHolders.Active = true
    TabHolders.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local tabs = {}
    local function switchTab(tab)
        for _, tabButton in pairs(tabs) do
            tabButton.content.Visible = false
        end
        tab.content.Visible = true
        Title.Text = "Zygarde | " .. tab.title
    end

    -- Dragging functionality
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        MainFrame.Position = newPos
    end

    local function onInputBegan(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end

    local function onInputChanged(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end

    MainFrame.InputBegan:Connect(onInputBegan)
    MainFrame.InputChanged:Connect(onInputChanged)
    Header.InputBegan:Connect(onInputBegan)
    Header.InputChanged:Connect(onInputChanged)

    local UserInputService = game:GetService("UserInputService")
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)


	
    return {
            
   AddTab = function(self, tabOptions)
    local tabButton = Instance.new("TextButton")
    tabButton.Name = tabOptions.Title or "Tab"
    tabButton.Parent = TabsHolderFrame
    tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabButton.Position = UDim2.new(0, 0, 0, 0)
    tabButton.Size = UDim2.new(0, 126, 0, 34)
    tabButton.Text = ""
    tabButton.TextSize = 14 
    tabButton.Font = Enum.Font.ArialBold 
    tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    tabButton.AutoButtonColor = false

    local tabButtonCorners = Instance.new("UICorner")
    tabButtonCorners.CornerRadius = UDim.new(0, 4)
    tabButtonCorners.Parent = tabButton

    local tabIcon = Instance.new("ImageLabel")
    tabIcon.Parent = tabButton
    tabIcon.Size = UDim2.new(0, 30, 0, 30)
    tabIcon.Name = tabOptions.Title or "Tab"
    tabIcon.Position = UDim2.new(0.1, 0, 0.1, 0)
    tabIcon.Image = tabOptions.Icon or "http://www.roblox.com/asset/?id=16803349493"
    tabIcon.BackgroundTransparency = 1

    local tabContent
    if tabOptions.EnableLayout then
        tabContent = Instance.new("ScrollingFrame")
        tabContent.Position = UDim2.new(0.0192, 0, 0.023, 0)
        tabContent.Size = UDim2.new(0, 490, 0, 290)
        tabContent.ScrollBarThickness = 3
        tabContent.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
        tabContent.ClipsDescendants = true
        tabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabContent.BorderSizePixel = 0
        tabContent.BackgroundTransparency = 1
        tabContent.Parent = MainFrame

        local layout = Instance.new("UIListLayout")
        layout.Parent = tabContent
        layout.SortOrder = Enum.SortOrder.LayoutOrder
        layout.Padding = UDim.new(0, 5)

        local function updateScrolling()
            local contentSize = layout.AbsoluteContentSize
            local frameSize = tabContent.AbsoluteSize

            if contentSize.Y > frameSize.Y then
                tabContent.CanvasSize = UDim2.new(0, 0, 0, contentSize.Y)
            else
                tabContent.CanvasSize = UDim2.new(0, 0, 0, frameSize.Y) -- Set canvas size to fit the frame
            end
        end

        layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateScrolling)
        updateScrolling()

    else
        tabContent = Instance.new("Frame")
        tabContent.Size = tabOptions.ContentSize or UDim2.new(0, 480, 0, 310)
        tabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabContent.BorderSizePixel = 0
        tabContent.BackgroundTransparency = 1
        tabContent.Parent = MainFrame
    end

    tabContent.Name = tabOptions.Title or "TabContent"
    tabContent.Parent = MainFrame
    tabContent.Visible = tabOptions.DefaultVisible or false

    tabButton.MouseButton1Click:Connect(function()
        switchTab({title = tabOptions.Title, content = tabContent})
    end)

    table.insert(tabs, { button = tabButton, content = tabContent })
			
            return {
                AddLabel = function(self, labelOptions)
                    local label = Instance.new("TextLabel")
                    label.Name = labelOptions.Title or "Label"
                    label.Position = labelOptions.Position or UDim2.new(0.017, 0, 0.015, 0)
                    label.Parent = tabContent
                    label.Size = labelOptions.Size or UDim2.new(0, 200, 0, 50)
                    label.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    label.Text = labelOptions.Text or "Label"
                    label.Font = Enum.Font.ArialBold
                    label.TextSize = labelOptions.TextSize or 14
                    label.TextColor3 = Color3.fromRGB(255, 255, 255)
                    label.BorderSizePixel = 0

                    local labelCorners = Instance.new("UICorner")
                    labelCorners.CornerRadius = UDim.new(0, 4)
                    labelCorners.Parent = label
                end,
                AddTime = function(self, parent)
                    local Time = Instance.new("TextLabel")
                    Time.Parent = tabContent
                    Time.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Time.Size = UDim2.new(0, 102, 0, 30)
                    Time.Position = UDim2.new(0.015, 0, 0.015, 0)
                    Time.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Time.TextSize = 16
                    Time.Font = Enum.Font.ArialBold
                    Time.BackgroundTransparency = 0
                    Time.Text = "00:00:00 AM"

                    local function updateTime()
                        local currentTime = os.date("%I:%M:%S %p")
                        Time.Text = currentTime
                    end

                    game:GetService("RunService").Heartbeat:Connect(updateTime)

                    local TimeCorners = Instance.new("UICorner")
                    TimeCorners.CornerRadius = UDim.new(0, 4)
                    TimeCorners.Parent = Time
                end,
                AddPlayer = function(self, player)
                    local playerFrame = Instance.new("Frame")
                    playerFrame.Parent = tabContent
                    playerFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    playerFrame.Position = UDim2.new(0.53, 0, 0.015, 0)
                    playerFrame.Size = UDim2.new(0, 240, 0, 30)

                    local PlayerFrameCorners = Instance.new("UICorner")
                    PlayerFrameCorners.CornerRadius = UDim.new(0, 4)
                    PlayerFrameCorners.Parent = playerFrame

                    local PlayerName = Instance.new("TextLabel")
                    PlayerName.Parent = tabContent
                    PlayerName.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    PlayerName.Size = UDim2.new(0, 199, 0, 30)
                    PlayerName.Position = UDim2.new(0.61, 0, 0.015, 0)
                    PlayerName.TextColor3 = Color3.fromRGB(255, 255, 255)
                    PlayerName.TextSize = 14
                    PlayerName.Font = Enum.Font.ArialBold
                    PlayerName.BackgroundTransparency = 1
                    PlayerName.Text = "Player Name"
                    PlayerName.TextXAlignment = Enum.TextXAlignment.Left
                    PlayerName.TextTruncate = Enum.TextTruncate.AtEnd
                    PlayerName.Text = game.Players.LocalPlayer.DisplayName

                    local Players = game:GetService("Players")
                    local player = Players.LocalPlayer

                    local PlayerIcon = Instance.new("ImageLabel")
                    PlayerIcon.Parent = tabContent
                    PlayerIcon.Size = UDim2.new(0, 30, 0, 30)
                    PlayerIcon.Position = UDim2.new(0.535, 0, 0.015, 0)
                    PlayerIcon.Image = game.Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
                    PlayerIcon.BackgroundTransparency = 1
                end,
        AddCredits = function(self, creditsOptions)
    local creditsFrame = Instance.new("Frame")
    creditsFrame.Parent = tabContent
    creditsFrame.Size = UDim2.new(0, 230, 0, 245)
    creditsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    creditsFrame.BorderSizePixel = 0
    creditsFrame.Position = UDim2.new(0.017, 0, 0.093, 0)

    local creditsFrameCorners = Instance.new("UICorner")
    creditsFrameCorners.CornerRadius = UDim.new(0, 4)
    creditsFrameCorners.Parent = creditsFrame               

    local CreditTitle = Instance.new("TextLabel")
    CreditTitle.Parent = creditsFrame
    CreditTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CreditTitle.Size = UDim2.new(0, 230, 0, 18)
    CreditTitle.Position = UDim2.new(0, 0, 0, 0)
    CreditTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    CreditTitle.TextSize = 14
    CreditTitle.Font = Enum.Font.ArialBold
    CreditTitle.BackgroundTransparency = 1
    CreditTitle.Text = "Credits"

    local creditsList = Instance.new("Frame")
    creditsList.Parent = creditsFrame
    creditsList.Size = UDim2.new(0, 217, 0, 217)
    creditsList.Position = UDim2.new(0.032, 0, 0.08, 0)
    creditsList.BackgroundTransparency = 1

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = creditsList
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 5)  -- Add padding between elements

    for _, credit in pairs(creditsOptions) do
        local NewFrame = Instance.new("Frame")
        NewFrame.Parent = creditsList
        NewFrame.BackgroundTransparency = 0
        NewFrame.Size = UDim2.new(1, 0, 0, 60)  -- Adjusted height to fit the icon
        NewFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

        local creditIcon = Instance.new("ImageLabel")
        creditIcon.Parent = NewFrame
        creditIcon.Size = UDim2.new(0, 45, 0, 45)
        creditIcon.Position = UDim2.new(0, 10, 0.5, -22.5)  -- Centered vertically
        creditIcon.Image = credit.Icon or ""
        creditIcon.BackgroundTransparency = 1

        local creditName = Instance.new("TextLabel")
        creditName.Parent = NewFrame
        creditName.Size = UDim2.new(1, -60, 1, 0)  -- Adjusted to fit within the frame
        creditName.Position = UDim2.new(0, 60, 0, 0)
        creditName.BackgroundTransparency = 1
        creditName.Text = credit.Name or ""
        creditName.Font = Enum.Font.ArialBold
        creditName.TextSize = 14
        creditName.TextColor3 = Color3.fromRGB(255, 255, 255)
        creditName.TextXAlignment = Enum.TextXAlignment.Left

        local creditsCorners = Instance.new("UICorner")
        creditsCorners.CornerRadius = UDim.new(0, 4)
        creditsCorners.Parent = NewFrame

        local creditIconCorners = Instance.new("UICorner")
        creditIconCorners.CornerRadius = UDim.new(0, 4)
        creditIconCorners.Parent = creditIcon
    end

    return creditsFrame
end,
                AddSupported = function(self, supportedOptions)
    local supportedFrame = Instance.new("Frame")
    supportedFrame.Parent = tabContent
    supportedFrame.Size = UDim2.new(0, 230, 0, 244)
    supportedFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    supportedFrame.BorderSizePixel = 0
    supportedFrame.Position = UDim2.new(0.55, 0, 0.093, 0)

    local supportedFrameCorners = Instance.new("UICorner")
    supportedFrameCorners.CornerRadius = UDim.new(0, 4)
    supportedFrameCorners.Parent = supportedFrame               

    local SupportedTitle = Instance.new("TextLabel")
    SupportedTitle.Parent = supportedFrame
    SupportedTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SupportedTitle.Size = UDim2.new(0, 230, 0, 18)
    SupportedTitle.Position = UDim2.new(0, 0, 0, 0)
    SupportedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    SupportedTitle.TextSize = 14
    SupportedTitle.Font = Enum.Font.ArialBold
    SupportedTitle.BackgroundTransparency = 1
    SupportedTitle.Text = "Supported Games"

    local supportedList = Instance.new("ScrollingFrame")
    supportedList.Parent = supportedFrame
    supportedList.Size = UDim2.new(0, 217, 0, 217)
    supportedList.Position = UDim2.new(0.032, 0, 0.08, 0)
    supportedList.BackgroundTransparency = 1
    supportedList.ScrollBarThickness = 3
    supportedList.BorderSizePixel = 0

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = supportedList
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 0)

    for _, supported in pairs(supportedOptions) do
        local SupportedText = Instance.new("TextLabel")
        SupportedText.Parent = supportedList
        SupportedText.Size = UDim2.new(0, 230, 0, 18)
        SupportedText.BackgroundTransparency = 1
        SupportedText.Text = supported.Text or ""
        SupportedText.Font = Enum.Font.ArialBold
        SupportedText.TextSize = 14
        SupportedText.TextColor3 = Color3.fromRGB(255, 255, 255)
        SupportedText.TextXAlignment = Enum.TextXAlignment.Left
    end

    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        supportedList.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
        supportedList.CanvasPosition = Vector2.new(0, supportedList.AbsoluteCanvasSize.Y)
    end)

    return supportedFrame
end,

    AddButton = function(self, buttonOptions)
                    local tabButton = Instance.new("TextButton")
                    tabButton.Parent = tabContent
                    tabButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
                    tabButton.Position = UDim2.new(0, 0, 0, 0)
                    tabButton.Size = UDim2.new(0, 480, 0, 40)
                    tabButton.Text = buttonOptions.Title or "Button"
                    tabButton.TextSize = 16
                    tabButton.Font = Enum.Font.ArialBold 
                    tabButton.TextColor3 = Color3.fromRGB(255,255,255)
                    tabButton.AutoButtonColor = false
                    tabButton.TextXAlignment = Enum.TextXAlignment.Left
                    tabButton.MouseButton1Click:Connect(buttonOptions.Callback or function() end)

                    local tabButtonCorners = Instance.new("UICorner")
                    tabButtonCorners.CornerRadius = UDim.new(0, 4)
                    tabButtonCorners.Parent = tabButton

                    local tabButtonPadding = Instance.new("UIPadding")
                    tabButtonPadding.Parent = tabButton
                    tabButtonPadding.PaddingLeft = UDim.new(0, 6) 

                    local FingerPrint = Instance.new("ImageLabel")
                    FingerPrint.Parent = tabButton
                    FingerPrint.Size = UDim2.new(0, 30, 0, 30)
                    FingerPrint.Position = UDim2.new(0.93, 0, 0.113, 0)
                    FingerPrint.Image = "http://www.roblox.com/asset/?id=17374737385"
                    FingerPrint.BackgroundTransparency = 1
                end,
            AddToggle = function(self, toggleOptions)
                    local tabToggle = Instance.new("TextButton")
                    tabToggle.Parent = tabContent
                    tabToggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
                    tabToggle.Position = UDim2.new(0, 0, 0, 0)
                    tabToggle.Size = UDim2.new(0,480,0,40)
                    tabToggle.Text = toggleOptions.Title or "Toggle"
                    tabToggle.TextSize = 16
                    tabToggle.Font = Enum.Font.ArialBold 
                    tabToggle.TextColor3 = Color3.fromRGB(255,255,255)
                    tabToggle.AutoButtonColor = false
                    tabToggle.Active = false 
                    tabToggle.TextXAlignment = Enum.TextXAlignment.Left

                    local tabToggleCorners = Instance.new("UICorner")
                    tabToggleCorners.CornerRadius = UDim.new(0, 4)
                    tabToggleCorners.Parent = tabToggle

                    local tabTogglePadding = Instance.new("UIPadding")
                    tabTogglePadding.Parent = tabToggle
                    tabTogglePadding.PaddingLeft = UDim.new(0, 6)

                    local tabToggleButton = Instance.new("TextButton")
                    tabToggleButton.Parent = tabToggle
                    tabToggleButton.Size = UDim2.new(0, 30, 0, 30)
                    tabToggleButton.Position = UDim2.new(0.93, 0, 0.113, 0)
                    tabToggleButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
                    tabToggleButton.Text = ""
                    tabToggleButton.BackgroundTransparency = 0
                    tabToggleButton.AutoButtonColor = false
                    
                    local tabToggleButtonCorners = Instance.new("UICorner")
                    tabToggleButtonCorners.CornerRadius = UDim.new(0, 4)
                    tabToggleButtonCorners.Parent = tabToggleButton

                    local tabToggleButtonStrok = Instance.new("UIStroke")
                    tabToggleButtonStrok.Parent = tabToggleButton
                    tabToggleButtonStrok.Thickness = 2
                    tabToggleButtonStrok.Color = Color3.fromRGB(25,25,25)
                    tabToggleButtonStrok.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
                    
                    local toggleState = false

                    local function updateToggle()
                        if toggleState then
                            tabToggleButton.BackgroundColor3 = Color3.fromRGB(196, 237, 112)
                        else
                            tabToggleButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
                        end
                    end

                    tabToggleButton.MouseButton1Click:Connect(function()
                        toggleState = not toggleState
                        updateToggle()
                        toggleOptions.Callback(toggleState)
                    end)

                    updateToggle()
                end,
	AddSlider = function(self, sliderOptions)
    local slider = Instance.new("TextButton")
    slider.Parent = tabContent
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.Size = UDim2.new(0, 480, 0, 40)
    slider.Text = sliderOptions.Title or "Slider"
    slider.TextSize = 16
    slider.Font = Enum.Font.ArialBold
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.AutoButtonColor = false
    slider.Active = false
    slider.TextXAlignment = Enum.TextXAlignment.Left

    local slidercorners = Instance.new("UICorner")
    slidercorners.CornerRadius = UDim.new(0, 4)
    slidercorners.Parent = slider

    local sliderpadding = Instance.new("UIPadding")
    sliderpadding.Parent = slider
    sliderpadding.PaddingLeft = UDim.new(0, 6)

    local sliderBar = Instance.new("Frame")
    sliderBar.Name = "SliderBar"
    sliderBar.Parent = slider
    sliderBar.Size = UDim2.new(0, 200, 0, 7)
    sliderBar.Position = UDim2.new(0.753, -90, 0.5, -5)
    sliderBar.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    sliderBar.BorderSizePixel = 0

    local sliderButton = Instance.new("ImageButton")
    sliderButton.Name = "SliderButton"
    sliderButton.Parent = sliderBar
    sliderButton.Size = UDim2.new(0, 15, 0, 15)
    sliderButton.Position = UDim2.new(0, -9, 0.2, -10)
    sliderButton.BackgroundColor3 = Color3.fromRGB(196, 237, 112)
    sliderButton.Image = ""
    sliderButton.BorderSizePixel = 0
    sliderButton.AutoButtonColor = false

    local sliderbuttoncorners = Instance.new("UICorner")
    sliderbuttoncorners.CornerRadius = UDim.new(0, 50)
    sliderbuttoncorners.Parent = sliderButton

    local sliderLine = Instance.new("Frame")
    sliderLine.Name = "SliderLine"
    sliderLine.Parent = sliderBar
    sliderLine.Size = UDim2.new(0, 0, 0, 7)
    sliderLine.Position = UDim2.new(0, 0, 0.5, -5)
    sliderLine.BackgroundColor3 = Color3.fromRGB(196, 237, 112)
    sliderLine.BorderSizePixel = 0

    local valueBox = Instance.new("TextBox")
    valueBox.Parent = slider
    valueBox.Size = UDim2.new(0, 30, 0, 30)
    valueBox.Position = UDim2.new(0.465, 0, 0.113, 0)
    valueBox.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    valueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueBox.TextSize = 14
    valueBox.Font = Enum.Font.ArialBold
    valueBox.Text = tostring(sliderOptions.Min or 0)
    valueBox.TextTruncate = Enum.TextTruncate.AtEnd
					
    local valuecorners = Instance.new("UICorner")
    valuecorners.CornerRadius = UDim.new(0, 4)
    valuecorners.Parent = valueBox

    local sliderValue = sliderOptions.Min or 0
    local maxValue = sliderOptions.Max or 100

    local function updateSlider(position)
        local relativePos = math.clamp(position, 0, 1)
        sliderButton.Position = UDim2.new(relativePos, -10, 0.5, -10)
        sliderLine.Size = UDim2.new(relativePos, 0, 0, 7)
        sliderValue = math.floor(relativePos * (maxValue - sliderOptions.Min) + sliderOptions.Min)
        valueBox.Text = tostring(sliderValue)
        sliderOptions.Callback(sliderValue)
    end

    sliderButton.MouseButton1Down:Connect(function()
        local moveConnection
        local releaseConnection

        moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                local relativePos = (input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
                updateSlider(relativePos)
            end
        end)

        releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                moveConnection:Disconnect()
                releaseConnection:Disconnect()
            end
        end)
    end)

    valueBox.FocusLost:Connect(function(enterPressed)
        if enterPressed then
            local inputValue = tonumber(valueBox.Text)
            if inputValue then
                local clampedValue = math.clamp(inputValue, sliderOptions.Min, maxValue)
                local relativePos = (clampedValue - sliderOptions.Min) / (maxValue - sliderOptions.Min)
                updateSlider(relativePos)
            else
                valueBox.Text = "0"
                updateSlider(0)
            end
        elseif valueBox.Text == "" then
            valueBox.Text = "0"
            updateSlider(0)
        end
    end)

    updateSlider((sliderValue - sliderOptions.Min) / (maxValue - sliderOptions.Min))
end,
		AddDropdown = function(self, dropdownOptions)
    local dropdownFrame = Instance.new("TextButton")
    dropdownFrame.Parent = tabContent
    dropdownFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    dropdownFrame.Position = UDim2.new(0, 0, 0, 0)
    dropdownFrame.Size = UDim2.new(0, 480, 0, 40)
    dropdownFrame.Text = dropdownOptions.Title or "Dropdown"
    dropdownFrame.TextSize = 16
    dropdownFrame.Font = Enum.Font.ArialBold
    dropdownFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownFrame.AutoButtonColor = false
    dropdownFrame.TextXAlignment = Enum.TextXAlignment.Left

    local dropdowncorners = Instance.new("UICorner")
    dropdowncorners.CornerRadius = UDim.new(0, 4)
    dropdowncorners.Parent = dropdownFrame

    local dropdownpadding = Instance.new("UIPadding")
    dropdownpadding.Parent = dropdownFrame
    dropdownpadding.PaddingLeft = UDim.new(0, 6)

    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "DropdownButton"
    dropdownButton.Parent = dropdownFrame
    dropdownButton.Size = UDim2.new(0, 120, 0, 30)
    dropdownButton.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(65, 65, 65)
    dropdownButton.Position = UDim2.new(0.74, 0, 0.113, 0)
    dropdownButton.Text = ""
    dropdownButton.Font = Enum.Font.ArialBold
    dropdownButton.TextSize = 14
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.BorderSizePixel = 0
    dropdownButton.TextTruncate = Enum.TextTruncate.AtEnd
    dropdownButton.AutoButtonColor = false

    local dropdownbuttoncorners = Instance.new("UICorner")
    dropdownbuttoncorners.CornerRadius = UDim.new(0, 4)
    dropdownbuttoncorners.Parent = dropdownButton
                    
    local dropdownList = Instance.new("Frame")
    dropdownList.Name = "DropdownList"
    dropdownList.Parent = tabContent
    dropdownList.Size = UDim2.new(0, 480, 0, #dropdownOptions.Items * 30)
    dropdownList.Position = UDim2.new(0, 0, 1, 0) -- Ensure this is correctly positioned
    dropdownList.BackgroundColor3 = Color3.fromRGB(40 ,40, 40)
    dropdownList.BorderSizePixel = 0
    dropdownList.Visible = false

    local dropdownListCorners = Instance.new("UICorner")
    dropdownListCorners.CornerRadius = UDim.new(0, 4)
    dropdownListCorners.Parent = dropdownList

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = dropdownList
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    dropdownButton.MouseButton1Click:Connect(function()
        dropdownList.Visible = not dropdownList.Visible
    end)

    for _, item in ipairs(dropdownOptions.Items) do
        local itemButton = Instance.new("TextButton")
        itemButton.Name = item
        itemButton.Parent = dropdownList
        itemButton.Size = UDim2.new(1, 0, 0, 30)
        itemButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        itemButton.Text = item
        itemButton.Font = Enum.Font.ArialBold
        itemButton.TextSize = 14
        itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemButton.BorderSizePixel = 0
        itemButton.AutoButtonColor = false
        itemButton.TextXAlignment = Enum.TextXAlignment.Left

        local itemPadding = Instance.new("UIPadding")
        itemPadding.Parent = itemButton
        itemPadding.PaddingLeft = UDim.new(0, 6)

        local itemButtonCorners = Instance.new("UICorner")
        itemButtonCorners.CornerRadius = UDim.new(0, 4)
        itemButtonCorners.Parent = itemButton

        itemButton.MouseButton1Click:Connect(function()
            dropdownButton.Text = item
            if dropdownOptions.Callback then
                dropdownOptions.Callback(item)
            end
            dropdownList.Visible = false
        end)
    end
end,
            }
        end,
    }
end

return UILib
