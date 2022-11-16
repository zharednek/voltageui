-- gcinfo and garbage collection credits to lego
spawn(function()
    repeat task.wait() until game:IsLoaded()

    local Amplitude = 200
    local RandomValue = {-15,15}
    local RandomTime = {.5, 1.5}

    local floor = math.floor
    local cos = math.cos
    local sin = math.sin
    local acos = math.acos
    local pi = math.pi

    local Maxima = 0

    while task.wait() do
        if gcinfo() >= Maxima then
            Maxima = gcinfo()
        else
            break
        end
    end

    task.wait(0.30)

    local OldGcInfo = gcinfo()+Amplitude
    local tick = 0

    local Old; Old = hookfunction(gcinfo, function(...)
        local Formula = ((acos(cos(pi * (tick)))/pi * (Amplitude * 2)) + -Amplitude )
        return floor(OldGcInfo + Formula)
    end)
    local Old2; Old2 = hookfunction(collectgarbage, function(arg, ...)
        if arg == "collect" then
            return gcinfo(...)
        end
        return Old2(arg, ...)
    end)


    game:GetService("RunService").Stepped:Connect(function()
        local Formula = ((acos(cos(pi * (tick)))/pi * (Amplitude * 2)) + -Amplitude )
        if Formula > ((acos(cos(pi * (tick)+.01))/pi * (Amplitude * 2)) + -Amplitude ) then
            tick = tick + .07
        else
            tick = tick + 0.01
        end
    end)

    local old1 = Amplitude
    for i,v in next, RandomTime do
        RandomTime[i] = v * 10000
    end

    local RandomTimeValue = math.random(RandomTime[1],RandomTime[2])/10000

    while wait(RandomTime) do
        Amplitude = math.random(old1+RandomValue[1], old1+RandomValue[2])
        RandomTimeValue = math.random(RandomTime[1],RandomTime[2])/10000
    end
end)

-- credits to lego again
spawn(function()
    repeat task.wait() until game:IsLoaded()

    local RunService = game:GetService("RunService")

    local Stats = game:GetService("Stats")
    local CurrMem = Stats:GetTotalMemoryUsageMb();
    local Rand = 0

    RunService.Stepped:Connect(function()
        Rand = math.random(-3,3)
    end)

    local _MemBypass
    _MemBypass = hookmetamethod(game, "__namecall", function(self,...)
        local method = getnamecallmethod();

        if not checkcaller() then
            if typeof(self) == "Instance" and method == "GetTotalMemoryUsageMb" and self.ClassName == "Stats" then
                return CurrMem + Rand;
            end
        end

        return _MemBypass(self,...)
    end)
end)

-- ... and again
for i,v in next, getconnections(game.DescendantAdded) do
    v:Disable()
end

-- ok my stuff now

local is_synapse = syn and syn.protect_gui
local library = {}

