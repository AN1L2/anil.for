local Players = game:GetService("Players")
local VIM = game:GetService("VirtualInputManager")
local UIS = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local setclipboard = setclipboard or print

-- 🛠️ ENGINE VARIABLES
local active = false
local targetPlayer = ""
local index = 1
local waitTime = 1.4
local phrases = {"LENA HAI KYA?", "ANIL SPAM USE KR", "DONT CRY KID", "TRY HARDER", "RO MAT", "BAAP SE MSTI NOII", "MKL BUND FAR CDAI", "🔥 ANIL PAPA BOL 🔥"}
local bypassStyles = {"0_o_ ", "Q-~ ", "Z_Z_ ", "I_I_ ", "D=D= "}


local SCRIPT_PASSWORD = "ANIL@123" -- 🔐 change this to whatever you want


-- 🛠️ UPDATED SPAM GENERATOR (WITH AUTO-CLIPBOARD)
local function getBypass()
    local style = bypassStyles[math.random(1, #bypassStyles)]
    local wall = string.rep(style, 22) 
    local msg = phrases[index]
    index = (index % #phrases) + 1
    local target = (targetPlayer ~= "" and targetPlayer) or "KID"
    local finalStr = wall .. " " .. target:upper() .. " < " .. msg:upper()
    
    -- FIX: Automatically copy to clipboard when generated
    if active then 
        setclipboard(finalStr) 
    end
    
    return finalStr
end

local function runAutoStep()
    local text = getBypass()
    UIS:ReleaseFocus()
    task.wait(0.1)
    VIM:SendKeyEvent(true, Enum.KeyCode.Slash, false, game)
    local start = tick()
    local chatBar = nil
    repeat 
        chatBar = UIS:GetFocusedTextBox()
        task.wait()
    until chatBar or (tick() - start) > 0.4
    if chatBar then
        chatBar.Text = text
        task.wait(0.1)
        VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        task.wait(0.1)
        UIS:ReleaseFocus()
    end
end

-- 🖥️ UI SETUP
if CoreGui:FindFirstChild("AnilSupreme") then CoreGui.AnilSupreme:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui); ScreenGui.Name = "AnilSupreme"
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(350, 420); Main.Position = UDim2.fromScale(0.5, 0.5); Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Main.BorderSizePixel = 0
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 15)
local Border = Instance.new("UIStroke", Main); Border.Color = Color3.fromRGB(0, 200, 255); Border.Thickness = 2.5

-- 🎡 LOGO & HEADER
local LogoBtn = Instance.new("TextButton", ScreenGui)
LogoBtn.Size = UDim2.fromOffset(55, 55); LogoBtn.Position = UDim2.fromScale(0.1, 0.1)
LogoBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20); LogoBtn.Text = "A"; LogoBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
LogoBtn.Font = Enum.Font.GothamBold; LogoBtn.TextSize = 25; Instance.new("UICorner", LogoBtn).CornerRadius = UDim.new(1, 0)
local LogoStroke = Instance.new("UIStroke", LogoBtn); LogoStroke.Color = Color3.new(1, 1, 1)
task.spawn(function() while task.wait(0.005) do LogoBtn.Rotation = LogoBtn.Rotation + 6 end end)

local Header = Instance.new("TextLabel", Main); Header.Text = "ANIL SUPREME"; Header.Size = UDim2.new(1, 0, 0, 50)
Header.Font = Enum.Font.GothamBold; Header.TextColor3 = Color3.new(1, 1, 1); Header.TextSize = 22; Header.BackgroundTransparency = 1

-- 📑 TAB SYSTEM
local TabBar = Instance.new("Frame", Main); TabBar.Position = UDim2.new(0, 10, 0, 60); TabBar.Size = UDim2.new(1, -20, 0, 35)
TabBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 8)
local TabList = Instance.new("UIListLayout", TabBar); TabList.FillDirection = Enum.FillDirection.Horizontal; TabList.HorizontalAlignment = Enum.HorizontalAlignment.Center; TabList.Padding = UDim.new(0, 15)

