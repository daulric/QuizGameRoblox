local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local OptionButtonComponent = react.Component:extend("Option Button")

function OptionButtonComponent:init()
    self.clickSound = react.createRef()
end

function OptionButtonComponent:didMount()
    self.sound = self.clickSound:getValue()
end

function OptionButtonComponent:render()

    return react.createElement("TextButton", {
        Name = "Option Button",
        Text = self.props.Text,
        RichText = true,
        TextScaled = true,
        BackgroundColor3 = Color3.fromRGB(46, 46, 46),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        Size = self.props.Size or UDim2.new(0.5, 0, 0.5, 0),
        Font = Enum.Font.Cartoon,
        [react.Event.MouseButton1Click] = function(element)
            self.sound:Play()
            self.props.mouseClicked(element)
        end,
    }, {

        Children = react.createFragment(self.props[react.Children]),

        UICorner = react.createElement("UICorner", {
            CornerRadius = UDim.new(0, 5),
        }),

        Sound = react.createElement("Sound", {
            SoundId = "rbxassetid://5393362166",
            [react.Ref] = self.clickSound,
        }),

        UIRatio = react.createElement("UIAspectRatioConstraint", {
            AspectRatio = 5,
            AspectType = Enum.AspectType.ScaleWithParentSize,
        })
    })
end

return OptionButtonComponent