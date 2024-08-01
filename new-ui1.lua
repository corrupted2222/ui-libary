local UILib = {}

function UILib:CreateWindow(options)
    local CoreGui = game:GetService("CoreGui")
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = CoreGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 500, 0, 300)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.Active = true
    MainFrame.Draggable = true

    local MainFrameCorners = Instance.new("UICorner")
    MainFrameCorners.CornerRadius = UDim.new(0, 4)
    MainFrameCorners.Parent = MainFrame

    local Header = Instance.new("Frame")
    Header.Parent = MainFrame
    Header.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Header.Position = UDim2.new(0, 0, 0, 0)
    Header.Size = UDim2.new(1, 0, 0, 36)
    Header.Active = true

    local Title = Instance.new("TextLabel")
    Title.Parent = Header
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Title.Size = UDim2.new(0, 200, 0, 36)
    Title.Position = UDim2.new(0.01, 0, 0, 0)
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 17
    Title.Text = options.Title or "Name Of UI"
    Title.Font = Enum.Font.ArialBold
    Title.BackgroundTransparency = 1
    Title.TextXAlignment = Enum.TextXAlignment.Left

    local GameTitle = Instance.new("TextLabel")
    GameTitle.Parent = Header
    GameTitle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    GameTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    GameTitle.TextSize = 14
    GameTitle.Text = options.Game or "Game Name"
    GameTitle.Font = Enum.Font.ArialBold
    GameTitle.BackgroundTransparency = 0
    local gameTitleWidth = tonumber(options.GameTitleWidth) or 80
    local gameTitleHeight = 30
    GameTitle.Size = UDim2.new(0, gameTitleWidth, 0, gameTitleHeight)
    local gameTitlePosX = tonumber(options.GameTitlePosX) or 0.83
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

    local TabsHolder = Instance.new("Frame")
    TabsHolder.Parent = MainFrame
    TabsHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabsHolder.Position = UDim2.new(0, 0, 0.12, 0)
    TabsHolder.Size = UDim2.new(1, 0, 0, 36)

    local TabsHolderCorners = Instance.new("UICorner")
    TabsHolderCorners.CornerRadius = UDim.new(0, 4)
    TabsHolderCorners.Parent = TabsHolder

    local TabsHolderFrame = Instance.new("ScrollingFrame")
    TabsHolderFrame.Parent = TabsHolder
    TabsHolderFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabsHolderFrame.Position = UDim2.new(0.02, 0, 0, 0)
    TabsHolderFrame.Size = UDim2.new(0.96, 0, 1, 0)
    TabsHolderFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabsHolderFrame.ScrollBarThickness = 0
    TabsHolderFrame.BackgroundTransparency = 1
    TabsHolderFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
    TabsHolderFrame.Active = true

    local TabsGridLayout = Instance.new("UIListLayout")
    TabsGridLayout.Parent = TabsHolderFrame
    TabsGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsGridLayout.Padding = UDim.new(0, 5)

    local TabHolders = Instance.new("Frame")
    TabHolders.Parent = MainFrame
    TabHolders.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TabHolders.Position = UDim2.new(0.0192, 0, 0.24, 0)
    TabHolders.Size = UDim2.new(0.96, 0, 0.76, 0)
    TabHolders.BackgroundTransparency = 1

    local function createTab(options)
        local TabButton = Instance.new("ImageButton")
        TabButton.Parent = TabsHolderFrame
        TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabButton.Size = UDim2.new(0, 100, 0, 36)
        TabButton.Image = options.Icon
        TabButton.BackgroundTransparency = 1

        local TabLabel = Instance.new("TextLabel")
        TabLabel.Parent = TabButton
        TabLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TabLabel.Size = UDim2.new(1, 0, 1, 0)
        TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabLabel.TextSize = 14
        TabLabel.Text = options.Title
        TabLabel.Font = Enum.Font.ArialBold
        TabLabel.BackgroundTransparency = 1
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left
        TabLabel.Position = UDim2.new(1.1, 0, 0, 0)

        local TabContent = Instance.new("Frame")
        TabContent.Parent = TabHolders
        TabContent.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        TabContent.Size = UDim2.new(1, 0, 1, 0)
        TabContent.Visible = false

        TabButton.MouseButton1Click:Connect(function()
            for _, tab in pairs(TabHolders:GetChildren()) do
                tab.Visible = false
            end
            TabContent.Visible = true
        end)

        return TabContent
    end

    return {
        AddTab = createTab
    }
end

return UILib
