

function flyKeyDown(key,level,dt)
    if key == 'k' then --up
        level.objects.character.body:applyForce(0,-5)
    elseif key == 'j' then --down
        level.objects.character.body:applyForce(0,5)
    elseif key == 'h' then --left
        level.objects.character.body:applyForce(-5,0)
    elseif key == 'l' then --right
        level.objects.character.body:applyForce(5,0)
    end
end

function snakeKeyDown(key,level,dt)
    if key == 'k' then --up
        level.objects.character.head:applyForce(0,-250)
    elseif key == 'j' then --down
        level.objects.character.head:applyForce(0,250)
    elseif key == 'h' then --left
        level.objects.character.head:applyForce(-250,0)
    elseif key == 'l' then --right
        level.objects.character.head:applyForce(250,0)
    end
end

function frogKeyDown(key,level,dt)
    if key == 'h' then --left
        level.objects.character.body:applyForce(-200,0)
    elseif key == 'l' then --right
        level.objects.character.body:applyForce(200,0)
    elseif key == 'right' then --increment jump angle
        character.jump_angle = math.min(0,character.jump_angle+(0.25*dt))
    elseif key == 'left' then --decrement jump angle
        character.jump_angle = math.max(0-math.pi,character.jump_angle-(0.25*dt))
    end
end

function frogKeyPressed(key,character,level)
    if key == 'j' then
        if character.energy > 0 then
            if character.energy > 2 then
                j = 600
            else
                j = 150
            end
            level.objects.character.body:applyLinearImpulse(j*math.cos(character.jump_angle),j*math.sin(character.jump_angle))
            character.energy = math.max(0,character.energy - 0.025)
        end
    end
end


function characterKeyDown(key,character,level,dt)
    if character.shape == 'fly' then
        flyKeyDown(key,level,dt)
    elseif character.shape == 'frog' then
        frogKeyDown(key,level,dt)
    elseif character.shape == 'snake' then
        snakeKeyDown(key,level,dt)
    end
end

function equipKeyDownEffects(key, level)
end

function characterKeyPressed(key,character,level)
    if character.shape == 'frog' then
        frogKeyPressed(key,character,level)
    end
end