local Pages = {}; local TabButtons = {}
local function CreatePage(name)
    local p = Instance.new("Frame", Main); p.Name = name .. "Page"; p.Position = UDim2.new(0, 15, 0, 110); p.Size = UDim2.new(1, -30, 0, 280)
    p.BackgroundTransparency = 1; p.Visible = false; Pages[name] = p; return p
end

local function ShowPage(name)
    for n, p in pairs(Pages) do p.Visible = (n == name) end
    for n, btn in pairs(TabButtons) do btn.TextColor3 = (n == name) and Border.Color or Color3.fromRGB(150, 150, 150) end
end

local function MakeTab(name)
    local tab = Instance.new("TextButton", TabBar); tab.BackgroundTransparency = 1; tab.Size = UDim2.new(0, 60, 1, 0)
    tab.Text = name; tab.Font = Enum.Font.GothamBold; tab.TextSize = 13; tab.TextColor3 = Color3.fromRGB(150, 150, 150)
    TabButtons[name] = tab; tab.MouseButton1Click:Connect(function() ShowPage(name) end)
end

local SpamPage = CreatePage("Spam"); local ThemesPage = CreatePage("Themes"); local ScriptsPage = CreatePage("Scripts"); local CreditsPage = CreatePage("Credits")
MakeTab("Spam"); MakeTab("Themes"); MakeTab("Scripts"); MakeTab("Credits")
ShowPage("Spam")

-- ⚙️ SPAM CONTENT (Cloned from reference image)
local Input = Instance.new("TextBox", SpamPage); Input.Size = UDim2.new(1, 0, 0, 45); Input.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Input.PlaceholderText = "TARGET NAME"; Input.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", Input)
local CopyBtn = Instance.new("TextButton", SpamPage); CopyBtn.Size = UDim2.new(1, 0, 0, 45); CopyBtn.Position = UDim2.new(0, 0, 0, 60)
CopyBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30); CopyBtn.Text = "TOOL 1: COPY NEXT"; CopyBtn.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", CopyBtn)
local AutoBtn = Instance.new("TextButton", SpamPage); AutoBtn.Size = UDim2.new(1, 0, 0, 45); AutoBtn.Position = UDim2.new(0, 0, 0, 120)
AutoBtn.BackgroundColor3 = Color3.fromRGB(40, 190, 80); AutoBtn.Text = "TOOL 2: START AUTO-BOT"; AutoBtn.TextColor3 = Color3.new(1, 1, 1); Instance.new("UICorner", AutoBtn)

-- 🌈 THEMES CONTENT
local ThemeScroll = Instance.new("ScrollingFrame", ThemesPage); ThemeScroll.Size = UDim2.new(1, 0, 1, 0); ThemeScroll.BackgroundTransparency = 1; ThemeScroll.CanvasSize = UDim2.new(0,0,0,350); ThemeScroll.ScrollBarThickness = 0
local ThemeLayout = Instance.new("UIListLayout", ThemeScroll); ThemeLayout.Padding = UDim.new(0, 8); ThemeLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
local rgbLoop = false
local function CreateThemeBtn(name, color, isRGB)
    local btn = Instance.new("TextButton", ThemeScroll); btn.Size = UDim2.new(0, 280, 0, 45); btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20); btn.Text = name; btn.Font = Enum.Font.GothamBold; btn.TextColor3 = isRGB and Color3.new(1,1,1) or color; btn.TextSize = 14; Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(function() rgbLoop = isRGB; if isRGB then task.spawn(function() while rgbLoop do local c = Color3.fromHSV(tick() % 5 / 5, 1, 1); Border.Color = c; LogoBtn.TextColor3 = c; task.wait() end end) else Border.Color = color; LogoBtn.TextColor3 = color end end)
