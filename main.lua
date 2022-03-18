push = require 'push'

-- our Paddle files, which stores position and dimensions for each Paddle
-- and the logic for rendering them
require 'Paddle1'--the left paddle
require 'Paddle2' --the right paddle

-- our Ball file, which isn't much different than a Paddle structure-wise
-- but which will mechanically function very differently
require 'Ball'

--our quirks file which will shorten the length of the paddle every n seconds
require 'Quirks'

--some basic global variables
VIRTUAL_WIDTH = 800
VIRTUAL_HEIGHT = 500
gameState = 'start'
timer_delay = 15
timeleft = 15
timer = 0

--[[
    Runs when the game first starts up, only once; used to initialize the game.
]]
function love.load()

    WINDOW_WIDTH,WINDOW_HEIGHT=love.window.getMode()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- the title of our application window
    love.window.setTitle('Pong')

    --makes the math.random calls truly randomized
    math.randomseed(os.time())

    -- more retro-looking font
    smallFont = love.graphics.newFont('font.ttf', 20)

    -- larger font
    scoreFont = love.graphics.newFont('font.ttf', 60)

    -- set the active font to the smallFont obect
    love.graphics.setFont(smallFont)

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = true,
        resizable = true,
        vsync = true
    })

    -- initialize score variables
    player1Score = 0
    player2Score = 0

    -- game state variable used to transition between different parts of the game
    -- (used for beginning, menus, main game, high score list, etc.)
    gameState = 'start'
end

function love.resize(w,d)
  push:resize(w,d)
end


function love.update(dt)

    if gameState == 'play' then
        -- detect ball collision with paddles
        --update the timer so that the quirks work well
        On_Collision(Paddle1,Paddle2)
        timer = timer + dt
        timeleft = timer_delay-timer
        if timer>timer_delay then
          Shorten(Paddle1,Paddle2)
          timer = 0
        end
    end

    -- if we reach the left or right edge of the screen,
    -- go back to start and update the score
    Ball_Point()

    --updating the movement of all entities and scores/texts
    if gameState == 'play' then
        Ball_Movement(dt)
    end

    Paddle1_Movement(dt)
    Paddle2_Movement(dt)
end


function love.keypressed(key)

    if key == 'escape' then
        --terminate application
        love.event.quit()
    -- if we press enter during the start state of the game, we'll go into play mode
    elseif key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
        else
            gameState = 'start'

            --reset the ball to its original place and values
            reset_position()
        end
    end
end


function love.draw()
    -- begin rendering at virtual resolution
    push:apply('start')

    -- clear the screen with a specific color; purple
    love.graphics.clear(80/255, 30/255, 92/255, 255/255)

    -- draw different things based on the state of the game
    love.graphics.setFont(smallFont)

    -- draw score on the left and right center of the screen
    -- need to switch font to draw before actually printing
    love.graphics.setFont(scoreFont)
    love.graphics.print(tostring(player1Score), VIRTUAL_WIDTH / 2 - 50,
        VIRTUAL_HEIGHT / 3)
    love.graphics.print(tostring(player2Score), VIRTUAL_WIDTH / 2 + 30,
        VIRTUAL_HEIGHT / 3)

    -- render paddles
    render1()
    render2()

    -- render ball
    Ball_render()

    -- function just to display the FPS
    displayFPS()
    if gameState == 'play' then
      displayTimer()
    end

    -- end rendering at virtual resolution
    push:apply('end')
end

--[[
    To render the current FPS
]]
function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255/255, 0, 255/255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end


function displayTimer()
  love.graphics.setFont(smallFont)
  love.graphics.setColor(0, 255/255, 0, 255/255)
  love.graphics.print('The paddles shorten in- ' .. tostring(math.floor(timeleft+0.5)), 320, 10)
end
