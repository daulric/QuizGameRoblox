local HttpService = game:GetService("HttpService")
local exon = require(game.ReplicatedStorage.Packages.exon)

local HttpService = game:GetService("HttpService")

local Controllers = exon.controllers

local QuizApi = Controllers.CreateController {
    Name = "Quiz Api",
    Info = {
        QuizInfo = {}
    }
}

type GameType = "multiple" | "boolean";
type difficulty = "easy" | "hard" | "medium";


-- Getting Info using the API
function QuizApi:Get(amount: number, difficulty: difficulty, type: GameType)
    local url = `https://opentdb.com/api.php?amount={amount}&category=18&difficulty={difficulty}&type={type}`
    local info = HttpService:JSONDecode(url)

    if type(info) == "table" then
        for i, v in pairs(info) do
            self.Info.QuizInfo[i] = v
        end
    end

end



return QuizApi