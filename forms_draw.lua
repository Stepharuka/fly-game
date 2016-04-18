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
    love.graphics.draw(flysprite.sheet, flysprite.f[f],x-16,y-16)
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
    love.graphics.polygon('fill',x1+400,y1+300,x2+400,y2+300,x3+400,y3+300,x4+400,y4+300)
    headx = (x1-x2)/2
    heady = (y1-y2)/2
    love.graphics.circle('fill',headx,heady,12)
end

function drawCharacter(character,level,frame)
    character.x, character.y = getCharacterPosition(character,level)
    if character.shape == 'oldfly' then
        drawOldFly(level,400,300)
    elseif character.shape == 'fly' then
        drawFly(level,400,300,frame)
    elseif character.shape == 'snake' then
        drawSnake(level,level.objects.character,400,300)
    end
end
