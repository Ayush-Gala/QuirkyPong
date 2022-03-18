Paddle1 = {}
Paddle1.x = 10
Paddle1.y = 30
Paddle1.width = 5
Paddle1.height = 60
Paddle1.speed = 200

function Paddle1_Movement(dt)

  if (love.keyboard.isDown("w")) then
    Paddle1.y = math.max(0 , Paddle1.y - Paddle1.speed*dt)
  end

  if (love.keyboard.isDown("s")) then
    Paddle1.y = math.min(VIRTUAL_HEIGHT - Paddle1.height , Paddle1.y + Paddle1.speed*dt)
  end

end

function Paddle1_reset()
  Paddle1.x = 10
  Paddle1.y = 30
  Paddle1.width = 5
  Paddle1.height = 60
  Paddle1.speed = 200
end

function render1()
  love.graphics.rectangle('fill', Paddle1.x, Paddle1.y, Paddle1.width, Paddle1.height)
end
