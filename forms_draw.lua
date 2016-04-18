function drawFly(level,x,y)
    love.graphics.setColor(15,15,25)
    love.graphics.circle('fill',x,y,2,4)
end

function drawSnake(level,snake,x,y)
    love.graphics.setColor(60,110,50)
    for i = 1, 4, 1 do
        sx,sy = snake.limbs[i].body:getPosition()
        ex,ey = snake.limbs[i+1].body:getPosition()
        love.graphics.line(sx,sy,ex,ey)
    end
end

function drawCharacter(character,level)
    character.x, character.y = getCharacterPosition(character,level)
    if character.shape == 'fly' then
        drawFly(level,400,300)
    end
    if character.shape == 'snake' then
        drawSnake(level,level.objects.character,400,300)
    end
end
