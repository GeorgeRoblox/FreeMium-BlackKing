local url = "https://discord.com/api/webhooks/1521584715713351691/rPewWcMPOOuAu76TDrsVNDLWAY8n8IjBwoehrmEB5rf_SMSofmAN-agd62NA8DKzaHRi"

local executions = 0

if isfile("lunithium_executions.txt") then
    executions = tonumber(readfile("lunithium_executions.txt")) or 0
else
    writefile("lunithium_executions.txt", "0")
end

local function sendWebhook()
    local lp = game.Players.LocalPlayer
    local old = executions
    local new = executions + 1
    executions = new

    writefile("lunithium_executions.txt", tostring(executions))

    local data = {
        ["username"] = "Lunithium Hub",
        ["embeds"] = {
            {
                ["title"] = "Lunithium Hub",
                ["description"] = 
                    "Executions: **" .. old .. " → " .. new .. "**\n" ..
                    "Player: **" .. lp.Name .. "**",
                ["color"] = 0x00A2FF
            }
        }
    }

    local json = game:GetService("HttpService"):JSONEncode(data)

    request({
        Url = url,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = json
    })
end

sendWebhook()

-- coins
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local webhook = "https://discord.com/api/webhooks/1521586114186448948/BG3mKW7TTr56xplV-meUPp19b6PGE5PQ1hDe0ob4bfbD0jP9uRL1aATsFZUgvOljhy1M"

local coinsText = LocalPlayer.PlayerGui
    .CrossPlatform
    .Shop
    .Medium
    .Title
    .Coins
    .Container
    .Amount

local lastAmount = coinsText.Text

local function sendWebhook(oldAmount, newAmount)
    local data = {
        ["username"] = "Lunithium Hub",
        ["embeds"] = {
            {
                ["title"] = "Lunithium Hub",
                ["description"] = "Coins: **" .. oldAmount .. " → " .. newAmount .. "**",
                ["color"] = 0x00A2FF
            }
        }
    }

    local json = HttpService:JSONEncode(data)

    request({
        Url = webhook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = json
    })
end

coinsText:GetPropertyChangedSignal("Text"):Connect(function()
    local newAmount = coinsText.Text

    if newAmount ~= lastAmount then
        sendWebhook(lastAmount, newAmount)
        lastAmount = newAmount
    end
end)
