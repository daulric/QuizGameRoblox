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
    self.categoryNum = 18

    self.mode = {
        [1] = "easy",
        [2] = "medium",
        [3] = "hard",
    }

    self.count = 0
end

function QuizManager:GetQuiz(player: Player, category)

    self.count += 1

    if self.count > #self.mode then
        self.count = 1
    end

    task.wait(1)
    QuizApi:Get(20, self.mode[self.count], "multiple", category)
    task.wait()
    RedNet:FireClient(player, "QuizGetNow", QuizApi.Info.QuizInfo)
end

function QuizManager:playerAdded(player: Player)
    print("player added")
    if self.isAdded[player.UserId] == nil then
        repeat
            task.wait()
        until player.CharacterAdded:Wait()
        print("sending quiz options in a sec....")
        task.wait(2)
        RedNet:FireClient(player,"GetQuizOptions", QuizApi:GetCategories())
        self.isAdded[player.UserId] = true
    end
end

function QuizManager:playerRemoved(player)
    self.isAdded[player.UserId] = nil
end

function QuizManager:start()

    for _, v in pairs(Players:GetPlayers()) do
        self:playerAdded(v)
    end

    RedNet.listen("resend_quiz", function(player)
        self:GetQuiz(player, self.categoryNum)
    end)

    RedNet.listen("QuizTopicSelected", function(player, topic)
        print("Selected:", topic)
        local topicIdFound = QuizApi:GetCategory(topic)
        self.categoryNum = topicIdFound
        self:GetQuiz(player, topicIdFound)
    end)

    Players.PlayerAdded:Connect(function(player)
        self:playerAdded(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        self:playerRemoved(player)
    end)

end


return QuizManager