local composer  = require( "composer" )   --轉換場景
local scene = composer.newScene()         --建立新場景

--creat--
function scene:create( event )
     
      local scenegroup=self.view
      --背景音樂--
      local backgroundmusic=audio.loadStream("images/background.wav")
      local gameovermusic=audio.loadStream("images/background_1.wav")
      audio.setVolume(1,{channel=1})
      audio.setVolume(0,{channel=2})
      audio.play(backgroundmusic,{channel=1,loops=-1})
      audio.play(gameovermusic,  {channel=2,loops=-1})
      audio.pause(2)
      
      --Menu文字--
      local tap= display.newText(scenegroup,"~Tap to Continue~",160,490,system.nativeFont,35)
      tap.alpha=0.4
 
      local function effect()
           if tap.alpha>0.35 then
              tap.alpha=0.3
           else
              tap.alpha=0.4
           end 
      end
      local tap_effect=timer.performWithDelay(150,effect,-1)
      
      --背景圖片--
      local picture= display.newImageRect(scenegroup,"images/menu.jpg", 320, 570 )
      picture.x=160
      picture.y=240
      picture:toBack()
end



--show--
function scene:show( event )
if event.phase=="will" then
-- --------無----------------
elseif event.phase=="did" then
      
      local first=0 --僅一次觸碰
      local scenegroup=self.view
      local tapsound= audio.loadSound("images/pop.wav")
      
      local function ontouch(event)
      if event.phase=="began" and first==0 then
          first=1
          audio.play(tapsound)
          local function call()
          composer.gotoScene("Play")
          end
          transition.fadeOut(scenegroup,{time=500})
          timer.performWithDelay(500,call,1)
      end
      end 
      Runtime:addEventListener("touch",ontouch)
end
end

--hide--
function scene:hide( event ) 

      local phase = event.phase
      if ( phase == "will" ) then 
      elseif ( phase == "did" ) then
      composer.removeScene("Star")
      end 
end

--destroy--
function scene:destroy( event )

      local scenegroup = self.view   
      scenegroup:removeSelf()   
      scenegroup = nil
      
end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )   --場景時先被呼叫的地方，可以加入場景需要的物件以及相對應的函數
scene:addEventListener( "show", scene )     --場景要開始運作的進入點，在這裡可以加入需要的執行動作
scene:addEventListener( "hide", scene )     --場景要被切換時會呼叫，也就是要離開場景時
scene:addEventListener( "destroy", scene )  --場景被移除時呼叫

-- -------------------------------------------------------------------------------

return scene