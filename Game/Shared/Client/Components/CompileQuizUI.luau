local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local OneFrame = Exon.oneframe
local React = Exon.react
local Component = require(ReplicatedStorage:WaitForChild("Shared"):WaitForChild("QuizUI").Quiz)

local CompileQuiz = OneFrame.Component.create("Compile Quiz UI")

function CompileQuiz:start()

    local Element = React.createElement(Component, {}, {

    })

    React.mount(Element, Players.LocalPlayer.PlayerGui)
end

return CompileQuiz