local HttpService = game:GetService("HttpService")
local exon = require(game.ReplicatedStorage.Packages.exon)

local HttpService = game:GetService("HttpService")

local Controllers = exon.controllers
local rednet = exon.rednet

local QuizApi = Controllers.CreateController {
    Name = "Quiz Api",
    Info = {
        QuizInfo = {}
    },

    Signal = rednet.createSignal(),
}

type GameType = "multiple" | "boolean";
type difficulty = "easy" | "hard" | "medium";

function QuizApi:Fire(data)
    self.Signal:Fire(data)
end

-- Getting Info using the API
function QuizApi:Get(amount: number, difficulty: difficulty, type: GameType)
    local url = `https://opentdb.com/api.php?amount={amount}&category=18&difficulty={difficulty}&type={type}`
    local urlData = HttpService:GetAsync(url, true)
    local info = HttpService:JSONDecode(urlData)

    table.clear(self.Info.QuizInfo)

    for i, v in pairs(info) do
        self.Info.QuizInfo[i] = v
    end
end



return QuizApi