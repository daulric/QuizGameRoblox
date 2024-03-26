local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local OptionButtonComponent = react.Component:extend("Option Button")

function OptionButtonComponent:init()
    --self.text, self.updateText = react.createBinding("")
end

function OptionButtonComponent:render()

    return react.createElement("TextButton", {
        Name = "Option Button",
        Text = self.props.Text,
        RichText = true,
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(46, 46, 46),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = UDim2.new(0.5, 0, 0.5, 0),
        Font = Enum.Font.Cartoon,
        [react.Event.MouseButton1Click] = self.props.mouseClicked,
    }, {
        UICorner = react.createElement("UICorner", {
            CornerRadius = UDim.new(0, 5),
        }),

        UIRatio = react.createElement("UIAspectRatioConstraint", {
            AspectRatio = 5,
            AspectType = Enum.AspectType.ScaleWithParentSize,
        })
    })
end


return OptionButtonComponent