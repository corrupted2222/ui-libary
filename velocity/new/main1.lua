local SearcherUILibrary = {}



function SearcherUILibrary:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true

    local UserInputService = game:GetService("UserInputService")
local frame = MainFrame
local dragging
local dragInput
local dragStart
local startPos
local function update(input)
        local delta = input.Position - dragStart
		frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
                               input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
end)
frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
end)
    local mainframecorner = Instance.new("UICorner")
    mainframecorner.CornerRadius = UDim.new(0, 4)
    mainframecorner.Parent = MainFrame

    local ToggleButton = Instance.new("ImageButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Image = config.Icon or "rbxassetid://17376881029"
ToggleButton.Position = UDim2.new(0.5, -25, 0, -50) -- Start off-screen at the top center
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
ToggleButton.BackgroundTransparency = 1
ToggleButton.BorderSizePixel = 0
ToggleButton.Active = true
ToggleButton.Draggable = true

-- Tweening function
local function tweenToggleButton()
    local tweenService = game:GetService("TweenService")
    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

    -- Adjusted target position closer to the top of the screen
    local targetPosition = UDim2.new(0.5, -25, 0, -25)
    
    local tween = tweenService:Create(ToggleButton, tweenInfo, {Position = targetPosition})
    tween:Play()
end

-- Call the tweening function when the button is clicked
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Start the tween when the GUI loads
tweenToggleButton()

    local ToggleButtoncorners = Instance.new("UICorner")
    ToggleButtoncorners.CornerRadius = UDim.new(0, 4)
    ToggleButtoncorners.Parent = ToggleButton

    
    local TitleLabel = Instance.new("TextLabel", MainFrame)
    TitleLabel.Size = UDim2.new(0, 189, 0, 26)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.Text = config.Title or "Untitled"
    TitleLabel.Font = Enum.Font.ArialBold
    TitleLabel.TextSize = 15
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleLabel.BorderSizePixel = 0
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local TitleLabelPadding = Instance.new("UIPadding", TitleLabel)
    TitleLabelPadding.PaddingLeft = UDim.new(0, 5)

    local Line2 = Instance.new("Frame")
    Line2.Parent = MainFrame
    Line2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Line2.Position = UDim2.new(0.248, -2, 0.073, 0)
    Line2.BorderSizePixel = 0
    Line2.Size = UDim2.new(0, 1, 0, 325)

    local Line1 = Instance.new("Frame")
    Line1.Parent = MainFrame
    Line1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Line1.Position = UDim2.new(0, 0, 0.072, 0)
    Line1.BorderSizePixel = 0
    Line1.Size = UDim2.new(0, 600, 0, 1)

    local DiscordButton = Instance.new("TextButton")
    DiscordButton.Size = UDim2.new(0, 20, 0, 20)
    DiscordButton.Position = UDim2.new(0.88, 0, 0.01, 0)
    DiscordButton.Text = ""
    DiscordButton.Font = Enum.Font.ArialBold
    DiscordButton.TextSize = 14
    DiscordButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    DiscordButton.BorderSizePixel = 0
    DiscordButton.BackgroundTransparency = 1
    DiscordButton.AutoButtonColor = false
    DiscordButton.Parent = MainFrame

    local DiscordButtonCorners = Instance.new("UICorner")
    DiscordButtonCorners.CornerRadius = UDim.new(0, 3)
    DiscordButtonCorners.Parent = DiscordButton

    local Dsicord = Instance.new("ImageButton")
    Dsicord.Size = UDim2.new(0, 16, 0, 16)
    Dsicord.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Dsicord.Position = UDim2.new(0.1, 0, 0.1, 0)
    Dsicord.BorderSizePixel = 0
    Dsicord.BackgroundTransparency = 1
    Dsicord.Image = "http://www.roblox.com/asset/?id=120024655986535"
    Dsicord.Parent = DiscordButton
    Dsicord.MouseButton1Click:Connect(function()
    setclipboard("https://discord.com/invite/SRGBMaE7aT")
	game.StarterGui:SetCore("SendNotification", {Title = "Velocity"; Text = "Discord Server Copied!"; Duration = 3; Icon = "http://www.roblox.com/asset/?id=17403968010"})
end)
    
    local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(DiscordButton, hoverTweenInfo, {BackgroundTransparency = 0})
local normalColorTween = tweenService:Create(DiscordButton, hoverTweenInfo, {BackgroundTransparency = 1})

DiscordButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

DiscordButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)

    local CloseButton = Instance.new("TextButton")
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Position = UDim2.new(0.96, 0, 0.01, 0)
    CloseButton.Text = ""
    CloseButton.Font = Enum.Font.ArialBold
    CloseButton.TextSize = 14
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CloseButton.BorderSizePixel = 0
    CloseButton.BackgroundTransparency = 1
    CloseButton.AutoButtonColor = false
    CloseButton.Parent = MainFrame

    local CloseButtonCorners = Instance.new("UICorner")
    CloseButtonCorners.CornerRadius = UDim.new(0, 3)
    CloseButtonCorners.Parent = CloseButton

    local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(CloseButton, hoverTweenInfo, {BackgroundTransparency = 0})
