require 'game_state'
require 'input_handle'
require 'forms'
require 'forms_draw'
require 'level'
require 'inventory'

mode = 'loading'
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
    game = initGame()
    love.graphics.setBackgroundColor(180,180,186)
    mode = 'level'
end

function love.update(dt)
    if mode == 'level' then
        updateLevel(game.levels[game.current_level],dt)
        levelKeyDown(game.character, game.levels[game.current_level],dt)
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
        --such as frame lengths of animations that need to repeat
        --(most values will share a factor with 8 factorial)
    end
end

function love.draw()
    if mode == 'title' then
        drawTitle()
    elseif mode == 'level' then
        drawLevel(game.character,game.levels[game.current_level])
        drawCharacter(game.character,game.levels[game.current_level],frame)
        love.graphics.setColor(0,0,0)
        love.graphics.print("Energy: " .. game.character.energy,700,560)
        love.graphics.print(game.character.shape .. "form",40,560)
        if game.character.shape == 'frog' then
            love.graphics.print(game.character.jump_angle,120,560)
        end
    elseif mode == 'equip' then
        drawLevel(game.levels[game.current_level],game.character)
        drawCharacter(game.character,game.levels[game.current_level])
        drawInventory()
    end
end

function love.keypressed(key)
    if mode == 'level' then
        characterKeyPressed(key,game.character,game.levels[game.current_level])
    end
end

function love.keyreleased(key)
end

function love.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
end
