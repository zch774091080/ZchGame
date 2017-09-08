
require "Common/define"

local transform;
local gameObject;

LobbyPanel = {};
local this = LobbyPanel;


--初始化面板--
function LobbyPanel.InitPanel(obj)
	gameObject = obj;
	transform = obj.transform;
    local creatbtn = transform:Find("Creat/Creat_Button").gameObject;
	
	gameObject_luabe = gameObject:AddComponent(typeof(LuaBehaviour))
	
	local joinbtn = transform:Find("Join/Join_Button").gameObject;
	
	gameObject_luabe:AddClick(creatbtn,OnClickCreat)
	gameObject_luabe:AddClick(joinbtn,OnClickJoin)
	
end

--单击事件--
function LobbyPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end

local logininfo = {}
function OnClickCreat(go)
 
  
  MyPeer.SendMsg(2,logininfo)

end

function OnClickJoin(go)
 
  
  MyPeer.SendMsg(3,logininfo)

end