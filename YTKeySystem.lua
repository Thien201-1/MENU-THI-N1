-- MENU THIÊN - BẢO VỆ BẰNG KEY
local key = "THIEN123"
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "ThienKeyGui"

local box = Instance.new("TextBox", gui)
box.Size = UDim2.new(0, 250, 0, 50)
box.Position = UDim2.new(0.5, -125, 0.5, -60)
box.PlaceholderText = "Nhập key để mở menu"
box.Text = ""
box.TextScaled = true
box.BackgroundColor3 = Color3.fromRGB(30,30,30)
box.TextColor3 = Color3.new(1,1,1)

local msg = Instance.new("TextLabel", gui)
msg.Size = UDim2.new(0, 250, 0, 30)
msg.Position = UDim2.new(0.5, -125, 0.5, 0)
msg.Text = ""
msg.TextScaled = true
msg.BackgroundTransparency = 1
msg.TextColor3 = Color3.fromRGB(255, 80, 80)

local btn = Instance.new("TextButton", gui)
btn.Size = UDim2.new(0, 200, 0, 40)
btn.Position = UDim2.new(0.5, -100, 0.5, 40)
btn.Text = "🔗 Đến kênh YouTube"
btn.TextScaled = true
btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
btn.TextColor3 = Color3.new(1,1,1)
btn.MouseButton1Click:Connect(function()
    setclipboard("https://youtube.com/@thienfootball201?si=V3YclL9uIR1PNm7L")
    msg.Text = "✅ Link kênh đã copy! Lên TRANG CHỦ tìm key rồi dán vào nha!"
end)

box.FocusLost:Connect(function()
    if box.Text == key then
        msg.Text = "✅ Đúng key! Đang mở menu..."
        wait(1)
        gui:Destroy()
        -- Load menu chính
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Thien201-1/MENU-THI-N1/main/ThienMenu.lua"))()
    else
        msg.Text = "❌ Sai key! Lên TRANG CHỦ kênh YouTube của Thiên để lấy key."
    end
end)
