-- Criação da GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)

local missionButton = Instance.new("TextButton")
missionButton.Size = UDim2.new(0, 200, 0, 50)
missionButton.Position = UDim2.new(0.5, -100, 0.5, -25)
missionButton.Text = "Pegar e Completar Missão"
missionButton.Parent = screenGui

local flying = false

-- Função para encontrar e atacar NPCs da missão
local function completeMission()
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")
    local playerLevel = player:WaitForChild("Data"):WaitForChild("Level").Value -- Ajuste conforme a estrutura de dados do jogador
    local missionNPCs = {} -- Lista de NPCs da missão

    -- Encontrar NPCs da missão com base no nível do jogador
    for _, npc in ipairs(workspace:GetChildren()) do
        if npc:IsA("Model") and npc:FindFirstChild("Humanoid") then
            -- Aqui você deve implementar a lógica para verificar se o NPC pertence à missão do nível do jogador
            -- Exemplo fictício: se o nível do NPC for igual ao do jogador
            if npc:FindFirstChild("Level") and npc.Level.Value == playerLevel then
                table.insert(missionNPCs, npc)
            end
        end
    end

    if #missionNPCs == 0 then
        print("Nenhum NPC da missão encontrado!")
        return
    end

    flying = true
    humanoid.PlatformStand = true

    -- Voar e atacar os NPCs
    for _, npc in ipairs(missionNPCs) do
        character.HumanoidRootPart.CFrame = npc.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0) -- Voar para cima do NPC
        wait(1) -- Espera um momento para chegar

        -- Atacar o NPC
        if npc:FindFirstChild("Humanoid") then
            while npc.Humanoid.Health > 0 and flying do
                character.Humanoid:MoveTo(npc.HumanoidRootPart.Position) -- Move-se para o NPC
                wait(0.5) -- Aguarda um pouco antes de atacar
                -- Aqui você deve implementar a lógica de ataque
                npc.Humanoid:TakeDamage(10) -- Exemplo de dano
            end
        end
    end

    flying = false
    humanoid.PlatformStand = false
end

-- Conectar o botão ao evento de clique
missionButton.MouseButton1Click:Connect(completeMission
