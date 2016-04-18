function levelKeyDown(character, level)
        if love.keyboard.isDown('h') then
            characterKeyDown('h',character,level)
        end
        if love.keyboard.isDown('l') then
            characterKeyDown('l',character,level)
        end
        if love.keyboard.isDown('j') then
            characterKeyDown('j',character,level)
        end
        if love.keyboard.isDown('k') then
            characterKeyDown('k',character,level)
        end
end
