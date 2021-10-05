local composer  = require( "composer" )   --轉換場景
local widget    = require( "widget" )     --按鈕
math.randomseed (os.time())               --亂數種子

local scene = composer.newScene()         --建立新場景

function scene:create (event)
end

function scene:hide   (event)  
end

function scene:destroy(event)
end


--show--
function scene:show( event )
if ( "will" == event.phase ) then
-- ------------無------------------
elseif ( "did" == event.phase ) then

      ---------------------音效與音樂--------------------------------     
      local eliminationsound=audio.loadSound("images/pop_1.wav")          
      local tapsound= audio.loadSound("images/pop.wav")
      -----------------------遊戲主架構變數-----------------------------      
      local color={{},{},{},{},{},{},{},{},{}}  --代入座標 給顏色
      local name ={{},{},{},{},{},{},{},{},{}}  --代入座標 給名稱
      local pos  ={}                            --代入名稱 給座標
      local arrived=0                           --(輔助用)移動是否完成
      local hp=3                                --血量
      local scores=0                            --分數
      local level=1                             --目前等級
      local difficulty=2                        --星星顏色數
      local button                              --重新一局的按鈕
      local apple=0                             --每次消掉星星的個數
      local object={"images/red.jpg",           --圖片設置
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
      
      ---------------------題目 & 解題 變數-----------------------------
      local quota={29,23,18,14,11,9}            --(輔助參數)顏色數量設置
      local t                                   --(輔助用)計算重新出題次數
      local c                                   --出題顏色
      local px                                  --出題x座標
      local py                                  --出題y座標     
      local shape                               --星星排列形狀
      local column={0,0,0,0,0,0,0,0,0}          --每列目前星星數                                          
      local color_box={0,0,0,0,0,0,0}           --目前各種顏色數量
      local random_height=9                     --(輔助參數)放置隨機顏色的row數
      local try_solute=500                      --(輔助參數)解題次數上限
      local copy={{},{},{},{},{},{},{},{},{}}   --備份題目顏色
      local topic_set    =function()            --題目參數調整函式
      end
      local creat_topic  =function()            --開始設計題目函式
      end
      local color_divide =function()            --平均分配顏色函式
      end
      -------------------------------------------------------------------
      
      -----------------------提示變數------------------------------------
      local prompt=3                            --提示次數
      local answer={}                           --解答
      local backup_score=0                      --備份分數
      local can_prompt=0                        --執行提示
      local show_prompt=function()
      end
      -------------------------------------------------------------------


      -- -------------------------------------------------------
                        --文字 & 圖片--
      -- -------------------------------------------------------
      --設置物件群組--  
      local playgroup= display.newGroup()
      local overgroup= display.newGroup()
      local stargroup= display.newGroup()
      
      -- 遊戲中使用--
      local level_text = display.newText(playgroup,"Level",265,40,system.nativeFont,20)   --Level文字                                
      local level_txt = display.newText(playgroup,level,303,40,system.nativeFont,20)      --等級文字             
      local score_text = display.newText(playgroup,"Score:",205,-8,system.nativeFont,25)  --Score 文字      
      local score_txt = display.newText(playgroup,scores,275,-7,system.nativeFont,25)     --分數文字
      local status = display.newText("Start",160,120,system.nativeFont,55)                --顯示 Clear 或 Fail 文字 
      local hint = display.newText(playgroup,"x "..prompt,60,63,system.nativeFont,20)     --提示剩餘次數文字
      score_text:setFillColor(0/255,0/255,0/255)
      score_txt:setFillColor( 0/255,0/255,0/255)
      level_text.alpha=0;level_txt.alpha=0
      score_text.alpha=0;score_txt.alpha=0
      status.alpha=0;hint.alpha=0
      transition.to(level_text,{time=1000,alpha=0.6,delay=1700})
      transition.to(level_txt, {time=1000,alpha=0.6,delay=1700})
      transition.to(score_text,{time=1000,alpha=1,  delay=1700})
      transition.to(score_txt, {time=1000,alpha=1,  delay=1700})

      --GameOver使用--
      local total_text = display.newText(overgroup,"Your Score:",110,130,system.nativeFont,35)           --Your Score文字
      local total_txt = display.newText(overgroup,0,250,132,system.nativeFont,35)                        --總分文字
      local clear_text = display.newText(overgroup,"Reach         Level",157,200,system.nativeFont,35)   --Clear ...Level文字      
      local clear_txt = display.newText(overgroup,0,164,201,system.nativeFont,35)                        --完成關卡數文字
      local push = display.newText(overgroup,"Push Button To Restart Game",160,270,system.nativeFont,22) --Push Button To Restart Game 文字      
      total_txt:setFillColor( 0/255, 255/255, 255/255 )
      clear_txt:setFillColor( 255/255, 255/255, 0/255 )
      overgroup.alpha=0
            

      --天空圖片設置--
      local sky = display.newImageRect(playgroup,"images/sky1.png", 320, 75 ) 
            sky.x = 160
            sky.y = -15
            sky.alpha=0
            sky:toBack()
      
      --血量圖片設置--
      --只顯示3滴血--      
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
      
      --提示燈泡--
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
          
          --累加分數--
          local function plusing()
                scores=scores+a
                score_txt.text=scores                 
          end
          timer.performWithDelay(20,plusing,a)
          
          --顯示加上分數--
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
                 --血量值調整與對應血滴顯示或消失--
      ---------------------------------------------------
      local function change_HP (value)                         
                 
            if value==1 then--增加1命
                      
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
               
               if hp<5 then--若目前血量大於5,血量不變
                  hp=hp+1  --反之加1血量
               end
                          
            elseif value==-1 then--減少1命
                
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
                 
               hp=hp-1 --減少1血量

            end
   
      end 
      


      -------------------------------------------
                   --隨機設置顏色--
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
                   --移除目標星星--
      --  --------------------------------------
      
      local function remove (number)  --代入編號
      
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
      --檢查是否還能繼續消除--
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
      local function  move_down ( target , moves ) --代入編號
       
            transition.to(object[target], {time=500, y=object[target].y+(moves)*35})
 
      end 
     
     
     
      -- ---------------------------------------------------
                  --move beside the stars--
      -- ---------------------------------------------------
      local function move_beside (target , moves) --代入編號

            transition.to(object[target], {time=500, x=object[target].x-(moves)*35})
            
      end
      
      

      ------------------------------------------------- 
              --所有星星已完成移動&是否進入下一關--  
      -------------------------------------------------
      local function all_arrived()                 

            local phase=checking() --確認狀態
            if phase==1 then
              
                   arrived=1       --完成移動
                   return     
            
            elseif phase=="complete" then---------------------------------全部消完
                                  
                   status.text="Clear"                          --status顯示Clear
                   transition.to(status,{time=200,alpha=0.7})   --讓status用0.2秒淡入
                   if bulb.alpha==1 then                        --提示組顯示效果
                      transition.to(bulb,{time=500,alpha=0.3})       
                      transition.to(hint,{time=500,alpha=0.2})      
                   end
                   timer.performWithDelay(200,complete,1)       --等待0.2秒後 呼叫complete 
                                           
            elseif phase=="remained" then-----------------------------無法繼續消除
            
                   if hp~=0 then                                     
                      status.text="Fail"      --status顯示Fail
                   else                                
                      status.text="Game Over" --status顯示Fail
                   end
                       
                   if bulb.alpha==1 then                        --提示組顯示效果
                      transition.to(bulb,{time=500,alpha=0.3})       
                      transition.to(hint,{time=500,alpha=0.2})      
                   end     
                   transition.to(status,{time=200,alpha=0.7})   --讓status用0.2秒淡入
                   timer.performWithDelay( 1000, remained , 1 ) --(玩家可看到剩餘的星星1秒)
            end
      end
     
    
      
      --  -------------------------------
               --y方向整理與移動--
      --  -------------------------------
      local function sort_y()
     
            local i
            local j
            local k
            local is_y_move=0
            
            for i=1,8 do  -- i 為 y軸(左右) 要補的空column
            if name[1][i]==nil then
                 
                   for j=i+1,9 do  --j 為 y軸(左右) 要移動column
                        if name[1][j]~=nil then
                              for k=1,9 do  --k 為該column的x軸 從下到上 移動到旁邊
                              
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
              --x方向整理與移動--
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
                --計算消除--
      --  --------------------------
      local function calculate_elimination (position) --代入位置
            
            local x=math.modf(position/10)
            local y=math.mod(position,10)  
           
            remove(name[x][y])
            apple=apple+1                --消掉個數+1
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
                  --判斷目標是否可被消除--
      ---------------------------------------------
      local function check_alone (position)  --代入位置
      
            local x=math.modf(position/10)
            local y=math.mod(position,10)  
            
            if  (x~=9  and  color[x][y]==color[x+1][y]) or (x~=1  and color[x][y]==color[x-1][y]) or (y~=9  and  color[x][y]==color[x][y+1]) or (y~=1  and  color[x][y]==color[x][y-1])then
                  return 1
            else  
                  return 0  
            end 
      end

      --  ------------------------------
                   --點擊目標--
      --  ------------------------------
      local function touching (target)  --代入編號
      return function(event)
      
             local phase=event.phase   
             if   arrived ==1 and "began"==phase then
                  if check_alone(pos[target])==1 then
                  apple=0                                    --這次得分初始
                  arrived=0                                  --移動中,無法點擊消除
                  audio.play(eliminationsound,{loops=0})     --消去的聲音
                  calculate_elimination(pos[target])         --計算所需消除的星星
                  show_score(apple)                          --顯示累加分數             
                  sort_x()                                   --整理並移動星星的x方向
                  end
             end      
      end
      end
 





      ----------------------------------- 
                --設置星星圖片--                        
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
            local set_x=-15   --星星x座標
            local set_y=540   --星星y座標
            stargroup.alpha=0
             
            --設置位置&監聽--
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
            --淡入效果--
            transition.fadeIn(stargroup, { time=1000 } )
            -- -----------------------------------------
    end 
       



  
       -- --------------------
              --到下一關--
       -- --------------------
       local function nextgame()                       
             
           local i
           local j  
           for i=1,9 do
           for j=1,9 do 
               if pos[i*10+j]~=nil then  
                  remove(i*10+j)          --清除剩餘星星
               end
               name[i][j]=nil             --重新設定name
               pos[i*10+j]=nil            --重新設定pos
           end
           end
           
           backup_score=scores            --更新備份分數
           topic_set()                    --生產星星
           
       end
       
       
       
       ----------------------------------
                --全部消完被呼叫--
       ----------------------------------       
       function complete()                                   
          
             level=level+1                                       --等級+1
             change_HP(1)                                        --血量增加 
             transition.fadeOut(status,{time=700,delay=1000})    --讓status停留1秒後 用0.7秒淡出 
             timer.performWithDelay( 1750, nextgame, 1 )         --等待1.75秒後   製造下一關 
                   
       end
       
  
  
       -- ----------------------------------------
              --當無法繼續消除時 將剩餘星星淡出的效果--
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
               --無法繼續消除被呼叫--
       ----------------------------------    
       function remained()                                           
       
             if hp==0 then
                 
                 transition.fadeOut(status,{time=1000,delay=700})          --讓status停留0.7秒後 用1秒淡出              
                 transition.fadeOut(playgroup,{time=1000,delay=700})       --等待0.7秒後  用1秒淡出play frame
                 timer.performWithDelay(700,fade_out_the_remained_stars ,1)--等待0.7秒後  以1秒淡出剩餘星星
                 audio.fade({channel=1,time=1700,volume=0})                --以1.7秒淡出遊戲背景音樂               
                 timer.performWithDelay( 1750 , gameover , 1 )             --等待1.75秒後  呼叫gameover
                 
             else
                          
                 level=level+1                                             --等級+1
                 change_HP(-1)                                             --血量減少                 
                 transition.fadeOut(status,{time=1000,delay=700})          --讓status停留0.7秒後 用1秒淡出
                 timer.performWithDelay(700,fade_out_the_remained_stars ,1)--等待0.7秒後  以1秒淡出剩餘星星 
                 timer.performWithDelay( 1750 , nextgame , 1 )             --等待1.75秒後  製造下一關
                    
             end
             
        end 
  
  
  
  
       -- ------------------------
            -- 重新開始遊戲--
       -- ------------------------
       function restart_game()                   
        
           audio.play(tapsound)
           
           --用1秒 隱藏以下物件--
           transition.fadeOut(overgroup,{time=1000})    --隱藏gameover frame      
           button.isVisible=false;button.alpha=0;       --隱藏重新開始的按鈕
           audio.fade({channel=2,time=1000,volume=0})   --以1秒淡出gameover音樂

           hp=3                         --血量初始
           level=1                      --等級初始
           scores=0                     --分數初始
           prompt=3                     --提示初始
           difficulty=2                 --難度初始
           backup_score=0               --備份分數初始
           level_txt.text=level         --等級 =level
           score_txt.text=scores        --分數 =scores
           hint.text="x "..prompt       --提示次數= prompt
           
           local function call()          
           sky.alpha=0.7
           blood1.alpha=1
           blood2.alpha=1
           blood3.alpha=1
           blood4.alpha=0
           blood5.alpha=0
           level_text.alpha=0.6
           level_txt.alpha=0.6
           transition.fadeIn(playgroup,{time=1000})  --顯示play frame   
           audio.pause(2)                            --關閉channel2
           audio.resume(1)                           --重啟channel1
           audio.fade({channel=1,time=1000,volume=1})--以1秒淡入遊戲背景音樂
           end 
           
           timer.performWithDelay(2700,call,1)       --等待1秒後   輔助呼叫call
           timer.performWithDelay(1000,topic_set,1)  --等待1秒後   設置出題並設置星星  
           
       end
  
  
  
  
       ------------------------
             --遊戲結束--
       ------------------------
       function gameover()                       
           
           local i
           local j
           
           for i=1,9 do
           for j=1,9 do
               if object[i*10+j]~=nil then       
                  remove(i*10+j)          --清除所有星星
               end
               name[i][j]=nil             --清空name[][]
               color[i][j]=nil            --清空color[][]
               pos[i*10+j]=nil            --清空pos[]
           end
           end
                                                         
           audio.pause(1)                                --關閉channel1         
           audio.resume(2)                               --重啟channel2
           audio.fade({channel=2,time=1500,volume=1})    --以1秒淡入gameover音樂
           
           --用1秒 顯示以下物件--
           button.isVisible=true                         --開啟重新開始的按鈕 
           total_txt.text=scores                         --總分 = scores       
           clear_txt.text=level                          --過關數 = level
           transition.fadeIn(button,{time=1500})         --顯示重新開始按鈕
           transition.fadeIn(overgroup,{time=1500})      --顯示gameover frame 
                 
      end
       
       
  
        
       -- --------------------------重新按鈕---------------------------------------
       button = widget.newButton 
       {
            defaultFile ="images/button.jpg",         -- 未按按鈕時顯示的圖片
            overFile ="images/button.jpg",            -- 按下按鈕時顯示的圖片
            label = "Start",                          -- 按鈕上顯示的文字
            font = native.systemFont,                 -- 按鈕使用字型
            labelColor = { default = { 0, 0, 250 } }, -- 按鈕字體顏色   
            fontSize = 20,                            -- 按鈕文字字體大小
            emboss = true,                            -- 立體效果
            onPress =restart_game,                    -- 觸發按下按鈕事件要執行的函式
       }
       button.x = 160; button.y = 330                 -- 按鈕物件位置
       button.alpha=0                                 -- 隱藏按鈕
       button.isVisible=false                         -- 關閉按鈕
      
       
   
     
          
      ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
         
                                                                              --模擬解題--
 
      ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
                     
  
     
     
     local function fchecking(event)            -- -----------------------------------------------------------模擬這次方法是否將星星消完 or 消不掉
           
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

     local function fsort_y()                 --   -----------------------------------------------------------模擬左移整理
     
            local i
            local j
            local k
            
            for i=1,8 do  -- i 為 y軸(左右) 要補的空clown
                if name[1][i]==nil then
                     for j=i+1,9 do  --j 為 y軸(左右) 要移動clown
                          if name[1][j]~=nil then
                                for k=1,9 do  --k 為該clown的x軸 從下到上 移動到旁邊  
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
      
     local function fsort_x()                   -- -----------------------------------------------------------模擬下移整理
            
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
                
     local function fcalculate_elimination (x,y) -- ----------------------------------------------------------模擬計算消除
            --代入x,y位置     
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
      
     local function fcheck_alone (x,y)         --  -----------------------------------------------------------模擬判斷該星星是否相連同色
            --代入x,y位置  
            if  (x~=9  and  copy[x][y]==copy[x+1][y]) or (x~=1  and copy[x][y]==copy[x-1][y]) or (y~=9  and  copy[x][y]==copy[x][y+1]) or (y~=1  and  copy[x][y]==copy[x][y-1])then
                  return 1
            else  
                  return 0  
            end 
      end
            
     local function erase()                    --  -----------------------------------------------------------將星星依顏色分組並選出欲消掉組別之座標
     
           local erase_x=math.random(9)
           local erase_y=math.random(9)
           if copy[erase_x][erase_y]==nil or fcheck_alone(erase_x,erase_y)==0 then
              erase_x,erase_y=erase()
           end
           return erase_x,erase_y
     end
     
     local function lets_set_color()           --   ----------------------------------------------------------確定題目 開始設置name&pos
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
      
     local function copy_color()               --  -----------------------------------------------------------備份題目顏色 
          local i
          local j   
          for i=1,9 do
          for j=1,9 do
              copy[i][j]=color[i][j]
              name[i][j]=i*10+j
          end
          end  
     end
    
     local function find_solution()            --  -----------------------------------------------------------嘗試解題
          
          copy_color()   --備份題目
          local i        --(輔助用)
          local k        --解題過程次數
          local way={}   --紀錄解題過程
          local times=0  --解題次數初始
          local phase=1  --解題狀態
          local erase_x  --模擬點擊x座標
          local erase_y  --模擬點擊y座標
          
          for times=1,try_solute do  --設定嘗試次數
                
                k=0
                times=times+1
                phase=1                                      --狀態初始化
                while phase==1 do                            --重複執行直到 (消完or消不掉)      
                     erase_x,erase_y=erase()                 --選擇消除之星星
                     k=k+1
                     way[k]=erase_x*10+erase_y               --紀錄嘗試
                     fcalculate_elimination(erase_x,erase_y) --計算消除
                     fsort_x()                               --整理移動星星
                     phase=fchecking()                       --更新狀態                   
                end
                
                if times==try_solute then                    --到達次數限制
                     timer.performWithDelay(1,creat_topic,1) --重新製造題目
                     break
                end
                
                if phase=="pass" then  --------------------- --成功消完(題目有解)       
                              
                     for i=1,math.modf(k*7/10) do       --將解答移到answer[]
                         answer[i]=way[i]                    
                     end 
                     answer[math.modf(k*7/10)+1]=nil    --答案結尾

                     local delay=1700-(0.4*t*try_solute)--計算延遲時間
                     if delay<=0 then
                        delay=1
                     end
                     
                     local function calls()
                           level_txt.text=level  --顯示等級 
                           local function call()
                           arrived=1             --到位
                           end
                           if prompt>0 then                         --有剩餘提示次數
                           transition.to(bulb,{time=1000,alpha=1})  --淡入燈泡
                           transition.to(hint,{time=1000,alpha=0.6})--淡入提示次數 
                           end
                           timer.performWithDelay(1000,call,1)
                     end
                     
                     lets_set_color()                                    --設定name & pos                  
                     timer.performWithDelay(delay,calls,1)               --等待delay秒後 輔助呼叫calls
                     timer.performWithDelay(delay,creat_star,1)          --等待delay秒後 生產星星(出題)
                     break        
                end
                
                copy_color()                                   --回復題目顏色 再次嘗試解題
          end
      end
         
         
     ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------    
       
                                                                             --設計題目--
  
     ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
      
      --目前星星數量(出題用)--
      local function total_star()
           local sum=0
           local i
           for i=1,9 do
           sum=sum+column[i]
           end
           return sum           
      end
      
      --設定顏色數量均衡--
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
      
      --x,y位置合法 & 位置參數--
      local function canuse(x,y)             
             
             local p=1 -- ----------------------打散排列
                  
              if color[x][y]~=nil then
                  
                  --有效--
                  if (x~=1 and color[x][y]==color[x-1][y]) then
                      p=p+4
                  end
                  if (y~=1 and color[x][y]==color[x][y-1]) then      
                      p=p+4
                  end
                  if (y<8 and color[x][y+1]~=nil and color[x][y+1]==color[x][y+2]) then      
                      p=p+4
                  end
                  
                  --無效--
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
      
      --目前擁有最少星星的column--
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
      
      --設定隨機有效的x,y座標 給 px,py--
      local function px_py(x_min,x_max,y_min,y_max) 
          
          if total_star()<(random_height*9+16) and difficulty>=5 then   --目前星星數少則放置在第一層的機率為2/5
              
              if 3<math.random(5) then
                  px=1
                  py=math.random(y_min,y_max) 
              else
                  px=math.random(x_min,x_max)
                  py=math.random(y_min,y_max)
              end
                       
          else          --   --------------------------------------50%機率選擇目前最少的column
              
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
      
      -- 整理 & 移動 --
      local function check_sort() 
            
            local i
            local j
            local k         
            ----------------------------------------------------2格上下型-----------------------------------------------------------
            if shape==1 or shape==8 then                        
                    if column[py]<8 then    
                         for i=column[py]+2,px+2,-1 do  --開始上移            
                             color[i][py]=color[i-2][py]
                         end
                         column[py]=column[py]+2       
                         color[px][py]=c
                         color[px+1][py]=c
                         color_box[c]=color_box[c]+ 2 
                    end                                                          
            end--shape end
            ------------------------------------------------2格左右型-------------------------------------------------------------           
            if shape==2 or shape== 7 then                    
                   if  px~=1 and color[px-1][py+1]==nil then ---------------------------------------------其他星星為非有效位置      
                          return      
                   else                                                 
                            if (column[py]<=8 and column[py+1]<=8 ) then--  --------------------判斷可以2上移
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
            ------------------------------------------------3格開口右上型-------------------------------------------------------------     
            if shape==3 then                         
                   if  px~=1 and color[px-1][py+1]==nil then --------------------------------------------------其他星星為非有效位置       
                          return
                   else                 
                            if (column[py]<=7 and column[py+1]<=8 ) then--  --------------------判斷可以3上移
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
            ------------------------------------------------3格開口左上型-------------------------------------------------------------
            if shape==4 then  
                   if  (px~=1 and color[px-1][py-1]==nil) then -------------------------------------------其他星星為非有效位置 
                          return
                   else                
                            if (column[py-1]<=8 and column[py]<=7 ) then--  --------------------判斷可以3上移
                                                     
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
            ------------------------------------------------3格左下型-------------------------------------------------------------
            if shape==5 then         
                   if  (color[px][py-1]==nil) then ---------------------------------------------------------其他星星為非有效位置       
                          return
                   else                                               
                            if (column[py]<=7 and column[py-1]<=8 ) then--  --------------------判斷可以3上移
                                 
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
            ------------------------------------------------3格右下型-------------------------------------------------------------           
            if shape==6 then        
                   if  color[px][py+1]==nil  then --------------------------------------------其他星星為非有效位置
                          return       
                   else     
                            if (column[py]<=7 and column[py+1]<=8 ) then--  --------------------判斷可以3上移
                                 
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
         
      --檢查是否可再填滿--   
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
       
      --清除題目顏色資訊--
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
           
      --開始逆運算出題--     
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

      
      --確認設置出題參數--
      function topic_set()       
            --依等級決定關卡難度
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
            --設定參數--
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
            t=0 --重新建構topic的次數初始
            creat_topic()
      end
         

      topic_set()-- -----------------------------------------------------------開始遊戲囉!!!-----------------------------------------------------------------------------------------------------------------
          
         
         
          
      ----------------------------------------------------------------------
      
                                  --提示--
                                  
      ----------------------------------------------------------------------

      -- -------呼叫提示--------
      local function show(event) 
           local i
           local j
           
           if (event.phase=="began") and (prompt>0) and (arrived==1) then
           --音效--
           audio.play(tapsound)
           --調整參數--
           arrived=0
           prompt=prompt-1
           hint.text="x "..prompt
           --淡出提示組--
           transition.to(bulb,{time=500,alpha=0,delay=500})
           transition.to(hint,{time=500,alpha=0,delay=500})
           --淡出剩餘星星--
           fade_out_the_remained_stars()
           --倒轉分數--
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
           --等待後呼叫--
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
                timer.performWithDelay(1000,calls,1)--等待1秒後輔助呼叫calls--
           end
           timer.performWithDelay(1000,call,1)--等待1秒後輔助呼叫call--
           end
      end
     
      -- ----------開啟提示--------------
      bulb:addEventListener("touch",show)  
      
      
      -- ---------提示閃爍----------
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
      

      -- -------分組並閃爍-----------
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
     
      
      -- -----秀出提示-------
      function show_prompt(i)                  
         
            if (answer[i]~=nil) and (can_prompt==1) then
                     
                local x=math.modf(answer[i]/10)
                local y=math.mod(answer[i],10)
                local star=name[x][y]
                
                check_group(x,y)
                
                local function erated()  --重複檢查是否進入下一步
                                                  
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
scene:addEventListener( "create", scene )   --場景時先被呼叫的地方，可以加入場景需要的物件以及相對應的函數
scene:addEventListener( "show", scene )     --場景要開始運作的進入點，在這裡可以加入需要的執行動作
scene:addEventListener( "hide", scene )     --場景要被切換時會呼叫，也就是要離開場景時
scene:addEventListener( "destroy", scene )  --場景被移除時呼叫
-- -------------------------------------------------------------------------------

return scene
