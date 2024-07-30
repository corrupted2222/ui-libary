local UILib = {}

function UILib:CreateWindow(options)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Title or "UI Window"
    screenGui.Parent = game.CoreGui

    local window = Instance.new("Frame")
    window.Name = "MainWindow"
    window.Parent = screenGui
    window.Size = UDim2.new(0, 500, 0, 300)
    window.Position = UDim2.new(0.5, -250, 0.5, -150)
    window.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    window.BorderSizePixel = 0
    window.Active = true
    window.Draggable = true

    local windowCorners = Instance.new("UICorner")
    windowCorners.CornerRadius = UDim.new(0, 4)
    windowCorners.Parent = window

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

    local tabFrameCorners = Instance.new("UICorner")
    tabFrameCorners.CornerRadius = UDim.new(0, 4)
    tabFrameCorners.Parent = tabFrame

    local contentFrame = Instance.new("ScrollingFrame")
    contentFrame.Parent = window
    contentFrame.Size = UDim2.new(1, 0, 1, -100)
    contentFrame.Position = UDim2.new(0, 0, 0, 100)
    contentFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    contentFrame.BorderSizePixel = 0
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    contentFrame.ScrollBarThickness = 10
    contentFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local contentFrameCorners = Instance.new("UICorner")
    contentFrameCorners.CornerRadius = UDim.new(0, 4)
    contentFrameCorners.Parent = contentFrame

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
    toggleButton.Image = "rbxassetid://PLACEHOLDER"

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

                    local dropdownCorners = Instance.new("UICorner")
                    dropdownCorners.CornerRadius = UDim.new(0, 4)
                    dropdownCorners.Parent = dropdownFrame

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

                    local dropdownListCorners = Instance.new("UICorner")
                    dropdownListCorners.CornerRadius = UDim.new(0, 4)
                    dropdownListCorners.Parent = dropdownList

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
                            dropdownList.Visible = false
                            if dropdownOptions.Callback then
                                dropdownOptions.Callback(item)
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

                    local toggleCorners = Instance.new("UICorner")
                    toggleCorners.CornerRadius = UDim.new(0, 4)
                    toggleCorners.Parent = toggleFrame

                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = "ToggleButton"
                    toggleButton.Parent = toggleFrame
                    toggleButton.Size = UDim2.new(1, 0, 1, 0)
                    toggleButton.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(45, 45, 45)
                    toggleButton.Text = toggleOptions.Title or "Toggle"
                    toggleButton.Font = Enum.Font.ArialBold
                    toggleButton.TextSize = 14
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.BorderSizePixel = 0

                    local isToggled = false
                    toggleButton.MouseButton1Click:Connect(function()
                        isToggled = not isToggled
                        toggleButton.Text = isToggled and "On" or "Off"
                        if toggleOptions.Callback then
                            toggleOptions.Callback(isToggled)
                        end
                    end)
                end,

                AddSlider = function(self, sliderOptions)
                    local sliderFrame = Instance.new("Frame")
                    sliderFrame.Name = sliderOptions.Title or "Slider"
                    sliderFrame.Parent = tabContent
                    sliderFrame.Size = UDim2.new(0, 200, 0, 50)
                    sliderFrame.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(45, 45, 45)
                    sliderFrame.BorderSizePixel = 0

                    local sliderCorners = Instance.new("UICorner")
                    sliderCorners.CornerRadius = UDim.new(0, 4)
                    sliderCorners.Parent = sliderFrame

                    local sliderLabel = Instance.new("TextLabel")
                    sliderLabel.Name = "SliderLabel"
                    sliderLabel.Parent = sliderFrame
                    sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                    sliderLabel.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    sliderLabel.Text = sliderOptions.Title or "Slider"
                    sliderLabel.Font = Enum.Font.ArialBold
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderLabel.BorderSizePixel = 0

                    local sliderBar = Instance.new("Frame")
                    sliderBar.Name = "SliderBar"
                    sliderBar.Parent = sliderFrame
                    sliderBar.Size = UDim2.new(1, 0, 0, 10)
                    sliderBar.Position = UDim2.new(0, 0, 0, 20)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    sliderBar.BorderSizePixel = 0

                    local sliderFill = Instance.new("Frame")
                    sliderFill.Name = "SliderFill"
                    sliderFill.Parent = sliderBar
                    sliderFill.Size = UDim2.new(0, 0, 1, 0)
                    sliderFill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    sliderFill.BorderSizePixel = 0

                    local sliderThumb = Instance.new("TextButton")
                    sliderThumb.Name = "SliderThumb"
                    sliderThumb.Parent = sliderBar
                    sliderThumb.Size = UDim2.new(0, 20, 1, 0)
                    sliderThumb.Position = UDim2.new(0, -10, 0, 0)
                    sliderThumb.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    sliderThumb.BorderSizePixel = 0
                    sliderThumb.Text = ""
                    sliderThumb.TextColor3 = Color3.fromRGB(255, 255, 255)
                    sliderThumb.Font = Enum.Font.ArialBold

                    local minValue = sliderOptions.Min or 0
                    local maxValue = sliderOptions.Max or 100
                    local value = sliderOptions.Default or 0

                    local function updateSlider(value)
                        local percentage = (value - minValue) / (maxValue - minValue)
                        sliderFill.Size = UDim2.new(percentage, 0, 1, 0)
                        sliderThumb.Position = UDim2.new(percentage, -10, 0, 0)
                        if sliderOptions.Callback then
                            sliderOptions.Callback(value)
                        end
                    end

                    updateSlider(value)

                    sliderThumb.MouseButton1Drag:Connect(function(input)
                        local function update(input)
                            local mousePos = input.Position.X - sliderBar.AbsolutePosition.X
                            local percentage = math.clamp(mousePos / sliderBar.AbsoluteSize.X, 0, 1)
                            local newValue = math.floor(minValue + percentage * (maxValue - minValue))
                            updateSlider(newValue)
                        end
                        update(input)
                        input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                update(input)
                            end
                        end)
                    end)
                end
            }
        end
    }
end

return UILib