local normalColorTween = tweenService:Create(CloseButton, hoverTweenInfo, {BackgroundTransparency = 1})

CloseButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

CloseButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)

    local Close = Instance.new("ImageButton")
    Close.Size = UDim2.new(0, 16, 0, 16)
    Close.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Close.Position = UDim2.new(0.1, 0, 0.1, 0)
    Close.BorderSizePixel = 0
    Close.BackgroundTransparency = 1
    Close.Image = "http://www.roblox.com/asset/?id=18420460106"
    Close.Parent = CloseButton
    Close.MouseButton1Click:Connect(function()
    MainFrame:Destroy()
    ToggleButton:Destroy()
end)

    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Size = UDim2.new(0, 20, 0, 20)
    MinimizeButton.Position = UDim2.new(0.92, 0, 0.01, 0)
    MinimizeButton.Text = ""
    MinimizeButton.Font = Enum.Font.ArialBold
    MinimizeButton.TextSize = 14
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.AutoButtonColor = false
    MinimizeButton.Parent = MainFrame

    local MinimizeButtonCorners = Instance.new("UICorner")
    MinimizeButtonCorners.CornerRadius = UDim.new(0, 3)
    MinimizeButtonCorners.Parent = MinimizeButton

        local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(MinimizeButton, hoverTweenInfo, {BackgroundTransparency = 0})
local normalColorTween = tweenService:Create(MinimizeButton, hoverTweenInfo, {BackgroundTransparency = 1})

MinimizeButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

MinimizeButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)
      

    local Minimize = Instance.new("ImageButton")
    Minimize.Size = UDim2.new(0, 16, 0, 16)
    Minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Minimize.Position = UDim2.new(0.1, 0, 0.1, 0)
    Minimize.BorderSizePixel = 0
    Minimize.BackgroundTransparency = 1
    Minimize.Image = "http://www.roblox.com/asset/?id=18642001126"
    Minimize.Parent = MinimizeButton
    Minimize.MouseButton1Click:Connect(function()
     MainFrame.Visible = not MainFrame.Visible
     end)


    return {
        MainFrame = MainFrame,
        Tabs = {},
    }
end

