local UILib = {}

function UILib:CreateWindow(options)
    local player = game.Players.LocalPlayer
    if not player then
        warn("No LocalPlayer found. Make sure this script runs on the client.")
        return
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Title or "UI Window"
    screenGui.Parent = player:WaitForChild("PlayerGui")

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

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Parent = window
    contentFrame.Size = UDim2.new(1, 0, 1, -100)
    contentFrame.Position = UDim2.new(0, 0, 0, 100)
    contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentFrame.BorderSizePixel = 0
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.ScrollBarThickness = 10
    contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local tabs = {}

    local function switchTab(tab)
        for _, tabButton in pairs(tabs) do
            tabButton.content.Visible = false
        end
        tab.content.Visible = true
    end

    local toggleButton = Instance.new("ImageButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Parent = screenGui
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 10, 0, 10)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Image = "rbxassetid://17376881029" -- Default image

    local windowVisible = true

    toggleButton.MouseButton1Click:Connect(function()
        windowVisible = not windowVisible
        window.Visible = windowVisible
    end)

    return {
        AddTab = function(self, tabOptions)
            local tabButton = Instance.new("ImageButton")
            tabButton.Name = tabOptions.Title or "Tab"
            tabButton.Parent = tabFrame
            tabButton.Size = UDim2.new(0, 100, 1, 0)
            tabButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
            tabButton.Image = tabOptions.Icon or ""
            tabButton.BorderSizePixel = 0
            tabButton.Position = UDim2.new(#tabs * 0.2, 0, 0, 0)

            local tabContent = Instance.new("Frame")
            tabContent.Name = tabOptions.Title or "TabContent"
            tabContent.Parent = contentFrame
            tabContent.Size = UDim2.new(1, 0, 1, 0)
            tabContent.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            tabContent.BorderSizePixel = 0
            tabContent.Visible = false

            local layout = Instance.new("UIListLayout")
            layout.Parent = tabContent
            layout.SortOrder = Enum.SortOrder.LayoutOrder
            layout.Padding = UDim.new(0, 10)

            tabButton.MouseButton1Click:Connect(function()
                switchTab({ button = tabButton, content = tabContent })
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
    dropdownFrame.Size = UDim2.new(0, 200, 0, 50)
    dropdownFrame.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(45, 45, 45)
    dropdownFrame.BorderSizePixel = 0

    local dropdownTitle = Instance.new("TextLabel")
    dropdownTitle.Name = "DropdownTitle"
    dropdownTitle.Parent = dropdownFrame
    dropdownTitle.Size = UDim2.new(1, 0, 0, 30)
    dropdownTitle.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(45, 45, 45)
    dropdownTitle.Text = dropdownOptions.Title or "Dropdown"
    dropdownTitle.Font = Enum.Font.ArialBold
    dropdownTitle.TextSize = 14
    dropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownTitle.BorderSizePixel = 0

    local dropdownButton = Instance.new("TextButton")
    dropdownButton.Name = "DropdownButton"
    dropdownButton.Parent = dropdownFrame
    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
    dropdownButton.Position = UDim2.new(0, 0, 0, 30)
    dropdownButton.BackgroundTransparency = 1
    dropdownButton.Text = ""
    dropdownButton.Font = Enum.Font.SourceSans
    dropdownButton.TextSize = 14
    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownButton.BorderSizePixel = 0

    local dropdownList = Instance.new("Frame")
    dropdownList.Name = "DropdownList"
    dropdownList.Parent = dropdownFrame
    dropdownList.Size = UDim2.new(1, 0, 0, 0)
    dropdownList.Position = UDim2.new(0, 0, 1, 0)
    dropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    dropdownList.BorderSizePixel = 0
    dropdownList.Visible = false

    local gridLayout = Instance.new("UIGridLayout")
    gridLayout.Parent = dropdownList
    gridLayout.CellSize = UDim2.new(1, 0, 0, 30)
    gridLayout.FillDirection = Enum.FillDirection.Vertical
    gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    gridLayout.Padding = UDim2.new(0, 5, 0, 5)

    dropdownButton.MouseButton1Click:Connect(function()
        local dropdownVisible = not dropdownList.Visible
        dropdownList.Visible = dropdownVisible

        if dropdownVisible then
            -- Calculate total height of dropdown items
            local totalHeight = gridLayout.AbsoluteContentSize.Y
            dropdownList.Size = UDim2.new(1, 0, 0, totalHeight)
            
            -- Reposition elements below the dropdown
            local offset = dropdownList.Size.Y.Offset
            for _, element in pairs(tabContent:GetChildren()) do
                if element:IsA("Frame") and element ~= dropdownFrame then
                    element.Position = element.Position + UDim2.new(0, 0, 0, offset)
                end
            end
        else
            dropdownList.Size = UDim2.new(1, 0, 0, 0)
            
            -- Reset positions of elements below the dropdown
            for _, element in pairs(tabContent:GetChildren()) do
                if element:IsA("Frame") and element ~= dropdownFrame then
                    element.Position = element.Position - UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y)
                end
            end
        end
    end)

    for _, item in pairs(dropdownOptions.Items or {}) do
        local itemButton = Instance.new("TextButton")
        itemButton.Name = item
        itemButton.Parent = dropdownList
        itemButton.Size = UDim2.new(1, 0, 1, 0)
        itemButton.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        itemButton.Text = item
        itemButton.Font = Enum.Font.Arial
        itemButton.TextSize = 14
        itemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        itemButton.BorderSizePixel = 0

        itemButton.MouseButton1Click:Connect(function()
            dropdownTitle.Text = item
            dropdownOptions.Callback(item)
            dropdownList.Visible = false
            dropdownList.Size = UDim2.new(1, 0, 0, 0)
            
            -- Reset positions of elements below the dropdown
            for _, element in pairs(tabContent:GetChildren()) do
                if element:IsA("Frame") and element ~= dropdownFrame then
                    element.Position = element.Position - UDim2.new(0, 0, 0, gridLayout.AbsoluteContentSize.Y)
                end
            end
        end)
    end
end,

                AddToggle = function(self, toggleOptions)
                    local toggleFrame = Instance.new("Frame")
                    toggleFrame.Name = toggleOptions.Title or "Toggle"
                    toggleFrame.Parent = tabContent
                    toggleFrame.Size = UDim2.new(0, 200, 0, 50)
                    toggleFrame.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(45, 45, 45)
                    toggleFrame.BorderSizePixel = 0

                    local toggleLabel = Instance.new("TextLabel")
                    toggleLabel.Name = "ToggleLabel"
                    toggleLabel.Parent = toggleFrame
                    toggleLabel.Size = UDim2.new(0, 150, 0, 50)
                    toggleLabel.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(45, 45, 45)
                    toggleLabel.Text = toggleOptions.Title or "Toggle"
                    toggleLabel.Font = Enum.Font.ArialBold
                    toggleLabel.TextSize = 14
                    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleLabel.BorderSizePixel = 0

                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = "ToggleButton"
                    toggleButton.Parent = toggleFrame
                    toggleButton.Size = UDim2.new(0, 50, 0, 50)
                    toggleButton.Position = UDim2.new(1, -50, 0, 0)
                    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    toggleButton.Text = ""
                    toggleButton.Font = Enum.Font.SourceSans
                    toggleButton.TextSize = 14
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.BorderSizePixel = 0

                    local toggled = false

                    toggleButton.MouseButton1Click:Connect(function()
                        toggled = not toggled
                        toggleButton.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(100, 100, 100)
                        toggleOptions.Callback(toggled)
                    end)
                end,

                AddSlider = function(self, sliderOptions)
                    local sliderFrame = Instance.new("Frame")
                    sliderFrame.Name = sliderOptions.Title or "Slider"
                    sliderFrame.Parent = tabContent
                    sliderFrame.Size = UDim2.new(0, 200, 0, 50)
                    sliderFrame.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(45, 45, 45)
                    sliderFrame.BorderSizePixel = 0

                    local sliderLabel = Instance.new("TextLabel")
                    sliderLabel.Name = "SliderLabel"
                    sliderLabel.Parent = sliderFrame
                    sliderLabel.Size = UDim2.new(1, -50, 0, 50)
                    sliderLabel.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(45, 45, 45)
                    sliderLabel.Text = sliderOptions.Title or "Slider"
                    sliderLabel.Font = Enum.Font.ArialBold
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderLabel.BorderSizePixel = 0

                    local sliderButton = Instance.new("TextButton")
                    sliderButton.Name = "SliderButton"
                    sliderButton.Parent = sliderFrame
                    sliderButton.Size = UDim2.new(0, 50, 1, 0)
                    sliderButton.Position = UDim2.new(1, -50, 0, 0)
                    sliderButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    sliderButton.Text = ""
                    sliderButton.Font = Enum.Font.SourceSans
                    sliderButton.TextSize = 14
                    sliderButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderButton.BorderSizePixel = 0

                    local minValue = sliderOptions.Min or 0
                    local maxValue = sliderOptions.Max or 100
                    local currentValue = minValue

                    sliderButton.MouseButton1Click:Connect(function()
                        -- Handle slider movement and value change
                        -- Example implementation: setting value based on mouse position
                        local mouse = game.Players.LocalPlayer:GetMouse()
                        local sliderPos = mouse.X - sliderFrame.AbsolutePosition.X
                        currentValue = math.clamp(math.round((sliderPos / sliderFrame.AbsoluteSize.X) * (maxValue - minValue) + minValue), minValue, maxValue)
                        sliderButton.Position = UDim2.new(currentValue / maxValue, -25, 0, 0)
                        sliderOptions.Callback(currentValue)
                    end)
                end,

                SetToggleButtonImage = function(self, imageId)
                    toggleButton.Image = imageId
                end,
            }
        end
    }
end

return UILib
