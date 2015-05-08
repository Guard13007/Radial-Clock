local lg = love.graphics

local hx, hy = lg.getWidth()/2, lg.getHeight()/2
local r = math.min(hx, hy)
local edge = r/20
r = r - r/20
local time = os.date("*t",os.time())

local offset = math.pi/2
local secR = math.pi*2 / 59
local secD = secR / 2
local minR = math.pi*2 / 59
local minD = minR / 2
local hourR = math.pi*2 / 23
local hourD = hourR / 2
local dayR = math.pi*2 / 31
local dayD = dayR / 2
local monthR = math.pi*2 / 12
local monthD = monthR / 2

local fullscreen = false
local borderless = false
local fakefullscreen = false

--[[
local color = {
    sec = {255, 102, 0},
    min = {255, 0, 0},
    hour = {255, 255, 0},
    day = {0, 200, 200},
    month = {120, 120, 130},
    background = {5,10,15},
    year = {255, 255, 255}
}
--]]
local color = {
    sec = {0, 0, 60},
    min = {0, 0, 180},
    hour = {0, 60, 255},
    day = {0, 120, 255},
    month = {0, 180, 255},
    background = {5,10,15},
    year = {220, 220, 220}
}

function love.update()
    time = os.date("*t",os.time())
    hx, hy = lg.getWidth()/2, lg.getHeight()/2
    r = math.min(hx, hy)
    r = r - r/20

    --tmp joke thing
    --offset = offset - 0.1
end

function love.draw()
    lg.translate(hx, hy)

    lg.setColor(color.background)
    for i=1,59 do
        lg.arc("fill", 0, 0, r, (i-1)*secR - offset, i*secR - secD - offset)
    end
    -- seconds
    lg.setColor(color.sec)
    for i=1,time.sec do
        lg.arc("fill", 0, 0, r, (i-1)*secR - offset, i*secR - secD - offset)
    end
    lg.setColor(0,0,0)
    lg.circle("fill", 0, 0, r*5/6 + edge/2)

    lg.setColor(color.background)
    for i=1,59 do
        lg.arc("fill", 0, 0, r*5/6 - edge/2, (i-1)*minR - offset, i*minR - minD - offset)
    end
    -- minutes
    lg.setColor(color.min)
    for i=1,time.min do
        lg.arc("fill", 0, 0, r*5/6 - edge/2, (i-1)*minR - offset, i*minR - minD - offset)
    end
    lg.setColor(0,0,0)
    lg.circle("fill", 0, 0, r*4/6 + edge/2)

    lg.setColor(color.background)
    for i=1,23 do
        lg.arc("fill", 0, 0, r*4/6 - edge/2, (i-1)*hourR - offset, i*hourR - hourD - offset)
    end
    -- hours
    lg.setColor(color.hour)
    for i=1,time.hour do
        lg.arc("fill", 0, 0, r*4/6 - edge/2, (i-1)*hourR - offset, i*hourR - hourD - offset)
    end
    lg.setColor(0,0,0)
    lg.circle("fill", 0, 0, r*3/6 + edge/2)

    lg.setColor(color.background)
    for i=1,31 do
        lg.arc("fill", 0, 0, r*3/6 - edge/2, (i-1)*dayR - offset, i*dayR - dayD - offset)
    end
    -- days
    lg.setColor(color.day)
    for i=1,time.day do
        lg.arc("fill", 0, 0, r*3/6 - edge/2, (i-1)*dayR - offset, i*dayR - dayD - offset)
    end
    lg.setColor(0,0,0)
    lg.circle("fill", 0, 0, r*2/6 + edge/2)

    lg.setColor(color.background)
    for i=1,12 do
        lg.arc("fill", 0, 0, r*2/6 - edge/2, (i-1)*monthR - offset, i*monthR - monthD - offset)
    end
    -- months
    lg.setColor(color.month)
    for i=1,time.month do
        lg.arc("fill", 0, 0, r*2/6 - edge/2, (i-1)*monthR - offset, i*monthR - monthD - offset)
    end
    lg.setColor(0,0,0)
    lg.circle("fill", 0, 0, r*1/6 + edge/2)

    -- years
    --love.graphics.print( text, x, y, r, sx, sy, ox, oy, kx, ky )
    lg.setColor(color.year)
    lg.print(time.year, -17, -6, 0, 1, 1, 0, 0)
end

local ow, oh
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f" then
        if not fakefullscreen then
            if fullscreen then
                love.window.setMode(ow, oh, {fullscreen=false, resizable=true})
            else
                ow = lg.getWidth()
                oh = lg.getHeight()
                local w, h = love.window.getDesktopDimensions()
                love.window.setMode(w, h, {fullscreen=true})
            end
            fullscreen = not fullscreen
        end
    elseif key == "b" then
        if not fakefullscreen then
            love.window.setMode(hx*2, hy*2, {borderless=not borderless, resizable=true})
            borderless = not borderless
        end
    elseif key == "g" then
        if fakefullscreen then
            love.window.setMode(ow, oh, {borderless = false, resizable=true})
            fakefullscreen = false
        else
            if fullscreen then
                fullscreen = not fullscreen
                love.window.setMode(hx*2, hy*2, {borderless=true})
            else
                ow = lg.getWidth()
                oh = lg.getHeight()
                local w, h = love.window.getDesktopDimensions()
                love.window.setMode(w, h, {borderless=true})
            end
            fakefullscreen = true
        end
    end
end
