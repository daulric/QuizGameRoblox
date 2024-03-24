local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local QuizComponent = react.Component:extend("QuizUI")

-- Components
local ScreenFolder = script.Parent:WaitForChild("Screen")

local QuizScreen = require(ScreenFolder.Screen)
local Label = require(ScreenFolder.Label)

local QAHandler = require(script.Parent:WaitForChild("QAHandler"))

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
            QA = react.createElement(QAHandler),
        })
    })
end

return QuizComponent