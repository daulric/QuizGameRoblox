local HttpService = game:GetService("HttpService")
local RS = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local exon = require(RS.Packages.exon)


local oneframe = exon.oneframe
local Controllers = exon.controllers
local ControllersFolder = ServerStorage:WaitForChild("Shared").Controllers

return function(start)
    start(function()
        Controllers.AddController(ControllersFolder)
    end)
end 