end
CreateThemeBtn("RGB MODE", Color3.new(1,1,1), true); CreateThemeBtn("Sky Blue", Color3.fromRGB(0, 200, 255), false); CreateThemeBtn("Red", Color3.fromRGB(255, 50, 50), false)
CreateThemeBtn("Purple", Color3.fromRGB(160, 80, 255), false)
CreateThemeBtn("Neon Green", Color3.fromRGB(50, 255, 120), false)
CreateThemeBtn("Orange", Color3.fromRGB(255, 140, 40), false)
CreateThemeBtn("Pink", Color3.fromRGB(255, 80, 150), false)
CreateThemeBtn("Yellow", Color3.fromRGB(255, 220, 80), false)
CreateThemeBtn("White", Color3.fromRGB(255, 255, 255), false)
-- 📜 SCRIPTS CONTENT
local ScriptScroll = Instance.new("ScrollingFrame", ScriptsPage)
ScriptScroll.Size = UDim2.new(1, 0, 1, 0)
ScriptScroll.BackgroundTransparency = 1
ScriptScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptScroll.ScrollBarThickness = 0

local ScriptLayout = Instance.new("UIListLayout", ScriptScroll)
ScriptLayout.Padding = UDim.new(0, 10)
ScriptLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ✅ AUTO SCROLL FIX
ScriptLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScriptScroll.CanvasSize = UDim2.new(
        0,
        0,
        0,
        ScriptLayout.AbsoluteContentSize.Y + 20
    )
end)

-- 🔓 PUBLIC SCRIPT BUTTON
local function CreateScriptBtn(name, url)
    local btn = Instance.new("TextButton", ScriptScroll)
    btn.Size = UDim2.new(0, 280, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    btn.Text = name
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        loadstring(game:HttpGet(url))()
    end)
end

-- 🔒 LOCKED SCRIPT BUTTON (SIMPLE & WORKING)
local function CreateLockedScriptBtn(name, url)
    local btn = Instance.new("TextButton", ScriptScroll)
    btn.Size = UDim2.new(0, 280, 0, 45)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = "🔒 " .. name
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.fromRGB(200, 200, 200)
    btn.TextSize = 14
    Instance.new("UICorner", btn)

    btn.MouseButton1Click:Connect(function()
        if btn:FindFirstChild("PassBox") then return end

        local passBox = Instance.new("TextBox", btn)
        passBox.Name = "PassBox"
        passBox.Size = UDim2.fromScale(1, 1)
        passBox.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        passBox.TextColor3 = Color3.new(1,1,1)
        passBox.PlaceholderText = "ENTER PASSWORD & PRESS ENTER"
        passBox.ClearTextOnFocus = true
        passBox.Font = Enum.Font.GothamBold
        passBox.TextSize = 14
        passBox.Text = ""
        passBox.TextEditable = true
        passBox.Active = true
        Instance.new("UICorner", passBox)

        passBox:CaptureFocus()

        passBox.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.Return then
                if passBox.Text == SCRIPT_PASSWORD then
                    -- ✅ CORRECT PASSWORD
                    btn.Text = "HUB"
                    btn.BackgroundColor3 = Color3.fromRGB(40, 190, 80)
                    passBox:Destroy()

                    loadstring(game:HttpGet(url))()
                else
                    -- ❌ WRONG PASSWORD
                    passBox:Destroy()
                end
            end
        end)
    end)
end

-- 🔓 PUBLIC (EVERYONE)
CreateScriptBtn("INF YIELD", "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")
CreateScriptBtn("REDZ HUB", "https://raw.githubusercontent.com/REDZHUB/REDZHUB/main/REDZHUB")
CreateScriptBtn("ANIL EMOTE", "https://raw.githubusercontent.com/AN1L2/ANILGAZE/refs/heads/main/anil.emote")
CreateScriptBtn("MIKEY CHAT", "https://raw.githubusercontent.com/Gaurav-0196/Mickey-Chat/refs/heads/main/MickeyChat")
CreateScriptBtn("MIKEY MUSIC", "https://raw.githubusercontent.com/Gaurav-0196/Mickey-Aud/refs/heads/main/MickeyMusic")
CreateScriptBtn("AVATOR COPY", "https://raw.githubusercontent.com/Gaurav-0196/MickeyAvatar/refs/heads/main/MickeyAvatar")

