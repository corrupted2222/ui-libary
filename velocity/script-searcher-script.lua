local SearcherUILibrary = {}

local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

function SearcherUILibrary:CreateWindow(config)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.Position = UDim2.new(0.2, 0, 0.2, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainFrame.BorderSizePixel = 0

    local mainframecorner = Instance.new("UICorner")
    mainframecorner.CornerRadius = UDim.new(0, 4)
    mainframecorner.Parent = MainFrame

    local ToggleButton = Instance.new("ImageButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Image = config.Icon or "rbxassetid://17376881029"
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.BackgroundColor3 = Color3.fromRGB(75, 75, 75)
ToggleButton.BackgroundTransparency = 1
ToggleButton.BorderSizePixel = 0
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

    local ToggleButtoncorners = Instance.new("UICorner")
    ToggleButtoncorners.CornerRadius = UDim.new(0, 4)
    ToggleButtoncorners.Parent = ToggleButton

    makeDraggable(MainFrame)
    
    local TitleLabel = Instance.new("TextLabel", MainFrame)
    TitleLabel.Size = UDim2.new(0, 189, 0, 26)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.Text = config.Title or "Untitled"
    TitleLabel.Font = Enum.Font.ArialBold
    TitleLabel.TextSize = 15
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TitleLabel.BorderSizePixel = 0
    TitleLabel.BackgroundTransparency = 1

    local Line2 = Instance.new("Frame")
    Line2.Parent = MainFrame
    Line2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Line2.Position = UDim2.new(0.248, -2, 0.073, 0)
    Line2.BorderSizePixel = 0
    Line2.Size = UDim2.new(0, 1, 0, 325)

    local Line1 = Instance.new("Frame")
    Line1.Parent = MainFrame
    Line1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Line1.Position = UDim2.new(0, 0, 0.072, 0)
    Line1.BorderSizePixel = 0
    Line1.Size = UDim2.new(0, 600, 0, 1)

    local Close = Instance.new("ImageButton")
    Close.Size = UDim2.new(0, 16, 0, 16)
    Close.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Close.Position = UDim2.new(0.96, 0, 0.015, 0)
    Close.BorderSizePixel = 0
    Close.BackgroundTransparency = 1
    Close.Image = "http://www.roblox.com/asset/?id=18420460106"
    Close.Parent = MainFrame
    Close.MouseButton1Click:Connect(function()
    MainFrame:Destroy()
    ToggleButton:Destroy()
end)

    local Minimize = Instance.new("ImageButton")
    Minimize.Size = UDim2.new(0, 16, 0, 16)
    Minimize.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    Minimize.Position = UDim2.new(0.917, 0, 0.015, 0)
    Minimize.BorderSizePixel = 0
    Minimize.BackgroundTransparency = 1
    Minimize.Image = "http://www.roblox.com/asset/?id=18642001126"
    Minimize.Parent = MainFrame
    Minimize.MouseButton1Click:Connect(function()
     MainFrame.Visible = not MainFrame.Visible
     end)

    local SearchBox = Instance.new("TextBox", MainFrame)
    SearchBox.Size = UDim2.new(0, 135, 0, 27)
    SearchBox.Position = UDim2.new(0.01, 0, 0, 30)
    SearchBox.PlaceholderText = "Search..."
    SearchBox.Font = Enum.Font.ArialBold
    SearchBox.TextSize = 15
    SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    SearchBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    SearchBox.BorderSizePixel = 0
    SearchBox.TextXAlignment = Enum.TextXAlignment.Left
    SearchBox.Text = ""

    local SearchBoxPadding = Instance.new("UIPadding")
    SearchBoxPadding.Parent = SearchBox
    SearchBoxPadding.PaddingLeft = UDim.new(0, 5)

    local searchBoxCorners = Instance.new("UICorner")
    searchBoxCorners.CornerRadius = UDim.new(0, 3)
    searchBoxCorners.Parent = SearchBox

    SearchBox.Changed:Connect(function()
        local text = SearchBox.Text:lower()
        local buttons = MainFrame:FindFirstChild("TabFrame"):GetDescendants()
        for _, button in pairs(buttons) do
            if button:IsA("ImageButton") then
                local buttonText = button:FindFirstChildOfClass("TextLabel")
                if buttonText and string.find(buttonText.Text:lower(), text) then
                    button.Visible = true
                else
                    button.Visible = false
                end
            end
        end
    end)


    return {
        MainFrame = MainFrame,
        SearchBox = SearchBox,
        Tabs = {},
    }
end

function SearcherUILibrary:AddTab(window, config)
    local TabFrame = window.MainFrame:FindFirstChild("TabFrame") or Instance.new("ScrollingFrame", window.MainFrame)
    TabFrame.Size = UDim2.new(0, 141, 0, 278)
    TabFrame.Position = UDim2.new(0.01, 0, 0.178, 0)
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabFrame.BorderSizePixel = 0
    TabFrame.Name = "TabFrame"
    TabFrame.ScrollBarThickness = 4
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    TabFrame.ScrollingEnabled = true
    TabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabFrame.ScrollBarImageColor3 = Color3.fromRGB(50,50,50)

    local ListLayout = Instance.new("UIListLayout", TabFrame)
    ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ListLayout.Padding = UDim.new(0, 5)

    local function updateTabScrolling()
        TabFrame.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
        TabFrame.ScrollingEnabled = TabFrame.CanvasSize.Y.Offset > TabFrame.AbsoluteSize.Y
    end

    ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateTabScrolling)
    updateTabScrolling()

    local TabButton = Instance.new("ImageButton", TabFrame)
    TabButton.Size = UDim2.new(0, 135, 0, 30)
    TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    TabButton.BorderSizePixel = 0
    TabButton.Image = config.Icon or ""
    TabButton.ImageColor3 = Color3.fromRGB(89, 89, 89) 
    TabButton.ImageTransparency = 0.23
    TabButton.BackgroundTransparency = 1

    local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(TabButton, hoverTweenInfo, {ImageColor3 = Color3.fromRGB(197, 197, 197)})
local normalColorTween = tweenService:Create(TabButton, hoverTweenInfo, {ImageColor3 = Color3.fromRGB(89, 89, 89)})

TabButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

TabButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)
        
    local tabButtonCorners = Instance.new("UICorner")
    tabButtonCorners.CornerRadius = UDim.new(0, 3)
    tabButtonCorners.Parent = TabButton

    local TabLabel = Instance.new("TextLabel")
    TabLabel.Size = UDim2.new(0, 135, 0, 30)
    TabLabel.Text = config.Game or "Untitled"
    TabLabel.Font = Enum.Font.ArialBold
    TabLabel.TextSize = 14
    TabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabLabel.BackgroundTransparency = 1
    TabLabel.Parent = TabButton
    TabLabel.TextXAlignment = Enum.TextXAlignment.Left
    TabLabel.TextYAlignment = Enum.TextYAlignment.Center
    TabLabel.TextWrapped = true

    local TextLabelPadding = Instance.new("UIPadding")
    TextLabelPadding.Parent = TabLabel
    TextLabelPadding.PaddingLeft = UDim.new(0, 5)
    
    -- Create ContentFrame
    local ContentFrame = Instance.new("ScrollingFrame", window.MainFrame)
    ContentFrame.Size = UDim2.new(0, 444, 0, 317)
    ContentFrame.Position = UDim2.new(0.26, 0, 0.084, 0)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.BorderSizePixel = 0
    ContentFrame.ScrollBarThickness = 4
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(60, 60, 60)
    ContentFrame.ScrollingEnabled = false
    ContentFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Visible = false
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.ScrollBarImageColor3 = Color3.fromRGB(50,50,50)

    local ContentLayout = Instance.new("UIListLayout", ContentFrame)
    ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentLayout.Padding = UDim.new(0, 5)

    local function updateContentScrolling()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentLayout.AbsoluteContentSize.Y)
        ContentFrame.ScrollingEnabled = ContentFrame.CanvasSize.Y.Offset > ContentFrame.AbsoluteSize.Y
    end

    ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateContentScrolling)
    updateContentScrolling()



    TabButton.MouseButton1Click:Connect(function()
        for _, child in ipairs(window.MainFrame:GetChildren()) do
            if child:IsA("ScrollingFrame") and child.Name == "ContentFrame" then
                child.Visible = false
            end
        end
        ContentFrame.Visible = true
    end)

    window.Tabs[config.Game or "Untitled"] = {
        Button = TabButton,
        Frame = ContentFrame,
    }


    return {
        ContentFrame = ContentFrame,
        TabButton = TabButton,
    }
