local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Exon = require(ReplicatedStorage.Packages.exon)

local OneFrame = Exon.oneframe
local Controllers = Exon.controllers
local RedNet = Exon.rednet

local QuizApi = Controllers.GetController("Quiz Api")

local QuizManager = OneFrame.Component.create("Quiz Manager")

function QuizManager:preload()
    self.isAdded = {}
end

function QuizManager:playerAdded(player)
    print("player added")
    if self.isAdded[player.UserId] == nil then
        self.isAdded[player.UserId] = true
        QuizApi:Get(10, "easy", "multiple")

        task.wait(2)
        RedNet:FireClient(player, "QuizGetNow", QuizApi.Info.QuizInfo)
        print("sent the data")
    end
end

function QuizManager:start()

    for i, v in pairs(Players:GetPlayers()) do
        self:playerAdded(v)
    end

    Players.PlayerAdded:Connect(function(player)
        self:playerAdded(player)
    end)

end


return QuizManager