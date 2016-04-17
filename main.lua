require 'forms'
require 'level'
require 'inventory'

mode = 'loading'
current_level = 'nil'

modes = {
    'loading',
    'title',
    'level',
    'equip'
}

function love.load()
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
    elseif mode == 'equip' then
        -- do NOT update the level or the world
    end
end

function love.draw()
    if mode == 'title' then
        drawTitle()
    elseif mode == 'level' then
        drawLevel(character,levels[current_level])
        drawCharacter(character,levels[current_level])
        love.graphics.print("Energy: " .. character.energy,700,560)
        love.graphics.print(character.shape .. "form",40,560)
    elseif mode == 'equip' then
        drawLevel(levels[current_level],character)
        drawCharacter(character,levels[current_level])
        drawInventory()
    end
end

function love.keypressed(key)
    if mode == 'level' then
        if character.shape == 'fly' then
            flyKeyPressed(key,levels[current_level])
        elseif character.shape == 'snake' then
            snakeKeyPressed(key,levels[current_level])
        end
    end
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end
