local Lighting = game:GetService("Lighting")

-- Remover névoa
Lighting.FogEnd = 1000000
Lighting.FogStart = 1000000

-- Remover texturas
local function removeTextures(obj)
    if obj:IsA("BasePart") then
        for _, decal in pairs(obj:GetDescendants()) do
            if decal:IsA("Texture") or decal:IsA("Decal") then
                decal:Destroy()
            end
        end
    end
end

local function traverseWorkspace(obj)
    removeTextures(obj)
    for _, child in pairs(obj:GetChildren()) do
        traverseWorkspace(child)
    end
end

traverseWorkspace(workspace)
workspace.DescendantAdded:Connect(removeTextures)
