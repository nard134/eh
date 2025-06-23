-- Freeze All Pets in Workspace 🐾❄️
for _, pet in pairs(workspace:GetDescendants()) do
    if pet:IsA("Model") and pet:FindFirstChild("HumanoidRootPart") then
        local name = tostring(pet.Name):lower()
        if name:find("pet") or name:find("companion") then
            local root = pet.HumanoidRootPart
            root.Anchored = true
            for _, part in ipairs(pet:GetDescendants()) do
                if part:IsA("BodyVelocity") or part:IsA("AlignPosition") or part:IsA("BodyGyro") then
                    part:Destroy()
                end
            end
        end
    end
end

print("[✔] All pets have been frozen.")