end


function SearcherUILibrary:AddScript(tab, config)
    local ContentFrame = tab.ContentFrame

    local ScriptFrame = Instance.new("ImageLabel")
    ScriptFrame.Size = UDim2.new(0, 437, 0, 40)
    ScriptFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    ScriptFrame.BorderSizePixel = 0
    ScriptFrame.Image = config.Icon or ""
    ScriptFrame.Parent = ContentFrame
    ScriptFrame.ImageColor3 = Color3.fromRGB(89, 89, 89) 
    ScriptFrame.ImageTransparency = 0.23
    ScriptFrame.BackgroundTransparency = 1

    local ScriptFrameCorners = Instance.new("UICorner")
    ScriptFrameCorners.CornerRadius = UDim.new(0, 3)
    ScriptFrameCorners.Parent = ScriptFrame

    local ScriptLabel = Instance.new("TextLabel", ScriptFrame)
    ScriptLabel.Size = UDim2.new(0, 115, 0, 30)
    ScriptLabel.Position = UDim2.new(0.02, 0, 0.1, 0)
    ScriptLabel.Text = config.Title or "Script"
    ScriptLabel.Font = Enum.Font.ArialBold
    ScriptLabel.TextSize = 17
    ScriptLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ScriptLabel.BackgroundTransparency = 1
    ScriptLabel.TextXAlignment = Enum.TextXAlignment.Left

    local ExecuteButton = Instance.new("TextButton", ScriptFrame)
    ExecuteButton.Size = UDim2.new(0, 80, 0, 27)
    ExecuteButton.Position = UDim2.new(0.8, 0, 0.14, 0)
    ExecuteButton.Text = "Execute"
    ExecuteButton.Font = Enum.Font.ArialBold
    ExecuteButton.TextSize = 14
    ExecuteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ExecuteButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    ExecuteButton.BorderSizePixel = 0
    ExecuteButton.AutoButtonColor = false
    ExecuteButton.TextWrapped = true

        local tweenService = game:GetService("TweenService")
local hoverTweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local hoverColorTween = tweenService:Create(ExecuteButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(45,45,45)})
local normalColorTween = tweenService:Create(ExecuteButton, hoverTweenInfo, {BackgroundColor3 = Color3.fromRGB(25,25,25)})

ExecuteButton.MouseEnter:Connect(function()
    hoverColorTween:Play()
end)

ExecuteButton.MouseLeave:Connect(function()
    normalColorTween:Play()
end)

    local ExecuteButtonCorners = Instance.new("UICorner")
    ExecuteButtonCorners.CornerRadius = UDim.new(0, 3)
    ExecuteButtonCorners.Parent = ExecuteButton

    local function updateScrolling()
        ContentFrame.CanvasSize = UDim2.new(0, 0, 0, ContentFrame.UIListLayout.AbsoluteContentSize.Y)
        ContentFrame.ScrollingEnabled = ContentFrame.CanvasSize.Y.Offset > ContentFrame.AbsoluteSize.Y
    end

    ExecuteButton.MouseButton1Click:Connect(function()
        if config.Callback then
            config.Callback()
        end
    end)


    return ScriptFrame
end






local UILib = SearcherUILibrary

local Window = UILib:CreateWindow({
    Title = "Velocity | Script Searcher",
    Icon = "http://www.roblox.com/asset/?id=17403968010",
})

