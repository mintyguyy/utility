--Tables
local Util = {}
Util.notifications = {}
Util.watermark = {}
Util.functions = {}

--Notification
function Util.notifications.new(textContent, duration , color) 
    local textdata = {
        color = Color3.fromRGB(255,255,255),
        outlineColor = Color3.fromRGB(0,0,0),
        size = 14,
        offset = 0,
        duration = 2
    }

    textdata.offset = #Util.notifications * 15

    local text = Drawing.new("Text")
    text.Text = textContent
    text.OutlineColor = textdata.outlineColor
    text.Size = textdata.size
    text.Center = false
    text.Outline = true
    text.Color = color or esp.color
    text.Position = Vector2.new(10, 10 + textdata.offset)
    text.Font = Drawing.Fonts.Monospace
    text.Visible = true

    table.insert(Util.notifications, text)

    task.spawn(function()
        task.wait(duration or textdata.duration)
        for i = 1, 0, -0.05 do
            task.wait(0.02)
            text.Transparency = i
        end

        text:Destroy()

        for i, v in pairs(Util.notifications) do
            if v == text then
                table.remove(Util.notifications, i)
                break
            end
        end
        for i, v in pairs(Util.notifications) do
            if type(v) ~= "function" then
                i = tonumber(i)
                v.Position = Vector2.new(10, 10 + (i - 1) * 15)
            end
        end
    end)
end