function SearcherUILibrary:AddTab(window, config)
    -- Create or find TabFrame
    local TabFrame = window.MainFrame:FindFirstChild("TabFrame") or Instance.new("ScrollingFrame", window.MainFrame)
    TabFrame.Size = UDim2.new(0, 140, 0, 315)
    TabFrame.Position = UDim2.new(0.01, 0, 0.087, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabFrame.BorderSizePixel = 0
    TabFrame.Name = "TabFrame"
    TabFrame.ScrollBarThickness = 0
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    TabFrame.ScrollingEnabled = true
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

    local ListLayout = Instance.new("UIListLayout", TabFrame)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 5)

    local function updateTabScrolling()
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
        TabFrame.ScrollingEnabled = TabFrame.CanvasSize.Y.Offset > TabFrame.AbsoluteSize.Y
    end

    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateTabScrolling)
    updateTabScrolling()

    -- Create TabButton
    local TabButton = Instance.new("TextButton", TabFrame)
    TabButton.Size = UDim2.new(0, 135, 0, 30)
    TabButton.BackgroundTransparency = config.Transparency or 1
    TabButton.BackgroundColor3 = config.Background or Color3.fromRGB(50, 50, 50)
    TabButton.BorderSizePixel = 0
    TabButton.AutoButtonColor = false
    TabButton.Text = ""

    local tabButtonCorners = Instance.new("UICorner")
    tabButtonCorners.CornerRadius = UDim.new(0, 3)
    tabButtonCorners.Parent = TabButton

    local TabLabel = Instance.new("TextLabel", TabButton)
    TabLabel.Size = UDim2.new(0, 135, 0, 30)
    TabLabel.Text = config.Game or "Untitled"
    TabLabel.Font = Enum.Font.ArialBold
    TabLabel.TextSize = 14
    TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabLabel.BackgroundTransparency = 1
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left
    TabLabel.TextYAlignment = Enum.TextYAlignment.Center
    TabLabel.TextWrapped = true

    local TextLabelPadding = Instance.new("UIPadding", TabLabel)
    TextLabelPadding.PaddingLeft = UDim.new(0, 5)

    -- Create ContentFrame
    local ContentFrame = Instance.new("ScrollingFrame", window.MainFrame)
    ContentFrame.Size = UDim2.new(0, 444, 0, 317)
    ContentFrame.Position = UDim2.new(0.26, 0, 0.084, 0)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.ScrollingEnabled = false
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Visible = config.Visible or false

    local ContentLayout = Instance.new("UIListLayout", ContentFrame)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 5)

    local function updateContentScrolling()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        ContentFrame.ScrollingEnabled = ContentFrame.CanvasSize.Y.Offset > ContentFrame.AbsoluteSize.Y
    end

    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContentScrolling)
    updateContentScrolling()

    local tweenService = game:GetService("TweenService")
    local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local hoverColorTween = tweenService:Create(TabButton, hoverTweenInfo, {BackgroundTransparency = 0.6})
    local normalColorTween = tweenService:Create(TabButton, hoverTweenInfo, {BackgroundTransparency = 1})

    local function shouldIgnoreEvents()
        return TabButton.BackgroundColor3 == Color3.fromRGB(6, 201, 255)
    end

    TabButton.MouseEnter:Connect(function()
        if not shouldIgnoreEvents() then
            hoverColorTween:Play()
        end
    end)

    TabButton.MouseLeave:Connect(function()
        if not shouldIgnoreEvents() then
            normalColorTween:Play()
        end
    end)

    local function onTabButtonClick()
        -- Reset all tab buttons
        for _, child in ipairs(TabFrame:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                child.BackgroundTransparency = 1
            end
        end

        -- Hide all content frames
        for _, child in ipairs(window.MainFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") and child.Name == "ContentFrame" then
                child.Visible = false
            end
        end

        -- Show selected tab content
        TabButton.BackgroundColor3 = Color3.fromRGB(6, 201, 255)
        TabButton.BackgroundTransparency = 0.6
        ContentFrame.Visible = true
        window.SelectedTab = TabButton
    end

    TabButton.MouseButton1Click:Connect(onTabButtonClick)

    -- Register the tab
    window.Tabs[config.Game or "Untitled"] = {
        Button = TabButton,
        Frame = ContentFrame,
    }

    return {
        ContentFrame = ContentFrame,
        TabButton = TabButton,
    }
end








function SearcherUILibrary:AddButton(tab, config)
    local ContentFrame = tab.ContentFrame

    local ButtonFrame = Instance.new("TextButton")
    ButtonFrame.Size = UDim2.new(0, 437, 0, 40)
    ButtonFrame.BackgroundColor3 = Color3.fromRGB(45,45,45)
    ButtonFrame.BorderSizePixel = 0
    ButtonFrame.Parent = ContentFrame
    ButtonFrame.BackgroundTransparency = 0
    ButtonFrame.Font = Enum.Font.ArialBold
    ButtonFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
    ButtonFrame.TextSize = 17
    ButtonFrame.AutoButtonColor = false
    ButtonFrame.TextXAlignment = Enum.TextXAlignment.Left
    ButtonFrame.Text = config.Title or ""

    local ButtonFrameCorners = Instance.new("UICorner")
    ButtonFrameCorners.CornerRadius = UDim.new(0, 3)
    ButtonFrameCorners.Parent = ButtonFrame

    local ButtonFramePadding = Instance.new("UIPadding", ButtonFrame)
    ButtonFramePadding.PaddingLeft = UDim.new(0, 5)

    local ExecuteButton = Instance.new("TextLabel", ButtonFrame)
    ExecuteButton.Size = UDim2.new(0, 80, 0, 27)
    ExecuteButton.Position = UDim2.new(0.8, 0, 0.14, 0)
    ExecuteButton.Text = "Button"
    ExecuteButton.Font = Enum.Font.Arial
    ExecuteButton.TextSize = 12
    ExecuteButton.TextColor3 = Color3.fromRGB(130,130,130)
    ExecuteButton.BackgroundTransparency = 1

    local tweenService = game:GetService("TweenService")
    local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    local hoverColorTween = tweenService:Create(ButtonFrame, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(55,55,55)})
    local normalColorTween = tweenService:Create(ButtonFrame, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(45,45,45)})

    ButtonFrame.MouseEnter:Connect(function()
        hoverColorTween:Play()
    end)

    ButtonFrame.MouseLeave:Connect(function()
        normalColorTween:Play()
    end)

    local ExecuteButtonCorners = Instance.new("UICorner")
    ExecuteButtonCorners.CornerRadius = UDim.new(0, 3)
    ExecuteButtonCorners.Parent = ExecuteButton

    ButtonFrame.MouseButton1Click:Connect(function()
            if config.Callback then
            config.Callback()
        end
    end)

    local function updateScrolling()
        if ContentFrame:FindFirstChild("UIListLayout") then
            ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentFrame.UIListLayout.AbsoluteContentSize.Y)
            ContentFrame.ScrollingEnabled = ContentFrame.CanvasSize.Y.Offset > ContentFrame.AbsoluteSize.Y
        end
    end

    -- Update scrolling after adding the script
    updateScrolling()

    return ButtonFrame
