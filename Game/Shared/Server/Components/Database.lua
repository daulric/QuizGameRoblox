local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages.exon)

local OneFrame = exon.oneframe
local db = exon.db
local rednet = exon.rednet
local util = exon.util

local DatabaseComponent = OneFrame.Component.create("Database Manager")

function DatabaseComponent:preload()
    self.profiles = {}
end

function DatabaseComponent:playerAdded(player: Player)
    local profile = db.LoadProfile("Player Database", player.UserId, {
        Score = 0,
    })

    profile:Reconcile()

    profile.saving:Connect(function()
        print("Saving Data")
    end)

    self.profiles[player.UserId] = profile

    for i, v in pairs(profile.data) do
        player:SetAttribute(i, v)

        player:GetAttributeChangedSignal(i):Connect(function()
            profile.data[i] = player:GetAttribute(i)
            task.wait()
            profile:Save()
        end)
    end

end

function DatabaseComponent:playerRemoved(player: Player)
    local profile = self.profiles[player.UserId]
    profile:Save()
    profile:Close()
end

function DatabaseComponent:start()

    for _, v in pairs(Players:GetPlayers()) do
        self:playerAdded(v)
    end

    Players.PlayerAdded:Connect(function(player)
        self:playerAdded(player)
    end)

    rednet.listen("score_update", function(player, increment)
        local profile = self.profiles[player.UserId]
        local currentScore = player:GetAttribute("Score")

        if increment == true then
            currentScore += 10
        else
            if profile.data.Score > 0 then
                currentScore -= 10
            end
        end

        player:SetAttribute("Score", currentScore)
    end)

end

function DatabaseComponent:closing()
    util.iterate(Players:GetPlayers(), function(_, player: Player)
        self:playerRemoved(player)
    end)
end

return DatabaseComponent