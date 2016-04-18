function loadAssets()
    flysprite = {}
    flysprite.f = {}
    flysprite.sheet = love.graphics.newImage('assets/flysheet.png')
    flysprite.f[1] = love.graphics.newQuad(0,0,32,32,64,64)
    flysprite.f[2] = love.graphics.newQuad(32,0,32,32,64,64)
    flysprite.f[3] = love.graphics.newQuad(0,32,32,32,64,64)
    flysprite.f[4] = love.graphics.newQuad(32,32,32,32,64,64)
end

function drawOldFly(level,x,y)
    love.graphics.setColor(15,15,25)
    love.graphics.circle('fill',x,y,2,4)
end

function drawFly(level,x,y,frame)
    f = 1 + (frame % 4)
    love.graphics.draw(flysprite.sheet, flysprite.f[f],x-16,y-14)
end

function drawOldSnake(level,snake,x,y)
    love.graphics.setColor(60,110,50)
    for i = 1, 4, 1 do
        sx,sy = snake.limbs[i].body:getPosition()
        ex,ey = snake.limbs[i+1].body:getPosition()
        love.graphics.line(sx,sy,ex,ey)
    end
end

function drawSnake(level,snake,x,y)
    love.graphics.setColor(60,110,50)
    x1,y1,x2,y2,x3,y3,x4,y4  = snake.shape:getPoints()
    love.graphics.polygon('fill',x1+x,y1+x,x2+x,y2+x,x3+x,y3+x,x4+x,y4+x)
    headx = (x1-x2)/2
    heady = (y1-y2)/2
    love.graphics.circle('fill',headx,heady,12)
end

function drawFrog(level,frog,x,y,angle)
    love.graphics.setColor(120,160,70)
    x1,y1,x2,y2,x3,y3,x4,y4  = frog.shape:getPoints()
    x1,x2,x3,x4 = x1+x,x2+x,x3+x,x4+x
    y1,y2,y3,y4 = y1+y,y2+y,y3+y,y4+y
    love.graphics.polygon('fill',x1,y1,x2,y2,x3,y3,x4,y4)
    --use angle when replacing with a texture
end

function drawCharacter(character,level,frame)
    character.x, character.y = getCharacterPosition(level,character)
    if character.shape == 'oldfly' then
        drawOldFly(level,400,300)
    elseif character.shape == 'fly' then
        drawFly(level,400,300,frame)
    elseif character.shape == 'snake' then
        drawSnake(level,level.objects.character,400,300)
    elseif character.shape == 'frog' then
        drawFrog(level,level.objects.character,400,300,character.jump_angle)
    end
end
