local SearcherUILibrary = {}



function SearcherUILibrary:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false

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
    setclipboard("https://discord.com/invite/qnrw8JVDvf")
	game.StarterGui:SetCore("SendNotification", {Title = "Zygarde"; Text = "Discord Server Copied!"; Duration = 3; Icon = "rbxassetid://17376881029"})
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
        return TabButton.BackgroundColor3 == Color3.fromRGB(196, 237, 112)
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
        TabButton.BackgroundColor3 = Color3.fromRGB(196, 237, 112)
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

return SearcherUILibrary
