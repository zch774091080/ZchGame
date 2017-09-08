require "Common/define"
require "Logic/MyGameManager"

ConnectedToServer = {}

local this = ConnectedToServer

function ConnectedToServer.Connet()
    local serverAddress = "192.168.2.123:5556"
	local applicationName = "MyPhotonServer"	
    MyPeer.Connected(serverAddress,applicationName)
end

function ConnectedToServer.HadConnected()
    Util.Log("11111")
end

function ConnectedToServer.HadDisConnected()
   Util.Log("222222")
end


function ConnectedToServer.GetMsg(luatable)	
   
	Util.Log(luatable)
	MyGameManager.ServerInfoChuLi(luatable)
end

