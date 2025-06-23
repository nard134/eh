-- ✅ FINAL Moon Cat Freeze Script (Fixed for post-placement freezing)
-- Use: loadstring(game:HttpGet("https://raw.githubusercontent.com/nard134/eh/main/rider.lua", true))()

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Store frozen Moon Cats and their final positions
local frozen = {}

-- Check Moon Cats every frame
RunService.Heartbeat:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():match("moon") and not frozen[obj] then
            local primary = obj.PrimaryPart or obj:FindFirstChildWhichIsA("BasePart")
            if primary and obj:IsDescendantOf(Workspace) then
                -- Wait for placement to finish (small movement tolerance)
                task.spawn(function()
                    local lastPos = primary.Position
                    local stillTime = 0

                    while stillTime < 0.5 do
                        task.wait(0.1)
                        if (primary.Position - lastPos).Magnitude < 0.05 then
                            stillTime += 0.1
                        else
                            stillTime = 0
                            lastPos = primary.Position
                        end
                    end

                    local freezeCFrame = primary.CFrame
                    frozen[obj] = true

                    -- Freeze it in place
                    for _, part in ipairs(obj:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.Anchored = true
                            part.CFrame = freezeCFrame
                            part.Velocity = Vector3.zero
                            part.RotVelocity = Vector3.zero
                        elseif part:IsA("AlignPosition") or part:IsA("AlignOrientation") or part:IsA("BodyGyro") or part:IsA("Motor6D") or part:IsA("BodyVelocity") then
                            part:Destroy()
                        end
                    end

                    print("✅ Moon Cat frozen at final position: " .. tostring(freezeCFrame.Position))
                end)
            end
        end
    end
end)

print("🧊 Moon Cat FREEZE ACTIVE (fixed after-placement version)")
