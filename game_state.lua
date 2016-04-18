require 'level'

function initGame()
    game = {}
    game.levels = {}
    game.levels[1] = initLevel()
    makeLevelOne(game.levels[1])
    game.character = initCharacter()
    changeShape(game.character, 'fly', game.levels[1])
    game.current_level = 1
    return game
end