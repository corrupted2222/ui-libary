local UILib = {}

function UILib:CreateWindow(options)
    local success, err = pcall(function()
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Parent = game:GetService("CoreGui")
        
        local MainFrame = Instance.new("Frame")
        MainFrame.Parent = ScreenGui
        MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        MainFrame.Position = UDim2.new(0.5, -100, 0.5, -70)
        MainFrame.Size = UDim2.new(0, 500, 0, 300)
        MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        MainFrame.Active = true
        
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
        
        -- Use options for size if provided
        local gameTitleWidth = options.GameTitleWidth or GameTitle.TextBounds.X + 10
        local gameTitleHeight = 30
        GameTitle.Size = UDim2.new(0, gameTitleWidth, 0, gameTitleHeight)

        -- Use options for position if provided
        local gameTitlePosX = options.GameTitlePosX or 0.592
        local gameTitlePosY = 0.09
        GameTitle.Position = UDim2.new(gameTitlePosX, 0, gameTitlePosY, 0)
        
        GameTitle:GetPropertyChangedSignal("TextBounds"):Connect(function()
            if not options.GameTitleWidth then
                GameTitle.Size = UDim2.new(0, GameTitle.TextBounds.X + 10, 0, gameTitleHeight) -- Add padding of 10
            end
        end)
        
        GameTitle.Text = options.Game or "Game Name" -- This triggers the TextBounds update
        
        local GameTitleCorners = Instance.new("UICorner")
        GameTitleCorners.CornerRadius = UDim.new(0, 4)
        GameTitleCorners.Parent = GameTitle
        
        local HeaderCorners = Instance.new("UICorner")
        HeaderCorners.CornerRadius = UDim.new(0, 4)
        HeaderCorners.Parent = Header
        
        local TabsHolder = Instance.new("Frame")
        TabsHolder.Parent = MainFrame
        TabsHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        TabsHolder.Position = UDim2.new(1.025, 0, 0, 0)
        TabsHolder.Size = UDim2.new(0, 54, 0, 300)
        
        local TabsHolderCorners = Instance.new("UICorner")
        TabsHolderCorners.CornerRadius = UDim.new(0, 4)
        TabsHolderCorners.Parent = TabsHolder
    end)

    if not success then
        warn("Failed to create UI in CoreGui: " .. tostring(err))
    end
    
    return UILib
end

return UILib
