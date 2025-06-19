-- MENU THIÊN – FULL FIX SẠCH – BY GPT CHO DELTA MOBILE

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")

local gui = Instance.new("ScreenGui")
gui.Name = "ThienMenuGUI"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = game:GetService("CoreGui")

-- Nút mở menu
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenButton"
openBtn.Size = UDim2.new(0, 50, 0, 50)
openBtn.Position = UDim2.new(0, 15, 0.5, -25)
openBtn.Text = "T"
openBtn.TextColor3 = Color3.new(0,0,0)
openBtn.BackgroundColor3 = Color3.new(1,1,1)
openBtn.TextScaled = true
openBtn.Draggable = true
openBtn.Parent = gui

-- Menu chính
local frame = Instance.new("Frame")
frame.Name = "MainMenu"
frame.Size = UDim2.new(0, 270, 0, 480)
frame.Position = UDim2.new(0.5, -135, 0.5, -240)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.Visible = false
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,40)
title.Text = "🔥 MENU THIÊN 🔥"
title.TextColor3 = Color3.fromRGB(255, 100, 0)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Parent = frame

openBtn.MouseButton1Click:Connect(function()
 frame.Visible = not frame.Visible
end)

-- Biến nhân vật
local char, hum, hrp
local toggles = {}

-- Tàng hình
local function applyInvisible(state)
 if not char then return end
 for _,v in pairs(char:GetDescendants()) do
  if v:IsA("BasePart") or v:IsA("MeshPart") then
   v.Transparency = state and 1 or 0
   v.CanCollide = not state
   v.CastShadow = not state
  elseif v:IsA("Decal") or v:IsA("Texture") then
   v.Transparency = state and 1 or 0
  elseif v:IsA("Accessory") then
   local h = v:FindFirstChild("Handle")
   if h then
    h.Transparency = state and 1 or 0
    local m = h:FindFirstChildWhichIsA("SpecialMesh")
    if m then m.Transparency = state and 1 or 0 end
   end
  end
 end
end

-- Cập nhật nhân vật
local function updateChar()
 char = player.Character or player.CharacterAdded:Wait()
 hum = char:WaitForChild("Humanoid")
 hrp = char:WaitForChild("HumanoidRootPart")

 -- Xóa các cục thừa dính trên người
 for _,v in pairs(char:GetDescendants()) do
  if (v:IsA("BodyMover") or v:IsA("Part") or v:IsA("Attachment")) and v.Name ~= "HumanoidRootPart" and v.Parent == hrp then
   v:Destroy()
  end
 end

 if toggles["Xuyên tường"] then
  for _,v in pairs(char:GetDescendants()) do
   if v:IsA("BasePart") then v.CanCollide = false end
  end
 else
  for _,v in pairs(char:GetDescendants()) do
   if v:IsA("BasePart") then v.CanCollide = true end
  end
 end
 applyInvisible(toggles["Tàng hình"] or false)
end
player.CharacterAdded:Connect(updateChar)
updateChar()

-- Tạo toggle
local function createToggle(name, y, callback)
 local b = Instance.new("TextButton")
 b.Size = UDim2.new(0.9, 0, 0, 30)
 b.Position = UDim2.new(0.05, 0, 0, y)
 b.BackgroundColor3 = Color3.fromRGB(60,60,60)
 b.TextColor3 = Color3.new(1,1,1)
 b.TextScaled = true
 b.Text = name.." [OFF]"
 local toggle = false
 toggles[name] = false
 b.MouseButton1Click:Connect(function()
  toggle = not toggle
  toggles[name] = toggle
  b.Text = name.." ["..(toggle and "ON" or "OFF").."]"
  callback(toggle)
 end)
 b.Parent = frame
end

-- Tạo ô nhập
local function makeInput(placeholder, posY, callback)
 local box = Instance.new("TextBox")
 box.Size = UDim2.new(0.9, 0, 0, 25)
 box.Position = UDim2.new(0.05, 0, 0, posY)
 box.PlaceholderText = placeholder
 box.Text = ""
 box.TextScaled = true
 box.ClearTextOnFocus = true
 box.Font = Enum.Font.Gotham
 box.TextColor3 = Color3.new(1,1,1)
 box.BackgroundTransparency = 1
 box.BorderSizePixel = 0
 box.FocusLost:Connect(function()
  local val = tonumber(box.Text)
  if val then callback(val) end
 end)
 box.Parent = frame
 return box
end

-- Fly
local flySpeed, flyBV = 100, nil
createToggle("Fly", 50, function(state)
 if state then
  flyBV = Instance.new("BodyVelocity")
  flyBV.Name = "ThienFly"
  flyBV.MaxForce = Vector3.new(1e9,1e9,1e9)
  flyBV.Velocity = Vector3.zero
  flyBV.Parent = hrp
 else
  if hrp:FindFirstChild("ThienFly") then
   hrp.ThienFly:Destroy()
  end
  flyBV = nil
 end
end)
makeInput("Fly Speed (VD: 100)", 85, function(val)
 flySpeed = val
end)

-- Speed
local runSpeed = 100
createToggle("Speed", 125, function(state)
 hum.WalkSpeed = state and runSpeed or 16
end)
makeInput("Speed chạy (VD: 100)", 160, function(val)
 runSpeed = val
 if toggles["Speed"] then hum.WalkSpeed = val end
end)

-- Tàng hình
createToggle("Tàng hình", 200, function(state)
 applyInvisible(state)
end)

-- Bất tử
local invincible = false
createToggle("Bất tử", 240, function(state)
 invincible = state
 if hum and state then hum.Health = hum.MaxHealth end
end)

-- Xuyên tường
local noclipConn
createToggle("Xuyên tường", 280, function(state)
 if state then
  noclipConn = RS.Stepped:Connect(function()
   for _,v in pairs(char:GetDescendants()) do
    if v:IsA("BasePart") then v.CanCollide = false end
   end
  end)
 else
  if noclipConn then noclipConn:Disconnect() noclipConn = nil end
  for _,v in pairs(char:GetDescendants()) do
   if v:IsA("BasePart") then v.CanCollide = true end
  end
 end
end)

-- Nhảy vĩnh viễn
local jumpConn
createToggle("Nhảy vĩnh viễn", 320, function(state)
 if state then
  jumpConn = UIS.JumpRequest:Connect(function()
   if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
  end)
 else
  if jumpConn then jumpConn:Disconnect() jumpConn = nil end
 end
end)

-- Giết tất cả
createToggle("Giết tất cả", 360, function(state)
 if state then
  for _,plr in pairs(game.Players:GetPlayers()) do
   if plr ~= player and plr.Character and plr.Character:FindFirstChild("Humanoid") then
    plr.Character.Humanoid.Health = 0
   end
  end
  for _,m in pairs(workspace:GetDescendants()) do
   if m:IsA("Model") and not game.Players:GetPlayerFromCharacter(m) then
    local h = m:FindFirstChild("Humanoid")
    if h then h.Health = 0 end
   end
  end
 end
end)

-- Luôn duy trì fly & bất tử
RS.Heartbeat:Connect(function()
 if invincible and hum and hum.Health < hum.MaxHealth then
  hum.Health = hum.MaxHealth
 end
 if toggles["Fly"] and flyBV and hrp then
  flyBV.Velocity = workspace.CurrentCamera.CFrame.LookVector * flySpeed
 end
end)
