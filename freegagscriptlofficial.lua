-- Hi, this script is made from TrexonHub, (.gg/CS2Taswnt2) from R3NTMM, please at least leave a credit, this script is open source for everyone!
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local selectedSeed = ""

local function formatToolName(seedName, count)
   return seedName .. " Seed [X" .. count .. "]"
end

local Window = Rayfield:CreateWindow({
   Name = "Free GaG Script - v1.0",
   Icon = "scroll",
   LoadingTitle = "Free GaG Script - .gg/CS2Taswnt2",
   LoadingSubtitle = "by TrexonHub",
   Theme = "Serenity",
   ToggleUIKeybind = "T",

   ConfigurationSaving = {
      Enabled = false,
      FolderName = nil,
      FileName = "TrexonHub"
   },

   Discord = {
      Enabled = true,
      Invite = "CS2Taswnt2",
      RememberJoins = true
   },

   KeySystem = false,
})

local STab = Window:CreateTab("Seed Spawner", "bean")
local PTab = Window:CreateTab("Pet Spawner (Working!)", "dog")
local SeTab = Window:CreateTab("Settings", "settings")

Rayfield:Notify({
   Title = "Loaded",
   Content = "THUB - Free GaG Script Loaded",
   Duration = 5.5,
   Image = "rss",
})

Rayfield:Notify({
   Title = "Welcome back, " .. LocalPlayer.DisplayName .. "!",
   Content = "Ready to spawn some seeds? 🌱",
   Duration = 6,
   Image = "leaf"
})

STab:CreateInput({
   Name = "Seed Name",
   PlaceholderText = "Enter seed name...",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      print("Seed ingresada:", Text)
      selectedSeed = Text
   end,
})

STab:CreateButton({
   Name = "Spawn Seed",
   Callback = function()
      if selectedSeed == "" then
         Rayfield:Notify({
            Title = "Error",
            Content = "Please enter a seed name.",
            Duration = 3,
            Image = "alert-triangle"
         })
         return
      end

      local seedFolder = ReplicatedStorage:FindFirstChild("Seed_Models")
      if not seedFolder then return end

      local seed = seedFolder:FindFirstChild(selectedSeed)
      if not seed then
         Rayfield:Notify({
            Title = "Not Found",
            Content = "There is no seed named '" .. selectedSeed .. "'.",
            Duration = 4,
            Image = "x"
         })
         return
      end

      local backpack = LocalPlayer:WaitForChild("Backpack")
      local existingTool, currentAmount = nil, 0

      for _, item in ipairs(backpack:GetChildren()) do
         if item:IsA("Tool") and item.Name:match("^" .. selectedSeed .. " Seed %[X%d+%]$") then
            existingTool = item
            currentAmount = tonumber(item.Name:match("%[X(%d+)%]")) or 0
            break
         end
      end

      local clone = seed:Clone()
      clone.Name = "Handle"

      if existingTool then
         local newTool = Instance.new("Tool")
         newTool.Name = formatToolName(selectedSeed, currentAmount + 1)
         newTool.RequiresHandle = true
         newTool.Grip = CFrame.new()
         clone.Parent = newTool

         existingTool:Destroy()
         newTool.Parent = backpack
      else
         local tool = Instance.new("Tool")
         tool.Name = formatToolName(selectedSeed, 1)
         tool.RequiresHandle = true
         tool.Grip = CFrame.new()
         clone.Parent = tool
         tool.Parent = backpack
      end

      Rayfield:Notify({
         Title = "Success",
         Content = selectedSeed .. " Seed spawned in backpack.",
         Duration = 3,
         Image = "check"
      })
   end,
})

STab:CreateButton({
   Name = "Delete All Spawned Seeds",
   Callback = function()
      local backpack = LocalPlayer:WaitForChild("Backpack")
      local deleted = 0

      for _, item in ipairs(backpack:GetChildren()) do
         if item:IsA("Tool") and item.Name:match(" Seed %[X%d+%]$") then
            item:Destroy()
            deleted += 1
         end
      end

      Rayfield:Notify({
         Title = "Deleted",
         Content = "Removed " .. deleted .. " seed(s).",
         Duration = 3,
         Image = "trash"
      })
   end
})

PTab:CreateLabel("Working on this tab! :D", "laugh")
SeTab:CreateLabel("This script is some part visual, some things wont work!", "info")

SeTab:CreateButton({
   Name = "Close UI",
   Callback = function()
      Rayfield:Notify({
         Title = "Closing...",
         Content = "UI closed successfully",
         Duration = 1,
         Image = "x"
      })
      Rayfield:Destroy()
   end
})
