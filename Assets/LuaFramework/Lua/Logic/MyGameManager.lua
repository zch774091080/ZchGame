require "Common/define"
require "View/PanelsMag"
require "View/GamePanel"
require "Logic/Test_pb"


MyGameManager = {}

local this = MyGameManager

local panels = {}

local quxiaoreadybtn 
local readytext 
local readybtn

local allkapais = {}

local dizhutouxiang = {}

function MyGameManager.ServerInfoChuLi(str)
	
	
	local info = this.Split(str,"_")
	if info[1] == "1" then
		-- 登录成功则跳转界面		
		panels.login:SetActive(false)
		panels.lobby:SetActive(true)
		
		GamePanel.MeJionRoomTime(info[3])
		
	elseif info[1] == "2" then
		
		panels.lobby:SetActive(false)
		panels.gameselect:SetActive(true)
					
    elseif info[1] == "3" then
		-- to do 快速加入房间
		panels.lobby:SetActive(false)
		panels.game:SetActive(true)
		
		--if info[2] == "1" then  -- 自己消息		
	    local playerids = MyGameManager.Split(info[2],"|")
	    GamePanel.OtherJionRoomTimeOne(playerids)			
       -- elseif info[2] == "2" then  -- 广播消息
			
          --GamePanel.OtherJionRoomTimeTwo(info[3])

		--end							
	elseif info[1] == "4" then
		Util.Log("dasdasdasadasd")
		panels.gameselect:SetActive(false)
		panels.game:SetActive(true)
	
	elseif info[1] == "5" then
		
        panels.gameselect:SetActive(false)
		panels.game:SetActive(true)		
		
	elseif info[1] == "6" then
			
		panels.gameselect:SetActive(false)
		panels.game:SetActive(true)
	elseif info[1] == "7" then
		
		if info[3] == "0" then
			
			GamePanel.ReadyBtn(info[2])
            Util.Log("---------->"..info[4])
		elseif info[3] == "1" then

            local kapais = MyGameManager.Split(info[4],",") -- 所有卡牌的名字(服务器发的牌)
			
			for i = 1 , 54 do
			    kapais[i] = this.Replace(kapais[i],"|","_")
               -- Util.Log(kapais[i])           		
			end
			-- 上边for循环 把 kapais的名字改下
            GamePanel.StartGame(kapais,allkapais,info[5])
        end	
             	
	elseif info[1] == "8" then
			
		if	info[2] == "yes" then
			
	    GamePanel.QuXiaoReadyBtn(info[3])
		
		end
	elseif info[1] == "9" then -- 传过来 谁是地主，或者下一个人叫分
		GamePanel.JiaoDiZhu(info,dizhutouxiang)	
	
    elseif info[1] == "10" then -- 发牌 ， 发的牌
       
        GamePanel.SendCardShow(info[2],info[3],info[4],info[5],info[6])
	end
end

function MyGameManager.Split(str,char)

  local nFindStartIndex = 1
  local nSplitIndex = 1
  local nSplitArray = {}
  while true do
   local nFindLastIndex = string.find(str, char, nFindStartIndex)
   if not nFindLastIndex then
    nSplitArray[nSplitIndex] = string.sub(str, nFindStartIndex, string.len(str))
    break
   end
   nSplitArray[nSplitIndex] = string.sub(str, nFindStartIndex, nFindLastIndex - 1)
   nFindStartIndex = nFindLastIndex + string.len(char)
   nSplitIndex = nSplitIndex + 1
  end

  return nSplitArray

end

function MyGameManager.Replace(str,oldvalue,newvalue)
   
   local variable = this.Split(str,oldvalue)
   local newstr = variable[1]..newvalue..variable[2]..newvalue..variable[3]
   return newstr
 
end

function MyGameManager.PanelsGameObject(allpanel)
	
	UIRoot =  GameObject.FindGameObjectWithTag("UIRoot")
	panels = allpanel
	this.PanelsInit(panels.login,UIRoot)  
	this.PanelsInit(panels.lobby,UIRoot)  
	this.PanelsInit(panels.gameselect,UIRoot)  
	this.PanelsInit(panels.game,UIRoot) 
    panels.login:SetActive(true)	 
	
end

function MyGameManager.PanelsInit(go,goUIRoot)
	
	
	go.transform:SetParent(goUIRoot.transform,false)
	go.transform.localPosition = Vector3.New(0,0,0)
    go:SetActive(false)	
end

-- 所有的 卡牌 Sprite
function MyGameManager.AllKaPai(kapaiss)
	
	allkapais = kapaiss

end

function  MyGameManager.DiZhuTouXiang(args)
  dizhutouxiang = args
end

function ProtoSerTest(id,str)
   local msg = Test_pb.LoginRequest()
   msg.id = id
   msg.info:append(str)
   local pb_data = msg:SerializeToString()                
   Util.Log(pb_data)
   ProtoDeSerTest(pb_data)
end

function ProtoDeSerTest(data)
  local msg = Test_pb.LoginRequest()
  msg:ParseFromString(data)
            --tostring 不会打印默认值
  print('person_pb decoder: '..tostring(msg)..'age: '..msg.id..'\nemail: '..msg.info[1])
 -- Util.Log('person_pb decoder: '..tostring(msg)..'age: '..msg.id..'\nemail: '..msg.info)
end


