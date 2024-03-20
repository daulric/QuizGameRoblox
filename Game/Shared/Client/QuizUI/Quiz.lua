local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local QuizComponent = react.Component:extend("QuizUI")

function QuizComponent:render()
    return react.createElement("ScreenGui", {
        Name = "Quiz Panel",
    }, self.props[react.Children])
end

return QuizComponent