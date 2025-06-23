-- ✅ Moon Cat Freeze AFTER Placement — stays exactly where dropped
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local frozenCats = {}

local function freezeMoonCat(catModel)
    local primary = catModel.PrimaryPart or catModel:FindFirstChild("HumanoidRootPart") or catModel:FindFirstChildWhichIsA("BasePart")
    if not primary then return end

    -- Wait for it to stop moving (placed and settled)
    task.spawn(function()
        local lastPosition = primary.Position
        local stillTime = 0
        while stillTime < 0.5 do
            wait(0.1)
            local current = primary.Position
            if (current - lastPosition).magnitude < 0.05 then
                stillTime += 0.1
            else
                stillTime = 0
                lastPosition = current
            end
        end

        -- Freeze in-place once settled
        for _, part in ipairs(catModel:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = true
                part.Velocity = Vector3.zero
                part.RotVelocity = Vector3.zero
            elseif part:IsA("AlignPosition") or part:IsA("AlignOrientation") or part:IsA("BodyGyro") or part:IsA("Motor6D") or part:IsA("BodyVelocity") then
                part:Destroy()
            end
        end

        print("✅ Moon Cat frozen at placed spot: " .. tostring(primary.Position))
    end)
end

-- Watch for Moon Cats being added or not yet frozen
RunService.Heartbeat:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("moon cat") and not frozenCats[obj] then
            frozenCats[obj] = true
            freezeMoonCat(obj)
        end
    end
end)

print("🧊 Moon Cat freeze script running — will lock each after it's placed.")
