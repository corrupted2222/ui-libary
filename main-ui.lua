local UILib = {}

function UILib:CreateWindow(options)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Title or "UI Window"
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui

    local window = Instance.new("Frame")
    window.Name = "MainWindow"
    window.Parent = screenGui
    window.Size = options.Size or UDim2.new(0, 580, 0, 460)
    window.Position = UDim2.new(0.5, -290, 0.5, -230)
    window.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    window.BorderSizePixel = 0
    window.Active = true
    window.Draggable = true

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Parent = window
    titleLabel.Size = UDim2.new(1, 0, 0, 40)
    titleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Text = options.Title or "UI Window"
    titleLabel.Font = Enum.Font.ArialBold
    titleLabel.TextSize = 18
    titleLabel.BorderSizePixel = 0

    local subTitleLabel = Instance.new("TextLabel")
    subTitleLabel.Parent = window
    subTitleLabel.Size = UDim2.new(1, 0, 0, 20)
    subTitleLabel.Position = UDim2.new(0, 0, 0, 40)
    subTitleLabel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    subTitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    subTitleLabel.Text = options.SubTitle or ""
    subTitleLabel.Font = Enum.Font.Arial
    subTitleLabel.TextSize = 14
    subTitleLabel.BorderSizePixel = 0

    local tabFrame = Instance.new("Frame")
    tabFrame.Parent = window
    tabFrame.Size = UDim2.new(1, 0, 0, 40)
    tabFrame.Position = UDim2.new(0, 0, 0, 60)
    tabFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    tabFrame.BorderSizePixel = 0

    local contentFrame = Instance.new("Frame")
    contentFrame.Parent = window
    contentFrame.Size = UDim2.new(1, 0, 1, -100)
    contentFrame.Position = UDim2.new(0, 0, 0, 100)
    contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentFrame.BorderSizePixel = 0

    local tabs = {}

    local function switchTab(tab)
        for _, tabButton in pairs(tabs) do
            tabButton.content.Visible = false
        end
        tab.content.Visible = true
    end

    return {
        AddTab = function(self, tabOptions)
            local tabButton = Instance.new("TextButton")
            tabButton.Name = tabOptions.Title or "Tab"
            tabButton.Parent = tabFrame
            tabButton.Size = UDim2.new(0, 100, 1, 0)
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            tabButton.Text = tabOptions.Title or "Tab"
            tabButton.Font = Enum.Font.ArialBold
            tabButton.TextSize = 14
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.BorderSizePixel = 0
            tabButton.Position = UDim2.new(#tabs * 0.2, 0, 0, 0)

            local tabContent = Instance.new("Frame")
            tabContent.Name = tabOptions.Title or "TabContent"
            tabContent.Parent = contentFrame
            tabContent.Size = UDim2.new(1, 0, 1, 0)
            tabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            tabContent.BorderSizePixel = 0
            tabContent.Visible = false

            tabButton.MouseButton1Click:Connect(function()
                switchTab({ button = tabButton, content = tabContent })
            end)

            table.insert(tabs, { button = tabButton, content = tabContent })

            local nextPositionY = 0

            return {
                AddButton = function(self, buttonOptions)
                    local button = Instance.new("TextButton")
                    button.Name = buttonOptions.Title or "Button"
                    button.Parent = tabContent
                    button.Position = buttonOptions.Position or UDim2.new(0.5, -50, 0, nextPositionY)
                    button.Size = buttonOptions.Size or UDim2.new(0, 100, 0, 50)
                    button.BackgroundColor3 = buttonOptions.Color or Color3.fromRGB(0, 170, 255)
                    button.Text = buttonOptions.Title or "Button"
                    button.Font = Enum.Font.ArialBold
                    button.TextSize = 14
                    button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    button.BorderSizePixel = 0

                    button.MouseButton1Click:Connect(buttonOptions.Callback or function() end)
                    
                    nextPositionY = nextPositionY + 60
                end,

                AddDropdown = function(self, dropdownOptions)
                    local dropdown = Instance.new("Frame")
                    dropdown.Name = dropdownOptions.Title or "Dropdown"
                    dropdown.Parent = tabContent
                    dropdown.Position = dropdownOptions.Position or UDim2.new(0.5, -50, 0, nextPositionY)
                    dropdown.Size = dropdownOptions.Size or UDim2.new(0, 100, 0, 50)
                    dropdown.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(45, 45, 45)
                    dropdown.BorderSizePixel = 0

                    local dropdownButton = Instance.new("TextButton")
                    dropdownButton.Name = "DropdownButton"
                    dropdownButton.Parent = dropdown
                    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
                    dropdownButton.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(45, 45, 45)
                    dropdownButton.Text = dropdownOptions.Title or "Dropdown"
                    dropdownButton.Font = Enum.Font.ArialBold
                    dropdownButton.TextSize = 14
                    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownButton.BorderSizePixel = 0

                    local dropdownList = Instance.new("Frame")
                    dropdownList.Name = "DropdownList"
                    dropdownList.Parent = dropdown
                    dropdownList.Position = UDim2.new(0, 0, 1, 0)
                    dropdownList.Size = UDim2.new(1, 0, 0, 0)
                    dropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    dropdownList.BorderSizePixel = 0
                    dropdownList.ClipsDescendants = true

                    local function toggleDropdown()
                        if dropdownList.Size.Y.Offset == 0 then
                            dropdownList:TweenSize(UDim2.new(1, 0, #dropdownOptions.Items * 30, 0), "Out", "Quad", 0.2, true)
                            nextPositionY = nextPositionY + #dropdownOptions.Items * 30
                        else
                            nextPositionY = nextPositionY - #dropdownOptions.Items * 30
                            dropdownList:TweenSize(UDim2.new(1, 0, 0, 0), "Out", "Quad", 0.2, true)
                        end
                    end

                    dropdownButton.MouseButton1Click:Connect(toggleDropdown)

                    for _, item in ipairs(dropdownOptions.Items) do
                        local itemButton = Instance.new("TextButton")
                        itemButton.Name = item
                        itemButton.Parent = dropdownList
                        itemButton.Size = UDim2.new(1, 0, 0, 30)
                        itemButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        itemButton.Text = item
                        itemButton.Font = Enum.Font.Arial
                        itemButton.TextSize = 14
                        itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        itemButton.BorderSizePixel = 0

                        itemButton.MouseButton1Click:Connect(function()
                            dropdownButton.Text = item
                            dropdownOptions.Callback(item)
                            toggleDropdown()
                        end)
                    end
                end,

                AddToggle = function(self, toggleOptions)
                    local toggle = Instance.new("Frame")
                    toggle.Name = toggleOptions.Title or "Toggle"
                    toggle.Parent = tabContent
                    toggle.Position = toggleOptions.Position or UDim2.new(0.5, -50, 0, nextPositionY)
                    toggle.Size = toggleOptions.Size or UDim2.new(0, 100, 0, 50)
                    toggle.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(45, 45, 45)
                    toggle.BorderSizePixel = 0

                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = "ToggleButton"
                    toggleButton.Parent = toggle
                    toggleButton.Size = UDim2.new(1, 0, 1, 0)
                    toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    toggleButton.Text = toggleOptions.Title or "Toggle"
                    toggleButton.Font = Enum.Font.ArialBold
                    toggleButton.TextSize = 14
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.BorderSizePixel = 0

                    local toggleState = false

                    local function updateToggle()
                        if toggleState then
                            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                        else
                            toggleButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                        end
                    end

                    toggleButton.MouseButton1Click:Connect(function()
                        toggleState = not toggleState
                        updateToggle()
                        toggleOptions.Callback(toggleState)
                    end)

                    updateToggle()
                    nextPositionY = nextPositionY + 60
                end,

                AddSlider = function(self, sliderOptions)
                    local slider = Instance.new("Frame")
                    slider.Name = sliderOptions.Title or "Slider"
                    slider.Parent = tabContent
                    slider.Position = sliderOptions.Position or UDim2.new(0.5, -50, 0, nextPositionY)
                    slider.Size = sliderOptions.Size or UDim2.new(0, 200, 0, 50)
                    slider.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(45, 45, 45)
                    slider.BorderSizePixel = 0

                    local sliderBar = Instance.new("Frame")
                    sliderBar.Name = "SliderBar"
                    sliderBar.Parent = slider
                    sliderBar.Size = UDim2.new(1, 0, 0, 10)
                    sliderBar.Position = UDim2.new(0, 0, 0.5, -5)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    sliderBar.BorderSizePixel = 0

                    local sliderButton = Instance.new("TextButton")
                    sliderButton.Name = "SliderButton"
                    sliderButton.Parent = sliderBar
                    sliderButton.Size = UDim2.new(0, 20, 1, 0)
                    sliderButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    sliderButton.Text = ""
                    sliderButton.BorderSizePixel = 0

                    local sliderValue = sliderOptions.Min or 0
                    local maxValue = sliderOptions.Max or 100

                    sliderButton.MouseButton1Down:Connect(function()
                        local input = game:GetService("UserInputService").InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                local relativePos = (input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
                                relativePos = math.clamp(relativePos, 0, 1)
                                sliderButton.Position = UDim2.new(relativePos, -10, 0, 0)
                                sliderValue = math.floor(relativePos * (maxValue - sliderOptions.Min) + sliderOptions.Min)
                                sliderOptions.Callback(sliderValue)
                            end
                        end)
                        
                        game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                input:Disconnect()
                            end
                        end)
                    end)

                    sliderButton.Position = UDim2.new((sliderValue - sliderOptions.Min) / (maxValue - sliderOptions.Min), -10, 0, 0)
                    nextPositionY = nextPositionY + 60
                end
            }
        end
    }
end

return UILib
