all_forms = {
    'fly',
    'frog',
    'cat',
    'bird',
    'snake',
    'bat',
    'dragon'
}

START_POSITION = {400,300}

function initCharacter()
    character = {}
    character.form_names = all_forms
    character.shape = nil
    character.x = START_POSITION[1]
    character.y = START_POSITION[2]
    character.energy = 5
    return character
end

function makeFly(level,x,y)
    fly = {}
    fly.body = love.physics.newBody(level.world,x,y,"dynamic")
    fly.body:setGravityScale(0.1)
    fly.body:setLinearDamping(0.5) --fly is very floaty
    fly.shape = love.physics.newCircleShape(2)
    fly.fixture = love.physics.newFixture(fly.body, fly.shape,0.5)
    fly.fixture:setRestitution(0.2)
    return fly
end

function makeSnakeLimb(level,x,y,limblength)
    limb = {}
    limb.body = love.physics.newBody(level.world,x,y,"dynamic")
    limb.shape = love.physics.newRectangleShape(limblength,1)
    limb.fixture = love.physics.newFixture(limb.body,limb.shape,14)
    return limb
end

function makeSnake(level,x,y,limblength)
    snake = {}
    snake.limbs = {}
    snake.joints = {}
    for i = 1, 5, 1 do
        snake.limbs[i] = makeSnakeLimb(level,x,y,limblength)
        x = x + limblength
    end
    for i = 1, 4, 1 do
        snake.joints[i] = love.physics.newDistanceJoint(snake.limbs[i].body,snake.limbs[i+1].body,0,0,limblength,0,limblength)
    end
    return snake
end

function getCharacterPosition(level,character)
    if character.shape == 'fly' then
        return level.objects.character.body:getPosition()
    elseif character.shape == 'snake' then
        return level.objects.character.limbs[1].body:getPosition()
    end
end

function makePlayerSnake(level,character)
    level.objects.character = makeSnake(level,character.x,character.y,4)
end

function makePlayerFly(level,character)
    level.objects.character = makeFly(level,character.x,character.y)
end

function makeForm(level)
    form = {}
    --form.body = love.physics.newBody(level.world,)
end

function flyKeyPressed(key,level)
    if key == 'k' then --up
        level.objects.character.body:applyForce(0,-50)
    elseif key == 'j' then --down
        level.objects.character.body:applyForce(0,50)
    elseif key == 'h' then --left
        level.objects.character.body:applyForce(-50,0)
    elseif key == 'l' then --right
        level.objects.character.body:applyForce(50,0)
    end
end

function snakeKeyPressed(key,level)
    if key == 'k' then --up
        level.objects.character.limbs[1].body:applyForce(0,-150)
    elseif key == 'j' then --down
        level.objects.character.limbs[1].body:applyForce(0,150)
    elseif key == 'h' then --left
        level.objects.character.limbs[1].body:applyForce(-150,0)
    elseif key == 'l' then --right
        level.objects.character.limbs[1].body:applyForce(150,0)
    end
end

function equipKeyPressEffects(key, level)
end

function changeShape(character, new_shape, level)
    if new_shape == 'fly' then
        character.shape = 'fly'
        makePlayerFly(level,character)
    end
    if new_shape == 'cat' then
        character.shape = 'cat'
    end
    if new_shape == 'frog' then
        character.shape = 'frog'
    end
    if new_shape == 'bird' then
        character.shape = 'bird'
    end
    if new_shape == 'snake' then
        character.shape = 'snake'
        makePlayerSnake(level,character)
    end
    if new_shape == 'bat' then
        character.shape = 'bat'
    end
    if new_shape == 'dragon' then
        character.shape = 'dragon'
    end
end

function drawFly(level,x,y)
    love.graphics.setColor(15,15,25)
    love.graphics.circle('fill',x,y,2,4)
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

function drawSnake(level,snake,x,y)
    love.graphics.setColor(60,110,50)
    for i = 1, 4, 1 do
        sx,sy = snake.limbs[i].body:getPosition()
        ex,ey = snake.limbs[i+1].body:getPosition()
        love.graphics.line(sx,sy,ex,ey)
    end
end