end

local TweenService = game:GetService("TweenService")





function SearcherUILibrary:AddDropdown(tab, config)
    local ContentFrame = tab.ContentFrame

    local DropdownFrame = Instance.new("Frame")
    DropdownFrame.Size = UDim2.new(0, 437, 0, 40)
    DropdownFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    DropdownFrame.BorderSizePixel = 0
    DropdownFrame.Parent = ContentFrame

    local DropDownFrameCorners = Instance.new("UICorner")
    DropDownFrameCorners.CornerRadius = UDim.new(0, 3)
    DropDownFrameCorners.Parent = DropdownFrame

    local DropDownFramePadding = Instance.new("UIPadding", DropdownFrame)
    DropDownFramePadding.PaddingLeft = UDim.new(0, 5)

    local TitleText = Instance.new("TextLabel")
    TitleText.Size = UDim2.new(0, 357, 1, 0)
    TitleText.BackgroundTransparency = 1
    TitleText.Text = config.Title or ""
    TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleText.Font = Enum.Font.ArialBold
    TitleText.TextSize = 17
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.TextYAlignment = Enum.TextYAlignment.Top
    TitleText.Parent = DropdownFrame

    local TitleTextPadding = Instance.new("UIPadding", TitleText)
    TitleTextPadding.PaddingTop = UDim.new(0, 10)

    local DropdownButtonFrame = Instance.new("Frame")
    DropdownButtonFrame.Size = UDim2.new(0, 120, 0, 40)
    DropdownButtonFrame.Position = UDim2.new(1, -165, 0, 0)
    DropdownButtonFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    DropdownButtonFrame.BackgroundTransparency = 1
    DropdownButtonFrame.Parent = DropdownFrame

    local DropdownButton = Instance.new("TextButton")
    DropdownButton.Size = UDim2.new(0, 120, 0, 30)
    DropdownButton.Position = UDim2.new(1, -80, 0.13, 0)
    DropdownButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    DropdownButton.Text = ""
    DropdownButton.Font = Enum.Font.ArialBold
    DropdownButton.TextSize = 14
    DropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownButton.Parent = DropdownButtonFrame
    DropdownButton.AutoButtonColor = false

    local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(DropdownButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(65,65,65)})
