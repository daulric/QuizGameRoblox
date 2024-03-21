local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react


local ScreenComponent = react.Component:extend("Quiz Screen Component")

function ScreenComponent:render()
    return react.createElement("TextLabel", {
        Name = "Quiz Name",
        Text = "Quiz",
        Size = UDim2.new(0.1, 0, 0.5, 0),
    })
end


return ScreenComponent