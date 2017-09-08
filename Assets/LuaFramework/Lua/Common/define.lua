
CtrlNames = {
	Prompt = "PromptCtrl",
	Message = "MessageCtrl"
}

PanelNames = {
	"PromptPanel",	
	"MessagePanel",
}

--协议类型--
ProtocalType = {
	BINARY = 0,
	PB_LUA = 1,
	PBC = 2,
	SPROTO = 3,
}
--当前使用的协议类型--
TestProtoType = ProtocalType.BINARY;

Util = LuaFramework.Util;
AppConst = LuaFramework.AppConst;
LuaHelper = LuaFramework.LuaHelper;
ByteBuffer = LuaFramework.ByteBuffer;
MyPeer = LuaFramework.MyPeer;
LuaBehaviour = LuaFramework.LuaBehaviour
MyPeer = LuaFramework.MyPeer

resMgr = LuaHelper.GetResManager();
panelMgr = LuaHelper.GetPanelManager();
soundMgr = LuaHelper.GetSoundManager();
networkMgr = LuaHelper.GetNetManager();

UI = UnityEngine.UI
WWW = UnityEngine.WWW;
GameObject = UnityEngine.GameObject;
RectTransform = UnityEngine.RectTransform;
Sprite = UnityEngine.Sprite
Text = UI.Text
Image = UI.Image
Button = UI.Button