local normalColorTween = tweenService:Create(DropdownButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(55, 55, 55)})

DropdownButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

DropdownButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)

    local DropdownButtonCorners = Instance.new("UICorner")
    DropdownButtonCorners.CornerRadius = UDim.new(0, 3)
    DropdownButtonCorners.Parent = DropdownButton

    local itemList = Instance.new("Frame")
    itemList.Size = UDim2.new(1, 0, 0, 0) -- Start with height 0
    itemList.Position = UDim2.new(0, 0, 1, 0)
    itemList.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
    itemList.BorderSizePixel = 0
    itemList.BackgroundTransparency = 1
    itemList.ClipsDescendants = true
    itemList.Parent = DropdownFrame

    local listLayout = Instance.new("UIListLayout", itemList)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

    for _, item in ipairs(config.Items or {}) do
        local ItemButton = Instance.new("TextButton")
        ItemButton.Size = UDim2.new(1, -10, 0, 30)
        ItemButton.Position = UDim2.new(0, 5, 0, 0)
        ItemButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        ItemButton.Text = item
        ItemButton.Font = Enum.Font.ArialBold
        ItemButton.BackgroundTransparency = 1
        ItemButton.TextSize = 14
        ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        ItemButton.Parent = itemList
        ItemButton.TextXAlignment = Enum.TextXAlignment.Left

        local Itembuttoncorner = Instance.new("UIPadding", ItemButton)
        Itembuttoncorner.PaddingLeft = UDim.new(0, 5)

        ItemButton.MouseButton1Click:Connect(function()
            DropdownButton.Text = item
            DropdownFrame.Size = UDim2.new(0, 437, 0, 40)
            itemList.Size = UDim2.new(1, 0, 0, 0)
            isOpen = false
            if config.Callback then
                config.Callback(item)
            end
        end)
    end

    local isOpen = false
    DropdownButton.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        local dropdownTargetSize = isOpen and UDim2.new(0, 437, 0, 40 + #config.Items * 30) or UDim2.new(0, 437, 0, 40)
        local itemListTargetSize = isOpen and UDim2.new(1, 0, 0, #config.Items * 30) or UDim2.new(1, 0, 0, 0)

        -- Position items inside the itemList frame
        itemList.Position = isOpen and UDim2.new(0, 0, 0, 40) or UDim2.new(0, 0, 1, 0)

        -- Resize the frames directly without tweening
        DropdownFrame.Size = dropdownTargetSize
        itemList.Size = itemListTargetSize

        -- Show/Hide item buttons based on the state
        for _, itemButton in ipairs(itemList:GetChildren()) do
            if itemButton:IsA("TextButton") then
                itemButton.Visible = isOpen
            end
        end
    end)

    local function updateScrolling()
        if ContentFrame:FindFirstChild("UIListLayout") then
            ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentFrame.UIListLayout.AbsoluteContentSize.Y)
            ContentFrame.ScrollingEnabled = ContentFrame.CanvasSize.Y.Offset > ContentFrame.AbsoluteSize.Y
        end
    end

    updateScrolling()

    return DropdownFrame