-- 🔒 PRIVATE (PASSWORD REQUIRED)
CreateLockedScriptBtn(
    "PRIVATE TOOL 1",
    "https://github.com/contateste8/OaOaOaOa-EbEbEbEb/raw/refs/heads/main/ChachadoHubObf.txt"
)

CreateLockedScriptBtn(
    "PRIVATE TOOL 2",
    "https://raw.githubusercontent.com/AN1L2/anilbest/main/best.lua"
)



-- 🛡️ CREDITS CONTENT
local IconFrame = Instance.new("Frame", CreditsPage); IconFrame.Size = UDim2.fromOffset(100, 100); IconFrame.Position = UDim2.new(0.5, -50, 0.1, 0); IconFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20); Instance.new("UICorner", IconFrame).CornerRadius = UDim.new(1, 0)
local IconStroke = Instance.new("UIStroke", IconFrame); IconStroke.Color = Color3.fromRGB(0, 200, 255); IconStroke.Thickness = 3
local IconText = Instance.new("TextLabel", IconFrame); IconText.Size = UDim2.fromScale(1, 1); IconText.BackgroundTransparency = 1; IconText.Text = "⚔️"; IconText.TextSize = 40
local DevLabel = Instance.new("TextLabel", CreditsPage); DevLabel.Size = UDim2.new(1, 0, 0, 30); DevLabel.Position = UDim2.new(0, 0, 0.5, 0); DevLabel.Text = "Dev: ANIL"; DevLabel.Font = Enum.Font.GothamBold; DevLabel.TextColor3 = Color3.new(1, 1, 1); DevLabel.TextSize = 20; DevLabel.BackgroundTransparency = 1

-- 🔐 PASSWORD INFO
local PasswordInfoLabel = Instance.new("TextLabel", CreditsPage)
PasswordInfoLabel.Size = UDim2.new(1, 0, 0, 22)
PasswordInfoLabel.Position = UDim2.new(0, 0, 0.5, 22)
PasswordInfoLabel.BackgroundTransparency = 1
PasswordInfoLabel.Text = "For access to password-protected tools, please contact the creator: ANIL."
PasswordInfoLabel.Font = Enum.Font.Gotham
PasswordInfoLabel.TextSize = 13
PasswordInfoLabel.TextWrapped = true
PasswordInfoLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
PasswordInfoLabel.TextXAlignment = Enum.TextXAlignment.Center


-- 🔗 DISCORD LINK
local DiscordLabel = Instance.new("TextButton", CreditsPage)
DiscordLabel.Size = UDim2.new(1, 0, 0, 22)
DiscordLabel.Position = UDim2.new(0, 0, 0.5, 35)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Text = "Discord: discord.gg/wPETFMu9"
DiscordLabel.Font = Enum.Font.Gotham
DiscordLabel.TextSize = 13
DiscordLabel.TextColor3 = Color3.fromRGB(0, 200, 255)
DiscordLabel.TextWrapped = true
DiscordLabel.AutoButtonColor = false

DiscordLabel.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/wPETFMu9")
    DiscordLabel.Text = "Discord link copied!"
    task.wait(1)
    DiscordLabel.Text = "Discord: discord.gg/wPETFMu9"
end)

-- 👥 CREDITS NAMES (BOTTOM)
local NamesLabel = Instance.new("TextLabel", CreditsPage)
NamesLabel.Size = UDim2.new(1, 0, 0, 20)
NamesLabel.Position = UDim2.new(0, 0, 1, -30)
NamesLabel.BackgroundTransparency = 1
NamesLabel.Text = "ANIL, AYU, RUDY, SAI"
NamesLabel.Font = Enum.Font.Gotham
NamesLabel.TextSize = 13
NamesLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
NamesLabel.TextXAlignment = Enum.TextXAlignment.Center

 

