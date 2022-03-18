--A file that includes all the functions that execute the game quirks
--This function shortens the paddle after every n seconds
function Shorten(paddle1,paddle2)
  if paddle1.height>10 then
    --shortening the paddles
    paddle1.height = paddle1.height - 10
    paddle2.height = paddle2.height - 10

    --increasing the speed of paddles for coverup
    paddle1.speed = paddle1.speed + 10
    paddle2.speed = paddle2.speed + 10

  else
    paddle1.height = 10
    paddle2.height = 10

  end
end

--if the game is over then we must reset the paddles to their original length
function reset_paddles()
  Paddle1_reset()
  Paddle2_reset()
end
