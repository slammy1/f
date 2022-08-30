getgenv().Enabled = false
getgenv().ZyZKey = Enum.KeyCode.Q
getgenv().Prediction = 1.36
getgenv().Tracer = false
getgenv().TracerBugged = false
getgenv().LookAt = false
getgenv().ZyZPart = "LowerTorso"
getgenv().NotifyZyZ = false
getgenv().BlindStrafe = false
getgenv().ViewPlr = false
getgenv().NotificationsSound = false
_G.AirshotFunction = false
_G.AirshotPart = "RightUpperLeg"
_G.FRAME = Vector3.new(0,20,0)
_G.FRAME2 = Vector3.new(0,20,0)


local guimain = Instance.new("Folder", game.CoreGui)
local CC = game:GetService "Workspace".CurrentCamera
local LocalMouse = game.Players.LocalPlayer:GetMouse()
local Locking = false
local cc = game:GetService("Workspace").CurrentCamera
local gs = game:GetService("GuiService")
local ggi = gs.GetGuiInset
local lp = game:GetService("Players").LocalPlayer
local mouse = lp:GetMouse()

local Tracer = Drawing.new("Line")
Tracer.Visible = false
Tracer.Color = Color3.fromRGB(13, 17, 214)
Tracer.Thickness = 1
Tracer.Transparency = 1

local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(
    function(keygo, ok)
        if (not ok) then
            if (keygo.KeyCode == getgenv().ZyZKey) then
                if getgenv().Enabled then
                    Locking = not Locking
                    if Locking then
                        Plr = getClosestPlayerToCursor()
                        if getgenv().ViewPlr then
                        	game.Workspace.CurrentCamera.CameraSubject = Plr.Character
                            
                        end
                        if getgenv().NotificationsSound then
                            sound:Play()
                        end
                        if getgenv().NotifyZyZ then
                            Library:Notify(': ' .. Plr.Character.Humanoid.DisplayName)
                        end
                    elseif not Locking then
                        
if getgenv().ViewPlr then
	game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
end

if getgenv().NotificationsSound then
    sound1:Play()
end

                        if getgenv().NotifyZyZ then
                            Library:Notify('unlock')
                        end
                    end
                end
            end
        end
    end
)
function getClosestPlayerToCursor()
    local closestPlayer
    local shortestDistance = 137

    for i, v in pairs(game.Players:GetPlayers()) do
        if
            v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and
                v.Character.Humanoid.Health ~= 0 and
                v.Character:FindFirstChild("LowerTorso")
         then
            local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
            local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(LocalMouse.X, LocalMouse.Y)).magnitude
            if magnitude < shortestDistance then
                closestPlayer = v
                shortestDistance = magnitude
            end
        end
    end
    return closestPlayer
end

local rawmetatable = getrawmetatable(game)
local old = rawmetatable.__namecall
setreadonly(rawmetatable, false)
rawmetatable.__namecall =
    newcclosure(
    function(...)
        local args = {...}
        if Locking and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
            args[3] =
                Plr.Character[getgenv().ZyZPart].Position + (Plr.Character[getgenv().ZyZPart].Velocity * Prediction / 10)
            return old(unpack(args))
        end
        return old(...)
    end
)

game:GetService("RunService").RenderStepped:Connect(
    function()
        if getgenv().autosetup == true then
            local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
            local split = string.split(pingvalue, " ")
            local ping = split[1]
            if tonumber(ping) < 30 then
                getgenv().Prediction = 1.14
            elseif tonumber(ping) <= 30 then
                if tonumber(ping) < 40 then
                    getgenv().Prediction = 1.16
                elseif tonumber(ping) <= 40 then
                    if tonumber(ping) < 50 then
                        getgenv().Prediction = 1.19
                    elseif tonumber(ping) <= 50 then
                        if tonumber(ping) < 70 then
                            getgenv().Prediction = 1.22
                        elseif tonumber(ping) <= 80 then
                            getgenv().Prediction = 1.38
                        elseif tonumber(ping) <= 80 then
                            getgenv().Prediction = 1.39
                        elseif tonumber(ping) <= 90 then
                            getgenv().Prediction = 1.42
                        elseif tonumber(ping) <= 150 then
                            getgenv().Prediction = 1.51
                        elseif tonumber(ping) >= 200 then
                            getgenv().Prediction = 1.69
                        end
                    end
                end
            end
        end
        
        if _G.AirshotFunction == true then
            if Plr.Character.Humanoid.Jump == true and Plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
                getgenv().ZyZPart = _G.AirshotPart
            else
                Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(
                    function(old, new)
                        if new == Enum.HumanoidStateType.Freefall then
                            getgenv().Partz = _G.AirshotPart
                        else
                            getgenv().ZyZPart = "UpperRightLeg"
                        end
                    end
                )
            end
        end
if getgenv().BlindStrafe and Locking and getgenv().Enabled then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position + _G.FRAME)
    

end

if getgenv().BlindStrafe and Locking and getgenv().Enabled then
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position + _G.FRAME)
    

end

if getgenv().LookAt and Locking and getgenv().Enabled then
                    local Char = game.Players.LocalPlayer.Character
                local PrimaryPartOfChar = game.Players.LocalPlayer.Character.PrimaryPart
                local NearestChar = Plr.Character
                local NearestRoot = Plr.Character.HumanoidRootPart
                local NearestPos = CFrame.new(PrimaryPartOfChar.Position, Vector3.new(NearestRoot.Position.X, NearestRoot.Position.Y, NearestRoot.Position.Z))
                Char:SetPrimaryPartCFrame(NearestPos)
                
    end
        if getgenv().Tracer == true and Locking then
            local Vector, OnScreen =
                cc:worldToViewportPoint(
                Plr.Character[getgenv().ZyZPart].Position + (Plr.Character[getgenv().ZyZPart].Velocity * Prediction / 10)
            )
            Tracer.Visible = true
            Tracer.From = Vector2.new(mouse.X, mouse.Y + ggi(gs).Y)
            Tracer.To = Vector2.new(Vector.X, Vector.Y)
        elseif getgenv().Tracer == false then
            Tracer.Visible = false
        end
if Tracer.Visible == true and not Locking and getgenv().Enabled then
    getgenv().TracerBugged = true
    Tracer.Visible = false
end

if getgenv().Tracer == true and getgenv().TracerBugged and Locking then
    Tracer.Visible = true
end
end)
