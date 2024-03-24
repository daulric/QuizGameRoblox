local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Exon = require(ReplicatedStorage.Packages.exon)

local OneFrame = Exon.oneframe
local Controllers = Exon.controllers
local RedNet = Exon.rednet

local QuizApi = Controllers.GetController("Quiz Api")

local QuizManager = OneFrame.Component.create("Quiz Manager")

function QuizManager:start()
    Players.PlayerAdded:Connect(function(player)
        QuizApi:Get(10, "easy", "multiple")

        task.wait(2)

        RedNet:FireClient(player, "QuizGetNow", QuizApi.Info.QuizInfo)
    end)

end


return QuizManager