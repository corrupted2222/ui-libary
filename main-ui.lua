local UILib = {}

function UILib:CreateWindow(options)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Title or "UI Window"
    screenGui.Parent = game.CoreGui

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
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Initial canvas size
    contentFrame.ScrollBarThickness = 10
    contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local tabs = {}

    local function switchTab(tab)
        for _, tabButton in pairs(tabs) do
            tabButton.content.Visible = false
        end
        tab.content.Visible = true
        titleLabel.Text = "zygarde | " .. tab.title
    end

    local toggleButton = Instance.new("ImageButton")
    toggleButton.Name = "ToggleButton"
    toggleButton.Parent = screenGui
    toggleButton.Size = UDim2.new(0, 50, 0, 50)
    toggleButton.Position = UDim2.new(0, 10, 0, 10)
    toggleButton.BackgroundTransparency = 1
    toggleButton.Image = "rbxassetid://PLACEHOLDER" -- Placeholder for the image

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
                    dropdownFrame.Size = UDim2.new(0, 200, 0, 50)
                    dropdownFrame.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(45, 45, 45)
                    dropdownFrame.BorderSizePixel = 0

                    local dropdownButton = Instance.new("TextButton")
                    dropdownButton.Name = "DropdownButton"
                    dropdownButton.Parent = dropdownFrame
                    dropdownButton.Size = UDim2.new(1, 0, 1, 0)
                    dropdownButton.BackgroundColor3 = dropdownOptions.Color or Color3.fromRGB(45, 45, 45)
                    dropdownButton.Text = dropdownOptions.Title or "Dropdown"
                    dropdownButton.Font = Enum.Font.ArialBold
                    dropdownButton.TextSize = 14
                    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownButton.BorderSizePixel = 0

                    local dropdownList = Instance.new("Frame")
                    dropdownList.Name = "DropdownList"
                    dropdownList.Parent = tabContent
                    dropdownList.Size = UDim2.new(0, 200, 0, #dropdownOptions.Items * 30)
                    dropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    dropdownList.BorderSizePixel = 0
                    dropdownList.Visible = false

                    local listLayout = Instance.new("UIListLayout")
                    listLayout.Parent = dropdownList
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder

                    dropdownButton.MouseButton1Click:Connect(function()
                        dropdownList.Visible = not dropdownList.Visible
                        dropdownList.Position = UDim2.new(0, 0, 1, 0)
                        layout:ApplyLayout()
                    end)

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
                            dropdownList.Visible = false
                            layout:ApplyLayout()
                        end)
                    end
                end,

                AddToggle = function(self, toggleOptions)
                    local toggle = Instance.new("Frame")
                    toggle.Name = toggleOptions.Title or "Toggle"
                    toggle.Parent = tabContent
                    toggle.Size = toggleOptions.Size or UDim2.new(0, 200, 0, 50)
                    toggle.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(45, 45, 45)
                    toggle.BorderSizePixel = 0

                    local toggleLabel = Instance.new("TextLabel")
                    toggleLabel.Parent = toggle
                    toggleLabel.Size = UDim2.new(0.8, 0, 1, 0)
                    toggleLabel.BackgroundTransparency = 1
                    toggleLabel.Text = toggleOptions.Title or "Toggle"
                    toggleLabel.Font = Enum.Font.ArialBold
                    toggleLabel.TextSize = 14
                    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleLabel.BorderSizePixel = 0

                    local toggleButton = Instance.new("ImageButton")
                    toggleButton.Parent = toggle
                    toggleButton.Size = UDim2.new(0.2, -10, 0.8, -10)
                    toggleButton.Position = UDim2.new(0.8, 5, 0.1, 0)
                    toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    toggleButton.BorderSizePixel = 0

                    toggleButton.MouseButton1Click:Connect(function()
                        toggleOptions.Callback(not toggleOptions.InitialState)
                        toggleOptions.InitialState = not toggleOptions.InitialState
                        if toggleOptions.InitialState then
                            toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                        else
                            toggleButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                        end
                    end)

                    if toggleOptions.InitialState then
                        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    end
                end,

                AddSlider = function(self, sliderOptions)
                    local slider = Instance.new("Frame")
                    slider.Name = sliderOptions.Title or "Slider"
                    slider.Parent = tabContent
                    slider.Size = sliderOptions.Size or UDim2.new(0, 200, 0, 70)
                    slider.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(45, 45, 45)
                    slider.BorderSizePixel = 0

                    local sliderLabel = Instance.new("TextLabel")
                    sliderLabel.Parent = slider
                    sliderLabel.Size = UDim2.new(1, 0, 0.3, 0)
                    sliderLabel.BackgroundTransparency = 1
                    sliderLabel.Text = sliderOptions.Title or "Slider"
                    sliderLabel.Font = Enum.Font.ArialBold
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderLabel.BorderSizePixel = 0

                    local sliderBar = Instance.new("Frame")
                    sliderBar.Parent = slider
                    sliderBar.Size = UDim2.new(1, -20, 0.3, 0)
                    sliderBar.Position = UDim2.new(0, 10, 0.4, 0)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    sliderBar.BorderSizePixel = 0

                    local sliderLine = Instance.new("Frame")
                    sliderLine.Parent = sliderBar
                    sliderLine.Size = UDim2.new(0, 0, 1, 0)
                    sliderLine.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    sliderLine.BorderSizePixel = 0

                    local sliderButton = Instance.new("ImageButton")
                    sliderButton.Parent = sliderBar
                    sliderButton.Size = UDim2.new(0, 10, 1, 0)
                    sliderButton.Position = UDim2.new(0, 0, 0, 0)
                    sliderButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    sliderButton.BorderSizePixel = 0
                    sliderButton.Draggable = true
                    sliderButton.Image = "rbxassetid://PLACEHOLDER" -- Placeholder for circular knob image

                    local valueBox = Instance.new("TextBox")
                    valueBox.Parent = slider
                    valueBox.Size = UDim2.new(0.2, 0, 0.3, 0)
                    valueBox.Position = UDim2.new(0.8, 0, 0.1, 0)
                    valueBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                    valueBox.Text = tostring(sliderOptions.Min or 0)
                    valueBox.Font = Enum.Font.ArialBold
                    valueBox.TextSize = 14
                    valueBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    valueBox.BorderSizePixel = 0

                    local function updateSlider(value)
                        local min = sliderOptions.Min or 0
                        local max = sliderOptions.Max or 100
                        value = math.clamp(value, min, max)
                        local percent = (value - min) / (max - min)
                        sliderButton.Position = UDim2.new(percent, -5, 0, 0)
                        sliderLine.Size = UDim2.new(percent, 0, 1, 0)
                        valueBox.Text = tostring(value)
                        sliderOptions.Callback(value)
                    end

                    sliderButton.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            local moveConnection
                            local releaseConnection
                            moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseMovement then
                                    local mousePos = input.Position
                                    local relativePos = mousePos.X - sliderBar.AbsolutePosition.X
                                    local percent = math.clamp(relativePos / sliderBar.AbsoluteSize.X, 0, 1)
                                    local value = math.floor((sliderOptions.Min + (sliderOptions.Max - sliderOptions.Min) * percent) + 0.5)
                                    updateSlider(value)
                                end
                            end)
                            releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
                                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                    moveConnection:Disconnect()
                                    releaseConnection:Disconnect()
                                end
                            end)
                        end
                    end)

                    valueBox.FocusLost:Connect(function(enterPressed)
                        if enterPressed then
                            local value = tonumber(valueBox.Text)
                            if value then
                                updateSlider(value)
                            else
                                valueBox.Text = tostring(sliderOptions.Min or 0)
                            end
                        end
                    end)
                end
            }
        end
    }
end

return UILib
