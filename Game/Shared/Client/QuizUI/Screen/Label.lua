local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react


local ScreenComponent = react.Component:extend("Quiz Screen Component")

function ScreenComponent:render()
    return react.createElement("TextLabel", {
        Name = "Quiz Name",
        Text = "Quiz",
        Size = UDim2.new(0.1, 0, 0.1, 0),
        Position = UDim2.fromScale(0.5, 0),
        BackgroundTransparency = 1,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Font = Enum.Font.Cartoon,
        TextScaled = true,
    }, {
        UIScaled = react.createElement("UIAspectRatioConstraint", {}),
    })
end


return ScreenComponent