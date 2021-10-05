
local composer  = require( "composer" )   --轉換場景
local widget    = require( "widget" )     --按鈕

local scene = composer.newScene()         --建立新場景

function scene:create( event )
      
      local overgroup= self.view
      local function restart_game()
            composer.gotoScene("Play",{ time=500, effect="fade"})
      end
      
      -- --------------------------重新按鈕------------------------------------------
       local button = widget.newButton 
       {
            defaultFile = "images/red.jpg",                    -- 未按按鈕時顯示的圖片
            overFile = "images/red.jpg",                       -- 按下按鈕時顯示的圖片
            label = "Start",                                   -- 按鈕上顯示的文字
            font = native.systemFont,                          -- 按鈕使用字型
            labelColor = { default = { 0, 0, 250 } },          -- 按鈕字體顏色   
            fontSize = 20,                                     -- 按鈕文字字體大小
            emboss = true,                                     -- 立體效果
            onPress =restart_game,                             -- 觸發按下按鈕事件要執行的函式
            -- onRelease = ,                                   -- 觸發放開按鈕事件要執行的函式
                                                          
       }
       button.x = 160; button.y = 330                          -- 按鈕物件位置
       overgroup:insert(button) 

end

function scene:show(event)

      local overgroup= self.view
      local total_text = display.newText(overgroup,"Your Score:",110,130,system.nativeFont,35)           --Your Score文字
      local total_txt = display.newText(overgroup,0,250,132,system.nativeFont,35)                        --總分文字
      local clear_text = display.newText(overgroup,"Reach         Level",157,200,system.nativeFont,35)   --Clear ...Level文字      
      local clear_txt = display.newText(overgroup,0,164,201,system.nativeFont,35)                        --完成關卡數文字
      local push = display.newText(overgroup,"Push Button To Restart Game",160,270,system.nativeFont,22) --Push Button To Restart Game 文字      
      total_txt:setFillColor( 0/255, 255/255, 255/255 )
      clear_txt:setFillColor( 255/255, 255/255, 0/255 )
      
end




-- "scene:hide()" --執行兩次
function scene:hide( event )

    local phase = event.phase

    if ( phase == "will" ) then   

    elseif ( phase == "did" ) then
        composer.removeScene("Gameover")
    end
end


-- "scene:destroy()"
function scene:destroy( event )

        local overgroup = self.view   
        overgroup:removeSelf()        --釋放群組物件
        overgroup = nil

end
-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )   --場景時先被呼叫的地方，可以加入場景需要的物件以及相對應的函數
scene:addEventListener( "show", scene )     --場景要開始運作的進入點，在這裡可以加入需要的執行動作
scene:addEventListener( "hide", scene )     --場景要被切換時會呼叫，也就是要離開場景時
scene:addEventListener( "destroy", scene )  --場景被移除時呼叫

-- -------------------------------------------------------------------------------

return scene
       