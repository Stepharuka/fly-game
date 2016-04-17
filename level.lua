require 'forms'

METER = 32
BOUNDARY_COLOR = {85,85,100}

function initLevel()
    level = {}
    love.physics.setMeter(METER)
    level.world = love.physics.newWorld(0,9.8*METER, true)
    level.objects = {}
    level.objects.boundaries = {}
    level.objects.NPC = {}
    return level
end

function makeBoundary(x, y, w, h, level)
    boundary = {}
    boundary.x = x
    boundary.y = y
    boundary.w = w
    boundary.h = h
    boundary.body = love.physics.newBody(level.world, x, y, "static")
    boundary.shape = love.physics.newRectangleShape(w,h)
    boundary.fixture = love.physics.newFixture(boundary.body, boundary.shape)
    table.insert(level.objects.boundaries,boundary)
end

function makeNPCFly(level,startx,starty)
    fly = makeFly(level,startx,starty)
    fly.ai = 'NPC fly'
    fly.nextimpulse = 0
    table.insert(level.objects.NPC,fly)
end

function NPCFlyAI(level,fly,dt)
    fly.nextimpulse = fly.nextimpulse - dt
end

function makeLevelOne(level)
    makeBoundary(400,500,800,5,level)
    makeBoundary(200,250,5,500,level)
    makeBoundary(600,225,5,450,level)
    makeBoundary(-850,650,5,1500,level)
    makeBoundary(1650,650,5,1500,level)
    makeBoundary(400,-100,2500,5,level)
    makeBoundary(400,1400,2500,5,level)
end

function updateLevel(level,dt)
    level.world:update(dt)
end

function drawLevel(level)
    chara_x, chara_y = character.x,character.y
    x_offset = 400 - chara_x
    y_offset = 300 - chara_y
    love.graphics.setColor(BOUNDARY_COLOR[1],BOUNDARY_COLOR[2],BOUNDARY_COLOR[3])
    for index, boundary in ipairs(level.objects.boundaries) do
        bound_x = boundary.x-(boundary.w/2)+x_offset
        bound_y = boundary.y-(boundary.h/2)+y_offset
        love.graphics.rectangle('fill',bound_x,bound_y, boundary.w,boundary.h)
    end
end
