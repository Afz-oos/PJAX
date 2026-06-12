-- รอจนกว่าตัวเกมจะโหลดระบบแจ้งเตือนเสร็จ ป้องกันอาการแจ้งเตือนไม่ขึ้น
repeat task.wait() until game:IsLoaded() and pcall(function() return game:GetService("StarterGui") end)

-- แปลง Place ID ปัจจุบันให้กลายเป็น "ข้อความ" เพื่อป้องกันบั๊กเปรียบเทียบตัวเลข
local currentPlaceId = tostring(game.PlaceId)
local StarterGui = game:GetService("StarterGui")

local function sendNotification(title, text, iconId)
    StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Icon = iconId or "rbxassetid://6015190132";
        Duration = 5;
    })
end

--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- ตั้งค่าข้อมูล (เปลี่ยนเลขครอบด้วยเครื่องหมายคำพูด เพื่อความเสถียรสูงสุด)
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
local scriptConfig = {
    ["3351674303"] = {
        Url = "https://raw.githubusercontent.com/Afz-oos/SC/refs/heads/main/DE%20KAITUN.lua",
        Name = "Driving Empire",
        Icon = "rbxassetid://6015190132" -- ใส่ ID ไอคอนของน้องได้เลย
    },
    ["2233445566"] = {
        Url = "https://raw.githubusercontent.com/USER/REPO/main/map2_script.lua",
        Name = "สคริปต์แมพที่ 2",
        Icon = "rbxassetid://87654321"
    }
}

--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
-- ระบบเช็คและรันอัตโนมัติ
--- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
local currentConfig = scriptConfig[currentPlaceId]

if currentConfig then
    -- แจ้งเตือนกำลังโหลด
    sendNotification("Script Loader", "กำลังโหลด: " .. currentConfig.Name, currentConfig.Icon)
    
    -- ทำการโหลดสคริปต์หลักมาทำงาน
    local success, err = pcall(function()
        loadstring(game:HttpGet(currentConfig.Url))()
    end)
    
    if success then
        sendNotification("สำเร็จ!", currentConfig.Name .. " รันเรียบร้อยแล้ว", currentConfig.Icon)
    else
        sendNotification("เกิดข้อผิดพลาด", "สคริปต์หลักมีปัญหา กรุณาเช็คโค้ดด้านใน", "rbxassetid://11401835376")
    end
else
    -- ถ้ายังไม่เจออีก ระบบจะบอกเลยว่ามันเห็นค่าเป็นอะไร
    sendNotification("ไม่รองรับแมพนี้", "ตรวจพบ ID: " .. currentPlaceId, "rbxassetid://11401835376")
end
