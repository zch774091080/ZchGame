require "Common/define"
require "Logic/ConnectedToServer"
require "View/LoginPanel"
require "View/LobbyPanel"
require "View/GameSelectPanel"
require "View/GamePanel"

require "Logic/MyGameManager"


--主入口函数。从这里开始lua逻辑
function Main()					
	print("logic start")
    ConnectedToServer.Connet()	 -- 连接服务器
	
	resMgr:LoadPrefab("myprefab",{"LoginPanel","LobbyPanel","GameSelectPanel","GamePanel","pai"},LoadPanel)

    resMgr:LoadSprite("pukepaiss",{"heitao_14_7","heitao_15_3","heitao_3_51","heitao_4_47","heitao_5_43","heitao_6_39","heitao_7_35","heitao_8_31","heitao_9_27","heitao_10_23","heitao_11_19","heitao_12_15","heitao_13_11","hongtao_14_8","hongtao_15_4","hongtao_3_52","hongtao_4_48","hongtao_5_44","hongtao_6_40","hongtao_7_36","hongtao_8_32","hongtao_9_28","hongtao_10_24","hongtao_11_20","hongtao_12_16","hongtao_13_12","meihua_14_9","meihua_15_5","meihua_3_53","meihua_4_49","meihua_5_45","meihua_6_41","meihua_7_37","meihua_8_33","meihua_9_29","meihua_10_25","meihua_11_21","meihua_12_17","meihua_13_13","fangpian_14_10","fangpian_15_6","fangpian_3_54","fangpian_4_50","fangpian_5_46","fangpian_6_42","fangpian_7_38","fangpian_8_34","fangpian_9_30","fangpian_10_26","fangpian_11_22","fangpian_12_18","fangpian_13_14","wang_da_1","wang_xiao_2"},LoadKaPai) 

   resMgr:LoadSprite("gamescene",{"head_lord_man","head_lord_man_fan","lord_label"},LoadTouXiang)   

end

--场景切换通知
function OnLevelWasLoaded(level)
	collectgarbage("collect")
	Time.timeSinceLevelLoad = 0
end

function LoadPanel(objs)

     local loginpanel = GameObject.Instantiate(objs[0])
	 LoginPanel.InitPanel(loginpanel)
	 local lobbyPanel = GameObject.Instantiate(objs[1])
	 LobbyPanel.InitPanel(lobbyPanel)
	 local gameselectpanel = GameObject.Instantiate(objs[2])
	 GameSelectPanel.InitPanel(gameselectpanel)
	 local gamepanel = GameObject.Instantiate(objs[3])
	
	local allkapais = {}
	for	i = 1,20 do
	
	 allkapais[i] = GameObject.Instantiate(objs[4])
      allkapais[i].name = "pai"..i
	 allkapais[i]:SetActive(false)
		
	end
	 GamePanel.InitPanel(gamepanel,allkapais)
	 local panels = {}
	 panels.login = loginpanel
	 panels.lobby = lobbyPanel
	 panels.gameselect = gameselectpanel
	 panels.game = gamepanel
	 MyGameManager.PanelsGameObject(panels)
	
	 
end

function LoadKaPai(objss)
	
    local aaaa = {}
	for	i = 0,objss.Length-1 do       
		aaaa[i+1] = objss[i]
	end
    MyGameManager.AllKaPai(aaaa)
 
end

function LoadTouXiang(objs)
	
    local aaaa = {}
	for	i = 0,objs.Length-1 do       
		aaaa[i+1] = objs[i]
	end
    MyGameManager.DiZhuTouXiang(aaaa)
end