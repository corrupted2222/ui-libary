local UILib = {}

function UILib:CreateWindow(options)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = options.Title or "UI Window"
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

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
                    dropdownList.Parent = dropdownFrame
                    dropdownList.Size = UDim2.new(1, 0, 0, #dropdownOptions.Items * 30)
                    dropdownList.Position = UDim2.new(0, 0, 1, 0)
                    dropdownList.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
                    dropdownList.BorderSizePixel = 0
                    dropdownList.Visible = false

                    local listLayout = Instance.new("UIListLayout")
                    listLayout.Parent = dropdownList
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    listLayout.Padding = UDim.new(0, 0)

                    local function updateContentFrameSize()
                        local totalHeight = 0
                        for _, child in ipairs(tabContent:GetChildren()) do
                            if child:IsA("Frame") and child ~= dropdownFrame then
                                totalHeight = totalHeight + child.Size.Y.Offset
                            end
                        end
                        contentFrame.CanvasSize = UDim2.new(0, 0, 0, totalHeight + (dropdownList.Visible and dropdownList.Size.Y.Offset or 0))
                    end

                    dropdownButton.MouseButton1Click:Connect(function()
                        dropdownList.Visible = not dropdownList.Visible
                        updateContentFrameSize()
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
                            updateContentFrameSize()
                        end)
                    end

                    -- Initial call to ensure size is correct
                    updateContentFrameSize()
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
                    toggleLabel.Size = UDim2.new(0.8, 0, 1, 0)
                    toggleLabel.BackgroundTransparency = 1
                    toggleLabel.Text = toggleOptions.Title or "Toggle"
                    toggleLabel.Font = Enum.Font.ArialBold
                    toggleLabel.TextSize = 14
                    toggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = "ToggleButton"
                    toggleButton.Parent = toggleFrame
                    toggleButton.Size = UDim2.new(0.2, 0, 1, 0)
                    toggleButton.Position = UDim2.new(0.8, 0, 0, 0)
                    toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    toggleButton.Text = "OFF"
                    toggleButton.Font = Enum.Font.ArialBold
                    toggleButton.TextSize = 14
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.BorderSizePixel = 0

                    local isToggled = false

                    toggleButton.MouseButton1Click:Connect(function()
                        isToggled = not isToggled
                        toggleButton.Text = isToggled and "ON" or "OFF"
                        toggleButton.BackgroundColor3 = isToggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
                        toggleOptions.Callback(isToggled)
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
                    sliderLabel.Size = UDim2.new(0.5, 0, 1, 0)
                    sliderLabel.BackgroundTransparency = 1
                    sliderLabel.Text = sliderOptions.Title or "Slider"
                    sliderLabel.Font = Enum.Font.ArialBold
                    sliderLabel.TextSize = 14
                    sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

                    local slider = Instance.new("TextButton")
                    slider.Name = "Slider"
                    slider.Parent = sliderFrame
                    slider.Size = UDim2.new(0.5, 0, 1, 0)
                    slider.Position = UDim2.new(0.5, 0, 0, 0)
                    slider.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(0, 170, 255)
                    slider.Text = tostring(sliderOptions.Default or 0)
                    slider.Font = Enum.Font.ArialBold
                    slider.TextSize = 14
                    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
                    slider.BorderSizePixel = 0

                    local minValue = sliderOptions.Min or 0
                    local maxValue = sliderOptions.Max or 100
                    local stepValue = sliderOptions.Step or 1
                    local defaultValue = sliderOptions.Default or 0

                    local function updateSliderValue(input)
                        local delta = input.Position.X.Scale * (maxValue - minValue) + minValue
                        local snappedValue = math.floor(delta / stepValue + 0.5) * stepValue
                        slider.Text = tostring(snappedValue)
                        sliderOptions.Callback(snappedValue)
                    end

                    slider.MouseButton1Click:Connect(function()
                        local connection
                        connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                updateSliderValue(input)
                            end
                        end)

                        game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                connection:Disconnect()
                            end
                        end)
                    end)

                    updateSliderValue({ Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 0, 0) })
                end,
            }
        end
    }
end

return UILib