function library:CreateWindow(name)
    name = name or "Voltage"
    for i, v in pairs(game.CoreGui:GetChildren()) do
        if v.Name == name then
            v:Destroy()
        end
    end

    local Voltage = Instance.new("ScreenGui")
    local TopMain = Instance.new("Frame")
    local Container = Instance.new("Frame")
    local UIGridLayout = Instance.new("UIGridLayout")
    local Title = Instance.new("TextLabel")
    local ToggleGui = Instance.new("TextButton")
    local CloseGui = Instance.new("TextButton")

    Voltage.Name = "Voltage"
    if is_synapse then
        syn.protect_gui(Voltage)
        Voltage.Parent = game.CoreGui
    elseif gethui then
        Voltage.Parent = gethui()
    else
        Voltage.Parent = game.CoreGui
    end

    TopMain.Name = "TopMain"
    TopMain.Parent = Voltage
    TopMain.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TopMain.BorderSizePixel = 0
    TopMain.Position = UDim2.new(0.310302287, 0, 0.278362572, 0)
    TopMain.Size = UDim2.new(0, 300, 0, 30)

    Container.Name = "Container"
    Container.Parent = TopMain
    Container.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Container.BorderSizePixel = 0
    Container.Position = UDim2.new(0, 0, 1, 0)
    Container.Size = UDim2.new(0, 300, 0, 300)

    UIGridLayout.Parent = Container
    UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 0)
    UIGridLayout.CellSize = UDim2.new(1, 0, 0, 50)

    Title.Name = "Title"
    Title.Parent = TopMain
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0.0378894657, 0, 0, 0)
    Title.Size = UDim2.new(0, 200, 0, 31)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "Title"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    ToggleGui.Name = "ToggleGui"
    ToggleGui.Parent = TopMain
    ToggleGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleGui.BackgroundTransparency = 1.000
    ToggleGui.BorderSizePixel = 0
    ToggleGui.Position = UDim2.new(0.792844713, 0, 0, 0)
    ToggleGui.Size = UDim2.new(0, 31, 0, 31)
    ToggleGui.Font = Enum.Font.GothamBold
    ToggleGui.Text = "-"
    ToggleGui.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleGui.TextSize = 20.000

    CloseGui.Name = "CloseGui"
    CloseGui.Parent = TopMain
    CloseGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    CloseGui.BackgroundTransparency = 1.000
    CloseGui.BorderSizePixel = 0
    CloseGui.Position = UDim2.new(0.896178007, 0, 0, 0)
    CloseGui.Size = UDim2.new(0, 31, 0, 31)
    CloseGui.Font = Enum.Font.GothamBold
    CloseGui.Text = "X"
    CloseGui.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseGui.TextSize = 20.000

    local function SPOYW_fake_script() -- ToggleGui.LocalScript 
        local script = Instance.new('LocalScript', ToggleGui)
    
        local Opened = true
        function Close()
            if Opened == true then
                for i, v in pairs(script.Parent.Parent.Container:GetChildren()) do
                    if v.ClassName ~= "UIGridLayout" then
                        v.Visible = false
                    end
                end
                Opened = false
                script.Parent.Parent.Container:TweenSize(UDim2.new(0, 300, 0, 0))
                repeat wait(0.1) until script.Parent.Parent.Container.Size.Y == UDim.new(0, 0)
            elseif Opened == false then
                script.Parent.Parent.Container:TweenSize(UDim2.new(0, 300, 0, 300))
                repeat wait(0.1) until script.Parent.Parent.Container.Size.Y == UDim.new(0, 300)
                Opened = true
                for i, v in pairs(script.Parent.Parent.Container:GetChildren()) do
                    if v.ClassName ~= "UIGridLayout" then
                        v.Visible = true
                    end
                end
            end
        end
        
        script.Parent.MouseButton1Click:Connect(Close)
    end
    coroutine.wrap(SPOYW_fake_script)()
    local function KGHD_fake_script() -- CloseGui.LocalScript 
        local script = Instance.new('LocalScript', CloseGui)
        function DestroyGui()
            Voltage:Destroy()
        end
    
        script.Parent.MouseButton1Click:Connect(DestroyGui)
        
    end
    coroutine.wrap(KGHD_fake_script)()

    local UIS = game:GetService("UserInputService")
    function dragify(Frame)
        dragToggle = nil
        local dragSpeed = 0
        dragInput = nil
        dragStart = nil
        local dragPos = nil
        function updateInput(input)
            local Delta = input.Position - dragStart
            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
            game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.25), {Position = Position}):Play()
        end
        Frame.InputBegan:Connect(function(input)
            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UIS:GetFocusedTextBox() == nil then
                dragToggle = true
                dragStart = input.Position
                startPos = Frame.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragToggle = false
                    end
                end)
            end
        end)
        Frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        game:GetService("UserInputService").InputChanged:Connect(function(input)
            if input == dragInput and dragToggle then
                updateInput(input)
            end
        end)
    end
    
    dragify(TopMain)

    local _library = {}

    function _library:CreateButton(name, callback)
        name = name or "New Button"
        callback = callback or function() end

        local Button = Instance.new("TextButton")

        Button.Name = name
        Button.Parent = Container
        Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(0, 200, 0, 50)
        Button.Font = Enum.Font.GothamSemibold
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.TextSize = 14.000
        Button.Text = name

        Button.MouseButton1Down:Connect(function()
            pcall(callback)
        end)
    end

    function _library:CreateToggle(name, callback)
        name = name or "New Toggle"
        callback = callback or function() end
        local Actions = {}
        local Enabled = false

        local Toggle = Instance.new("Frame")
        local ToggleName = Instance.new("TextLabel")
        local Background = Instance.new("TextButton")
        local OnOffToggle = Instance.new("TextButton")

        Toggle.Name = name
        Toggle.Parent = Container
        Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Toggle.BackgroundTransparency = 1.000
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(0, 100, 0, 100)

        ToggleName.Name = "ToggleName"
        ToggleName.Parent = Toggle
        ToggleName.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        ToggleName.BackgroundTransparency = 1.000
        ToggleName.BorderSizePixel = 0
        ToggleName.Position = UDim2.new(0.0599999987, 0, -0.00442932127, 0)
        ToggleName.Size = UDim2.new(0, 172, 0, 50)
        ToggleName.Font = Enum.Font.GothamSemibold
        ToggleName.Text = name
        ToggleName.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleName.TextSize = 14.000
        ToggleName.TextXAlignment = Enum.TextXAlignment.Left

        Background.Name = "Background"
        Background.Parent = ToggleName
        Background.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Background.BorderSizePixel = 0
        Background.Position = UDim2.new(1.16271305, 0, 0.234999999, 0)
        Background.Size = UDim2.new(0, 50, 0, 25)
        Background.Font = Enum.Font.SourceSans
        Background.Text = ""
        Background.TextColor3 = Color3.fromRGB(255, 255, 255)
        Background.TextSize = 14.000

        OnOffToggle.Name = "OnOffToggle"
        OnOffToggle.Parent = Background
        OnOffToggle.BackgroundColor3 = Color3.fromRGB(255, 65, 65)
        OnOffToggle.BorderSizePixel = 0
        OnOffToggle.Position = UDim2.new(-0.012, 0, -0.02, 0)
        OnOffToggle.Size = UDim2.new(0, 25, 0, 25)
        OnOffToggle.Font = Enum.Font.SourceSans
        OnOffToggle.Text = ""
        OnOffToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
        OnOffToggle.TextSize = 14.000

        local function Fire()
            Enabled = not Enabled
            OnOffToggle:TweenPosition(Enabled and UDim2.new(0.488, 0,-0.02, 0) or UDim2.new(-0.012, 0, -0.02, 0), "InOut", "Quad", 0.3)
            OnOffToggle.BackgroundColor3 = Enabled and Color3.fromRGB(70, 255, 116) or Color3.fromRGB(255, 65, 65)
            pcall(callback, Enabled)
        end

        OnOffToggle.MouseButton1Click:Connect(Fire)

        function Actions:Set(arg)
            OnOffToggle:TweenPosition(Enabled and UDim2.new(0.488, 0,-0.02, 0) or UDim2.new(-0.012, 0, -0.02, 0), "InOut", "Quad", 0.3)
            OnOffToggle.BackgroundColor3 = Enabled and Color3.fromRGB(70, 255, 116) or Color3.fromRGB(255, 65, 65)
            pcall(callback, arg)
        end
    end

    function _library:CreateSlider(name, min, max, callback)
        name = name or "New Slider"
        minvalue = min or 0
        maxvalue = max or 500
        callback = callback or function() end

        local mouse = game.Players.LocalPlayer:GetMouse()
        local uis = game:GetService("UserInputService")
        local value

        local Slider = Instance.new("Frame")
        local SliderName = Instance.new("TextLabel")
        local SliderButton = Instance.new("TextButton")
        local SliderInner = Instance.new("Frame")
        local Value = Instance.new("TextLabel")

        Slider.Name = name
        Slider.Parent = Container
        Slider.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Slider.BorderSizePixel = 0
        Slider.Position = UDim2.new(0, 0, 0.286666662, 0)
        Slider.Size = UDim2.new(0, 100, 0, 100)

        SliderName.Name = "SliderName"
        SliderName.Parent = Slider
        SliderName.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        SliderName.BorderSizePixel = 0
        SliderName.Position = UDim2.new(0.0599999987, 0, 0, 0)
        SliderName.Size = UDim2.new(0, 151, 0, 20)
        SliderName.Font = Enum.Font.GothamSemibold
        SliderName.Text = name
        SliderName.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderName.TextSize = 14.000
        SliderName.TextXAlignment = Enum.TextXAlignment.Left

        SliderButton.Name = "SliderButton"
        SliderButton.Parent = Slider
        SliderButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        SliderButton.BorderSizePixel = 0
        SliderButton.Position = UDim2.new(0.0599999987, 0, 0.505999982, 0)
        SliderButton.Size = UDim2.new(0, 265, 0, 15)
        SliderButton.Font = Enum.Font.SourceSans
        SliderButton.Text = ""
        SliderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        SliderButton.TextSize = 14.000

        SliderInner.Name = "SliderInner"
        SliderInner.Parent = SliderButton
        SliderInner.BackgroundColor3 = Color3.fromRGB(255, 210, 44)
        SliderInner.BorderSizePixel = 0
        SliderInner.Size = UDim2.new(0, 0, 0, 15)

        Value.Name = "Value"
        Value.Parent = Slider
        Value.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        Value.BorderSizePixel = 0
        Value.Position = UDim2.new(0.704556048, 0, 0, 0)
        Value.Size = UDim2.new(0, 71, 0, 20)
        Value.Font = Enum.Font.GothamSemibold
        Value.Text = "0"
        Value.TextColor3 = Color3.fromRGB(255, 255, 255)
        Value.TextSize = 14.000
        Value.TextXAlignment = Enum.TextXAlignment.Right

        SliderButton.MouseButton1Down:Connect(function()
            value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 265) * SliderInner.AbsoluteSize.X) + tonumber(minvalue)) or 0
            pcall(function()
                callback(value)
            end)
            SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 265), 0, 15)
            moveconnection = mouse.Move:Connect(function()
                Value.Text = value
                value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 265) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
                pcall(function()
                    callback(value)
                end)
                SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 265), 0, 15)
            end)
            releaseconnection = uis.InputEnded:Connect(function(Mouse)
                if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                    value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 265) * SliderInner.AbsoluteSize.X) + tonumber(minvalue))
                    pcall(function()
                        callback(value)
                    end)
                    SliderInner.Size = UDim2.new(0, math.clamp(mouse.X - SliderInner.AbsolutePosition.X, 0, 265), 0, 15)
                    moveconnection:Disconnect()
                    releaseconnection:Disconnect()
                end
            end)
        end)
    end

    return _library
end

return Library
