local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false)
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)

local Exon = require(ReplicatedStorage.Packages.exon)
local OneFrame = Exon.oneframe

local ClientFolder = ReplicatedStorage.Shared.Components
OneFrame.OnStart(ClientFolder):andThen(function()
    print("Client Loaded!")
end)