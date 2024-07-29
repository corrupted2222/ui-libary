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
    contentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
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

                    local listLayout = Instance.new("UIListLayout")
                    listLayout.Parent = dropdownList
                    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    listLayout.Padding = UDim.new(0, 5)

                    dropdownButton.MouseButton1Click:Connect(function()
                        dropdownList.Visible = not dropdownList.Visible
                        dropdownList.Size = UDim2.new(1, 0, 0, dropdownList.UIListLayout.AbsoluteContentSize.Y)
                        dropdownFrame.Size = UDim2.new(0, 200, 0, dropdownList.Size.Y.Offset + 30)  -- Adjust frame size
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
                            dropdownTitle.Text = item
                            dropdownOptions.Callback(item)
                            dropdownList.Visible = false
                            dropdownFrame.Size = UDim2.new(0, 200, 0, 50)  -- Reset frame size
                        end)
                    end
                end
            }
        end
    }
end,
                AddToggle = function(self, toggleOptions)
                    local toggle = Instance.new("Frame")
                    toggle.Name = toggleOptions.Title or "Toggle"
                    toggle.Parent = tabContent
                    toggle.Size = toggleOptions.Size or UDim2.new(0, 200, 0, 50)
                    toggle.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(45, 45, 45)
                    toggle.BorderSizePixel = 0

                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Name = "ToggleButton"
                    toggleButton.Parent = toggle
                    toggleButton.Size = UDim2.new(1, 0, 1, 0)
                    toggleButton.BackgroundColor3 = toggleOptions.Color or Color3.fromRGB(45, 45, 45)
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
                end,

                AddSlider = function(self, sliderOptions)
                    local slider = Instance.new("Frame")
                    slider.Name = sliderOptions.Title or "Slider"
                    slider.Parent = tabContent
                    slider.Size = sliderOptions.Size or UDim2.new(0, 200, 0, 50)
                    slider.BackgroundColor3 = sliderOptions.Color or Color3.fromRGB(45, 45, 45)
                    slider.BorderSizePixel = 0

                    local sliderBar = Instance.new("Frame")
                    sliderBar.Name = "SliderBar"
                    sliderBar.Parent = slider
                    sliderBar.Size = UDim2.new(1, -20, 0, 10)
                    sliderBar.Position = UDim2.new(0.5, -90, 0.5, -5)
                    sliderBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                    sliderBar.BorderSizePixel = 0

                    local sliderButton = Instance.new("ImageButton")
                    sliderButton.Name = "SliderButton"
                    sliderButton.Parent = sliderBar
                    sliderButton.Size = UDim2.new(0, 20, 0, 20)
                    sliderButton.Position = UDim2.new(0, -10, 0.5, -10)
                    sliderButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    sliderButton.Image = "rbxassetid://6031091008"
                    sliderButton.BorderSizePixel = 0

                    local sliderLine = Instance.new("Frame")
                    sliderLine.Name = "SliderLine"
                    sliderLine.Parent = sliderBar
                    sliderLine.Size = UDim2.new(0, 0, 0, 10)
                    sliderLine.Position = UDim2.new(0, 0, 0.5, -5)
                    sliderLine.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
                    sliderLine.BorderSizePixel = 0

                    local sliderValue = sliderOptions.Min or 0
                    local maxValue = sliderOptions.Max or 100

                    local function updateSlider(position)
                        local relativePos = math.clamp(position, 0, 1)
                        sliderButton.Position = UDim2.new(relativePos, -10, 0.5, -10)
                        sliderLine.Size = UDim2.new(relativePos, 0, 0, 10)
                        sliderValue = math.floor(relativePos * (maxValue - sliderOptions.Min) + sliderOptions.Min)
                        sliderOptions.Callback(sliderValue)
                    end

                    sliderButton.MouseButton1Down:Connect(function()
                        local moveConnection
                        local releaseConnection

                        moveConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                local relativePos = (input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X
                                updateSlider(relativePos)
                            end
                        end)

                        releaseConnection = game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                moveConnection:Disconnect()
                                releaseConnection:Disconnect()
                            end
                        end)
                    end)

                    updateSlider((sliderValue - sliderOptions.Min) / (maxValue - sliderOptions.Min))
                end
            }
        end,

        SetToggleButtonImage = function(self, assetId)
            toggleButton.Image = assetId
        end
    }
end

return UILib
