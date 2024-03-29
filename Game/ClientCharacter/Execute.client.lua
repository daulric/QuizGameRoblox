local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Exon = require(ReplicatedStorage.Packages.exon)

local CharacterComponent = ReplicatedStorage.Shared.CharacterComponent

local OneFrame = Exon.oneframe

local character = script.Parent.Parent

OneFrame.OnStart(CharacterComponent, character):andThen(function()
    print("Character Components Loaded!")
end)