end

function SearcherUILibrary:AddToggle(tab, config)
    local ContentFrame = tab.ContentFrame

    local ToggleFrame = Instance.new("TextButton")
    ToggleFrame.Size = UDim2.new(0, 437, 0, 40)
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(45,45,45)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Parent = ContentFrame
    ToggleFrame.BackgroundTransparency = 0
    ToggleFrame.Font = Enum.Font.ArialBold
    ToggleFrame.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleFrame.TextSize = 17
    ToggleFrame.AutoButtonColor = false
    ToggleFrame.TextXAlignment = Enum.TextXAlignment.Left
    ToggleFrame.Text = config.Title or ""

    local ToggleFrameCorners = Instance.new("UICorner")
    ToggleFrameCorners.CornerRadius = UDim.new(0, 3)
    ToggleFrameCorners.Parent = ToggleFrame

    local ToggleFramePadding = Instance.new("UIPadding", ToggleFrame)
    ToggleFramePadding.PaddingLeft = UDim.new(0, 5)


    -- Create the toggle button frame
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0, 50, 0, 25)
    toggleFrame.Position = UDim2.new(1, -60, 0.5, -12)
    toggleFrame.BackgroundColor3 = Color3.fromRGB(45,45,45)
    toggleFrame.BorderSizePixel = 0
    toggleFrame.Parent = ToggleFrame
    
    local toggleframecorners = Instance.new("UICorner")
    toggleframecorners.CornerRadius = UDim.new(0, 50)
    toggleframecorners.Parent = toggleFrame

    local uiStroke = Instance.new("UIStroke")
    uiStroke.Thickness = 1
    uiStroke.Color = Color3.fromRGB(65,65,65)
    uiStroke.Parent = toggleFrame

    -- Create the toggle circle
    local toggleCircle = Instance.new("Frame")
    toggleCircle.Size = UDim2.new(0, 20, 0, 20)
    toggleCircle.Position = UDim2.new(0, 2, 0, 2.5)
    toggleCircle.BackgroundColor3 = Color3.fromRGB(80,80,80)
    toggleCircle.BorderSizePixel = 0
    toggleCircle.Parent = toggleFrame

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(1, 0)
    uiCorner.Parent = toggleCircle

    -- Toggle state
    local isOn = false

    local function toggle()
        isOn = not isOn
        if isOn then
            toggleCircle:TweenPosition(UDim2.new(1, -22, 0, 2.5), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2, true)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(6, 201, 255)  
            toggleFrame.BackgroundTransparency = 0.4
            toggleCircle.BackgroundColor3 = Color3.fromRGB(6, 201, 255) 
        else
            toggleCircle:TweenPosition(UDim2.new(0, 2, 0, 2.5), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2, true)
            toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
            toggleFrame.BackgroundTransparency = 0
            toggleCircle.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        end

        -- Call the callback function and pass the toggle state
        if config.Callback then
            config.Callback(isOn)
        end
    end

    -- Connect the toggle function to the toggle button
    toggleFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            toggle()
        end
    end)

    return ToggleFrame
end


