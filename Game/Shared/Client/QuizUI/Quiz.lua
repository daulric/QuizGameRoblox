local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local QuizComponent = react.Component:extend("QuizUI")

-- Components
local ScreenFolder = script.Parent:WaitForChild("Screen")
local ItemsFolder = script.Parent:WaitForChild("Items")

local QuizScreen = require(ScreenFolder.Screen)
local Label = require(ScreenFolder.Label)
local QuestionLabel = require(ItemsFolder.QuestionLabel)
local ButtonArea = require(ScreenFolder.ButtonArea)

function QuizComponent:init()
    self:setState({
        Buttons = {}, -- Can Hold Up to 4 Buttons!
    })
end

function QuizComponent:render()
    return react.createElement("ScreenGui", {
        Name = "Quiz Panel",
        IgnoreGuiInset = true,
    }, self.props[react.Children], {
        ScreenElement = react.createElement(QuizScreen, {}, {
            Label = react.createElement(Label),
            QuestionLabel = react.createElement(QuestionLabel),
            ButtonArea = react.createElement(ButtonArea, {}),
        })
    })
end

return QuizComponent