require 'forms'

METER = 32
BOUNDARY_COLOR = {85,85,100}

function initLevel()
    level = {}
    love.physics.setMeter(METER)
    level.world = love.physics.newWorld(0,9.8*METER, true)
    level.world:setCallbacks(beginContact,endContact,preSolve,postSolve)
    level.objects = {}
    level.objects.boundaries = {}
    level.objects.NPC = {}
    level.nextUniqueNPC_id = 0
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
    boundary.fixture:setUserData({"boundary","N/A"})
    table.insert(level.objects.boundaries,boundary)
end

function MakeNPC(level,npc)
    level.nextUniqueNPC_id = 1 + level.nextUniqueNPC_id 
    npc.id = level.nextUniqueNPC_id
    npc.alive = true
    npc.fixture:setUserData({npc.NPCtype,npc.id})
end

function makeNPCFly(level,startx,starty)
    fly = makeFly(level,startx,starty)
    fly.NPCtype = 'fly'
    MakeNPC(level,fly)
    fly.ai = 'NPC fly'
    fly.nextimpulse = 0
    fly.impulse_gap = 0.8
    table.insert(level.objects.NPC,fly)
end

function NPCFlyAI(level,fly,dt)
    fly.nextimpulse = fly.nextimpulse - dt
    if fly.nextimpulse < 0 then
        theta = 2*math.pi*math.random()
        magnitude = math.random()
        x, y = fly.body:getPosition()
        fly.body:applyLinearImpulse(magnitude*math.cos(theta),magnitude*math.sin(theta))
        if y > 200 then
            fly.body:applyLinearImpulse(0,-0.2)
        end
        if y > -200 then
            fly.body:applyLinearImpulse(0,-0.2)
        end
        fly.nextimpulse = fly.nextimpulse + fly.impulse_gap
    end
end

function makeNPCFrog(level,startx,starty)
    frog = makeFrog(level,startx,starty)
    frog.NPCtype = 'frog'
    MakeNPC(level,frog)
    frog.ai = 'NPC frog'
    frog.next_jump = 1
    frog.next_adjust = 0
    frog.jump_interval = 2.5
    frog.adjust_interval = 0.8
    frog.jump_angle = 0 - (math.pi/2)
    table.insert(level.objects.NPC,frog)
end

function NPCFrogAI(level,frog,dt)
    frog.next_jump = frog.next_jump - dt
    frog.next_adjust = frog.next_adjust - dt
end


ai_types = {'NPC fly','NPC frog'}

function updateNPC(level,NPC,dt)
    if NPC.ai == 'NPC fly' then
        NPCFlyAI(level,NPC,dt)
    elseif NPC.ai == 'NPC frog' then
        NPCFrogAI(level,NPC,dt)
    end
end

function makeLevelOne(level)
    makeBoundary(400,500,800,5,level)
    makeBoundary(200,250,5,500,level)
    makeBoundary(600,225,5,450,level)
    makeBoundary(-850,650,5,1500,level)
    makeBoundary(1650,650,5,1500,level)
    makeBoundary(400,-100,2500,5,level)
    makeBoundary(400,1400,2500,5,level)
    makeNPCFly(level,200,300)
    makeNPCFly(level,250,30)
    makeNPCFly(level,100,60)
    makeNPCFly(level,400,30)
    makeNPCFly(level,500,60)
    makeNPCFly(level,900,30)
    makeNPCFly(level,1200,30)
    makeNPCFly(level,-200,30)
    makeNPCFly(level,-400,30)
    makeNPCFly(level,-600,30)
    makeNPCFly(level,1400,30)
end

function updateLevel(level,dt)
    level.world:update(dt)
    kill = {}
    for i, NPC in ipairs(level.objects.NPC) do
        if NPC.alive == false then
            table.insert(kill,i)
        end
        updateNPC(level,NPC,dt)
    end
    for i, npcindex in ipairs(kill) do
        level.objects.NPC[npcindex].body:destroy()
        table.remove(level.objects.NPC,npcindex)
    end
end

function drawLevel(character,level,frame)
    chara_x, chara_y = getCharacterPosition(level,character)
    x_offset = 400 - chara_x
    y_offset = 300 - chara_y
    love.graphics.setColor(BOUNDARY_COLOR[1],BOUNDARY_COLOR[2],BOUNDARY_COLOR[3])
    for index, boundary in ipairs(level.objects.boundaries) do
        bound_x = boundary.x-(boundary.w/2)+x_offset
        bound_y = boundary.y-(boundary.h/2)+y_offset
        love.graphics.rectangle('fill',bound_x,bound_y, boundary.w,boundary.h)
    end

    for index, NPC in ipairs(level.objects.NPC) do
        if NPC.NPCtype == 'fly' then
            fx, fy = NPC.body:getPosition()
            drawFly(level,fx+x_offset,fy+y_offset,frame)
        end
    end
end

function eat(a,b)
    if a[2] == 'player' then
        if a[1] == 'frog' then
            if b[1] == 'fly' then
                game.character.energy = game.character.energy + 1
                for i, npc in ipairs(game.levels[game.current_level].objects.NPC) do
                    if npc.id == b[2] then
                        npc.alive = false
                    end
                end
            end
        end
    elseif b[2] == 'player' then
        game.playerdeath = true
    end
end

function beginContact(a,b,coll)
    game.prints = true
    astuff = a:getUserData()
    bstuff = b:getUserData()
    --game.stufftoprint = a:getUserData().." collides with "..b:getUserData()
    game.stufftoprint = astuff[1]..", ("..astuff[2]..") collides with "..bstuff[1]..", ("..bstuff[2]..")."
    if (astuff[1] == 'frog' and bstuff[1] == 'fly') then
        eat(astuff,bstuff)
    elseif (bstuff[1] == 'frog' and astuff[1] == 'fly') then
        eat(bstuff,astuff)
    end
end

function endContact(a,b,coll)
end


function preSolve(a, b, coll)
end
 
function postSolve(a, b, coll, normalimpulse, tangentimpulse)
end
