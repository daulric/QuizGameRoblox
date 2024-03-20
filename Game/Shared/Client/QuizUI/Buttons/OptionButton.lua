local exon = require(game.ReplicatedStorage.Packages.exon)

local react = exon.react

local OptionButtonComponent = react.Component:extend("Option Button")

function OptionButtonComponent:init()
    self.text, self.updateText = react.createBinding("")
end

function OptionButtonComponent:render()
    return react.createElement("TextButton", {
        Name = "Option Button",
        Text = self.text:map(function(value) return value end),

        [react.Event.MouseButton1Click] = self.props.mouseClicked,

    })
end


return OptionButtonComponent