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
            tabContent.Size = UDim2.new(1, 0, 1, 0)
            tabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            tabContent.BorderSizePixel = 0
            tabContent.BackgroundTransparency = 1
            tabContent.Visible = false

            local layout = Instance.new("UIListLayout")
            layout.Parent = tabContent
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 10)

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
                end,

                AddDropdown = function(self, dropdownOptions)
                    local dropdownFrame = Instance.new("Frame")
                    dropdownFrame.Name = dropdownOptions.Title or "Dropdown"
                    dropdownFrame.Parent = tabContent
                    dropdownFrame.Size = dropdownOptions.Size or UDim2.new(0, 200, 0, 50)
                    dropdownFrame.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(40, 40, 40)
                    dropdownFrame.BorderSizePixel = 0

                    local dropdownButton = Instance.new("TextButton")
                    dropdownButton.Name = dropdownOptions.Title or "DropdownButton"
                    dropdownButton.Parent = dropdownFrame
                    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
                    dropdownButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    dropdownButton.Text = dropdownOptions.Title or "Select Option"
                    dropdownButton.Font = Enum.Font.ArialBold
                    dropdownButton.TextSize = 14
                    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownButton.BorderSizePixel = 0

                    local dropdownMenu = Instance.new("Frame")
                    dropdownMenu.Name = "DropdownMenu"
                    dropdownMenu.Parent = dropdownFrame
                    dropdownMenu.Size = UDim2.new(1, 0, 0, 0)
                    dropdownMenu.Position = UDim2.new(0, 0, 1, 0)
                    dropdownMenu.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    dropdownMenu.BorderSizePixel = 0
                    dropdownMenu.Visible = false

                    local uiListLayout = Instance.new("UIListLayout")
                    uiListLayout.Parent = dropdownMenu
                    uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    uiListLayout.Padding = UDim.new(0, 5)

                    dropdownButton.MouseButton1Click:Connect(function()
                        dropdownMenu.Visible = not dropdownMenu.Visible
                        if dropdownMenu.Visible then
                            dropdownMenu:TweenSize(UDim2.new(1, 0, 0, #dropdownOptions.Options * 25), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
                        else
                            dropdownMenu:TweenSize(UDim2.new(1, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
                        end
                    end)

                    for _, option in ipairs(dropdownOptions.Options) do
                        local optionButton = Instance.new("TextButton")
                        optionButton.Name = option
                        optionButton.Parent = dropdownMenu
                        optionButton.Size = UDim2.new(1, 0, 0, 25)
                        optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                        optionButton.Text = option
                        optionButton.Font = Enum.Font.ArialBold
                        optionButton.TextSize = 14
                        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        optionButton.BorderSizePixel = 0

                        optionButton.MouseButton1Click:Connect(function()
                            dropdownButton.Text = option
                            dropdownMenu.Visible = false
                            if dropdownOptions.Callback then
                                dropdownOptions.Callback(option)
                            end
                        end)
                    end
                end,

                AddToggle = function(self, toggleOptions)
                    local toggleFrame = Instance.new("Frame")
                    toggleFrame.Name = toggleOptions.Title or "Toggle"
                    toggleFrame.Parent = tabContent
                    toggleFrame.Size = toggleOptions.Size or UDim2.new(0, 200, 0, 50)
                    toggleFrame.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(40, 40, 40)
                    toggleFrame.BorderSizePixel = 0

                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = toggleOptions.Title or "ToggleButton"
                    toggleButton.Parent = toggleFrame
                    toggleButton.Size = UDim2.new(0, 50, 1, 0)
                    toggleButton.Position = UDim2.new(0, 0, 0, 0)
                    toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    toggleButton.Text = toggleOptions.State and "On" or "Off"
                    toggleButton.Font = Enum.Font.ArialBold
                    toggleButton.TextSize = 14
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.BorderSizePixel = 0

                    local toggleLabel = Instance.new("TextLabel")
                    toggleLabel.Name = "ToggleLabel"
                    toggleLabel.Parent = toggleFrame
                    toggleLabel.Size = UDim2.new(1, -60, 1, 0)
                    toggleLabel.Position = UDim2.new(0, 60, 0, 0)
                    toggleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    toggleLabel.Text = toggleOptions.Title or "Toggle"
                    toggleLabel.Font = Enum.Font.ArialBold
                    toggleLabel.TextSize = 14
                    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    toggleLabel.BorderSizePixel = 0

                    local function updateToggle(state)
                        toggleButton.Text = state and "On" or "Off"
                        if toggleOptions.Callback then
                            toggleOptions.Callback(state)
                        end
                    end

                    toggleButton.MouseButton1Click:Connect(function()
                        toggleOptions.State = not toggleOptions.State
                        updateToggle(toggleOptions.State)
                    end)

                    updateToggle(toggleOptions.State)
                end,

                AddSlider = function(self, sliderOptions)
                    local sliderFrame = Instance.new("Frame")
                    sliderFrame.Name = sliderOptions.Title or "Slider"
                    sliderFrame.Parent = tabContent
                    sliderFrame.Size = sliderOptions.Size or UDim2.new(0, 200, 0, 50)
                    sliderFrame.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(40, 40, 40)
                    sliderFrame.BorderSizePixel = 0

                    local sliderLabel = Instance.new("TextLabel")
                    sliderLabel.Name = "SliderLabel"
                    sliderLabel.Parent = sliderFrame
                    sliderLabel.Size = UDim2.new(1, 0, 0, 25)
                    sliderLabel.Position = UDim2.new(0, 0, 0, 0)
                    sliderLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    sliderLabel.Text = sliderOptions.Title or "Slider"
                    sliderLabel.Font = Enum.Font.ArialBold
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    sliderLabel.BorderSizePixel = 0

                    local sliderValue = Instance.new("TextLabel")
                    sliderValue.Name = "SliderValue"
                    sliderValue.Parent = sliderFrame
                    sliderValue.Size = UDim2.new(0, 50, 0, 25)
                    sliderValue.Position = UDim2.new(1, -50, 0, 0)
                    sliderValue.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    sliderValue.Text = tostring(sliderOptions.Default or 0)
                    sliderValue.Font = Enum.Font.ArialBold
                    sliderValue.TextSize = 14
                    sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderValue.TextXAlignment = Enum.TextXAlignment.Right
                    sliderValue.BorderSizePixel = 0

                    local sliderBar = Instance.new("Frame")
                    sliderBar.Name = "SliderBar"
                    sliderBar.Parent = sliderFrame
                    sliderBar.Size = UDim2.new(1, 0, 0, 10)
                    sliderBar.Position = UDim2.new(0, 0, 1, -10)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                    sliderBar.BorderSizePixel = 0

                    local sliderFill = Instance.new("Frame")
                    sliderFill.Name = "SliderFill"
                    sliderFill.Parent = sliderBar
                    sliderFill.Size = UDim2.new((sliderOptions.Default or 0) / (sliderOptions.Max or 100), 0, 1, 0)
                    sliderFill.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(0, 170, 255)
                    sliderFill.BorderSizePixel = 0

                    local sliderHandle = Instance.new("ImageButton")
                    sliderHandle.Name = "SliderHandle"
                    sliderHandle.Parent = sliderBar
                    sliderHandle.Size = UDim2.new(0, 20, 0, 20)
                    sliderHandle.Position = UDim2.new((sliderOptions.Default or 0) / (sliderOptions.Max or 100), -10, 0.5, -10)
                    sliderHandle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    sliderHandle.BorderSizePixel = 0

                    sliderHandle.MouseButton1Down:Connect(function()
                        local function move(input)
                            local pos = UDim2.new(math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1), -10, 0.5, -10)
                            sliderHandle.Position = pos
                            sliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
                            local value = math.floor((pos.X.Scale * (sliderOptions.Max or 100)) + 0.5)
                            sliderValue.Text = tostring(value)
                            if sliderOptions.Callback then
                                sliderOptions.Callback(value)
                            end
                        end

                        local moveConnection = game:GetService("UserInputService").InputChanged:Connect(move)
                        local releaseConnection
                        releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                moveConnection:Disconnect()
                                releaseConnection:Disconnect()
                            end
                        end)
                    end)
                end,

AddTime = function(self, timeOptions)
    local timeLabel = Instance.new("TextLabel")
    timeLabel.Name = "TimeLabel"
    timeLabel.Parent = tabContent
    timeLabel.Size = UDim2.new(0, 102, 0, 30)
    timeLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    timeLabel.Position = UDim2.new(0.017, 0, 0.015, 0)
    timeLabel.Text = "00:00:00"
    timeLabel.Font = Enum.Font.ArialBold
    timeLabel.TextSize = 14
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.BorderSizePixel = 0
    timeLabel.TextXAlignment = Enum.TextXAlignment.Center
    timeLabel.BackgroundTransparency = 0

    local TimeCorners = Instance.new("UICorner")
    TimeCorners.CornerRadius = UDim.new(0, 4)
    TimeCorners.Parent = timeLabel

    local function updateTime()
        while true do
            local currentTime = os.date("%H:%M:%S")
            timeLabel.Text = currentTime
            wait(1)
        end
    end

    spawn(updateTime)
end,
            }
        end
    }
end

return UILib
