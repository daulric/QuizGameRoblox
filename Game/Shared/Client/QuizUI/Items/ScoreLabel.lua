local Players = game:GetService("Players")
local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local ScoreLabelComponent = react.Component:extend("Score Label")

function ScoreLabelComponent:init()
    self.Score, self.updateScore = react.createBinding(0)
end

function ScoreLabelComponent:didMount()
    local player = Players.LocalPlayer

    player:GetAttributeChangedSignal("Score"):Connect(function()
        self.updateScore(player:GetAttribute("Score"))
    end)

end

function ScoreLabelComponent:render()
    return react.createElement("TextLabel", {
        Name = "Score Label",
        Text = self.Score:map(function(value)
            return "Score: "..value
        end),

        Size = UDim2.fromScale(0.2, 0.065),
        Position = UDim2.fromScale(0.748, 0),
        Font = Enum.Font.Cartoon,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 1,
        TextScaled = true,

    }, {
        UIRatio = react.createElement("UIAspectRatioConstraint", {
            AspectRatio = 5,
        })
    })
end

return ScoreLabelComponent