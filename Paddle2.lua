VIRTUAL_WIDTH = 800
VIRTUAL_HEIGHT = 500
Paddle2 = {}
Paddle2.x = VIRTUAL_WIDTH-10
Paddle2.y = VIRTUAL_HEIGHT-70
Paddle2.width = 5
Paddle2.height = 60
Paddle2.speed = 200

function Paddle2_Movement(dt)
  if (love.keyboard.isDown("up")) then
    Paddle2.y = math.max(0 , Paddle2.y - Paddle2.speed*dt)
  end

  if (love.keyboard.isDown("down")) then
    Paddle2.y = math.min(VIRTUAL_HEIGHT - Paddle2.height , Paddle2.y + Paddle2.speed*dt)
  end

end

function Paddle2_reset()
  Paddle2.x = VIRTUAL_WIDTH - 10
  Paddle2.y = VIRTUAL_HEIGHT - 70
  Paddle2.width = 5
  Paddle2.height = 60
  Paddle2.speed = 200
end

function render2()
  love.graphics.rectangle('fill', Paddle2.x, Paddle2.y, Paddle2.width, Paddle2.height)
end
