-- FINAL Moon Cat Freeze Script (Freeze Even After Placement)
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

-- Find all Moon Cats and freeze them in place
RunService.Heartbeat:Connect(function()
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj.Name:lower():find("moon cat") then
            local primary = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
            if primary and obj:IsDescendantOf(Workspace) then
                local freezeCFrame = primary.CFrame

                -- Reapply freeze every frame
                for _, part in ipairs(obj:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Anchored = true
                        part.CFrame = freezeCFrame
                        part.Velocity = Vector3.zero
                        part.RotVelocity = Vector3.zero
                    elseif part:IsA("AlignPosition") or part:IsA("BodyGyro") or part:IsA("BodyVelocity") or part:IsA("Motor6D") then
                        part:Destroy() -- remove any movers
                    end
                end
            end
        end
    end
end)

print("✅ Moon Cats are now frozen in place — even after planting.")
