-- main-ui.lua

local UILibrary = {}

function UILibrary:CreateWindow(options)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local mainWindow = Instance.new("ScreenGui")
    mainWindow.Name = options.Title
    mainWindow.Parent = playerGui

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 500)
    mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
    mainFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    mainFrame.Visible = false
    mainFrame.Parent = mainWindow

    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.Text = options.Title
    titleLabel.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.TextScaled = true
    titleLabel.TextStrokeTransparency = 0.5
    titleLabel.Parent = mainFrame

    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 1, -30)
    tabContainer.Position = UDim2.new(0, 0, 0, 30)
    tabContainer.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    tabContainer.Parent = mainFrame

    local tabList = Instance.new("Frame")
    tabList.Size = UDim2.new(1, 0, 0, 30)
    tabList.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tabList.Parent = tabContainer

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -30)
    contentFrame.Position = UDim2.new(0, 0, 0, 30)
    contentFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    contentFrame.Name = "ContentFrame"
    contentFrame.Parent = tabContainer

    local toggleButton = Instance.new("TextButton")
    toggleButton.Size = UDim2.new(0, 100, 0, 30)
    toggleButton.Position = UDim2.new(0.5, -50, 0, 10)
    toggleButton.Text = "Open UI"
    toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    toggleButton.TextScaled = true
    toggleButton.TextStrokeTransparency = 0.5
    toggleButton.Parent = playerGui

    toggleButton.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
        toggleButton.Text = mainFrame.Visible and "Close UI" or "Open UI"
    end)

    return {
        NewTab = function(tabOptions)
            local tabButton = Instance.new("TextButton")
            tabButton.Size = UDim2.new(1 / 3, 0, 1, 0)
            tabButton.Position = UDim2.new((#tabList:GetChildren() - 1) * (1 / 3), 0, 0, 0)
            tabButton.Text = tabOptions.Name
            tabButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            tabButton.TextScaled = true
            tabButton.TextStrokeTransparency = 0.5
            tabButton.Parent = tabList

            local tabFrame = Instance.new("Frame")
            tabFrame.Size = UDim2.new(1, 0, 1, 0)
            tabFrame.Position = UDim2.new(0, 0, 0, 0)
            tabFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            tabFrame.Visible = false
            tabFrame.Parent = contentFrame

            tabButton.MouseButton1Click:Connect(function()
                for _, child in pairs(contentFrame:GetChildren()) do
                    if child:IsA("Frame") then
                        child.Visible = false
                    end
                end
                tabFrame.Visible = true
            end)

            return {
                NewToggle = function(toggleOptions)
                    local toggleButton = Instance.new("TextButton")
                    toggleButton.Size = UDim2.new(0, 200, 0, 30)
                    toggleButton.Text = toggleOptions.Name .. ": " .. (toggleOptions.default and "On" or "Off")
                    toggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    toggleButton.TextScaled = true
                    toggleButton.TextStrokeTransparency = 0.5
                    toggleButton.Position = UDim2.new(0, 10, 0, (#tabFrame:GetChildren() * 35) + 10)
                    toggleButton.Parent = tabFrame

                    local isOn = toggleOptions.default
                    toggleButton.MouseButton1Click:Connect(function()
                        isOn = not isOn
                        toggleButton.Text = toggleOptions.Name .. ": " .. (isOn and "On" or "Off")
                        toggleOptions.callback(isOn)
                    end)
                end,

                NewSlider = function(sliderOptions)
                    local slider = Instance.new("TextButton")
                    slider.Size = UDim2.new(0, 200, 0, 30)
                    slider.Text = sliderOptions.Name .. ": " .. sliderOptions.default
                    slider.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    slider.TextColor3 = Color3.fromRGB(255, 255, 255)
                    slider.TextScaled = true
                    slider.TextStrokeTransparency = 0.5
                    slider.Position = UDim2.new(0, 10, 0, (#tabFrame:GetChildren() * 35) + 10)
                    slider.Parent = tabFrame

                    local value = sliderOptions.default
                    slider.MouseButton1Down:Connect(function()
                        local inputConnection
                        inputConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseMovement then
                                local relativePosition = math.clamp(input.Position.X - slider.AbsolutePosition.X, 0, slider.AbsoluteSize.X)
                                value = sliderOptions.min + ((sliderOptions.max - sliderOptions.min) * (relativePosition / slider.AbsoluteSize.X))
                                slider.Text = sliderOptions.Name .. ": " .. math.floor(value)
                                sliderOptions.callback(value)
                            end
                        end)

                        game:GetService("UserInputService").InputEnded:Connect(function(input)
                            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                                inputConnection:Disconnect()
                            end
                        end)
                    end)
                end,

                NewDropdown = function(dropdownOptions)
                    local dropdownButton = Instance.new("TextButton")
                    dropdownButton.Size = UDim2.new(0, 200, 0, 30)
                    dropdownButton.Text = dropdownOptions.Name .. ": " .. dropdownOptions.default
                    dropdownButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    dropdownButton.TextScaled = true
                    dropdownButton.TextStrokeTransparency = 0.5
                    dropdownButton.Position = UDim2.new(0, 10, 0, (#tabFrame:GetChildren() * 35) + 10)
                    dropdownButton.Parent = tabFrame

                    local dropdownFrame = Instance.new("Frame")
                    dropdownFrame.Size = UDim2.new(0, 200, 0, #dropdownOptions.options * 30)
                    dropdownFrame.Position = UDim2.new(0, 0, 1, 0)
                    dropdownFrame.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
                    dropdownFrame.Visible = false
                    dropdownFrame.Parent = dropdownButton

                    for i, option in ipairs(dropdownOptions.options) do
                        local optionButton = Instance.new("TextButton")
                        optionButton.Size = UDim2.new(1, 0, 0, 30)
                        optionButton.Position = UDim2.new(0, 0, 0, (i - 1) * 30)
                        optionButton.Text = option
                        optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                        optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                        optionButton.TextScaled = true
                        optionButton.TextStrokeTransparency = 0.5
                        optionButton.Parent = dropdownFrame

                        optionButton.MouseButton1Click:Connect(function()
                            dropdownButton.Text = dropdownOptions.Name .. ": " .. option
                            dropdownFrame.Visible = false
                            dropdownOptions.callback(option)
                        end)
                    end

                    dropdownButton.Mouse
