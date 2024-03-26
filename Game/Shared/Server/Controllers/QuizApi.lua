local HttpService = game:GetService("HttpService")
local exon = require(game.ReplicatedStorage.Packages.exon)

local HttpService = game:GetService("HttpService")

local Controllers = exon.controllers
local rednet = exon.rednet

local QuizApi = Controllers.CreateController {
    Name = "Quiz Api",
    Info = {
        QuizInfo = {},
        Categories = {},
    },

    Signal = rednet.createSignal(),
}

type GameType = "multiple" | "boolean";
type difficulty = "easy" | "hard" | "medium";

function QuizApi:Fire(data)
    self.Signal:Fire(data)
end

function QuizApi:GetCategories()
    local url = "https://opentdb.com/api_category.php"
    local urlData = HttpService:GetAsync(url)
    local info = HttpService:JSONDecode(urlData)

    for i, v in pairs(info.trivia_categories) do
        local item = {
            id = v.id,
            category = v.name
        }

        table.insert(self.Info.Categories, item)
    end

end

function QuizApi:GetCategory(category)

    local chosenId = 0

    for i, v in pairs(self:GetCategories()) do
        if v.category == category then
            chosenId = v.id
            break
        end
    end

    return chosenId

end

-- Getting Info using the API
function QuizApi:Get(amount: number, difficulty: difficulty, type: GameType, category)
    category = category or 18
    local url = `https://opentdb.com/api.php?amount={amount}&category={category}&difficulty={difficulty}&type={type}`
    local urlData = HttpService:GetAsync(url, true)
    local info = HttpService:JSONDecode(urlData)

    table.clear(self.Info.QuizInfo)

    for i, v in pairs(info) do
        self.Info.QuizInfo[i] = v
    end
end



return QuizApi