local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local OneFrame = Exon.oneframe
local React = Exon.react

local QuizUIFolder = ReplicatedStorage:WaitForChild("Shared"):WaitForChild("QuizUI")

local Component = require(QuizUIFolder.Quiz)

local CompileQuiz = OneFrame.Component.create("Compile Quiz UI")


function CompileQuiz:start()

    local Element = React.createElement(Component)

    local player = Players.LocalPlayer or Players.PlayerAdded:Wait()

    player.CharacterAdded:Connect(function()
        React.mount(Element, player.PlayerGui)
    end)
end

return CompileQuiz