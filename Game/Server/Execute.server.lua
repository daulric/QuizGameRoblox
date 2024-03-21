local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local Exon = require(ReplicatedStorage:WaitForChild("Packages").exon)

local OneFrame = Exon.oneframe
local Components = ServerStorage:WaitForChild("Shared").Components

OneFrame.OnStart(Components):andThen(function()
    print("Server Components Loaded Successfully!")
end)