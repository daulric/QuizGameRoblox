local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local QuizQuestionComponent = react.Component:extend("QuizQuestionLabel")

function QuizQuestionComponent:init()
    self.text, self.updateText = react.createBinding("Question Area")
end

function QuizQuestionComponent:render()
    return react.createElement("TextLabel", {
        Name = "Question Label",
        Position = UDim2.fromScale(0.364, 0.15),
        Size = UDim2.fromScale(0.316,0.143),
        Text = self.text:map(function(value) return value end),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextScaled = true,
    }, {
        UIScaled = react.createElement("UIAspectRatioConstraint", {
            AspectRatio = 5,
        }),
    })
end


return QuizQuestionComponent