-- 🌈 RGB CLOCK + DATE + UPTIME (UI)
local TimeFrame = Instance.new("Frame", CreditsPage)
TimeFrame.Size = UDim2.new(1, -20, 0, 60)
TimeFrame.Position = UDim2.new(0, 10, 0, 10)
TimeFrame.BackgroundTransparency = 1

local ClockLabel = Instance.new("TextLabel", TimeFrame)
ClockLabel.Size = UDim2.new(1, 0, 0, 22)
ClockLabel.BackgroundTransparency = 1
ClockLabel.Text = "TIME: --:--:--"
ClockLabel.Font = Enum.Font.GothamBold
ClockLabel.TextSize = 14
ClockLabel.TextXAlignment = Enum.TextXAlignment.Right
ClockLabel.TextColor3 = Color3.new(1,1,1)

local DateLabel = Instance.new("TextLabel", TimeFrame)
DateLabel.Size = UDim2.new(1, 0, 0, 18)
DateLabel.Position = UDim2.new(0, 0, 0, 22)
DateLabel.BackgroundTransparency = 1
DateLabel.Text = "DATE: --/--/----"
DateLabel.Font = Enum.Font.Gotham
DateLabel.TextSize = 12
DateLabel.TextXAlignment = Enum.TextXAlignment.Right
DateLabel.TextColor3 = Color3.fromRGB(200,200,200)

local UptimeLabel = Instance.new("TextLabel", TimeFrame)
UptimeLabel.Size = UDim2.new(1, 0, 0, 18)
UptimeLabel.Position = UDim2.new(0, 0, 0, 40)
UptimeLabel.BackgroundTransparency = 1
UptimeLabel.Text = "UPTIME: 00:00"
UptimeLabel.Font = Enum.Font.Gotham
UptimeLabel.TextSize = 12
UptimeLabel.TextXAlignment = Enum.TextXAlignment.Right
UptimeLabel.TextColor3 = Color3.fromRGB(150, 255, 150)







-- 🚀 FINAL CONNECTS
CopyBtn.MouseButton1Click:Connect(function() targetPlayer = Input.Text; setclipboard(getBypass()); CopyBtn.Text = "COPIED!"; task.wait(1); CopyBtn.Text = "TOOL 1: COPY NEXT" end)

AutoBtn.MouseButton1Click:Connect(function() 
    active = not active; targetPlayer = Input.Text
    AutoBtn.Text = active and "AUTO-BOT: RUNNING" or "TOOL 2: START AUTO-BOT"
    AutoBtn.BackgroundColor3 = active and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(40, 190, 80)
end)

task.spawn(function() while true do if active then pcall(runAutoStep) task.wait(waitTime) end task.wait(0.1) end end)

-- 🌈 RGB CLOCK + DATE + UPTIME LOGIC
local startTime = os.time()

task.spawn(function()
    while true do
        -- RGB effect
        local rgb = Color3.fromHSV((tick() % 5) / 5, 1, 1)
        ClockLabel.TextColor3 = rgb

        -- Live time
        local now = os.date("*t")
        ClockLabel.Text = string.format(
            "TIME: %02d:%02d:%02d",
            now.hour, now.min, now.sec
        )

        -- Date
        DateLabel.Text = string.format(
            "DATE: %02d/%02d/%04d",
            now.day, now.month, now.year
        )

        -- Uptime
        local elapsed = os.time() - startTime
        local minutes = math.floor(elapsed / 60)
        local seconds = elapsed % 60
        UptimeLabel.Text = string.format(
            "UPTIME: %02d:%02d",
            minutes, seconds
        )

        task.wait(1)
    end
end)





local function Drag(obj)
    local drag, start, startPos; obj.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = true start = i.Position startPos = obj.Position end end)
    UIS.InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.MouseMovement then local delta = i.Position - start; obj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y) end end)
    UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
end
Drag(Main); Drag(LogoBtn); LogoBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
