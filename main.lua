require 'forms'
require 'forms_draw'
require 'level'
require 'inventory'

mode = 'loading'
current_level = 'nil'
FPS = 30
frame = 0
frame_dt = 1/FPS
next_frame = 0

modes = {
    'loading',
    'title',
    'level',
    'equip'
}

function love.load()
    loadAssets()
    levels = {}
    levels[1] = initLevel()
    makeLevelOne(levels[1])
    character = initCharacter()
    love.graphics.setBackgroundColor(180,180,186)
    changeShape(character, 'fly', levels[1])
    current_level = 1
    mode = 'level'
end

function love.update(dt)
    if mode == 'level' then
        updateLevel(levels[current_level],dt)
        if love.keyboard.isDown('h') then
            characterKeyDown('h',character,levels[current_level])
        end
        if love.keyboard.isDown('l') then
            characterKeyDown('l',character,levels[current_level])
        end
        if love.keyboard.isDown('j') then
            characterKeyDown('j',character,levels[current_level])
        end
        if love.keyboard.isDown('k') then
            characterKeyDown('k',character,levels[current_level])
        end
    elseif mode == 'equip' then
        -- do NOT update the level or the world
    end
    next_frame = next_frame - dt
    if next_frame < 0 then
        frame = frame + 1
        next_frame = next_frame + frame_dt
    end
    if frame > 100000 then
        frame = frame % 40320
        --don't let the frame counter get ridiculously high
        --use modulo to preserve function of other functions that use modulo
        --(most values will share a factor with 8!)
    end
end

function love.draw()
    if mode == 'title' then
        drawTitle()
    elseif mode == 'level' then
        drawLevel(character,levels[current_level])
        drawCharacter(character,levels[current_level],frame)
        love.graphics.print("Energy: " .. character.energy,700,560)
        love.graphics.print(character.shape .. "form",40,560)
    elseif mode == 'equip' then
        drawLevel(levels[current_level],character)
        drawCharacter(character,levels[current_level])
        drawInventory()
    end
end

function love.keypressed(key)
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end
