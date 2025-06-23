-- ✅ FINAL Moon Cat Freeze Script (Hosted as rider.lua)
-- Use: loadstring(game:HttpGet("https://raw.githubusercontent.com/nard134/eh/main/rider.lua", true))()

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Function to find all Moon Cats in the game
local function getMoonCats()
    local found = {}
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("moon cat") then
            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if primary then
                table.insert(found, {Model = obj, Part = primary})
            end
        end
    end
    return found
end

-- Refreeze all Moon Cats every frame
RunService.Heartbeat:Connect(function()
    local moonCats = getMoonCats()
    for _, data in ipairs(moonCats) do
        local model = data.Model
        local part = data.Part
        if model and part and part:IsDescendantOf(Workspace) then
            local freezeCFrame = part.CFrame
            for _, p in ipairs(model:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.Anchored = true
                    p.CFrame = freezeCFrame
                    p.Velocity = Vector3.zero
                    p.RotVelocity = Vector3.zero
                end
            end
        end
    end
end)

print("✅ Moon Cat FREEZE ACTIVE")
