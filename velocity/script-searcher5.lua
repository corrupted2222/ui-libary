local SearcherUILibrary = {}

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

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

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function SearcherUILibrary:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0

    local mainframecorner = Instance.new("UICorner")
    mainframecorner.CornerRadius = UDim.new(0, 4)
    mainframecorner.Parent = MainFrame

    local ToggleButton = Instance.new("ImageButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Image = config.Icon or "rbxassetid://17376881029"
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

    makeDraggable(MainFrame)
    
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

    local Close = Instance.new("ImageButton")
    Close.Size = UDim2.new(0, 16, 0, 16)
    Close.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Close.Position = UDim2.new(0.96, 0, 0.015, 0)
    Close.BorderSizePixel = 0
    Close.BackgroundTransparency = 1
    Close.Image = "http://www.roblox.com/asset/?id=18420460106"
    Close.Parent = MainFrame
    Close.MouseButton1Click:Connect(function()
    MainFrame:Destroy()
    ToggleButton:Destroy()
end)

    local Minimize = Instance.new("ImageButton")
    Minimize.Size = UDim2.new(0, 16, 0, 16)
    Minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Minimize.Position = UDim2.new(0.917, 0, 0.015, 0)
    Minimize.BorderSizePixel = 0
    Minimize.BackgroundTransparency = 1
    Minimize.Image = "http://www.roblox.com/asset/?id=18642001126"
    Minimize.Parent = MainFrame
    Minimize.MouseButton1Click:Connect(function()
     MainFrame.Visible = not MainFrame.Visible
     end)

    local SearchBox = Instance.new("TextBox", MainFrame)
    SearchBox.Size = UDim2.new(0, 135, 0, 27)
    SearchBox.Position = UDim2.new(0.01, 0, 0, 30)
    SearchBox.PlaceholderText = "Search..."
    SearchBox.Font = Enum.Font.ArialBold
    SearchBox.TextSize = 15
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SearchBox.BorderSizePixel = 0
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.Text = ""

    local SearchBoxPadding = Instance.new("UIPadding")
    SearchBoxPadding.Parent = SearchBox
    SearchBoxPadding.PaddingLeft = UDim.new(0, 5)

    local searchBoxCorners = Instance.new("UICorner")
    searchBoxCorners.CornerRadius = UDim.new(0, 3)
    searchBoxCorners.Parent = SearchBox

    SearchBox.Changed:Connect(function()
        local text = SearchBox.Text:lower()
        local buttons = MainFrame:FindFirstChild("TabFrame"):GetDescendants()
        for _, button in pairs(buttons) do
            if button:IsA("ImageButton") then
                local buttonText = button:FindFirstChildOfClass("TextLabel")
                if buttonText and string.find(buttonText.Text:lower(), text) then
                    button.Visible = true
                else
                    button.Visible = false
                end
            end
        end
    end)


    return {
        MainFrame = MainFrame,
        SearchBox = SearchBox,
        Tabs = {},
    }
end

function SearcherUILibrary:AddTab(window, config)
    local TabFrame = window.MainFrame:FindFirstChild("TabFrame") or Instance.new("ScrollingFrame", window.MainFrame)
    TabFrame.Size = UDim2.new(0, 135, 0, 274)
    TabFrame.Position = UDim2.new(0.01, 0, 0.178, 0)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabFrame.BorderSizePixel = 0
    TabFrame.Name = "TabFrame"
    TabFrame.ScrollBarThickness = 4
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    TabFrame.ScrollingEnabled = false
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)

    local ListLayout = Instance.new("UIListLayout", TabFrame)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 5)

    local function TabupdateScrolling()
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
        TabFrame.ScrollingEnabled = TabFrame.CanvasSize.Y.Offset > TabFrame.AbsoluteSize.Y
    end

    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(TabupdateScrolling)
    
    local TabButton = Instance.new("ImageButton", TabFrame)
    TabButton.Size = UDim2.new(0, 135, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.BorderSizePixel = 0
    TabButton.Image = config.Icon or ""
    TabButton.ImageColor3 = Color3.fromRGB(89, 89, 89) 
    TabButton.ImageTransparency = 0.23
    TabButton.BackgroundTransparency = 1

    local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(TabButton, hoverTweenInfo, {ImageColor3 = Color3.fromRGB(197, 197, 197)})
local normalColorTween = tweenService:Create(TabButton, hoverTweenInfo, {ImageColor3 = Color3.fromRGB(89, 89, 89)})

TabButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

TabButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)
        
    local tabButtonCorners = Instance.new("UICorner")
    tabButtonCorners.CornerRadius = UDim.new(0, 3)
    tabButtonCorners.Parent = TabButton

    local TabLabel = Instance.new("TextLabel")
    TabLabel.Size = UDim2.new(0, 135, 0, 30)
    TabLabel.Text = config.Game or "Untitled"
    TabLabel.Font = Enum.Font.ArialBold
    TabLabel.TextSize = 14
    TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Parent = TabButton
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left
    TabLabel.TextYAlignment = Enum.TextYAlignment.Center
    TabLabel.TextWrapped = true

    local TextLabelPadding = Instance.new("UIPadding")
    TextLabelPadding.Parent = TabLabel
    TextLabelPadding.PaddingLeft = UDim.new(0, 5)
    
    -- Create ContentFrame
    local ContentFrame = Instance.new("ScrollingFrame", window.MainFrame)
    ContentFrame.Size = UDim2.new(0, 444, 0, 317)
    ContentFrame.Position = UDim2.new(0.26, 0, 0.084, 0)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.ScrollingEnabled = false
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Visible = false
    ContentFrame.BackgroundTransparency = 1

    local ContentLayout = Instance.new("UIListLayout", ContentFrame)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 5)

    local function updateContentScrolling()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        ContentFrame.ScrollingEnabled = ContentFrame.CanvasSize.Y.Offset > ContentFrame.AbsoluteSize.Y
    end



    TabButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(window.MainFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") and child.Name == "ContentFrame" then
                child.Visible = false
            end
        end
        ContentFrame.Visible = true
    end)

    window.Tabs[config.Game or "Untitled"] = {
        Button = TabButton,
        Frame = ContentFrame,
    }

    updateContentScrolling()
    TabupdateScrolling()

    return {
        ContentFrame = ContentFrame,
        TabButton = TabButton,
    }