function SearcherUILibrary:AddSlider(tab, config)
    local ContentFrame = tab.ContentFrame

    local slider = Instance.new("TextButton")
    slider.Parent = ContentFrame
    slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    slider.Position = UDim2.new(0, 0, 0, 0)
    slider.Size = UDim2.new(0, 437, 0, 40)
    slider.Text = config.Title or "Slider"
    slider.TextSize = 16
    slider.Font = Enum.Font.ArialBold
    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
    slider.AutoButtonColor = false
    slider.Active = false
    slider.TextXAlignment = Enum.TextXAlignment.Left

    local sliderCorners = Instance.new("UICorner")
    sliderCorners.CornerRadius = UDim.new(0, 4)
    sliderCorners.Parent = slider

    local sliderPadding = Instance.new("UIPadding")
    sliderPadding.Parent = slider
    sliderPadding.PaddingLeft = UDim.new(0, 6)

    local sliderBar = Instance.new("Frame")
    sliderBar.Name = "SliderBar"
    sliderBar.Parent = slider
    sliderBar.Size = UDim2.new(0, 185, 0, 5)
    sliderBar.Position = UDim2.new(0.753, -90, 0.5, -5)
    sliderBar.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    sliderBar.BorderSizePixel = 0

    local sliderButton = Instance.new("ImageButton")
    sliderButton.Name = "SliderButton"
    sliderButton.Parent = sliderBar
    sliderButton.Size = UDim2.new(0, 15, 0, 15)
    sliderButton.Position = UDim2.new(0.5, -7.5, 0.2, -10) -- Centered position
    sliderButton.BackgroundColor3 = Color3.fromRGB(6, 201, 255)
    sliderButton.Image = ""
    sliderButton.BorderSizePixel = 0
    sliderButton.AutoButtonColor = false

    local sliderButtonCorners = Instance.new("UICorner")
    sliderButtonCorners.CornerRadius = UDim.new(0, 50)
    sliderButtonCorners.Parent = sliderButton

    local sliderLine = Instance.new("Frame")
    sliderLine.Name = "SliderLine"
    sliderLine.Parent = sliderBar
    sliderLine.Size = UDim2.new(0, 0, 0, 7)
    sliderLine.Position = UDim2.new(0, 0, 0, 0)
    sliderLine.BackgroundColor3 = Color3.fromRGB(6, 201, 255) 
    sliderLine.BorderSizePixel = 0

    local valueBox = Instance.new("TextBox")
    valueBox.Parent = slider
    valueBox.Size = UDim2.new(0, 30, 0, 30)
    valueBox.Position = UDim2.new(0.44, 0, 0.113, 0)
    valueBox.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
    valueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    valueBox.TextSize = 14
    valueBox.Font = Enum.Font.ArialBold
    valueBox.Text = tostring(config.Min or 0)
    valueBox.TextTruncate = Enum.TextTruncate.AtEnd

    local valueBoxCorners = Instance.new("UICorner")
    valueBoxCorners.CornerRadius = UDim.new(0, 4)
    valueBoxCorners.Parent = valueBox

    local sliderValue = config.Min or 0
    local maxValue = config.Max or 100

    local function updateSlider(position)
        local relativePos = math.clamp(position, 0, 1)
        sliderButton.Position = UDim2.new(relativePos, -7.5, 0.8, -10)
        sliderLine.Size = UDim2.new(relativePos, 0, 0, 5)
        sliderValue = math.floor(relativePos * (maxValue - config.Min) + config.Min)
        valueBox.Text = tostring(sliderValue)
        if config.Callback then
            config.Callback(sliderValue)
        end
    end

    local function startDragging(input)
        local moveConnection
        local releaseConnection

        moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(inputChanged)
            if inputChanged.UserInputType == Enum.UserInputType.MouseMovement or inputChanged.UserInputType == Enum.UserInputType.Touch then
                local relativePos = (inputChanged.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
                updateSlider(relativePos)
            end
        end)

        releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(inputEnded)
            if inputEnded.UserInputType == Enum.UserInputType.MouseButton1 or inputEnded.UserInputType == Enum.UserInputType.Touch then
                moveConnection:Disconnect()
                releaseConnection:Disconnect()
            end
        end)
    end

    sliderButton.MouseButton1Down:Connect(startDragging)
    sliderButton.TouchTap:Connect(startDragging)

    valueBox.FocusLost:Connect(function(enterPressed)
        local inputValue = tonumber(valueBox.Text)
        if inputValue then
            local clampedValue = math.clamp(inputValue, config.Min, maxValue)
            local relativePos = (clampedValue - config.Min) / (maxValue - config.Min)
            updateSlider(relativePos)
        else
            valueBox.Text = tostring(config.Min)
            updateSlider(0)
        end
    end)

    updateSlider((sliderValue - config.Min) / (maxValue - config.Min))

    return slider
end

return SearcherUILibrary