local Tabs = {
    Visuals = UILib:AddTab(Window, {Game = "Visuals", Icon = "http://www.roblox.com/asset/?id=18954013557"}),
    Rivals = UILib:AddTab(Window, {Game = "Rivals", Icon = "rbxassetid://118354616228514"}),
    BloxFruit = UILib:AddTab(Window, {Game = "BloxFruits", Icon = "http://www.roblox.com/asset/?id=16803637633"}),
    Strongest = UILib:AddTab(Window, {Game = "The Strongest Battle Grounds", Icon = "http://www.roblox.com/asset/?id=95381361794075"}),
    PS99 = UILib:AddTab(Window, {Game = "Pet Simulator 99", Icon = "http://www.roblox.com/asset/?id=80499780671892"}),
    JJK = UILib:AddTab(Window, {Game = "Jujutsu Shenanigans", Icon = "http://www.roblox.com/asset/?id=70487160345209"}),
    Dahood = UILib:AddTab(Window, {Game = "Da Hood", Icon = "http://www.roblox.com/asset/?id=134326397872947"}),
    Evade = UILib:AddTab(Window, {Game = "Evade", Icon = "http://www.roblox.com/asset/?id=103331983579685"}),
    Doors = UILib:AddTab(Window, {Game = "Doors", Icon = "http://www.roblox.com/asset/?id=71128510241514"}),
    MM2 = UILib:AddTab(Window, {Game = "Murder Mystery 2", Icon = "http://www.roblox.com/asset/?id=76051326595475"}),
    Jailbreak = UILib:AddTab(Window, {Game = "Jailbreak", Icon = "http://www.roblox.com/asset/?id=78566315145294"}),
    G3008 = UILib:AddTab(Window, {Game = "3008", Icon = "http://www.roblox.com/asset/?id=139325265919664"}),-- start
    Brookhaven = UILib:AddTab(Window, {Game = "Brookhaven", Icon = "http://www.roblox.com/asset/?id=131333019006492"}),
    Prision = UILib:AddTab(Window, {Game = "Prision Life", Icon = "http://www.roblox.com/asset/?id=120742705195501"}),
    Tower = UILib:AddTab(Window, {Game = "Tower Of Hell", Icon = "http://www.roblox.com/asset/?id=70482815301790"}),
    Slap = UILib:AddTab(Window, {Game = "Slap Battles", Icon = "http://www.roblox.com/asset/?id=110347554939363"}),
    King = UILib:AddTab(Window, {Game = "King Legacy", Icon = "http://www.roblox.com/asset/?id=101357195428337"}),
    Arsenal = UILib:AddTab(Window, {Game = "Arsenal", Icon = "http://www.roblox.com/asset/?id=137126359631331"}), -- stop
    BABFT = UILib:AddTab(Window, {Game = "Build A Boat For Treaser", Icon = "http://www.roblox.com/asset/?id=126625170868803"}),
    Blade = UILib:AddTab(Window, {Game = "Blade Ball", Icon = "http://www.roblox.com/asset/?id=88752035289389"}),
    Funky = UILib:AddTab(Window, {Game = "Funky Friday", Icon = "http://www.roblox.com/asset/?id=130576013619704"})
}

-- Misc --

UILib:AddScript(Tabs.Visuals, {
    Title = "Q Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/qtoolv3/main/qtoolv3", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "C Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
       loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/ctool/main/ctool", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "V Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/vtool/main/vtool", true))() 
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "A Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/a-tool/main/a-tool", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "P Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/P-TOOL/main/P-tool", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "K Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/k-tool/main/k-tool", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "E Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/e-tool/main/e-tool", true))()
    end
})


