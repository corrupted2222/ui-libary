-- UILib module
local UILib = {}

-- Create Window
function UILib:CreateWindow(config)
    local window = Instance.new("Frame")
    window.Size = config.Size or UDim2.fromOffset(580, 460)
    window.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    window.Position = UDim2.fromScale(0.5, 0.5)
    window.AnchorPoint = Vector2.new(0.5, 0.5)
    
    local title = Instance.new("TextLabel", window)
    title.Text = config.Title or "Window"
    title.Size = UDim2.new(1, 0, 0, 30)
    title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true

    local subtitle = Instance.new("TextLabel", window)
    subtitle.Text = config.SubTitle or ""
    subtitle.Size = UDim2.new(1, 0, 0, 20)
    subtitle.Position = UDim2.new(0, 0, 0.05, 0)
    subtitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitle.TextScaled = true
    
    window.Name = "MainWindow"

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -50)
    tabContainer.Position = UDim2.new(0, 0, 0, 50)
    tabContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    tabContainer.Parent = window

    local tabButtons = Instance.new("Frame")
    tabButtons.Size = UDim2.new(1, 0, 0, 50)
    tabButtons.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabButtons.Parent = window

    window.Tabs = {}

    function window:AddTab(config)
        local tab = Instance.new("Frame")
        tab.Size = UDim2.new(1, 0, 1, 0)
        tab.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tab.Name = config.Title or "Tab"
        tab.Visible = false
        tab.Parent = tabContainer

        local tabButton = Instance.new("TextButton")
        tabButton.Text = config.Title or "Tab"
        tabButton.Size = UDim2.new(1 / #window.Tabs, 0, 1, 0)
        tabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Parent = tabButtons
        
        if #window.Tabs == 0 then
            tab.Visible = true
        end

        tabButton.MouseButton1Click:Connect(function()
            for _, t in pairs(tabContainer:GetChildren()) do
                t.Visible = false
            end
            tab.Visible = true
        end)

        table.insert(window.Tabs, tab)

        return {
            AddButton = function(buttonConfig)
                local button = Instance.new("TextButton")
                button.Text = buttonConfig.Title or "Button"
                button.Size = UDim2.new(1, -20, 0, 40)
                button.Position = UDim2.new(0, 10, 0, 50)
                button.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                button.TextColor3 = Color3.fromRGB(255, 255, 255)
                button.Parent = tab
                button.MouseButton1Click:Connect(buttonConfig.Callback)
            end,
            
            AddDropdown = function(dropdownConfig)
                local dropdown = Instance.new("Frame")
                dropdown.Size = UDim2.new(1, -20, 0, 40)
                dropdown.Position = UDim2.new(0, 10, 0, 50)
                dropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                dropdown.Parent = tab

                local dropdownButton = Instance.new("TextButton")
                dropdownButton.Text = dropdownConfig.Title or "Dropdown"
                dropdownButton.Size = UDim2.new(1, 0, 0, 40)
                dropdownButton.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
                dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                dropdownButton.Parent = dropdown
                
                local dropdownList = Instance.new("Frame")
                dropdownList.Size = UDim2.new(1, 0, 0, #dropdownConfig.Items * 40)
                dropdownList.Position = UDim2.new(0, 0, 1, 0)
                dropdownList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                dropdownList.Visible = false
                dropdownList.Parent = dropdown
                
                for i, item in ipairs(dropdownConfig.Items) do
                    local optionButton = Instance.new("TextButton")
                    optionButton.Text = item
                    optionButton.Size = UDim2.new(1, 0, 0, 40)
                    optionButton.Position = UDim2.new(0, 0, (i - 1) * 40, 0)
                    optionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    optionButton.Parent = dropdownList
                    optionButton.MouseButton1Click:Connect(function()
                        dropdownButton.Text = item
                        dropdownList.Visible = false
                        dropdownConfig.Callback(item)
                    end)
                end
                
                dropdownButton.MouseButton1Click:Connect(function()
                    dropdownList.Visible = not dropdownList.Visible
                end)
            end,
            
            AddSlider = function(sliderConfig)
                local sliderFrame = Instance.new("Frame")
                sliderFrame.Size = UDim2.new(1, -20, 0, 40)
                sliderFrame.Position = UDim2.new(0, 10, 0, 50)
                sliderFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                sliderFrame.Parent = tab

                local sliderLabel = Instance.new("TextLabel")
                sliderLabel.Text = sliderConfig.Title or "Slider"
                sliderLabel.Size = UDim2.new(1, 0, 0, 20)
                sliderLabel.BackgroundColor3 = Color3.fromRGB(90, 90, 90)
                sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                sliderLabel.Parent = sliderFrame
                
                local sliderBar = Instance.new("Frame")
                sliderBar.Size = UDim2.new(1, 0, 0, 10)
                sliderBar.Position = UDim2.new(0, 0, 0.5, 0)
                sliderBar.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
                sliderBar.Parent = sliderFrame
                
                local sliderHandle = Instance.new("Frame")
                sliderHandle.Size = UDim2.new(0, 10, 1, 0)
                sliderHandle.Position = UDim2.new(0, 0, 0, 0)
                sliderHandle.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
                sliderHandle.Parent = sliderBar
                
                local dragging = false
                sliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = true
                    end
                end)
                
                sliderBar.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        dragging = false
                    end
                end)
                
                sliderBar.InputChanged:Connect(function(input)
                    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local mouseX = input.Position.X - sliderBar.AbsolutePosition.X
                        local newValue = math.clamp(mouseX / sliderBar.Size.X.Offset, 0, 1) * (sliderConfig.Max - sliderConfig.Min) + sliderConfig.Min
                        sliderHandle.Position = UDim2.new(newValue / (sliderConfig.Max - sliderConfig.Min), -5, 0, 0)
                        sliderConfig.Callback(newValue)
                    end
                end)
            end
        }
    end
    
    return window
end

return UILib
