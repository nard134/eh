local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer

-- GUI
local gui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
gui.Name = "RemoteSpyGui"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0, 50, 0, 50)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local closeButton = Instance.new("TextButton", frame)
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.Text = "X"
closeButton.BackgroundColor3 = Color3.fromRGB(40, 0, 0)
closeButton.TextColor3 = Color3.new(1, 1, 1)
closeButton.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

local logBox = Instance.new("TextLabel", frame)
logBox.Size = UDim2.new(1, -10, 1, -40)
logBox.Position = UDim2.new(0, 5, 0, 35)
logBox.BackgroundTransparency = 1
logBox.TextColor3 = Color3.fromRGB(0, 255, 0)
logBox.Font = Enum.Font.Code
logBox.TextSize = 14
logBox.TextXAlignment = Enum.TextXAlignment.Left
logBox.TextYAlignment = Enum.TextYAlignment.Top
logBox.TextWrapped = true
logBox.TextScaled = false
logBox.Text = "🛰️ Hooking RemoteEvents...\n"

local function log(str)
    if #logBox.Text > 10000 then
        logBox.Text = "🛰️ Log cleared due to length\n"
    end
    logBox.Text = logBox.Text .. str .. "\n"
end

-- Hook RemoteEvents & Functions
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
        if not v:FindFirstChild("AlreadyHooked") then
            local tag = Instance.new("BoolValue")
            tag.Name = "AlreadyHooked"
            tag.Parent = v

            local name = v:GetFullName()
            log("✅ Hooked: " .. name)

            if v:IsA("RemoteEvent") then
                local oldFire = v.FireServer
                v.FireServer = function(self, ...)
                    local args = {...}
                    log("📤 Event: " .. name)
                    for i, arg in ipairs(args) do
                        log("  [" .. i .. "]: " .. tostring(arg))
                    end
                    return oldFire(self, unpack(args))
                end
            elseif v:IsA("RemoteFunction") then
                local oldInvoke = v.InvokeServer
                v.InvokeServer = function(self, ...)
                    local args = {...}
                    log("📤 Function: " .. name)
                    for i, arg in ipairs(args) do
                        log("  [" .. i .. "]: " .. tostring(arg))
                    end
                    return oldInvoke(self, unpack(args))
                end
            end
        end
    end
end

log("✅ All available Remotes hooked.\n👉 Now: Hatch pets, give them, or equip them. Watch for logs.")