UILib:AddScript(Tabs.Visuals, {
    Title = "Keyboard",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Infinite Yeild",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Right Click",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/BalligusapoTT/BalligusapoTT/main/Leftclickballi'))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Animation Changer",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/LunarWareOP/Animation-Changer-Source/main/Script", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Fake Limiteds",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/fakelimitedsv2/main/fakelimitedsv2", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Chat Bypasser",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/synnyyy/synergy/additional/betterbypasser", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Fly",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XNEOFF/FlyGuiV3/main/FlyGuiV3.txt%22"))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Nameless Admin",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Auto Clicker",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        getgenv().key = "Hostile"
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Hosvile/The-telligence/main/MC%20KSystem%202%22"))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Better Volume",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/bettervolume/main/bettervolume", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Free Emotes",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/eCpipCTH"))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Devx Explorer",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Babyhamsta/RBLX_Scripts/main/Universal/BypassedDarkDexV3.lua", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "BT Tool",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
       loadstring(game:HttpGet("https://cdn.wearedevs.net/scripts/BTools.txt%22"))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Chat Spammer",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/scripthubekitten/chatspammer/main/chatspammer", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "FPS Booster",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        _G.Settings = {
    Players = {
        ["Ignore Me"] = true, -- Ignore your Character
        ["Ignore Others"] = true -- Ignore other Characters
    },
    Meshes = {
        Destroy = false, -- Destroy Meshes
        LowDetail = false -- Low detail meshes (NOT SURE IT DOES ANYTHING)
    },
    Images = {
        Invisible = true, -- Invisible Images
        LowDetail = false, -- Low detail images (NOT SURE IT DOES ANYTHING)
        Destroy = false, -- Destroy Images
    },
    Other = {
        ["No Particles"] = true, -- Disables all ParticleEmitter, Trail, Smoke, Fire and Sparkles
        ["No Camera Effects"] = true, -- Disables all PostEffect's (Camera/Lighting Effects)
        ["No Explosions"] = true, -- Makes Explosion's invisible
        ["No Clothes"] = true, -- Removes Clothing from the game
        ["Low Water Graphics"] = true, -- Removes Water Quality
        ["No Shadows"] = false, -- Remove Shadows
        ["Low Rendering"] = true, -- Lower Rendering
        ["Low Quality Parts"] = true -- Lower quality parts
    }
}
loadstring(game:HttpGet("https://raw.githubusercontent.com/CasperFlyModz/discord.gg-rips/main/FPSBooster.lua%22"))()
    end
})


UILib:AddScript(Tabs.Visuals, {
    Title = "Infinite Jump",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/WweihvrM"))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "CMD X",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/CMD-X/CMD-X/master/Source%22,true"))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Rejoin",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        local ts = game:GetService("TeleportService")

local p = game:GetService("Players").LocalPlayer

 

ts:Teleport(game.PlaceId, p)
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Headless And Korblox",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/H5yx10Jq'))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Hitbox Expander",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Vcsk/RobloxScripts/main/HitboxExpander.lua", true))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Mobile Resolution",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        getgenv().Resolution = {
    [".gg/scripters"] = 0.65
}

local Camera = workspace.CurrentCamera
if getgenv().gg_scripters == nil then
    game:GetService("RunService").RenderStepped:Connect(
        function()
            Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, getgenv().Resolution[".gg/scripters"], 0, 0, 0, 1)
        end
    )
end
getgenv().gg_scripters = "Aori0001"
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Rizz Script 1",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet('https://scripts.luawl.com/hosted/4694/19821/VadriftsRizz.lua'))()
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Rizz Script 2",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet('https://pastebin.com/raw/Wqxzdi1q'))()
    end
})



