local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages.exon)

local react = exon.react
local rednet = exon.rednet

local OptionButton = require(script.Parent.Parent:WaitForChild("Buttons").OptionButton)

local SelectionMenu = react.Component:extend("Selection Menu")

function SelectionMenu:init()
    self.text, self.updateText = react.createBinding("")
end

function SelectionMenu:didMount()
    rednet.listen("GetQuizOptions", function(options)

        local TempButtons = {}

        for i, v in pairs(options) do
            local element = react.createElement(OptionButton, {
                Text = v.category,
                mouseClicked = function(element)
                    self.updateText(element.Text)
                end,
            })

            table.insert(TempButtons, element)
        end

        self:setState({
            Buttons = TempButtons,
        })

    end)
end

function SelectionMenu:render()
    return react.createElement("Frame", {
        Name = "Selection Menu",
        Size = UDim2.fromScale(0.3, 0.7),
        Position = UDim2.fromScale(0.4, 0.5),
        BackgroundColor3 = Color3.fromRGB(43, 43, 43),
    }, {

        TextLabel = react.createElement("TextLabel", {
            Name = "SelectionText",
            Text = self.text:map(function(value) 
                rednet:FireServer("QuizTopicSelected", value)
                return value
            end),

            Size = UDim2.fromScale(0.5, 0.3),
            Font = Enum.Font.Cartoon,
            TextScaled = true,
        }, {
            UIRatio = react.createElement("UIAspectRatioConstraint", {
                AspectRatio = 5,
            })
        }),

        Buttons = react.createFragment(self.state.Buttons),
    })
end

return SelectionMenu