local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react


local ScreenComponent = react.Component:extend("Quiz Screen Component")

function ScreenComponent:render()
    return react.createElement("Frame", {
        Name = "Quiz Frame",
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundColor3 = Color3.fromRGB(36, 36, 36),
    }, self.props[react.Children])
end


return ScreenComponent