UILib:AddScript(Tabs.Visuals, {
    Title = "Anti AFK",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        wait(0.5)local ba=Instance.new("ScreenGui")
local ca=Instance.new("TextLabel")local da=Instance.new("Frame")
local _b=Instance.new("TextLabel")local ab=Instance.new("TextLabel")ba.Parent=game.CoreGui
ba.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;ca.Parent=ba;ca.Active=true
ca.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ca.Draggable=true
ca.Position=UDim2.new(0.698610067,0,0.098096624,0)ca.Size=UDim2.new(0,304,0,52)
ca.Font=Enum.Font.SourceSansSemibold;ca.Text="Smacking big pussy with tits"ca.TextColor3=Color3.new(0,1,1)
ca.TextSize=22;da.Parent=ca
da.BackgroundColor3=Color3.new(0.196078,0.196078,0.196078)da.Position=UDim2.new(0,0,1.0192306,0)
da.Size=UDim2.new(0,304,0,107)_b.Parent=da
_b.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)_b.Position=UDim2.new(0,0,0.800455689,0)
_b.Size=UDim2.new(0,304,0,21)_b.Font=Enum.Font.Arial;_b.Text="Made by XxSwordmaster_2xX"
_b.TextColor3=Color3.new(1,1,1)_b.TextSize=20;ab.Parent=da
ab.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ab.Position=UDim2.new(0,0,0.158377379,0)
ab.Size=UDim2.new(0,304,0,44)ab.Font=Enum.Font.ArialBold;ab.Text="Status: Script Started"
ab.TextColor3=Color3.new(1,1,1)ab.TextSize=20;local bb=game:service'VirtualUser'
game:service'Players'.LocalPlayer.Idled:connect(function()
bb:CaptureController()bb:ClickButton2(Vector2.new())
ab.Text="You went idle and ROBLOX tried to kick you but we reflected it!"wait(2)ab.Text="Script Re-Enabled"end)
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Server Hop",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        local module = loadstring(game:HttpGet"https://raw.githubusercontent.com/LeoKholYt/roblox/main/lk_serverhop.lua")()

module:Teleport(game.PlaceId)
    end
})

UILib:AddScript(Tabs.Visuals, {
    Title = "Shaders",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet(('https://pastefy.app/xXkUxA0P/raw'),true))()
    end
})

-- Rivals --

UILib:AddScript(Tabs.Rivals, {
    Title = "Thunder Client",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/25bef65fd4756876a25c68d1297b80a6.lua?__cf_chl_tk=py6zsQwNIzDxsnInPbhG.l2TK_ekGuFdSJKevW2938c-1724462623-0.0.1.1-4244"))()
    end
})

UILib:AddScript(Tabs.Rivals, {
    Title = "Venox",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet('https://raw.githubusercontent.com/venoxhh/universalscripts/main/rivals/venoxware'))()
    end
})

UILib:AddScript(Tabs.Rivals, {
    Title = "Nexam Hub",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/86c2ae2bea7bd8f522b1db3283b56967.lua"))()
    end
})

UILib:AddScript(Tabs.Rivals, {
    Title = "Rivals Roblox Gui",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Sheeshablee73/Scriptss/main/Rivals%20Latest.lua"))()
    end
})

-- Bloxfruit --

UILib:AddScript(Tabs.BloxFruit, {
    Title = "W-Azure",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/3b2169cf53bc6104dabe8e19562e5cc2.lua"))()
    end
})

UILib:AddScript(Tabs.BloxFruit, {
    Title = "Cokka Hub",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet"https://raw.githubusercontent.com/UserDevEthical/Loadstring/main/CokkaHub.lua")()
    end
})

UILib:AddScript(Tabs.BloxFruit, {
    Title = "Hoho Hub",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/acsu123/HOHO_H/main/Loading_UI"))()
    end
})

UILib:AddScript(Tabs.BloxFruit, {
    Title = "Annie Hub",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Anniecuti/Free-Scr/main/Annie-Hub.lua"))()
    end
})

UILib:AddScript(Tabs.BloxFruit, {
    Title = "BKHAX",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/koonpeatch/PeatEX/master/BKHAX/BloxFruits"))()
    end
})

UILib:AddScript(Tabs.BloxFruit, {
    Title = "Matsune Hub",
    Icon = "http://www.roblox.com/asset/?id=18954013557",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/SkibidiSupremacy/Loader.xyz/main/Loader.Blurk%20ST%20%3A%20G"))()
    end
})
return UILib
