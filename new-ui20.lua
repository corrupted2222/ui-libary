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

    local TabsHolder = Instance.new("Frame")
    TabsHolder.Parent = MainFrame
    TabsHolder.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabsHolder.Position = UDim2.new(1.025, 0, 0, 0)
    TabsHolder.Size = UDim2.new(0, 54, 0, 300)

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
        Title.Text = "zygarde | " .. tab.title
    end
    
    return {
        AddTab = function(self, tabOptions)
            local tabButton = Instance.new("TextButton")
            tabButton.Name = tabOptions.Title or "Tab"
            tabButton.Parent = TabsHolderFrame
            tabButton.BackgroundColor3 = Color3.fromRGB(40,40,40)
            tabButton.Position = UDim2.new(0, 0, 0, 0)
            tabButton.Size = UDim2.new(0,126,0,34)
            tabButton.Text = ""
            tabButton.TextSize = 14 
            tabButton.Font = Enum.Font.ArialBold 
            tabButton.TextColor3 = Color3.fromRGB(255,255,255)
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

            local tabContent = Instance.new("Frame")
            tabContent.Name = tabOptions.Title or "TabContent"
            tabContent.Parent = MainFrame
            tabContent.Size = tabOptions.ContentSize or UDim2.new(1, 0, 1, 0)
            tabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            tabContent.BorderSizePixel = 0
            tabContent.BackgroundTransparency = 1
            tabContent.Visible = false

            if tabOptions.EnableLayout then
                local layout = Instance.new("UIListLayout")
                layout.Parent = tabContent
                layout.SortOrder = Enum.SortOrder.LayoutOrder
                layout.Padding = UDim.new(0, 10)
            end

            tabButton.MouseButton1Click:Connect(function()
                switchTab({ button = tabButton, content = tabContent, title = tabOptions.Title or "Tab" })
            end)

            table.insert(tabs, { button = tabButton, content = tabContent })

            return {
                AddButton = function(self, buttonOptions)
                    local button = Instance.new("TextButton")
                    button.Name = buttonOptions.Title or "Button"
                    button.Parent = tabContent
                    button.Size = buttonOptions.Size or UDim2.new(0, 200, 0, 50)
                    button.BackgroundColor3 = buttonOptions.Color or Color3.fromRGB(0, 170, 255)
                    button.Text = buttonOptions.Title or "Button"
                    button.Font = Enum.Font.ArialBold
                    button.TextSize = 14
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    button.BorderSizePixel = 0

                    button.MouseButton1Click:Connect(buttonOptions.Callback or function() end)

                    local buttonCorners = Instance.new("UICorner")
                    buttonCorners.CornerRadius = UDim.new(0, 4)
                    buttonCorners.Parent = button
                end,
                AddToggle = function(self, toggleOptions)
                    local toggle = Instance.new("Frame")
                    toggle.Name = toggleOptions.Title or "Toggle"
                    toggle.Parent = tabContent
                    toggle.Size = UDim2.new(0, 200, 0, 50)
                    toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    toggle.BorderSizePixel = 0

                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Parent = toggle
                    toggleButton.Size = UDim2.new(0, 200, 0, 50)
                    toggleButton.BackgroundTransparency = 1
                    toggleButton.Text = toggleOptions.Title or "Toggle"
                    toggleButton.Font = Enum.Font.ArialBold
                    toggleButton.TextSize = 14
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.BorderSizePixel = 0

                    local toggleSwitch = Instance.new("Frame")
                    toggleSwitch.Parent = toggle
                    toggleSwitch.Size = UDim2.new(0, 20, 0, 20)
                    toggleSwitch.Position = UDim2.new(0.9, 0, 0.5, -10)
                    toggleSwitch.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    toggleSwitch.BorderSizePixel = 0

                    toggleButton.MouseButton1Click:Connect(function()
                        toggleOptions.State = not toggleOptions.State
                        toggleSwitch.BackgroundColor3 = toggleOptions.State and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                        if toggleOptions.Callback then
                            toggleOptions.Callback(toggleOptions.State)
                        end
                    end)

                    local toggleCorners = Instance.new("UICorner")
                    toggleCorners.CornerRadius = UDim.new(0, 4)
                    toggleCorners.Parent = toggle

                    local toggleSwitchCorners = Instance.new("UICorner")
                    toggleSwitchCorners.CornerRadius = UDim.new(0, 4)
                    toggleSwitchCorners.Parent = toggleSwitch
                end,
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
                end
            }
        end
    }
end

return UILib
