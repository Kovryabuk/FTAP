--[[
    Simpliness UI Library for Roblox
    A beautiful dark-themed UI library with purple accents
]]

local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local TextService = game:GetService("TextService")

-- Colors
local colors = {
    Background = Color3.fromRGB(25, 25, 30),
    DarkContrast = Color3.fromRGB(19, 19, 24),
    LightContrast = Color3.fromRGB(30, 30, 36),
    TextColor = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(177, 156, 217),
    DarkAccent = Color3.fromRGB(150, 130, 190),
    Hover = Color3.fromRGB(35, 35, 40),
    Shadow = Color3.fromRGB(15, 15, 17)
}

-- Create the GUI
function Library:CreateWindow(title)
    local SimplicityLib = Instance.new("ScreenGui")
    SimplicityLib.Name = "SimplicityLib"
    SimplicityLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    SimplicityLib.ResetOnSpawn = false
    
    -- Check if using Synapse or other exploits
    pcall(function()
        syn.protect_gui(SimplicityLib)
        SimplicityLib.Parent = game.CoreGui
    end)
    
    -- Fallback if exploit doesn't support syn.protect_gui
    if not SimplicityLib.Parent then
        SimplicityLib.Parent = game.CoreGui
    end
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.BackgroundColor3 = colors.Background
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 575, 0, 350)
    MainFrame.Parent = SimplicityLib
    MainFrame.Active = true
    MainFrame.Draggable = true
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 35, 1, 35)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://5554236805"
    Shadow.ImageColor3 = colors.Shadow
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.Parent = MainFrame
    
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.BackgroundColor3 = colors.DarkContrast
    TopBar.BorderSizePixel = 0
    TopBar.Size = UDim2.new(1, 0, 0, 30)
    TopBar.Parent = MainFrame
    
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Name = "Title"
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 10, 0, 0)
    TitleLabel.Size = UDim2.new(0, 200, 1, 0)
    TitleLabel.Font = Enum.Font.Gotham
    TitleLabel.Text = title or "Simpliness"
    TitleLabel.TextColor3 = colors.TextColor
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TopBar
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.BackgroundTransparency = 1
    CloseButton.Position = UDim2.new(1, -25, 0, 0)
    CloseButton.Size = UDim2.new(0, 25, 1, 0)
    CloseButton.Font = Enum.Font.Gotham
    CloseButton.Text = "×"
    CloseButton.TextColor3 = colors.TextColor
    CloseButton.TextSize = 20
    CloseButton.Parent = TopBar
    
    CloseButton.MouseButton1Click:Connect(function()
        SimplicityLib:Destroy()
    end)
    
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.BackgroundTransparency = 1
    MinimizeButton.Position = UDim2.new(1, -50, 0, 0)
    MinimizeButton.Size = UDim2.new(0, 25, 1, 0)
    MinimizeButton.Font = Enum.Font.Gotham
    MinimizeButton.Text = "-"
    MinimizeButton.TextColor3 = colors.TextColor
    MinimizeButton.TextSize = 20
    MinimizeButton.Parent = TopBar
    
    local Minimized = false
    MinimizeButton.MouseButton1Click:Connect(function()
        Minimized = not Minimized
        if Minimized then
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 575, 0, 30)}):Play()
        else
            TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2.new(0, 575, 0, 350)}):Play()
        end
    end)
    
    local TabButtons = Instance.new("Frame")
    TabButtons.Name = "TabButtons"
    TabButtons.BackgroundColor3 = colors.DarkContrast
    TabButtons.BorderSizePixel = 0
    TabButtons.Position = UDim2.new(0, 0, 0, 30)
    TabButtons.Size = UDim2.new(0, 100, 1, -30)
    TabButtons.Parent = MainFrame
    
    local TabButtonHolder = Instance.new("ScrollingFrame")
    TabButtonHolder.Name = "TabButtonHolder"
    TabButtonHolder.Active = true
    TabButtonHolder.BackgroundTransparency = 1
    TabButtonHolder.BorderSizePixel = 0
    TabButtonHolder.Position = UDim2.new(0, 0, 0, 10)
    TabButtonHolder.Size = UDim2.new(1, 0, 1, -20)
    TabButtonHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
    TabButtonHolder.ScrollBarThickness = 0
    TabButtonHolder.Parent = TabButtons
    
    local TabButtonLayout = Instance.new("UIListLayout")
    TabButtonLayout.Name = "TabButtonLayout"
    TabButtonLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    TabButtonLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabButtonLayout.Padding = UDim.new(0, 5)
    TabButtonLayout.Parent = TabButtonHolder
    
    local TabFolder = Instance.new("Folder")
    TabFolder.Name = "TabFolder"
    TabFolder.Parent = MainFrame
    
    -- Update the canvas size for the tab button holder
    TabButtonLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabButtonHolder.CanvasSize = UDim2.new(0, 0, 0, TabButtonLayout.AbsoluteContentSize.Y)
    end)
    
    local SelectedTab = nil
    local Window = {}
    
    -- Create a new tab
    function Window:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "TabButton"
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(0, 90, 0, 25)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = name
        TabButton.TextColor3 = colors.TextColor
        TabButton.TextSize = 12
        TabButton.Parent = TabButtonHolder
        
        local TabUnderline = Instance.new("Frame")
        TabUnderline.Name = "TabUnderline"
        TabUnderline.BackgroundColor3 = colors.Accent
        TabUnderline.BorderSizePixel = 0
        TabUnderline.Position = UDim2.new(0, 0, 1, -1)
        TabUnderline.Size = UDim2.new(0, 0, 0, 1)
        TabUnderline.Parent = TabButton
        
        local TabContainer = Instance.new("ScrollingFrame")
        TabContainer.Name = name .. "TabContainer"
        TabContainer.Active = true
        TabContainer.BackgroundTransparency = 1
        TabContainer.BorderSizePixel = 0
        TabContainer.Position = UDim2.new(0, 100, 0, 30)
        TabContainer.Size = UDim2.new(1, -100, 1, -30)
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        TabContainer.ScrollBarThickness = 2
        TabContainer.ScrollBarImageColor3 = colors.Accent
        TabContainer.Visible = false
        TabContainer.Parent = TabFolder
        
        local ElementLayout = Instance.new("UIListLayout")
        ElementLayout.Name = "ElementLayout"
        ElementLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        ElementLayout.SortOrder = Enum.SortOrder.LayoutOrder
        ElementLayout.Padding = UDim.new(0, 10)
        ElementLayout.Parent = TabContainer
        
        local ElementPadding = Instance.new("UIPadding")
        ElementPadding.Name = "ElementPadding"
        ElementPadding.PaddingTop = UDim.new(0, 10)
        ElementPadding.PaddingBottom = UDim.new(0, 10)
        ElementPadding.Parent = TabContainer
        
        -- Update the canvas size for the tab container
        ElementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContainer.CanvasSize = UDim2.new(0, 0, 0, ElementLayout.AbsoluteContentSize.Y + 20)
        end)
        
        TabButton.MouseButton1Click:Connect(function()
            if SelectedTab == name then return end
            
            -- Hide all tabs
            for _, container in pairs(TabFolder:GetChildren()) do
                container.Visible = false
            end
            
            -- Reset all tab buttons
            for _, button in pairs(TabButtonHolder:GetChildren()) do
                if button:IsA("TextButton") then
                    TweenService:Create(button, TweenInfo.new(0.3), {TextColor3 = colors.TextColor}):Play()
                    TweenService:Create(button.TabUnderline, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 1)}):Play()
                end
            end
            
            -- Show selected tab
            TabContainer.Visible = true
            TweenService:Create(TabButton, TweenInfo.new(0.3), {TextColor3 = colors.Accent}):Play()
            TweenService:Create(TabUnderline, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 1)}):Play()
            
            SelectedTab = name
        end)
        
        local Tab = {}
        
        -- Create a section in the tab
        function Tab:CreateSection(sectionName)
            local Section = Instance.new("Frame")
            Section.Name = sectionName .. "Section"
            Section.BackgroundColor3 = colors.LightContrast
            Section.BorderSizePixel = 0
            Section.Size = UDim2.new(0.95, 0, 0, 30)
            Section.Parent = TabContainer
            
            local SectionCorner = Instance.new("UICorner")
            SectionCorner.CornerRadius = UDim.new(0, 5)
            SectionCorner.Parent = Section
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "SectionTitle"
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Position = UDim2.new(0, 10, 0, 0)
            SectionTitle.Size = UDim2.new(1, -10, 0, 30)
            SectionTitle.Font = Enum.Font.GothamSemibold
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = colors.TextColor
            SectionTitle.TextSize = 12
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            SectionTitle.Parent = Section
            
            local SectionContainer = Instance.new("Frame")
            SectionContainer.Name = "SectionContainer"
            SectionContainer.BackgroundTransparency = 1
            SectionContainer.Position = UDim2.new(0, 0, 0, 30)
            SectionContainer.Size = UDim2.new(1, 0, 0, 0)
            SectionContainer.Parent = Section
            
            local SectionElementLayout = Instance.new("UIListLayout")
            SectionElementLayout.Name = "SectionElementLayout"
            SectionElementLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            SectionElementLayout.SortOrder = Enum.SortOrder.LayoutOrder
            SectionElementLayout.Padding = UDim.new(0, 5)
            SectionElementLayout.Parent = SectionContainer
            
            local SectionPadding = Instance.new("UIPadding")
            SectionPadding.Name = "SectionPadding"
            SectionPadding.PaddingBottom = UDim.new(0, 5)
            SectionPadding.Parent = SectionContainer
            
            -- Update the section size based on its contents
            SectionElementLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContainer.Size = UDim2.new(1, 0, 0, SectionElementLayout.AbsoluteContentSize.Y + 5)
                Section.Size = UDim2.new(0.95, 0, 0, 30 + SectionContainer.Size.Y.Offset)
            end)
            
            local SectionElements = {}
            
            -- Create a toggle element
            function SectionElements:CreateToggle(toggleName, callback)
                callback = callback or function() end
                
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Name = toggleName .. "Toggle"
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Size = UDim2.new(0.95, 0, 0, 30)
                ToggleFrame.Parent = SectionContainer
                
                local ToggleLabel = Instance.new("TextLabel")
                ToggleLabel.Name = "ToggleLabel"
                ToggleLabel.BackgroundTransparency = 1
                ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
                ToggleLabel.Font = Enum.Font.Gotham
                ToggleLabel.Text = toggleName
                ToggleLabel.TextColor3 = colors.TextColor
                ToggleLabel.TextSize = 12
                ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                ToggleLabel.Parent = ToggleFrame
                
                local ToggleButton = Instance.new("Frame")
                ToggleButton.Name = "ToggleButton"
                ToggleButton.BackgroundColor3 = colors.DarkContrast
                ToggleButton.BorderSizePixel = 0
                ToggleButton.Position = UDim2.new(1, -50, 0.5, -8)
                ToggleButton.Size = UDim2.new(0, 40, 0, 16)
                ToggleButton.Parent = ToggleFrame
                
                local ToggleButtonCorner = Instance.new("UICorner")
                ToggleButtonCorner.CornerRadius = UDim.new(1, 0)
                ToggleButtonCorner.Parent = ToggleButton
                
                local ToggleCircle = Instance.new("Frame")
                ToggleCircle.Name = "ToggleCircle"
                ToggleCircle.BackgroundColor3 = colors.TextColor
                ToggleCircle.Position = UDim2.new(0, 2, 0.5, -6)
                ToggleCircle.Size = UDim2.new(0, 12, 0, 12)
                ToggleCircle.Parent = ToggleButton
                
                local ToggleCircleCorner = Instance.new("UICorner")
                ToggleCircleCorner.CornerRadius = UDim.new(1, 0)
                ToggleCircleCorner.Parent = ToggleCircle
                
                local Toggled = false
                
                local function UpdateToggle()
                    Toggled = not Toggled
                    if Toggled then
                        TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = colors.Accent}):Play()
                        TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(1, -14, 0.5, -6)}):Play()
                    else
                        TweenService:Create(ToggleButton, TweenInfo.new(0.3), {BackgroundColor3 = colors.DarkContrast}):Play()
                        TweenService:Create(ToggleCircle, TweenInfo.new(0.3), {Position = UDim2.new(0, 2, 0.5, -6)}):Play()
                    end
                    callback(Toggled)
                end
                
                ToggleButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        UpdateToggle()
                    end
                end)
                
                -- Create a clickable hitbox for the entire toggle frame
                local ToggleHitbox = Instance.new("TextButton")
                ToggleHitbox.Name = "ToggleHitbox"
                ToggleHitbox.BackgroundTransparency = 1
                ToggleHitbox.Size = UDim2.new(1, 0, 1, 0)
                ToggleHitbox.Text = ""
                ToggleHitbox.Parent = ToggleFrame
                
                ToggleHitbox.MouseButton1Click:Connect(function()
                    UpdateToggle()
                end)
                
                local ToggleElement = {}
                
                function ToggleElement:Set(value)
                    if value ~= Toggled then
                        UpdateToggle()
                    end
                end
                
                return ToggleElement
            end
            
            -- Create a slider element
            function SectionElements:CreateSlider(sliderName, minValue, maxValue, defaultValue, precision, callback)
                callback = callback or function() end
                defaultValue = defaultValue or minValue
                precision = precision or 0
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Name = sliderName .. "Slider"
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Size = UDim2.new(0.95, 0, 0, 50)
                SliderFrame.Parent = SectionContainer
                
                local SliderLabel = Instance.new("TextLabel")
                SliderLabel.Name = "SliderLabel"
                SliderLabel.BackgroundTransparency = 1
                SliderLabel.Position = UDim2.new(0, 10, 0, 0)
                SliderLabel.Size = UDim2.new(1, -10, 0, 20)
                SliderLabel.Font = Enum.Font.Gotham
                SliderLabel.Text = sliderName
                SliderLabel.TextColor3 = colors.TextColor
                SliderLabel.TextSize = 12
                SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                SliderLabel.Parent = SliderFrame
                
                local SliderValue = Instance.new("TextLabel")
                SliderValue.Name = "SliderValue"
                SliderValue.BackgroundTransparency = 1
                SliderValue.Position = UDim2.new(1, -40, 0, 0)
                SliderValue.Size = UDim2.new(0, 30, 0, 20)
                SliderValue.Font = Enum.Font.Gotham
                SliderValue.Text = tostring(defaultValue)
                SliderValue.TextColor3 = colors.TextColor
                SliderValue.TextSize = 12
                SliderValue.Parent = SliderFrame
                
                local SliderBackground = Instance.new("Frame")
                SliderBackground.Name = "SliderBackground"
                SliderBackground.BackgroundColor3 = colors.DarkContrast
                SliderBackground.BorderSizePixel = 0
                SliderBackground.Position = UDim2.new(0, 10, 0, 25)
                SliderBackground.Size = UDim2.new(1, -20, 0, 6)
                SliderBackground.Parent = SliderFrame
                
                local SliderBackgroundCorner = Instance.new("UICorner")
                SliderBackgroundCorner.CornerRadius = UDim.new(1, 0)
                SliderBackgroundCorner.Parent = SliderBackground
                
                local SliderFill = Instance.new("Frame")
                SliderFill.Name = "SliderFill"
                SliderFill.BackgroundColor3 = colors.Accent
                SliderFill.BorderSizePixel = 0
                SliderFill.Size = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 1, 0)
                SliderFill.Parent = SliderBackground
                
                local SliderFillCorner = Instance.new("UICorner")
                SliderFillCorner.CornerRadius = UDim.new(1, 0)
                SliderFillCorner.Parent = SliderFill
                
                local SliderCircle = Instance.new("Frame")
                SliderCircle.Name = "SliderCircle"
                SliderCircle.AnchorPoint = Vector2.new(0.5, 0.5)
                SliderCircle.BackgroundColor3 = colors.TextColor
                SliderCircle.Position = UDim2.new((defaultValue - minValue) / (maxValue - minValue), 0, 0.5, 0)
                SliderCircle.Size = UDim2.new(0, 12, 0, 12)
                SliderCircle.Parent = SliderBackground
                
                local SliderCircleCorner = Instance.new("UICorner")
                SliderCircleCorner.CornerRadius = UDim.new(1, 0)
                SliderCircleCorner.Parent = SliderCircle
                
                local function UpdateSlider(input)
                    local positionX = math.clamp((input.Position.X - SliderBackground.AbsolutePosition.X) / SliderBackground.AbsoluteSize.X, 0, 1)
                    SliderFill.Size = UDim2.new(positionX, 0, 1, 0)
                    SliderCircle.Position = UDim2.new(positionX, 0, 0.5, 0)
                    
                    local value = minValue + (maxValue - minValue) * positionX
                    value = math.floor(value * 10^precision) / 10^precision
                    SliderValue.Text = tostring(value)
                    callback(value)
                end
                
                SliderBackground.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        UpdateSlider(input)
                        local connection
                        connection = RunService.RenderStepped:Connect(function()
                            if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
                                UpdateSlider({Position = Vector2.new(Mouse.X, Mouse.Y)})
                            else
                                connection:Disconnect()
                            end
                        end)
                    end
                end)
                
                local SliderElement = {}
                
                function SliderElement:Set(value)
                    value = math.clamp(value, minValue, maxValue)
                    value = math.floor(value * 10^precision) / 10^precision
                    SliderValue.Text = tostring(value)
                    
                    local positionX = (value - minValue) / (maxValue - minValue)
                    TweenService:Create(SliderFill, TweenInfo.new(0.3), {Size = UDim2.new(positionX, 0, 1, 0)}):Play()
                    TweenService:Create(SliderCircle, TweenInfo.new(0.3), {Position = UDim2.new(positionX, 0, 0.5, 0)}):Play()
                    
                    callback(value)
                end
                
                SliderElement:Set(defaultValue)
                return SliderElement
            end
            
            -- Create a button element
            function SectionElements:CreateButton(buttonName, callback)
                callback = callback or function() end
                
                local ButtonFrame = Instance.new("Frame")
                ButtonFrame.Name = buttonName .. "Button"
                ButtonFrame.BackgroundTransparency = 1
                ButtonFrame.Size = UDim2.new(0.95, 0, 0, 30)
                ButtonFrame.Parent = SectionContainer
                
                local Button = Instance.new("TextButton")
                Button.Name = "Button"
                Button.BackgroundColor3 = colors.DarkContrast
                Button.BorderSizePixel = 0
                Button.Size = UDim2.new(1, 0, 1, 0)
                Button.Font = Enum.Font.Gotham
                Button.Text = buttonName
                Button.TextColor3 = colors.TextColor
                Button.TextSize = 12
                Button.Parent = ButtonFrame
                
                local ButtonCorner = Instance.new("UICorner")
                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button
                
                Button.MouseButton1Click:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = colors.Accent}):Play()
                    wait(0.15)
                    TweenService:Create(Button, TweenInfo.new(0.15, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {BackgroundColor3 = colors.DarkContrast}):Play()
                    callback()
                end)
                
                Button.MouseEnter:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = colors.Hover}):Play()
                end)
                
                Button.MouseLeave:Connect(function()
                    TweenService:Create(Button, TweenInfo.new(0.2), {BackgroundColor3 = colors.DarkContrast}):Play()
                end)
                
                return Button
            end
            
            -- Create a dropdown element
            function SectionElements:CreateDropdown(dropdownName, options, callback)
                callback = callback or function() end
                options = options or {}
                
                local DropdownFrame = Instance.new("Frame")
                DropdownFrame.Name = dropdownName .. "Dropdown"
                DropdownFrame.BackgroundTransparency = 1
                DropdownFrame.Size = UDim2.new(0.95, 0, 0, 30)
                DropdownFrame.Parent = SectionContainer
                
                local DropdownLabel = Instance.new("TextLabel")
                DropdownLabel.Name = "DropdownLabel"
                DropdownLabel.BackgroundTransparency = 1
                DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
                DropdownLabel.Size = UDim2.new(1, -10, 0, 30)
                DropdownLabel.Font = Enum.Font.Gotham
                DropdownLabel.Text = dropdownName
                DropdownLabel.TextColor3 = colors.TextColor
                DropdownLabel.TextSize = 12
                DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                DropdownLabel.Parent = DropdownFrame
                
                local DropdownButton = Instance.new("TextButton")
                DropdownButton.Name = "DropdownButton"
                DropdownButton.BackgroundColor3 = colors.DarkContrast
                DropdownButton.BorderSizePixel = 0
                DropdownButton.Position = UDim2.new(0.5, 0, 0, 30)
                DropdownButton.Size = UDim2.new(1, 0, 0, 30)
                DropdownButton.Font = Enum.Font.Gotham
                DropdownButton.Text = "Select..."
                DropdownButton.TextColor3 = colors.TextColor
                DropdownButton.TextSize = 12
                DropdownButton.Parent = DropdownFrame
                
                local DropdownButtonCorner = Instance.new("UICorner")
                DropdownButtonCorner.CornerRadius = UDim.new(0, 4)
                DropdownButtonCorner.Parent = DropdownButton
                
                local DropdownContainer = Instance.new("Frame")
                DropdownContainer.Name = "DropdownContainer"
                DropdownContainer.BackgroundColor3 = colors.DarkContrast
                
