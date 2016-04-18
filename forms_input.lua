

function flyKeyDown(key,level)
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

function snakeKeyDown(key,level)
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

function characterKeyDown(key,character,level)
    if character.shape == 'fly' then
        flyKeyDown(key,level)
    elseif character.shape == 'snake' then
        snakeKeyDown(key,level)
    end
end

function equipKeyDownEffects(key, level)
end
