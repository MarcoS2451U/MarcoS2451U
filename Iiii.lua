-- Criação da GUI
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui", playerGui)

local flyingButton = Instance.new("TextButton")
flyingButton.Size = UDim2.new(0, 200, 0, 50)
flyingButton.Position = UDim2.new(0.5, -100, 0.5, -25)
flyingButton.Text = "Começar a Voar"
flyingButton.Parent = screenGui

local flying = false

-- Função para voar
local function toggleFly()
    flying = not flying
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoid = character:WaitForChild("Humanoid")

    if flying then
        humanoid.PlatformStand = true
        while flying do
            character.HumanoidRootPart.Velocity = Vector3.new(0, 50, 0) -- Ajuste a velocidade de voo conforme necessário
            wait(0.1)
        end
        humanoid.PlatformStand = false
    end
end

-- Conectar o botão ao evento de clique
flyingButton.MouseButton1Click:Connect(toggleFly)
