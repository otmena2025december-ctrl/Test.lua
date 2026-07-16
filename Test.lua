```lua
-- Touch Fling Script | On/Off Toggle
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local HRP = Char:WaitForChild("HumanoidRootPart")

local enabled = false
local flingPower = 500

-- GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = Player.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 150, 0, 50)
frame.Position = UDim2.new(0.5, -75, 0.5, -25)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.BackgroundTransparency = 0.3
frame.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(1, 0, 1, 0)
button.Text = "FLING: OFF"
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
button.Parent = frame

button.MouseButton1Click:Connect(function()
    enabled = not enabled
    button.Text = enabled and "FLING: ON" or "FLING: OFF"
    button.BackgroundColor3 = enabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
end)

-- Touch fling
local function onTouch(part)
    if not enabled then return end
    local character = part.Parent
    if not character or character == Char then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local dir = (hrp.Position - HRP.Position).Unit
        hrp.Velocity = dir * flingPower + Vector3.new(0, 20, 0)
    end
end

HRP.Touched:Connect(onTouch)

-- Cleanup
Player.CharacterAdded:Connect(function(newChar)
    Char = newChar
    HRP = newChar:WaitForChild("HumanoidRootPart")
    HRP.Touched:Connect(onTouch)
end)
```
