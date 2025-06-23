-- 🔐 Freeze ONLY your Moon Cats at specific garden positions
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

-- 📌 Positions to freeze Moon Cats at (customize these!)
local targetSpots = {
    Vector3.new(25, 3, 15),
    Vector3.new(28, 3, 15),
    Vector3.new(31, 3, 15)
}

local frozenCount = 0
local frozenCats = {}

local function freezeAtSpot(catModel, freezePosition)
    local primary = catModel.PrimaryPart or catModel:FindFirstChild("HumanoidRootPart") or catModel:FindFirstChildWhichIsA("BasePart")
    if not primary then return end

    -- Move & freeze at target location
    catModel:SetPrimaryPartCFrame(CFrame.new(freezePosition))
    for _, part in ipairs(catModel:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
            part.Velocity = Vector3.zero
            part.RotVelocity = Vector3.zero
        elseif part:IsA("AlignPosition") or part:IsA("AlignOrientation") or part:IsA("BodyGyro") or part:IsA("Motor6D") or part:IsA("BodyVelocity") then
            part:Destroy()
        end
    end

    print("✅ Your Moon Cat frozen at:", tostring(freezePosition))
end

RunService.Heartbeat:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("moon cat") and not frozenCats[obj] then
            -- Check if this Moon Cat belongs to you
            local creator = obj:FindFirstChild("creator") or obj:FindFirstChild("Owner") or obj:FindFirstChild("owner")
            if creator and tostring(creator.Value) == LocalPlayer.Name then
                frozenCats[obj] = true
                frozenCount += 1

                local freezePosition = targetSpots[frozenCount] or targetSpots[#targetSpots]
                freezeAtSpot(obj, freezePosition)
            end
        end
    end
end)

print("🧊 Moon Cat freezer ON — only yours will freeze at specific garden spots.")
