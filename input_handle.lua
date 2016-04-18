character_commands = { 'h', 'l', 'j', 'k', 'right', 'left' }

function levelKeyDown(character, level, dt)
    for i, chara in ipairs(character_commands) do
        if love.keyboard.isDown(chara) then
            characterKeyDown(chara,character,level,dt)
        end
    end
end
