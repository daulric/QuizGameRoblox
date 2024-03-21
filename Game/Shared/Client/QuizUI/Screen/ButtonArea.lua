local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local ButtonArea = react.Component:extend("Button Area")

function ButtonArea:render()
    return react.createElement("Frame", {
        Name = "Button Area",
        Size = UDim2.new(0.3, 0, 0.4, 0),
    })
end


return ButtonArea