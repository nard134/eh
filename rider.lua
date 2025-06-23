-- 🧊 Freeze specific Moon Cat (by Pet ID) at final placed location
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer

local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

local TARGET_ID = "14235123-ab50-494e-a086-6658979ef111"
local frozen = false

-- Watch for models that match
RunService.Heartbeat:Connect(function()
    if frozen then return end

    for _, model in ipairs(Workspace:GetDescendants()) do
        if model:IsA("Model") and not frozen then
            -- Check if this model has the matching Pet ID
            local petId = model:FindFirstChild("PetID") or model:FindFirstChild("UUID") or model:FindFirstChild("id")
            if petId and tostring(petId.Value) == TARGET_ID then
                -- Found your Moon Cat
                local primary = model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
                if primary then
                    -- Wait until it's done moving
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

                        -- Freeze at final location
                        local freezeCFrame = primary.CFrame
                        for _, part in ipairs(model:GetDescendants()) do
                            if part:IsA("BasePart") then
                                part.Anchored = true
                                part.CFrame = freezeCFrame
                                part.Velocity = Vector3.zero
                                part.RotVelocity = Vector3.zero
                            elseif part:IsA("AlignPosition") or part:IsA("AlignOrientation") or part:IsA("Motor6D") or part:IsA("BodyGyro") or part:IsA("BodyVelocity") then
                                part:Destroy()
                            end
                        end

                        print("✅ Moon Cat with ID frozen at final position.")
                        frozen = true
                    end)
                end
            end
        end
    end
end)

print("🧊 Waiting for Moon Cat with ID:", 14235123-ab50-494e-a086-6658979ef111)
