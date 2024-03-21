local RS = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local exon = require(RS.Packages.exon)


local oneframe = exon.oneframe
local Controllers = exon.controllers
local ControllersFolder = ServerStorage:WaitForChild("Shared").Controllers

local ContExec = oneframe.Component.create("Controller Execution")

function ContExec:start()
    Controllers.AddController(ControllersFolder)
end 

return ContExec