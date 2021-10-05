
local composer  = require( "composer" )   --�ഫ����
local widget    = require( "widget" )     --���s

local scene = composer.newScene()         --�إ߷s����

function scene:create( event )
      
      local overgroup= self.view
      local function restart_game()
            composer.gotoScene("Play",{ time=500, effect="fade"})
      end
      
      -- --------------------------���s���s------------------------------------------
       local button = widget.newButton 
       {
            defaultFile = "images/red.jpg",                    -- �������s����ܪ��Ϥ�
            overFile = "images/red.jpg",                       -- ���U���s����ܪ��Ϥ�
            label = "Start",                                   -- ���s�W��ܪ���r
            font = native.systemFont,                          -- ���s�ϥΦr��
            labelColor = { default = { 0, 0, 250 } },          -- ���s�r���C��   
            fontSize = 20,                                     -- ���s��r�r��j�p
            emboss = true,                                     -- ����ĪG
            onPress =restart_game,                             -- Ĳ�o���U���s�ƥ�n���檺�禡
            -- onRelease = ,                                   -- Ĳ�o��}���s�ƥ�n���檺�禡
                                                          
       }
       button.x = 160; button.y = 330                          -- ���s�����m
       overgroup:insert(button) 

end

function scene:show(event)

      local overgroup= self.view
      local total_text = display.newText(overgroup,"Your Score:",110,130,system.nativeFont,35)           --Your Score��r
      local total_txt = display.newText(overgroup,0,250,132,system.nativeFont,35)                        --�`����r
      local clear_text = display.newText(overgroup,"Reach         Level",157,200,system.nativeFont,35)   --Clear ...Level��r      
      local clear_txt = display.newText(overgroup,0,164,201,system.nativeFont,35)                        --�������d�Ƥ�r
      local push = display.newText(overgroup,"Push Button To Restart Game",160,270,system.nativeFont,22) --Push Button To Restart Game ��r      
      total_txt:setFillColor( 0/255, 255/255, 255/255 )
      clear_txt:setFillColor( 255/255, 255/255, 0/255 )
      
end




-- "scene:hide()" --����⦸
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
        overgroup:removeSelf()        --����s�ժ���
        overgroup = nil

end
-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )   --�����ɥ��Q�I�s���a��A�i�H�[�J�����ݭn������H�ά۹��������
scene:addEventListener( "show", scene )     --�����n�}�l�B�@���i�J�I�A�b�o�̥i�H�[�J�ݭn������ʧ@
scene:addEventListener( "hide", scene )     --�����n�Q�����ɷ|�I�s�A�]�N�O�n���}������
scene:addEventListener( "destroy", scene )  --�����Q�����ɩI�s

-- -------------------------------------------------------------------------------

return scene
       