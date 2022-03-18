Ball = {}

Ball.x = VIRTUAL_WIDTH / 2 - 2
Ball.y = VIRTUAL_HEIGHT / 2 - 2
Ball.width = 4
Ball.height = 4

-- these variables are for keeping track of our velocity on both the
-- X and Y axis, since the ball can move in two dimensions
Ball.dy = math.random(2) == 1 and -10 or 10
Ball.dx = math.random(2) == 1 and math.random(-100, -200) or math.random(100, 200)


--[[
    Expects a paddle as an argument and returns true or false, depending
    on whether their rectangles overlap.
]]
function Collision(paddle)
  return Ball.x<paddle.x+paddle.width and
       Ball.x+Ball.width>paddle.x and
       Ball.y<paddle.y+paddle.height and
       Ball.y+Ball.height>paddle.y
end


function On_Collision(paddle1, paddle2)
  if(Collision(paddle1)) then
    Ball.dx = -Ball.dx * 1.05
    Ball.x = paddle1.x + 4

  elseif(Collision(paddle2)) then
    Ball.dx = -Ball.dx*1.05
    Ball.x = paddle2.x - 4

  end


  -- keep velocity going in the same direction, but randomize it
  if Ball.dy < 0 then
      Ball.dy = -math.random(100, 200)
  else
      Ball.dy = math.random(100, 200)
  end
end
--[[
    Places the ball in the middle of the screen, with an initial random velocity
    on both axes.
]]
function reset_position()
    Ball.x = VIRTUAL_WIDTH / 2 - 2
    Ball.y = VIRTUAL_HEIGHT / 2 - 2
    Ball.dy = math.random(2) == 1 and -10 or 10
    Ball.dx = math.random(2) == 1 and math.random(-100, -200) or math.random(100, 200)
end

--[[
    Simply applies velocity to position, scaled by deltaTime.
]]
function Ball_Movement(dt)

    Ball.x = Ball.x + Ball.dx * dt
    Ball.y = Ball.y + Ball.dy * dt
-- detect upper and lower screen boundary collision and reverse if collided
    if Ball.y <= 0 then
        Ball.y = 0
        Ball.dy = -Ball.dy
    end

    -- -4 to account for the ball's size
    if Ball.y >= VIRTUAL_HEIGHT - 4 then
        Ball.y = VIRTUAL_HEIGHT - 4
        Ball.dy = -Ball.dy
    end
end

function Ball_Point()
  if Ball.x < 0 then
      servingPlayer = 1
      player2Score = player2Score + 1
      reset_position()
      reset_paddles()
      gameState = 'start'
      timer = 0
  end

  if Ball.x > VIRTUAL_WIDTH then
      servingPlayer = 2
      player1Score = player1Score + 1
      reset_position()
      reset_paddles()
      gameState = 'start'
      timer = 0
  end
end


function Ball_render()
    love.graphics.rectangle('fill', Ball.x, Ball.y, Ball.width, Ball.height)
end
