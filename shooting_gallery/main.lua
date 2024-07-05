function love.load()
   target = {}
   target.x = 300
   target.y = 300
   target.radius = 50

   score = 0
   timer = 0
   gameState = 1

   sprites = {}

   sprites.sky = love.graphics.newImage('sprites/sky.png')
   sprites.target = love.graphics.newImage('sprites/target.png')
   sprites.crosshairs = love.graphics.newImage('sprites/crosshairs.png')

   gameFont = love.graphics.newFont(40)

   love.mouse.setVisible(false)


end

function love.update(dt)
    if timer > 0 then
        timer = timer - dt

    end
    if timer < 0 then
       timer = 0
       gameState = 1


    end

end

function love.draw()
    --background
    love.graphics.draw(sprites.sky, 0, 0)

    


    love.graphics.setColor(1,1,1)
    love.graphics.setFont(gameFont)
    love.graphics.print("Score: " .. score, 5, 5)
    love.graphics.print("Time: " .. math.ceil(timer), 300, 5)

    if gameState == 1 then
        love.graphics.printf("click anywhere to begin!", 0, 250, love.graphics.getWidth(), "center")
    end

    if gameState == 2 then 
        love.graphics.draw(sprites.target, target.x - target.radius, target.y - target.radius)
    end
    love.graphics.draw(sprites.crosshairs, love.mouse.getX() - 20, love.mouse.getY() - 20) -- crosshair 
end

function love.mousepressed(x, y, button, istouch, presses)
    if button == 1 and gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 1
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        elseif mouseToTarget > target.radius then
            if score > 0 then
                score = score - 1
            end
        end
    
    elseif  gameState == 1 and button == 1 then
        gameState = 2
        timer = 10
        score = 0
    end

    if button == 2 and gameState == 2 then
        local mouseToTarget = distanceBetween(x, y, target.x, target.y)
        if mouseToTarget < target.radius then
            score = score + 2
            target.x = math.random(target.radius, love.graphics.getWidth() - target.radius)
            target.y = math.random(target.radius, love.graphics.getHeight() - target.radius)
        elseif mouseToTarget > target.radius then
            if timer > 0 then
                timer = timer -1
            end

        end
    end

end

function distanceBetween(x1, y1, x2, y2)
    return math.sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

