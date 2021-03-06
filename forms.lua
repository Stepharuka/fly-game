require 'forms_draw'
require 'forms_input'

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
    character.alive = true
    return character
end

function makeFly(level,x,y)
    fly = {}
    fly.body = love.physics.newBody(level.world,x,y,"dynamic")
    fly.body:setGravityScale(0.1)
    fly.body:setLinearDamping(0.5) --fly is very floaty
    fly.shape = love.physics.newCircleShape(3)
    fly.fixture = love.physics.newFixture(fly.body, fly.shape,0.5)
    fly.fixture:setRestitution(0.2)
    return fly
end

function makeFrog(level,x,y)
    frog = {}
    frog.body = love.physics.newBody(level.world,x,y,"dynamic")
    frog.shape = love.physics.newRectangleShape(40,32)
    frog.fixture = love.physics.newFixture(frog.body, frog.shape, 1)
    frog.body:setGravityScale(1.2)
    return frog
end

function makeSnakeLimb(level,x,y,limblength)
    limb = {}
    limb.body = love.physics.newBody(level.world,x,y,"dynamic")
    limb.shape = love.physics.newRectangleShape(limblength,1)
    limb.fixture = love.physics.newFixture(limb.body,limb.shape,14)
    return limb
end

function makeOldSnake(level,x,y,limblength)
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

function makeSnake(level,x,y,length)
    --Lets make it just a big box
    snake = {}
    snake.body = love.physics.newBody(level.world,x,y,"dynamic")
    snake.shape = love.physics.newRectangleShape(length,15)
    snake.fixture = love.physics.newFixture(snake.body,snake.shape,1)
    snake.head = love.physics.newBody(level.world,x-length/2,y,"dynamic")
    snake.headshape = love.physics.newCircleShape(12)
    snake.headfix = love.physics.newFixture(snake.head,snake.headshape,2)
    snake.neck = love.physics.newWeldJoint(snake.body,snake.head,x-length/2,y)
    return snake
end

function getCharacterPosition(level,character)
    if character.shape == 'fly' then
        return level.objects.character.body:getPosition()
    elseif character.shape == 'snake' then
        return level.objects.character.body:getPosition()
    elseif character.shape == 'frog' then
        return level.objects.character.body:getPosition()
    end
end

function makePlayerSnake(level,character)
    level.objects.character = makeSnake(level,character.x,character.y,44)
end

function makePlayerFly(level,character)
    level.objects.character = makeFly(level,character.x,character.y)
end

function makePlayerFrog(level,character)
    level.objects.character = makeFrog(level,character.x,character.y)
    character.jump_angle = -math.pi/2
end

function makeForm(level)
    form = {}
    --form.body = love.physics.newBody(level.world,)
end

function changeShape(character, new_shape, level)
    if level.objects.character ~= nil then
        level.objects.character.body:destroy()
    end
    if new_shape == 'fly' then
        character.shape = 'fly'
        character.defaultGravity = 0.1
        makePlayerFly(level,character)
    end
    if new_shape == 'cat' then
        character.shape = 'cat'
    end
    if new_shape == 'frog' then
        character.shape = 'frog'
        character.defaultGravity = 1.2
        makePlayerFrog(level,character)
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
    level.objects.character.fixture:setUserData({character.shape,"player"})
end
