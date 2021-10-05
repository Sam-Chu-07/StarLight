local composer  = require( "composer" )   --�ഫ����
local scene = composer.newScene()         --�إ߷s����

--creat--
function scene:create( event )
     
      local scenegroup=self.view
      --�I������--
      local backgroundmusic=audio.loadStream("images/background.wav")
      local gameovermusic=audio.loadStream("images/background_1.wav")
      audio.setVolume(1,{channel=1})
      audio.setVolume(0,{channel=2})
      audio.play(backgroundmusic,{channel=1,loops=-1})
      audio.play(gameovermusic,  {channel=2,loops=-1})
      audio.pause(2)
      
      --Menu��r--
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
      
      --�I���Ϥ�--
      local picture= display.newImageRect(scenegroup,"images/menu.jpg", 320, 570 )
      picture.x=160
      picture.y=240
      picture:toBack()
end



--show--
function scene:show( event )
if event.phase=="will" then
-- --------�L----------------
elseif event.phase=="did" then
      
      local first=0 --�Ȥ@��Ĳ�I
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
scene:addEventListener( "create", scene )   --�����ɥ��Q�I�s���a��A�i�H�[�J�����ݭn������H�ά۹��������
scene:addEventListener( "show", scene )     --�����n�}�l�B�@���i�J�I�A�b�o�̥i�H�[�J�ݭn������ʧ@
scene:addEventListener( "hide", scene )     --�����n�Q�����ɷ|�I�s�A�]�N�O�n���}������
scene:addEventListener( "destroy", scene )  --�����Q�����ɩI�s

-- -------------------------------------------------------------------------------

return scene