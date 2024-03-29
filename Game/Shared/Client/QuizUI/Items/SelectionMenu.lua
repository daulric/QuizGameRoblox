local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages.exon)

local react = exon.react
local rednet = exon.rednet

local OptionButton = require(script.Parent.Parent:WaitForChild("Buttons").OptionButton)

local SelectionMenu = react.Component:extend("Selection Menu")

function SelectionMenu:init()
    self.text, self.updateText = react.createBinding("")

    self:setState({
        Buttons = {},
    })
end

function SelectionMenu:AutoScale(element: ScrollingFrame)
    repeat
        task.wait()
    until (self.listLayout ~= nil)

    local listLayout: UIListLayout = self.listLayout

    element.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y)
end

function SelectionMenu:didMount()
    rednet.listen("GetQuizOptions", function(options)

        local TempButtons = {}

        for _, v in pairs(options) do
            local element = react.createElement(OptionButton, {
                Text = v,
                Size = UDim2.fromScale(0.9, 0.4),
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
        Size = UDim2.fromScale(0.2, 0.7),
        Position = UDim2.fromScale(0.015,0.219),
        BackgroundColor3 = Color3.fromRGB(43, 43, 43),
    }, {

        UICorner = react.createElement("UICorner", {
            CornerRadius = UDim.new(0, 5),
        }),

        ScrollingFrame = react.createElement("ScrollingFrame", {
            Name = "ScrollingSelectionFrame",
            Size = UDim2.fromScale(1, 0.822),
            Position = UDim2.fromScale(0, 0.178),
            BorderColor3 = Color3.fromRGB(43, 43, 43),
            BackgroundTransparency = 1,
            ScrollBarThickness = 5,

            [react.Ref] = function(element)
                if element ~= nil then
                    task.spawn(function()
                        local temp = Instance.new("HopperBin", element) -- This is there too trigger the autoscale event
                        task.wait(3)
                        temp:Destroy()
                    end)
                end
            end,

            [react.Event.ChildAdded] = function(element, ...)
                task.wait(2)
                self:AutoScale(element)
            end,
            [react.Event.ChildRemoved] = function(element, ...)
                task.wait(2)
                self:AutoScale(element)
            end,

        }, {
            UIList = react.createElement("UIListLayout", {
                [react.Ref] = function(element)
                    self.listLayout = element
                end,
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 5),
            }),

            Buttons = react.createFragment(self.state.Buttons),
        }),

        TextLabel = react.createElement("TextLabel", {
            Name = "SelectionText",
            Text = self.text:map(function(value)
                rednet:FireServer("QuizTopicSelected", value)
                return value
            end),
            TextColor3 = Color3.fromRGB(255, 255, 255),
            Size = UDim2.fromScale(1, 0.09),
            Position = UDim2.fromScale(0.144, 0.01),
            Font = Enum.Font.Cartoon,
            TextScaled = true,
            BackgroundTransparency = 1,
        }, {
            UIRatio = react.createElement("UIAspectRatioConstraint", {
                AspectRatio = 5,
            }),
        }),
    })
end

return SelectionMenu