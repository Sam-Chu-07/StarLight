local composer  = require( "composer" )   --�ഫ����
local widget    = require( "widget" )     --���s
math.randomseed (os.time())               --�üƺؤl

local scene = composer.newScene()         --�إ߷s����

function scene:create (event)
end

function scene:hide   (event)  
end

function scene:destroy(event)
end


--show--
function scene:show( event )
if ( "will" == event.phase ) then
-- ------------�L------------------
elseif ( "did" == event.phase ) then

      ---------------------���ĻP����--------------------------------     
      local eliminationsound=audio.loadSound("images/pop_1.wav")          
      local tapsound= audio.loadSound("images/pop.wav")
      -----------------------�C���D�[�c�ܼ�-----------------------------      
      local color={{},{},{},{},{},{},{},{},{}}  --�N�J�y�� ���C��
      local name ={{},{},{},{},{},{},{},{},{}}  --�N�J�y�� ���W��
      local pos  ={}                            --�N�J�W�� ���y��
      local arrived=0                           --(���U��)���ʬO�_����
      local hp=3                                --��q
      local scores=0                            --����
      local level=1                             --�ثe����
      local difficulty=2                        --�P�P�C���
      local button                              --���s�@�������s
      local apple=0                             --�C�������P�P���Ӽ�
      local object={"images/red.jpg",           --�Ϥ��]�m
                   "images/orange.jpg",
                   "images/purple.jpg",
                   "images/green.jpg",
                   "images/indigo.jpg",
                   "images/blue.jpg",
                   "images/pink.jpg",
                   "images/blood.png",
                   37}                           
      local restart_game =function()
      end
      local gameover     =function()
      end
      local complete     =function()
      end
      local remained     =function()
      end
      ------------------------------------------------------------------
      
      ---------------------�D�� & ���D �ܼ�-----------------------------
      local quota={29,23,18,14,11,9}            --(���U�Ѽ�)�C��ƶq�]�m
      local t                                   --(���U��)�p�⭫�s�X�D����
      local c                                   --�X�D�C��
      local px                                  --�X�Dx�y��
      local py                                  --�X�Dy�y��     
      local shape                               --�P�P�ƦC�Ϊ�
      local column={0,0,0,0,0,0,0,0,0}          --�C�C�ثe�P�P��                                          
      local color_box={0,0,0,0,0,0,0}           --�ثe�U���C��ƶq
      local random_height=9                     --(���U�Ѽ�)��m�H���C�⪺row��
      local try_solute=500                      --(���U�Ѽ�)���D���ƤW��
      local copy={{},{},{},{},{},{},{},{},{}}   --�ƥ��D���C��
      local topic_set    =function()            --�D�ذѼƽվ�禡
      end
      local creat_topic  =function()            --�}�l�]�p�D�ب禡
      end
      local color_divide =function()            --�������t�C��禡
      end
      -------------------------------------------------------------------
      
      -----------------------�����ܼ�------------------------------------
      local prompt=3                            --���ܦ���
      local answer={}                           --�ѵ�
      local backup_score=0                      --�ƥ�����
      local can_prompt=0                        --���洣��
      local show_prompt=function()
      end
      -------------------------------------------------------------------


      -- -------------------------------------------------------
                        --��r & �Ϥ�--
      -- -------------------------------------------------------
      --�]�m����s��--  
      local playgroup= display.newGroup()
      local overgroup= display.newGroup()
      local stargroup= display.newGroup()
      
      -- �C�����ϥ�--
      local level_text = display.newText(playgroup,"Level",265,40,system.nativeFont,20)   --Level��r                                
      local level_txt = display.newText(playgroup,level,303,40,system.nativeFont,20)      --���Ť�r             
      local score_text = display.newText(playgroup,"Score:",205,-8,system.nativeFont,25)  --Score ��r      
      local score_txt = display.newText(playgroup,scores,275,-7,system.nativeFont,25)     --���Ƥ�r
      local status = display.newText("Start",160,120,system.nativeFont,55)                --��� Clear �� Fail ��r 
      local hint = display.newText(playgroup,"x "..prompt,60,63,system.nativeFont,20)     --���ܳѾl���Ƥ�r
      score_text:setFillColor(0/255,0/255,0/255)
      score_txt:setFillColor( 0/255,0/255,0/255)
      level_text.alpha=0;level_txt.alpha=0
      score_text.alpha=0;score_txt.alpha=0
      status.alpha=0;hint.alpha=0
      transition.to(level_text,{time=1000,alpha=0.6,delay=1700})
      transition.to(level_txt, {time=1000,alpha=0.6,delay=1700})
      transition.to(score_text,{time=1000,alpha=1,  delay=1700})
      transition.to(score_txt, {time=1000,alpha=1,  delay=1700})

      --GameOver�ϥ�--
      local total_text = display.newText(overgroup,"Your Score:",110,130,system.nativeFont,35)           --Your Score��r
      local total_txt = display.newText(overgroup,0,250,132,system.nativeFont,35)                        --�`����r
      local clear_text = display.newText(overgroup,"Reach         Level",157,200,system.nativeFont,35)   --Clear ...Level��r      
      local clear_txt = display.newText(overgroup,0,164,201,system.nativeFont,35)                        --�������d�Ƥ�r
      local push = display.newText(overgroup,"Push Button To Restart Game",160,270,system.nativeFont,22) --Push Button To Restart Game ��r      
      total_txt:setFillColor( 0/255, 255/255, 255/255 )
      clear_txt:setFillColor( 255/255, 255/255, 0/255 )
      overgroup.alpha=0
            

      --�ѪŹϤ��]�m--
      local sky = display.newImageRect(playgroup,"images/sky1.png", 320, 75 ) 
            sky.x = 160
            sky.y = -15
            sky.alpha=0
            sky:toBack()
      
      --��q�Ϥ��]�m--
      --�u���3�w��--      
      local blood1 = display.newImageRect(playgroup,object[8], 35, 35 ) 
            blood1.x = 20
            blood1.y = -10            
            blood1.alpha=0
            
      local blood2 = display.newImageRect(playgroup,object[8], 35, 35 )
            blood2.x = blood1.x+30
            blood2.y = blood1.y
            blood2.alpha=0
                  
      local blood3 = display.newImageRect(playgroup,object[8], 35, 35 )
            blood3.x = blood1.x+60
            blood3.y = blood1.y
            blood3.alpha=0
            
      local blood4 = display.newImageRect(playgroup,object[8], 35, 35 )
            blood4.x = blood1.x+90
            blood4.y = blood1.y
            blood4.alpha=0
            
      local blood5 = display.newImageRect(playgroup,object[8], 35, 35 )
            blood5.x = blood1.x+120
            blood5.y = blood1.y
            blood5.alpha=0
      
      --���ܿO�w--
      local bulb = display.newImageRect( playgroup,"images/bulb.png", 80, 80 )
            bulb.x = 25
            bulb.y = 50 
            bulb.alpha=0
         
      transition.to(sky,{time=1000 ,alpha=0.7,delay=1700})
      transition.to(blood1,{time=1000,alpha=1,delay=1700})
      transition.to(blood2,{time=1000,alpha=1,delay=1700})
      transition.to(blood3,{time=1000,alpha=1,delay=1700})

      
      
      
      ----------------------
          --show Score--
      ----------------------
      local function show_score(a)
          
          --�֥[����--
          local function plusing()
                scores=scores+a
                score_txt.text=scores                 
          end
          timer.performWithDelay(20,plusing,a)
          
          --��ܥ[�W����--
          local plus=display.newText("+ "..a*a,160,180,system.nativeFont,28)
          if a>1 and a<5 then
          plus:setFillColor( 255/255, 255/255, 255/255)  
          else
          plus:setFillColor( 255/255, 255/255, 0/255)
          end 
          plus.alpha=1 
          transition.to(plus,{time=700, y=40,alpha=0})
          local function delet()
               plus:removeSelf()
               plus=nil
          end
          timer.performWithDelay(700,delet,1)
      end
      

      ---------------------------------------------------
                 --��q�Ƚվ�P������w��ܩή���--
      ---------------------------------------------------
      local function change_HP (value)                         
                 
            if value==1 then--�W�[1�R
                      
               if hp==0 then
                  transition.fadeIn(blood1, { time=1000 } )
               elseif hp==1 then
                  transition.fadeIn(blood2, { time=1000 } )
               elseif hp==2 then
                  transition.fadeIn(blood3, { time=1000 } )
               elseif hp==3 then
                  transition.fadeIn(blood4, { time=1000 } )
               elseif hp==4 then
                  transition.fadeIn(blood5, { time=1000 } )
               end
               
               if hp<5 then--�Y�ثe��q�j��5,��q����
                  hp=hp+1  --�Ϥ��[1��q
               end
                          
            elseif value==-1 then--���1�R
                
               if hp==1 then
                  transition.to(blood1, { time=1000,alpha=0.1} )
               elseif hp==2 then
                  transition.to(blood2, { time=1000,alpha=0.1} )
               elseif hp==3 then
                  transition.to(blood3, { time=1000,alpha=0.1} )
               elseif hp==4 then
                  transition.to(blood4, { time=1000,alpha=0.1} )
               elseif hp==5 then
                  transition.to(blood5, { time=1000,alpha=0.1} )
               end
                 
               hp=hp-1 --���1��q

            end
   
      end 
      


      -------------------------------------------
                   --�H���]�m�C��--
      -------------------------------------------
      local function set_color()
            local i
            local j   
            for i=1,random_height do
            for j=1,9 do
            color[i][j]=color_divide()
            column[j]=column[j]+1
            color_box[color[i][j]]=color_box[color[i][j]]+1
            end
            end    
      end
      


      --  --------------------------------------
                   --�����ؼЬP�P--
      --  --------------------------------------
      
      local function remove (number)  --�N�J�s��
      
           object[number]=nil
           if number==11 then
                  star11:removeSelf()
                  star11=nil
           elseif number==12 then
                  star12:removeSelf()
                  star12=nil
           elseif number==13 then
                  star13:removeSelf()
                  star13=nil
           elseif number==14 then
                  star14:removeSelf()
                  star14=nil
           elseif number==15 then
                  star15:removeSelf()
                  star15=nil
           elseif number==16 then
                  star16:removeSelf()
                  star16=nil
           elseif number==17 then
                  star17:removeSelf()
                  star17=nil
           elseif number==18 then
                  star18:removeSelf()
                  star18=nil
           elseif number==19 then
                  star19:removeSelf()
                  star19=nil                                                 
           elseif number==21 then
                  star21:removeSelf()
                  star21=nil
           elseif number==22 then
                  star22:removeSelf()
                  star22=nil
           elseif number==23 then
                  star23:removeSelf()
                  star23=nil
           elseif number==24 then
                  star24:removeSelf()
                  star24=nil
           elseif number==25 then
                  star25:removeSelf()
                  star25=nil
           elseif number==26 then
                  star26:removeSelf()
                  star26=nil
           elseif number==27 then
                  star27:removeSelf()
                  star27=nil
           elseif number==28 then
                  star28:removeSelf()
                  star28=nil
           elseif number==29 then
                  star29:removeSelf()
                  star29=nil                                                 
           elseif number==31 then
                  star31:removeSelf()
                  star31=nil
           elseif number==32 then
                  star32:removeSelf()
                  star32=nil
           elseif number==33 then
                  star33:removeSelf()
                  star33=nil
           elseif number==34 then
                  star34:removeSelf()
                  star34=nil
           elseif number==35 then
                  star35:removeSelf()
                  star35=nil
           elseif number==36 then
                  star36:removeSelf()
                  star36=nil
           elseif number==37 then
                  star37:removeSelf()
                  star37=nil
           elseif number==38 then
                  star38:removeSelf()
                  star38=nil
           elseif number==39 then
                  star39:removeSelf()
                  star39=nil                                                 
           elseif number==41 then
                  star41:removeSelf()
                  star41=nil
           elseif number==42 then
                  star42:removeSelf()
                  star42=nil
           elseif number==43 then
                  star43:removeSelf()
                  star43=nil
           elseif number==44 then
                  star44:removeSelf()
                  star44=nil
           elseif number==45 then
                  star45:removeSelf()
                  star45=nil
           elseif number==46 then
                  star46:removeSelf()
                  star46=nil
           elseif number==47 then
                  star47:removeSelf()
                  star47=nil
           elseif number==48 then
                  star48:removeSelf()
                  star48=nil
           elseif number==49 then
                  star49:removeSelf()
                  star49=nil                                                 
           elseif number==51 then
                  star51:removeSelf()
                  star51=nil
           elseif number==52 then
                  star52:removeSelf()
                  star52=nil
           elseif number==53 then
                  star53:removeSelf()
                  star53=nil
           elseif number==54 then
                  star54:removeSelf()
                  star54=nil
           elseif number==55 then
                  star55:removeSelf()
                  star55=nil
           elseif number==56 then
                  star56:removeSelf()
                  star56=nil
           elseif number==57 then
                  star57:removeSelf()
                  star57=nil
           elseif number==58 then
                  star58:removeSelf()
                  star58=nil
           elseif number==59 then
                  star59:removeSelf()
                  star59=nil                                                 
           elseif number==61 then
                  star61:removeSelf()
                  star61=nil
           elseif number==62 then
                  star62:removeSelf()
                  star62=nil
           elseif number==63 then
                  star63:removeSelf()
                  star63=nil
           elseif number==64 then
                  star64:removeSelf()
                  star64=nil
           elseif number==65 then
                  star65:removeSelf()
                  star65=nil
           elseif number==66 then
                  star66:removeSelf()
                  star66=nil
           elseif number==67 then
                  star67:removeSelf()
                  star67=nil
           elseif number==68 then
                  star68:removeSelf()
                  star68=nil
           elseif number==69 then
                  star69:removeSelf()
                  star69=nil                                                         
           elseif number==71 then
                  star71:removeSelf()
                  star71=nil
           elseif number==72 then
                  star72:removeSelf()
                  star72=nil
           elseif number==73 then
                  star73:removeSelf()
                  star73=nil
           elseif number==74 then
                  star74:removeSelf()
                  star74=nil
           elseif number==75 then
                  star75:removeSelf()
                  star75=nil
           elseif number==76 then
                  star76:removeSelf()
                  star76=nil
           elseif number==77 then
                  star77:removeSelf()
                  star77=nil
           elseif number==78 then
                  star78:removeSelf()
                  star78=nil
           elseif number==79 then
                  star79:removeSelf()
                  star79=nil                                                 
           elseif number==81 then
                  star81:removeSelf()
                  star81=nil
           elseif number==82 then
                  star82:removeSelf()
                  star82=nil
           elseif number==83 then
                  star83:removeSelf()
                  star83=nil
           elseif number==84 then
                  star84:removeSelf()
                  star84=nil
           elseif number==85 then
                  star85:removeSelf()
                  star85=nil
           elseif number==86 then
                  star86:removeSelf()
                  star86=nil
           elseif number==87 then
                  star87:removeSelf()
                  star87=nil
           elseif number==88 then
                  star88:removeSelf()
                  star88=nil
           elseif number==89 then
                  star89:removeSelf()
                  star89=nil                                                 
           elseif number==91 then
                  star91:removeSelf()
                  star91=nil
           elseif number==92 then
                  star92:removeSelf()
                  star92=nil
           elseif number==93 then
                  star93:removeSelf()
                  star93=nil
           elseif number==94 then
                  star94:removeSelf()
                  star94=nil
           elseif number==95 then
                  star95:removeSelf()
                  star95=nil
           elseif number==96 then
                  star96:removeSelf()
                  star96=nil
           elseif number==97 then
                  star97:removeSelf()
                  star97=nil
           elseif number==98 then
                  star98:removeSelf()
                  star98=nil
           elseif number==99 then
                  star99:removeSelf()
                  star99=nil                                                 
           end
      end 
    
      
      
      --------------------------------------------------------------------
                 --check go to next level--
      --------------------------------------------------------------------
      --�ˬd�O�_�ٯ��~�����--
      local function checking(event)
           
           local i
           local j
           if color[1][1]==nil then
              return "complete"
           end
           for j=1,9 do
           for i=1,9 do
               if color[i][j]~=nil then
                    if (i~=9 and color[i][j]==color[i+1][j]) or (j~=9 and color[i][j]==color[i][j+1]) then
                        return 1
                    end
               else
                    if i==1 then
                       return "remained"
                    end
                    break;
               end
           end
           end
           
           return "remained"
      end
      
        
        
      ------------------------------------------------------
                   --move down the stars--
      ------------------------------------------------------
      local function  move_down ( target , moves ) --�N�J�s��
       
            transition.to(object[target], {time=500, y=object[target].y+(moves)*35})
 
      end 
     
     
     
      -- ---------------------------------------------------
                  --move beside the stars--
      -- ---------------------------------------------------
      local function move_beside (target , moves) --�N�J�s��

            transition.to(object[target], {time=500, x=object[target].x-(moves)*35})
            
      end
      
      

      ------------------------------------------------- 
              --�Ҧ��P�P�w��������&�O�_�i�J�U�@��--  
      -------------------------------------------------
      local function all_arrived()                 

            local phase=checking() --�T�{���A
            if phase==1 then
              
                   arrived=1       --��������
                   return     
            
            elseif phase=="complete" then---------------------------------��������
                                  
                   status.text="Clear"                          --status���Clear
                   transition.to(status,{time=200,alpha=0.7})   --��status��0.2��H�J
                   if bulb.alpha==1 then                        --���ܲ���ܮĪG
                      transition.to(bulb,{time=500,alpha=0.3})       
                      transition.to(hint,{time=500,alpha=0.2})      
                   end
                   timer.performWithDelay(200,complete,1)       --����0.2��� �I�scomplete 
                                           
            elseif phase=="remained" then-----------------------------�L�k�~�����
            
                   if hp~=0 then                                     
                      status.text="Fail"      --status���Fail
                   else                                
                      status.text="Game Over" --status���Fail
                   end
                       
                   if bulb.alpha==1 then                        --���ܲ���ܮĪG
                      transition.to(bulb,{time=500,alpha=0.3})       
                      transition.to(hint,{time=500,alpha=0.2})      
                   end     
                   transition.to(status,{time=200,alpha=0.7})   --��status��0.2��H�J
                   timer.performWithDelay( 1000, remained , 1 ) --(���a�i�ݨ�Ѿl���P�P1��)
            end
      end
     
    
      
      --  -------------------------------
               --y��V��z�P����--
      --  -------------------------------
      local function sort_y()
     
            local i
            local j
            local k
            local is_y_move=0
            
            for i=1,8 do  -- i �� y�b(���k) �n�ɪ���column
            if name[1][i]==nil then
                 
                   for j=i+1,9 do  --j �� y�b(���k) �n����column
                        if name[1][j]~=nil then
                              for k=1,9 do  --k ����column��x�b �q�U��W ���ʨ����
                              
                                  if name[k][j]==nil then
                                     break
                                  end
                                  name[k][i]=name[k][j]
                                  name[k][j]=nil
                                  pos[name[k][i]]=k*10+i  
                                  move_beside(name[k][i],j-i)                                       
                                  color[k][i]=color[k][j]
                                  color[k][j]=nil

                              end
                              is_y_move=1 
                              break;
                        end
                   end
            end
            end
            
            if is_y_move==0 then
                timer.performWithDelay( 100, all_arrived , 1 )
            else
                timer.performWithDelay( 500+10, all_arrived , 1 )
            end
            
 
      end
      
      
      
      
      -----------------------------------
              --x��V��z�P����--
      -----------------------------------
      local function sort_x()   
            
            local i=0
            local j=0
            local k=0
            local is_x_move=0
            for i=1,8 do
            for j=1,9 do     
            if name[i][j]==nil then
               for k=i+1,9 do
                   if name[k][j]~=nil then
                   
                      name[i][j]=name[k][j]
                      name[k][j]=nil
                      pos[name[i][j]]=i*10+j                  
                      move_down(name[i][j],k-i)
                      color[i][j]=color[k][j]
                      color[k][j]=nil
                      is_x_move=1
                      break
                      
                   end
               end
            end
            end
            end  

           if is_x_move==0 then
               timer.performWithDelay( 100, sort_y , 1 )            
           else
               timer.performWithDelay( 500+10, sort_y , 1 )
           end 
      end
      
      


      --  --------------------------
                --�p�����--
      --  --------------------------
      local function calculate_elimination (position) --�N�J��m
            
            local x=math.modf(position/10)
            local y=math.mod(position,10)  
           
            remove(name[x][y])
            apple=apple+1                --�����Ӽ�+1
            pos[name[x][y]]=nil
            name[x][y]=nil
            
            if  (x~=9  and  name[x+1][y]~=nil) and color[x][y]==color[x+1][y] then
                calculate_elimination((x+1)*10+y)
            end 
            
            if (x~=1  and  name[x-1][y]~=nil) and color[x][y]==color[x-1][y] then
               calculate_elimination((x-1)*10+y)
            end  
             
            if (y~=9  and  name[x][y+1]~=nil) and color[x][y]==color[x][y+1] then
               calculate_elimination(x*10+y+1)
            end 
            
            if (y~=1  and  name[x][y-1]~=nil) and color[x][y]==color[x][y-1] then
               calculate_elimination(x*10+y-1)
            end  
            
            color[x][y]=nil 
      end
     


      ---------------------------------------------
                  --�P�_�ؼЬO�_�i�Q����--
      ---------------------------------------------
      local function check_alone (position)  --�N�J��m
      
            local x=math.modf(position/10)
            local y=math.mod(position,10)  
            
            if  (x~=9  and  color[x][y]==color[x+1][y]) or (x~=1  and color[x][y]==color[x-1][y]) or (y~=9  and  color[x][y]==color[x][y+1]) or (y~=1  and  color[x][y]==color[x][y-1])then
                  return 1
            else  
                  return 0  
            end 
      end

      --  ------------------------------
                   --�I���ؼ�--
      --  ------------------------------
      local function touching (target)  --�N�J�s��
      return function(event)
      
             local phase=event.phase   
             if   arrived ==1 and "began"==phase then
                  if check_alone(pos[target])==1 then
                  apple=0                                    --�o���o����l
                  arrived=0                                  --���ʤ�,�L�k�I������
                  audio.play(eliminationsound,{loops=0})     --���h���n��
                  calculate_elimination(pos[target])         --�p��һݮ������P�P
                  show_score(apple)                          --��֥ܲ[����             
                  sort_x()                                   --��z�ò��ʬP�P��x��V
                  end
             end      
      end
      end
 





      ----------------------------------- 
                --�]�m�P�P�Ϥ�--                        
      -----------------------------------
      local function creat_star()                                                  
      
            star11 = display.newImageRect( stargroup, object[color[1][1]], object[9], object[9] )    
            star12 = display.newImageRect( stargroup, object[color[1][2]], object[9], object[9] )   
            star13 = display.newImageRect( stargroup, object[color[1][3]], object[9], object[9] )     
            star14 = display.newImageRect( stargroup, object[color[1][4]], object[9], object[9] )    
            star15 = display.newImageRect( stargroup, object[color[1][5]], object[9], object[9] )   
            star16 = display.newImageRect( stargroup, object[color[1][6]], object[9], object[9] )    
            star17 = display.newImageRect( stargroup, object[color[1][7]], object[9], object[9] )
            star18 = display.newImageRect( stargroup, object[color[1][8]], object[9], object[9] )
            star19 = display.newImageRect( stargroup, object[color[1][9]], object[9], object[9] )
            
            star21 = display.newImageRect( stargroup, object[color[2][1]], object[9], object[9] )
            star22 = display.newImageRect( stargroup, object[color[2][2]], object[9], object[9] )  
            star23 = display.newImageRect( stargroup, object[color[2][3]], object[9], object[9] )   
            star24 = display.newImageRect( stargroup, object[color[2][4]], object[9], object[9] ) 
            star25 = display.newImageRect( stargroup, object[color[2][5]], object[9], object[9] )    
            star26 = display.newImageRect( stargroup, object[color[2][6]], object[9], object[9] )   
            star27 = display.newImageRect( stargroup, object[color[2][7]], object[9], object[9] )  
            star28 = display.newImageRect( stargroup, object[color[2][8]], object[9], object[9] )
            star29 = display.newImageRect( stargroup, object[color[2][9]], object[9], object[9] )
            
            star31 = display.newImageRect( stargroup, object[color[3][1]], object[9], object[9] )
            star32 = display.newImageRect( stargroup, object[color[3][2]], object[9], object[9] ) 
            star33 = display.newImageRect( stargroup, object[color[3][3]], object[9], object[9] )
            star34 = display.newImageRect( stargroup, object[color[3][4]], object[9], object[9] ) 
            star35 = display.newImageRect( stargroup, object[color[3][5]], object[9], object[9] )  
            star36 = display.newImageRect( stargroup, object[color[3][6]], object[9], object[9] )  
            star37 = display.newImageRect( stargroup, object[color[3][7]], object[9], object[9] )  
            star38 = display.newImageRect( stargroup, object[color[3][8]], object[9], object[9] )
            star39 = display.newImageRect( stargroup, object[color[3][9]], object[9], object[9] )
            
            star41 = display.newImageRect( stargroup, object[color[4][1]], object[9], object[9] )
            star42 = display.newImageRect( stargroup, object[color[4][2]], object[9], object[9] )  
            star43 = display.newImageRect( stargroup, object[color[4][3]], object[9], object[9] )   
            star44 = display.newImageRect( stargroup, object[color[4][4]], object[9], object[9] )   
            star45 = display.newImageRect( stargroup, object[color[4][5]], object[9], object[9] )     
            star46 = display.newImageRect( stargroup, object[color[4][6]], object[9], object[9] )    
            star47 = display.newImageRect( stargroup, object[color[4][7]], object[9], object[9] )
            star48 = display.newImageRect( stargroup, object[color[4][8]], object[9], object[9] )
            star49 = display.newImageRect( stargroup, object[color[4][9]], object[9], object[9] )
            
            star51 = display.newImageRect( stargroup, object[color[5][1]], object[9], object[9] )
            star52 = display.newImageRect( stargroup, object[color[5][2]], object[9], object[9] )   
            star53 = display.newImageRect( stargroup, object[color[5][3]], object[9], object[9] ) 
            star54 = display.newImageRect( stargroup, object[color[5][4]], object[9], object[9] )   
            star55 = display.newImageRect( stargroup, object[color[5][5]], object[9], object[9] )  
            star56 = display.newImageRect( stargroup, object[color[5][6]], object[9], object[9] )   
            star57 = display.newImageRect( stargroup, object[color[5][7]], object[9], object[9] )
            star58 = display.newImageRect( stargroup, object[color[5][8]], object[9], object[9] )  
            star59 = display.newImageRect( stargroup, object[color[5][9]], object[9], object[9] )
             
            star61 = display.newImageRect( stargroup, object[color[6][1]], object[9], object[9] )
            star62 = display.newImageRect( stargroup, object[color[6][2]], object[9], object[9] )   
            star63 = display.newImageRect( stargroup, object[color[6][3]], object[9], object[9] )
            star64 = display.newImageRect( stargroup, object[color[6][4]], object[9], object[9] )   
            star65 = display.newImageRect( stargroup, object[color[6][5]], object[9], object[9] )  
            star66 = display.newImageRect( stargroup, object[color[6][6]], object[9], object[9] )   
            star67 = display.newImageRect( stargroup, object[color[6][7]], object[9], object[9] )  
            star68 = display.newImageRect( stargroup, object[color[6][8]], object[9], object[9] ) 
            star69 = display.newImageRect( stargroup, object[color[6][9]], object[9], object[9] )
            
            star71 = display.newImageRect( stargroup, object[color[7][1]], object[9], object[9] )  
            star72 = display.newImageRect( stargroup, object[color[7][2]], object[9], object[9] )
            star73 = display.newImageRect( stargroup, object[color[7][3]], object[9], object[9] )  
            star74 = display.newImageRect( stargroup, object[color[7][4]], object[9], object[9] )    
            star75 = display.newImageRect( stargroup, object[color[7][5]], object[9], object[9] )    
            star76 = display.newImageRect( stargroup, object[color[7][6]], object[9], object[9] )
            star77 = display.newImageRect( stargroup, object[color[7][7]], object[9], object[9] )
            star78 = display.newImageRect( stargroup, object[color[7][8]], object[9], object[9] )
            star79 = display.newImageRect( stargroup, object[color[7][9]], object[9], object[9] )
            
            star81 = display.newImageRect( stargroup, object[color[8][1]], object[9], object[9] )
            star82 = display.newImageRect( stargroup, object[color[8][2]], object[9], object[9] )  
            star83 = display.newImageRect( stargroup, object[color[8][3]], object[9], object[9] )
            star84 = display.newImageRect( stargroup, object[color[8][4]], object[9], object[9] )    
            star85 = display.newImageRect( stargroup, object[color[8][5]], object[9], object[9] )   
            star86 = display.newImageRect( stargroup, object[color[8][6]], object[9], object[9] )   
            star87 = display.newImageRect( stargroup, object[color[8][7]], object[9], object[9] )   
            star88 = display.newImageRect( stargroup, object[color[8][8]], object[9], object[9] )
            star89 = display.newImageRect( stargroup, object[color[8][9]], object[9], object[9] )

            star91 = display.newImageRect( stargroup, object[color[9][1]], object[9], object[9] )
            star92 = display.newImageRect( stargroup, object[color[9][2]], object[9], object[9] )
            star93 = display.newImageRect( stargroup, object[color[9][3]], object[9], object[9] )
            star94 = display.newImageRect( stargroup, object[color[9][4]], object[9], object[9] )
            star95 = display.newImageRect( stargroup, object[color[9][5]], object[9], object[9] )
            star96 = display.newImageRect( stargroup, object[color[9][6]], object[9], object[9] )
            star97 = display.newImageRect( stargroup, object[color[9][7]], object[9], object[9] )
            star98 = display.newImageRect( stargroup, object[color[9][8]], object[9], object[9] )
            star99 = display.newImageRect( stargroup, object[color[9][9]], object[9], object[9] )

            object[11]=star11; object[41]=star41; object[71]=star71
            object[12]=star12; object[42]=star42; object[72]=star72
            object[13]=star13; object[43]=star43; object[73]=star73
            object[14]=star14; object[44]=star44; object[74]=star74
            object[15]=star15; object[45]=star45; object[75]=star75
            object[16]=star16; object[46]=star46; object[76]=star76
            object[17]=star17; object[47]=star47; object[77]=star77
            object[18]=star18; object[48]=star48; object[78]=star78
            object[19]=star19; object[49]=star49; object[79]=star79
            
            object[21]=star21; object[51]=star51; object[81]=star81
            object[22]=star22; object[52]=star52; object[82]=star82
            object[23]=star23; object[53]=star53; object[83]=star83
            object[24]=star24; object[54]=star54; object[84]=star84
            object[25]=star25; object[55]=star55; object[85]=star85
            object[26]=star26; object[56]=star56; object[86]=star86
            object[27]=star27; object[57]=star57; object[87]=star87
            object[28]=star28; object[58]=star58; object[88]=star88
            object[29]=star29; object[59]=star59; object[89]=star89
            
            object[31]=star31; object[61]=star61; object[91]=star91
            object[32]=star32; object[62]=star62; object[92]=star92
            object[33]=star33; object[63]=star63; object[93]=star93
            object[34]=star34; object[64]=star64; object[94]=star94
            object[35]=star35; object[65]=star65; object[95]=star95
            object[36]=star36; object[66]=star66; object[96]=star96
            object[37]=star37; object[67]=star67; object[97]=star97
            object[38]=star38; object[68]=star68; object[98]=star98
            object[39]=star39; object[69]=star69; object[99]=star99
            -- ----------------------------------------------------            
            local i
            local j
            local set_x=-15   --�P�Px�y��
            local set_y=540   --�P�Py�y��
            stargroup.alpha=0
             
            --�]�m��m&��ť--
            for i=1,9 do
            set_x=-15
            set_y=set_y-35
            for j=1,9 do
                set_x=set_x+35
                object[i*10+j].x=set_x
                object[i*10+j].y=set_y
                object[i*10+j]:addEventListener("touch",touching(i*10+j))
            end
            end  
            --�H�J�ĪG--
            transition.fadeIn(stargroup, { time=1000 } )
            -- -----------------------------------------
    end 
       



  
       -- --------------------
              --��U�@��--
       -- --------------------
       local function nextgame()                       
             
           local i
           local j  
           for i=1,9 do
           for j=1,9 do 
               if pos[i*10+j]~=nil then  
                  remove(i*10+j)          --�M���Ѿl�P�P
               end
               name[i][j]=nil             --���s�]�wname
               pos[i*10+j]=nil            --���s�]�wpos
           end
           end
           
           backup_score=scores            --��s�ƥ�����
           topic_set()                    --�Ͳ��P�P
           
       end
       
       
       
       ----------------------------------
                --���������Q�I�s--
       ----------------------------------       
       function complete()                                   
          
             level=level+1                                       --����+1
             change_HP(1)                                        --��q�W�[ 
             transition.fadeOut(status,{time=700,delay=1000})    --��status���d1��� ��0.7��H�X 
             timer.performWithDelay( 1750, nextgame, 1 )         --����1.75���   �s�y�U�@�� 
                   
       end
       
  
  
       -- ----------------------------------------
              --��L�k�~������� �N�Ѿl�P�P�H�X���ĪG--
       -- ----------------------------------------     
       local function fade_out_the_remained_stars ()     
              
             local i
             local j
             for i=1,9 do
             for j=1,9 do
                 if object[i*10+j]~=nil then      
                 transition.fadeOut(object[i*10+j], {time=1000})
                 end
             end
             end 
       end
       
       
       
       ----------------------------------
               --�L�k�~������Q�I�s--
       ----------------------------------    
       function remained()                                           
       
             if hp==0 then
                 
                 transition.fadeOut(status,{time=1000,delay=700})          --��status���d0.7��� ��1��H�X              
                 transition.fadeOut(playgroup,{time=1000,delay=700})       --����0.7���  ��1��H�Xplay frame
                 timer.performWithDelay(700,fade_out_the_remained_stars ,1)--����0.7���  �H1��H�X�Ѿl�P�P
                 audio.fade({channel=1,time=1700,volume=0})                --�H1.7��H�X�C���I������               
                 timer.performWithDelay( 1750 , gameover , 1 )             --����1.75���  �I�sgameover
                 
             else
                          
                 level=level+1                                             --����+1
                 change_HP(-1)                                             --��q���                 
                 transition.fadeOut(status,{time=1000,delay=700})          --��status���d0.7��� ��1��H�X
                 timer.performWithDelay(700,fade_out_the_remained_stars ,1)--����0.7���  �H1��H�X�Ѿl�P�P 
                 timer.performWithDelay( 1750 , nextgame , 1 )             --����1.75���  �s�y�U�@��
                    
             end
             
        end 
  
  
  
  
       -- ------------------------
            -- ���s�}�l�C��--
       -- ------------------------
       function restart_game()                   
        
           audio.play(tapsound)
           
           --��1�� ���åH�U����--
           transition.fadeOut(overgroup,{time=1000})    --����gameover frame      
           button.isVisible=false;button.alpha=0;       --���í��s�}�l�����s
           audio.fade({channel=2,time=1000,volume=0})   --�H1��H�Xgameover����

           hp=3                         --��q��l
           level=1                      --���Ū�l
           scores=0                     --���ƪ�l
           prompt=3                     --���ܪ�l
           difficulty=2                 --���ת�l
           backup_score=0               --�ƥ����ƪ�l
           level_txt.text=level         --���� =level
           score_txt.text=scores        --���� =scores
           hint.text="x "..prompt       --���ܦ���= prompt
           
           local function call()          
           sky.alpha=0.7
           blood1.alpha=1
           blood2.alpha=1
           blood3.alpha=1
           blood4.alpha=0
           blood5.alpha=0
           level_text.alpha=0.6
           level_txt.alpha=0.6
           transition.fadeIn(playgroup,{time=1000})  --���play frame   
           audio.pause(2)                            --����channel2
           audio.resume(1)                           --����channel1
           audio.fade({channel=1,time=1000,volume=1})--�H1��H�J�C���I������
           end 
           
           timer.performWithDelay(2700,call,1)       --����1���   ���U�I�scall
           timer.performWithDelay(1000,topic_set,1)  --����1���   �]�m�X�D�ó]�m�P�P  
           
       end
  
  
  
  
       ------------------------
             --�C������--
       ------------------------
       function gameover()                       
           
           local i
           local j
           
           for i=1,9 do
           for j=1,9 do
               if object[i*10+j]~=nil then       
                  remove(i*10+j)          --�M���Ҧ��P�P
               end
               name[i][j]=nil             --�M��name[][]
               color[i][j]=nil            --�M��color[][]
               pos[i*10+j]=nil            --�M��pos[]
           end
           end
                                                         
           audio.pause(1)                                --����channel1         
           audio.resume(2)                               --����channel2
           audio.fade({channel=2,time=1500,volume=1})    --�H1��H�Jgameover����
           
           --��1�� ��ܥH�U����--
           button.isVisible=true                         --�}�ҭ��s�}�l�����s 
           total_txt.text=scores                         --�`�� = scores       
           clear_txt.text=level                          --�L���� = level
           transition.fadeIn(button,{time=1500})         --��ܭ��s�}�l���s
           transition.fadeIn(overgroup,{time=1500})      --���gameover frame 
                 
      end
       
       
  
        
       -- --------------------------���s���s---------------------------------------
       button = widget.newButton 
       {
            defaultFile ="images/button.jpg",         -- �������s����ܪ��Ϥ�
            overFile ="images/button.jpg",            -- ���U���s����ܪ��Ϥ�
            label = "Start",                          -- ���s�W��ܪ���r
            font = native.systemFont,                 -- ���s�ϥΦr��
            labelColor = { default = { 0, 0, 250 } }, -- ���s�r���C��   
            fontSize = 20,                            -- ���s��r�r��j�p
            emboss = true,                            -- ����ĪG
            onPress =restart_game,                    -- Ĳ�o���U���s�ƥ�n���檺�禡
       }
       button.x = 160; button.y = 330                 -- ���s�����m
       button.alpha=0                                 -- ���ë��s
       button.isVisible=false                         -- �������s
      
       
   
     
          
      ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
         
                                                                              --�������D--
 
      ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
                     
  
     
     
     local function fchecking(event)            -- -----------------------------------------------------------�����o����k�O�_�N�P�P���� or ������
           
           local i
           local j          
           if copy[1][1]==nil then
              return "pass"
           end
           
           for j=1,9 do
           for i=1,9 do              
               if copy[i][j]~=nil then
                    if (i~=9 and copy[i][j]==copy[i+1][j]) or (j~=9 and copy[i][j]==copy[i][j+1]) then
                        return 1
                    end
               else
                    if i==1 then
                       return -1
                    end
                    break;
               end              
           end
           end
           
           return -1
           
      end

     local function fsort_y()                 --   -----------------------------------------------------------����������z
     
            local i
            local j
            local k
            
            for i=1,8 do  -- i �� y�b(���k) �n�ɪ���clown
                if name[1][i]==nil then
                     for j=i+1,9 do  --j �� y�b(���k) �n����clown
                          if name[1][j]~=nil then
                                for k=1,9 do  --k ����clown��x�b �q�U��W ���ʨ����  
                                    if name[k][j]==nil then
                                       break
                                    end
                                    name[k][i]=name[k][j]
                                    name[k][j]=nil                           
                                    copy[k][i]=copy[k][j]
                                    copy[k][j]=nil 
                                end
                                break;
                          end
                     end
                end
            end        
      end
      
     local function fsort_x()                   -- -----------------------------------------------------------�����U����z
            
            local i=0
            local j=0
            local k=0
            
            for i=1,8 do
            for j=1,9 do    
                if name[i][j]==nil then
                   for k=i+1,9 do
                       if name[k][j]~=nil then
                          copy[i][j]=copy[k][j]
                          copy[k][j]=nil
                          name[i][j]=name[k][j]
                          name[k][j]=nil
                          break
                       end
                   end
                end
       
            end
            end  
            fsort_y()
      end
                
     local function fcalculate_elimination (x,y) -- ----------------------------------------------------------�����p�����
            --�N�Jx,y��m     
            name[x][y]=nil
            
            if  (x~=9  and  name[x+1][y]~=nil) and copy[x][y]==copy[x+1][y] then
                fcalculate_elimination(x+1,y)
            end 
            
            if (x~=1  and  name[x-1][y]~=nil) and copy[x][y]==copy[x-1][y] then
               fcalculate_elimination(x-1,y)
            end  
             
            if (y~=9  and  name[x][y+1]~=nil) and copy[x][y]==copy[x][y+1] then
               fcalculate_elimination(x,y+1)
            end 
            
            if (y~=1  and  name[x][y-1]~=nil) and copy[x][y]==copy[x][y-1] then
               fcalculate_elimination(x,y-1)
            end  
            
            copy[x][y]=nil 
      end
      
     local function fcheck_alone (x,y)         --  -----------------------------------------------------------�����P�_�ӬP�P�O�_�۳s�P��
            --�N�Jx,y��m  
            if  (x~=9  and  copy[x][y]==copy[x+1][y]) or (x~=1  and copy[x][y]==copy[x-1][y]) or (y~=9  and  copy[x][y]==copy[x][y+1]) or (y~=1  and  copy[x][y]==copy[x][y-1])then
                  return 1
            else  
                  return 0  
            end 
      end
            
     local function erase()                    --  -----------------------------------------------------------�N�P�P���C����ըÿ�X�������էO���y��
     
           local erase_x=math.random(9)
           local erase_y=math.random(9)
           if copy[erase_x][erase_y]==nil or fcheck_alone(erase_x,erase_y)==0 then
              erase_x,erase_y=erase()
           end
           return erase_x,erase_y
     end
     
     local function lets_set_color()           --   ----------------------------------------------------------�T�w�D�� �}�l�]�mname&pos
          local i
          local j        
          for i=1,9 do
          for j=1,9 do
              name[i][j]=i*10+j
              pos[i*10+j]=i*10+j
              copy[i][j]=color[i][j]
          end
          end    
     end
      
     local function copy_color()               --  -----------------------------------------------------------�ƥ��D���C�� 
          local i
          local j   
          for i=1,9 do
          for j=1,9 do
              copy[i][j]=color[i][j]
              name[i][j]=i*10+j
          end
          end  
     end
    
     local function find_solution()            --  -----------------------------------------------------------���ո��D
          
          copy_color()   --�ƥ��D��
          local i        --(���U��)
          local k        --���D�L�{����
          local way={}   --�������D�L�{
          local times=0  --���D���ƪ�l
          local phase=1  --���D���A
          local erase_x  --�����I��x�y��
          local erase_y  --�����I��y�y��
          
          for times=1,try_solute do  --�]�w���զ���
                
                k=0
                times=times+1
                phase=1                                      --���A��l��
                while phase==1 do                            --���ư��檽�� (����or������)      
                     erase_x,erase_y=erase()                 --��ܮ������P�P
                     k=k+1
                     way[k]=erase_x*10+erase_y               --��������
                     fcalculate_elimination(erase_x,erase_y) --�p�����
                     fsort_x()                               --��z���ʬP�P
                     phase=fchecking()                       --��s���A                   
                end
                
                if times==try_solute then                    --��F���ƭ���
                     timer.performWithDelay(1,creat_topic,1) --���s�s�y�D��
                     break
                end
                
                if phase=="pass" then  --------------------- --���\����(�D�ئ���)       
                              
                     for i=1,math.modf(k*7/10) do       --�N�ѵ�����answer[]
                         answer[i]=way[i]                    
                     end 
                     answer[math.modf(k*7/10)+1]=nil    --���׵���

                     local delay=1700-(0.4*t*try_solute)--�p�⩵��ɶ�
                     if delay<=0 then
                        delay=1
                     end
                     
                     local function calls()
                           level_txt.text=level  --��ܵ��� 
                           local function call()
                           arrived=1             --���
                           end
                           if prompt>0 then                         --���Ѿl���ܦ���
                           transition.to(bulb,{time=1000,alpha=1})  --�H�J�O�w
                           transition.to(hint,{time=1000,alpha=0.6})--�H�J���ܦ��� 
                           end
                           timer.performWithDelay(1000,call,1)
                     end
                     
                     lets_set_color()                                    --�]�wname & pos                  
                     timer.performWithDelay(delay,calls,1)               --����delay��� ���U�I�scalls
                     timer.performWithDelay(delay,creat_star,1)          --����delay��� �Ͳ��P�P(�X�D)
                     break        
                end
                
                copy_color()                                   --�^�_�D���C�� �A�����ո��D
          end
      end
         
         
     ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
       
                                                                             --�]�p�D��--
  
     ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      
      --�ثe�P�P�ƶq(�X�D��)--
      local function total_star()
           local sum=0
           local i
           for i=1,9 do
           sum=sum+column[i]
           end
           return sum           
      end
      
      --�]�w�C��ƶq����--
      function color_divide()          
            local rand
             
            rand=math.random(difficulty)
            if (color_box[1]>=quota[difficulty-1] and color_box[2]>=quota[difficulty-1] and (difficulty<3 or color_box[3]>=quota[difficulty-1]) and ( difficulty<4 or color_box[4]>=quota[difficulty-1]) 
            and (difficulty<5 or color_box[5]>=quota[difficulty-1]) and (difficulty<6 or color_box[6]>=quota[difficulty-1]) and (difficulty<7 or color_box[7]>=quota[difficulty-1])) then
                return rand
            else
                if color_box[rand]<quota[difficulty-1] then
                   return rand
                else
                   return color_divide()
                end
            end 
      end
      
      --x,y��m�X�k & ��m�Ѽ�--
      local function canuse(x,y)             
             
             local p=1 -- ----------------------�����ƦC
                  
              if color[x][y]~=nil then
                  
                  --����--
                  if (x~=1 and color[x][y]==color[x-1][y]) then
                      p=p+4
                  end
                  if (y~=1 and color[x][y]==color[x][y-1]) then      
                      p=p+4
                  end
                  if (y<8 and color[x][y+1]~=nil and color[x][y+1]==color[x][y+2]) then      
                      p=p+4
                  end
                  
                  --�L��--
                  if (y<9 and color[x][y]~=nil and color[x][y]==color[x][y+1] and (shape==2 or shape==7))then
                      if 2~=math.random(3)then
                         return 0
                      end
                  end
                  if (x<8 and color[x+1][y]~=nil and color[x+1][y]==color[x+2][y]) then      
                      if 2~=math.random(3)then
                         return 0
                      end
                  end
                  if (c==color[x][y]) or (x~=1 and c==color[x-1][y]) or (y~=1 and c==color[x][y-1]) or (y~=9 and c==color[x][y+1]) then
                      if 2~=math.random(3)then
                         return 0
                      end
                  end
                  
                  
                  if (p*2)>=math.random(20) then      
                      return 1
                  else
                      return 0
                  end
                    
              else
                  return 0
              end                
      end 
      
      --�ثe�֦��̤֬P�P��column--
      local function less_column(y_min,y_max)
         
           local min=5
           local i
           local j
           for i=1,6+(math.modf(total_star()/12))*4 do
                 j=math.random(y_min,y_max)
                 if column[j]<=column[min] then
                 min=j
                 end
           end
           return min
      end
      
      --�]�w�H�����Ī�x,y�y�� �� px,py--
      local function px_py(x_min,x_max,y_min,y_max) 
          
          if total_star()<(random_height*9+16) and difficulty>=5 then   --�ثe�P�P�Ƥ֫h��m�b�Ĥ@�h�����v��2/5
              
              if 3<math.random(5) then
                  px=1
                  py=math.random(y_min,y_max) 
              else
                  px=math.random(x_min,x_max)
                  py=math.random(y_min,y_max)
              end
                       
          else          --   --------------------------------------50%���v��ܥثe�̤֪�column
              
              if 2~=math.random(2) then
                  px=math.random(x_min,x_max) 
                  py=less_column(y_min,y_max)
              else
                  px=math.random(x_min,x_max)
                  py=math.random(y_min,y_max)
              end
              
          end
          
          if canuse(px,py)~=1 then
              px_py(x_min,x_max,y_min,y_max)
          end
      end 
      
      -- ��z & ���� --
      local function check_sort() 
            
            local i
            local j
            local k         
            ----------------------------------------------------2��W�U��-----------------------------------------------------------
            if shape==1 or shape==8 then                        
                    if column[py]<8 then    
                         for i=column[py]+2,px+2,-1 do  --�}�l�W��            
                             color[i][py]=color[i-2][py]
                         end
                         column[py]=column[py]+2       
                         color[px][py]=c
                         color[px+1][py]=c
                         color_box[c]=color_box[c]+ 2 
                    end                                                          
            end--shape end
            ------------------------------------------------2�楪�k��-------------------------------------------------------------           
            if shape==2 or shape== 7 then                    
                   if  px~=1 and color[px-1][py+1]==nil then ---------------------------------------------��L�P�P���D���Ħ�m      
                          return      
                   else                                                 
                            if (column[py]<=8 and column[py+1]<=8 ) then--  --------------------�P�_�i�H2�W��
                                 for i=column[py]+1,px+1,-1 do              
                                     color[i][py]=color[i-1][py]
                                 end
                                 for i=column[py+1]+1,px+1,-1 do             
                                     color[i][py+1]=color[i-1][py+1]
                                 end
                                 column[py]=column[py]+1        
                                 column[py+1]=column[py+1]+1
                                 color[px][py]=c
                                 color[px][py+1]=c
                                 color_box[c]=color_box[c]+ 2   
                            end     
                   end--type end 
            end--shape end
            ------------------------------------------------3��}�f�k�W��-------------------------------------------------------------     
            if shape==3 then                         
                   if  px~=1 and color[px-1][py+1]==nil then --------------------------------------------------��L�P�P���D���Ħ�m       
                          return
                   else                 
                            if (column[py]<=7 and column[py+1]<=8 ) then--  --------------------�P�_�i�H3�W��
                                 for i=column[py]+2,px+2,-1 do              
                                     color[i][py]=color[i-2][py]
                                 end
                                 for i=column[py+1]+1,px+1,-1 do             
                                     color[i][py+1]=color[i-1][py+1]
                                 end
                                 column[py]=column[py]+2        
                                 column[py+1]=column[py+1]+1
                                 color[px][py]=c
                                 color[px+1][py]=c
                                 color[px][py+1]=c
                                 color_box[c]=color_box[c]+3                            
                            end                            
                   end--type end
            end--shape end           
            ------------------------------------------------3��}�f���W��-------------------------------------------------------------
            if shape==4 then  
                   if  (px~=1 and color[px-1][py-1]==nil) then -------------------------------------------��L�P�P���D���Ħ�m 
                          return
                   else                
                            if (column[py-1]<=8 and column[py]<=7 ) then--  --------------------�P�_�i�H3�W��
                                                     
                                 for i=column[py-1]+1,px+1,-1 do 
                                     color[i][py-1]=color[i-1][py-1]
                                 end
                                 for i=column[py]+2,px+2,-1 do              
                                     color[i][py]=color[i-2][py]
                                 end
                                 column[py-1]=column[py-1]+1        
                                 column[py]=column[py]+2
                                 color[px][py-1]=c
                                 color[px][py]=c
                                 color[px+1][py]=c
                                 color_box[c]=color_box[c]+3                            
                            end                                     
                   end--type end
            end--shape end
            ------------------------------------------------3�楪�U��-------------------------------------------------------------
            if shape==5 then         
                   if  (color[px][py-1]==nil) then ---------------------------------------------------------��L�P�P���D���Ħ�m       
                          return
                   else                                               
                            if (column[py]<=7 and column[py-1]<=8 ) then--  --------------------�P�_�i�H3�W��
                                 
                                 for i=column[py-1]+1,px+1,-1 do              
                                     color[i][py-1]=color[i-1][py-1]
                                 end
                                 for i=column[py]+2,px+2,-1 do             
                                     color[i][py]=color[i-2][py]
                                 end
                                 column[py-1]=column[py-1]+1        
                                 column[py]=column[py]+2
                                 color[px][py-1]=c
                                 color[px][py]=c
                                 color[px+1][py]=c
                                 color_box[c]=color_box[c]+3   
                            end                                  
                   end --type end                     
            end--shape end           
            ------------------------------------------------3��k�U��-------------------------------------------------------------           
            if shape==6 then        
                   if  color[px][py+1]==nil  then --------------------------------------------��L�P�P���D���Ħ�m
                          return       
                   else     
                            if (column[py]<=7 and column[py+1]<=8 ) then--  --------------------�P�_�i�H3�W��
                                 
                                 for i=column[py]+2,px+2,-1 do              
                                     color[i][py]=color[i-2][py]
                                 end
                                 for i=column[py+1]+1,px+1,-1 do             
                                     color[i][py+1]=color[i-1][py+1]
                                 end
                                 column[py]=column[py]+2        
                                 column[py+1]=column[py+1]+1
                                 color[px][py]=c
                                 color[px+1][py]=c
                                 color[px+1][py+1]=c
                                 color_box[c]=color_box[c]+3   
                            end     
                   end --type end  
            end--shape end           
       end --function end
         
      --�ˬd�O�_�i�A��--   
      local function fill_up() 
          
          local i      
          for i=1,9 do              
            if column[i]<8 then
            return 0        
            end             
          end
          
          for i=1,9 do              
            if column[i]==8 then
              if i==1 and column[2]==9 then
                   color[9][1]=math.random(difficulty)
                   column[1]=column[1]+1
              elseif i==9 and column[8]==9 then
                   color[9][9]=math.random(difficulty)
                   column[9]=column[9]+1
              elseif column[i+1]==9 and column[i-1]==9 then
                   color[9][i]=math.random(difficulty)
                   column[i]=column[i]+1
              end    
            end             
          end
          return total_star()     
       end
       
      --�M���D���C���T--
      local function clean()  
       
            local i
            local j
            color_box={0,0,0,0,0,0,0}
            for i=1,9 do
            for j=1,9 do
                   color[i][j]=nil                  
            end
            column[i]=0
            end
       end
           
      --�}�l�f�B��X�D--     
      function creat_topic()          
           
           local i
           local j
           local sum=0
           t=t+1
           clean()
           set_color()
           while 1==1 do         
                   c=color_divide()
                   shape=math.random(7)
                   if shape==1 then    
                      px_py(1,8,1,9)       
                   elseif shape==2 or shape==7 then 
                      px_py(1,9,1,8)                             
                   elseif shape==3 then
                      px_py(1,8,1,8)
                   elseif shape==4 then
                      px_py(1,8,2,9)
                   elseif shape==5 then
                      px_py(1,8,2,9)
                   elseif shape==6 then
                      px_py(1,8,1,8)                       
                   end
                                                                
                   check_sort()               
                   if fill_up()==81 then                   
                       find_solution()                                      
                       break
                   end
                                     
           end
       end 

      
      --�T�{�]�m�X�D�Ѽ�--
      function topic_set()       
            --�̵��ŨM�w���d����
            local lv={1,2,3,4,5}
            if level<=lv[1] then                   
               difficulty=2
            elseif level<=lv[1]+lv[2] then
               difficulty=3
            elseif level<=lv[1]+lv[2]+lv[3] then
               difficulty=4
            elseif level<=lv[1]+lv[2]+lv[3]+lv[4] then
               difficulty=5
            elseif level<=lv[1]+lv[2]+lv[3]+lv[4]+lv[5] then
               difficulty=6
            elseif level>lv[1]+lv[2]+lv[3]+lv[4]+lv[5]  then
               difficulty=7
            end 
            --�]�w�Ѽ�--
            if difficulty==5 then
                random_height=6
                try_solute=250
            elseif difficulty==6 then
                random_height=3
                try_solute=375
            elseif difficulty==7 then
                random_height=1
                try_solute=475
            else
               random_height=9
               try_solute=500
            end
            t=0 --���s�غctopic�����ƪ�l
            creat_topic()
      end
         

      topic_set()-- -----------------------------------------------------------�}�l�C���o!!!-----------------------------------------------------------------------------------------------------------------
          
         
         
          
      ----------------------------------------------------------------------
      
                                  --����--
                                  
      ----------------------------------------------------------------------

      -- -------�I�s����--------
      local function show(event) 
           local i
           local j
           
           if (event.phase=="began") and (prompt>0) and (arrived==1) then
           --����--
           audio.play(tapsound)
           --�վ�Ѽ�--
           arrived=0
           prompt=prompt-1
           hint.text="x "..prompt
           --�H�X���ܲ�--
           transition.to(bulb,{time=500,alpha=0,delay=500})
           transition.to(hint,{time=500,alpha=0,delay=500})
           --�H�X�Ѿl�P�P--
           fade_out_the_remained_stars()
           --�������--
           local function minus()
                 scores=scores-50
                 if scores<=backup_score then
                    scores=backup_score
                    score_txt.text=scores
                 else
                    score_txt.text=scores
                    timer.performWithDelay(15,minus,1)
                 end
           end
           minus()
           --���ݫ�I�s--
           local function call()
                for i=1,9 do 
                for j=1,9 do
                    if object[i*10+j]~=nil then
                    remove(i*10+j)
                    end
                    name[i][j]=i*10+j
                    pos[i*10+j]=i*10+j
                    color[i][j]=copy[i][j]
                end
                end
                local function calls()
                arrived=1
                can_prompt=1
                show_prompt(1)
                end
                creat_star()
                timer.performWithDelay(1000,calls,1)--����1��Ỳ�U�I�scalls--
           end
           timer.performWithDelay(1000,call,1)--����1��Ỳ�U�I�scall--
           end
      end
     
      -- ----------�}�Ҵ���--------------
      bulb:addEventListener("touch",show)  
      
      
      -- ---------���ܰ{�{----------
      local function bright (number)         
             
             if object[number]~=nil and can_prompt==1 then
                   if object[number].alpha~=1 then
                      object[number].alpha=1
                   else
                      object[number].alpha=0.5
                   end
                   local function call()
                   bright(number)
                   end
                   timer.performWithDelay(500,call,1)
             elseif can_prompt==0 and object[number]~=nil then
             
                   if object[number].alpha~=1 then
                      object[number].alpha=1
                   end
             end
      end
      

      -- -------���ըð{�{-----------
      local function check_group(x,y)          
      
            local have_group={{},{},{},{},{},{},{},{},{}}
            local function grouping(x,y)
                       
                   have_group[x][y]=1
                   if  (x~=9  and  have_group[x+1][y]~=1) and color[x][y]==color[x+1][y] then           
                       grouping(x+1,y)
                   end 
                    
                   if (x~=1  and  have_group[x-1][y]~=1) and color[x][y]==color[x-1][y] then
                      grouping(x-1,y)
                   end  
                     
                   if (y~=9  and  have_group[x][y+1]~=1) and color[x][y]==color[x][y+1] then
                      grouping(x,y+1)
                   end 
                   
                   if (y~=1  and  have_group[x][y-1]~=1) and color[x][y]==color[x][y-1] then
                      grouping(x,y-1)
                   end
                   bright(name[x][y]) 
             end
             grouping(x,y)
       end
     
      
      -- -----�q�X����-------
      function show_prompt(i)                  
         
            if (answer[i]~=nil) and (can_prompt==1) then
                     
                local x=math.modf(answer[i]/10)
                local y=math.mod(answer[i],10)
                local star=name[x][y]
                
                check_group(x,y)
                
                local function erated()  --�����ˬd�O�_�i�J�U�@�B
                                                  
                     if  pos[star]~=nil and arrived==0 then
                            can_prompt=0                               
                            return                                           
                     elseif( pos[star]==nil )and( arrived==1 )then                  
                            show_prompt(i+1)
                     elseif can_prompt==1 then
                            timer.performWithDelay(200,erated,1)
                     end
                       
                end
                
                erated()
                
            else
                
                can_prompt=0
                
            end
      end
      
end
end

-- -------------------------------------------------------------------------------
scene:addEventListener( "create", scene )   --�����ɥ��Q�I�s���a��A�i�H�[�J�����ݭn������H�ά۹��������
scene:addEventListener( "show", scene )     --�����n�}�l�B�@���i�J�I�A�b�o�̥i�H�[�J�ݭn������ʧ@
scene:addEventListener( "hide", scene )     --�����n�Q�����ɷ|�I�s�A�]�N�O�n���}������
scene:addEventListener( "destroy", scene )  --�����Q�����ɩI�s
-- -------------------------------------------------------------------------------

return scene
