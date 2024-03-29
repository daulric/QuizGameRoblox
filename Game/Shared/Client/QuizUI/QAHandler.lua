local ReplicatedStorage = game:GetService("ReplicatedStorage")
local exon = require(ReplicatedStorage.Packages.exon)

local react = exon.react
local rednet = exon.rednet

local ScreenFolder = script.Parent:WaitForChild("Screen")
local ItemsFolder = script.Parent:WaitForChild("Items")

local QuestionLabel = require(ItemsFolder.QuestionLabel)
local ButtonArea = require(ScreenFolder.ButtonArea)

local QAHandler = react.Component:extend("QA Handler")

local OptionButton = require(script.Parent:WaitForChild("Buttons").OptionButton)

function QAHandler:init()
    self.question, self.updateQuestion = react.createBinding("")
    self.questionData, self.updateQuestionData = react.createBinding({})
    self:setState({
        Buttons = {},
    })

end

function QAHandler:didMount()
    print("QA handler Did Mount")

    rednet.listen("QuizGetNow", function(data)
        self.updateQuestionData(data)
    end)

    self.questionData[react.Bind].subscribe(function(data)
        local results = data.results
        local tempStore = {}
        local buttons = {}
        local Answered = false

        for i = 1, #results do
            local Question_Queue = results[i]

            self.updateQuestion(Question_Queue.question)
            table.insert(tempStore, Question_Queue.correct_answer)

            for i, v in pairs(Question_Queue.incorrect_answers) do
                table.insert(tempStore, v)
            end

            for i = 1, #tempStore do
                local chosenNum = math.random(1, #tempStore)
                local soundRef = react.createRef()
                local element = react.createElement(OptionButton, {
                    Text = tempStore[chosenNum],
                    mouseClicked = function(element)
                        local soundPlayer = soundRef:getValue()

                        if Answered == true then
                            return
                        end

                        if element.Text == Question_Queue.correct_answer then
                            element.BackgroundColor3 = Color3.fromRGB(30, 70, 9)
                            rednet:FireServer("score_update", true)
                            soundPlayer.SoundId = "rbxassetid://9060788686"
                            soundPlayer:Play()
                        else
                            element.BackgroundColor3 = Color3.fromRGB(84, 11, 11)
                            rednet:FireServer("score_update", false)
                            soundPlayer.SoundId = "rbxassetid://1637297605"
                            soundPlayer:Play()
                        end

                        Answered = true
                    end
                }, {
                    Sound = react.createElement("Sound", {
                        Name = "Success/Failure",
                        SoundId = "",
                        [react.Ref] = soundRef,
                    })
                })

                table.insert(buttons, element)
                table.remove(tempStore, chosenNum)
            end

            self:setState({
                Buttons = buttons
            })

            repeat
                task.wait()
            until (Answered == true)

            task.wait(2)
            Answered = false
            table.clear(tempStore)
            table.clear(buttons)

            if i == #results then
                rednet:FireServer("resend_quiz")
            end

        end
    end)

end

function QAHandler:render()
    return react.createFragment({
        QuestionLabel = react.createElement(QuestionLabel, {
            Question = self.question:map(function(value) return value end),
        }),
        ButtonArea = react.createElement(ButtonArea, {}, {
            Buttons = react.createFragment(self.state.Buttons),
        }),
    })
end


return QAHandler