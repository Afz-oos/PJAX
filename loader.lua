local currentPlaceId = game.PlaceId
local StarterGui = game:GetService("StarterGui")

-- ฟังก์ชันสำหรับส่งการแจ้งเตือนไปที่ขอบจอ
local function sendNotification(title, text, iconId)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Icon = iconId or "rbxassetid://6015190132"; -- ไอคอนเริ่มต้น (ถ้าไม่ได้ใส่จะใช้รูปเฟือง/โล่)
        Duration = 5; -- แสดงค้างไว้ 5 วินาที
    })
end

--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- 1. ตั้งค่าข้อมูล: [Place ID] = { ลิงก์สคริปต์, ชื่อแมพ/ชื่อสคริปต์, ID รูปภาพ }
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
local scriptConfig = {
    [3351674303] = {
        Url = "https://raw.githubusercontent.com/Afz-oos/SC/refs/heads/main/DE%20KAITUN.lua",
        Name = "Driving Empire",
        Icon = "rbxassetid://12345678" -- ใส่ Asset ID รูปภาพของแมพนี้ (ต้องเป็นตัวเลข)
    },
    [2233445566] = {
        Url = "https://raw.githubusercontent.com/USER/REPO/main/map2_script.lua",
        Name = "สคริปต์แมพที่ 2",
        Icon = "rbxassetid://87654321"
    },
    [3344556677] = {
        Url = "https://raw.githubusercontent.com/USER/REPO/main/map3_script.lua",
        Name = "สคริปต์แมพที่ 3",
        Icon = "rbxassetid://13579246"
    }
}

--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- 2. ระบบเช็คและรันอัตโนมัติ
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
local currentConfig = scriptConfig[currentPlaceId]

if currentConfig then
    -- แจ้งเตือนกำลังโหลด
    sendNotification("Script Loader", "กำลังโหลด: " .. currentConfig.Name, currentConfig.Icon)
    
    local success, err = pcall(function()
        loadstring(game:HttpGet(currentConfig.Url))()
    end)
    
    if success then
        -- แจ้งเตือนโหลดสำเร็จ
        sendNotification("สำเร็จ!", currentConfig.Name .. " รันเรียบร้อยแล้ว", currentConfig.Icon)
    else
        -- แจ้งเตือนเมื่อสคริปต์ฝั่งนู้นมี Bug
        sendNotification("เกิดข้อผิดพลาด", "สคริปต์มีปัญหา กรุณาเช็คโค้ด", "rbxassetid://11401835376")
    end
else
    -- แจ้งเตือนกรณีไม่รองรับแมพนี้ (ใช้ไอคอนกากบาทสีแดง)
    sendNotification("ไม่รองรับแมพนี้", "ไม่พบสคริปต์สำหรับ Place ID นี้", "rbxassetid://11401835376")
end
