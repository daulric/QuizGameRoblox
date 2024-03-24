local Players = game:GetService("Players")

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(char)
        char.HumanoidRootPart.Anchored = true
    end)
end)