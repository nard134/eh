-- ✅ Moon Cat Freeze Script (Dynamic & Optimized)
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Stores frozen moon cats with updated positions
local frozen = {}

RunService.Heartbeat:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("moon cat") then
            local primary = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
            if primary and obj:IsDescendantOf(Workspace) then
                -- Freeze only once per Moon Cat
                if not frozen[obj] then
                    frozen[obj] = primary.CFrame
                    print("❄️ Freezing Moon Cat at:", tostring(primary.Position))
                end

                -- Reapply freeze every frame
                for _, p in ipairs(obj:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Anchored = true
                        p.CFrame = frozen[obj]
                        p.Velocity = Vector3.zero
                        p.RotVelocity = Vector3.zero
                    elseif p:IsA("AlignPosition") or p:IsA("BodyGyro") or p:IsA("BodyVelocity") or p:IsA("Motor6D") then
                        p:Destroy()
                    end
                end
            end
        end
    end
end)

print("✅ Moon Cat Freeze ACTIVE — All placed Moon Cats will stay frozen.")
