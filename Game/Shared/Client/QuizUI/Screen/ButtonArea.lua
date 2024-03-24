local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local ButtonArea = react.Component:extend("Button Area")

function ButtonArea:render()
    return react.createElement("Frame", {
        Name = "Button Area",
        Size = UDim2.fromScale(0.5, 0.5),
        Position = UDim2.fromScale(0.3, 0.4),
    }, self.props[react.Children],  {

        UICorner = react.createElement("UICorner", {
            CornerRadius = UDim.new(0, 4),
        }),

        UIGridLayout = react.createElement("UIGridLayout", {
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            CellPadding = UDim2.fromOffset(5, 5),
            CellSize = UDim2.fromOffset(200, 50),
        })
    })
end

return ButtonArea