end


function SearcherUILibrary:AddScript(tab, config)
    local ContentFrame = tab.ContentFrame

    local ScriptFrame = Instance.new("ImageLabel")
    ScriptFrame.Size = UDim2.new(0, 437, 0, 40)
    ScriptFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ScriptFrame.BorderSizePixel = 0
    ScriptFrame.Image = config.Icon or ""
    ScriptFrame.Parent = ContentFrame
    ScriptFrame.ImageColor3 = Color3.fromRGB(89, 89, 89) 
    ScriptFrame.ImageTransparency = 0.23
    ScriptFrame.BackgroundTransparency = 1

    local ScriptFrameCorners = Instance.new("UICorner")
    ScriptFrameCorners.CornerRadius = UDim.new(0, 3)
    ScriptFrameCorners.Parent = ScriptFrame

    local ScriptLabel = Instance.new("TextLabel", ScriptFrame)
    ScriptLabel.Size = UDim2.new(0, 115, 0, 30)
    ScriptLabel.Position = UDim2.new(0.02, 0, 0.1, 0)
    ScriptLabel.Text = config.Title or "Script"
    ScriptLabel.Font = Enum.Font.ArialBold
    ScriptLabel.TextSize = 17
    ScriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptLabel.BackgroundTransparency = 1
    ScriptLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ExecuteButton = Instance.new("TextButton", ScriptFrame)
    ExecuteButton.Size = UDim2.new(0, 80, 0, 27)
    ExecuteButton.Position = UDim2.new(0.8, 0, 0.14, 0)
    ExecuteButton.Text = "Execute"
    ExecuteButton.Font = Enum.Font.ArialBold
    ExecuteButton.TextSize = 14
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.AutoButtonColor = false
    ExecuteButton.TextWrapped = true

        local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(ExecuteButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(45,45,45)})
local normalColorTween = tweenService:Create(ExecuteButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(25,25,25)})

ExecuteButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

ExecuteButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)

    local ExecuteButtonCorners = Instance.new("UICorner")
    ExecuteButtonCorners.CornerRadius = UDim.new(0, 3)
    ExecuteButtonCorners.Parent = ExecuteButton

    local function updateScrolling()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentFrame.UIListLayout.AbsoluteContentSize.Y)
        ContentFrame.ScrollingEnabled = ContentFrame.CanvasSize.Y.Offset > ContentFrame.AbsoluteSize.Y
    end

    ExecuteButton.MouseButton1Click:Connect(function()
        if config.Callback then
            config.Callback()
        end
    end)


    return ScriptFrame
end

return SearcherUILibrary
