using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using ExitGames.Client.Photon;
using System;
using LuaFramework;
// Name : 邹长洪 

public class ConnetedToMyPhotonServer : IPhotonPeerListener
{

    private PhotonPeer peer;
    public PhotonPeer Peer
    {
        get
        {
            if (peer == null)
            {
                peer = new PhotonPeer(this, ConnectionProtocol.Tcp);
            }
            return peer;
        }
    }

    public bool ConnectedToServer(string serverAddress, string applicationName)
    {
        return Peer.Connect(serverAddress, applicationName);
    }

    public void DebugReturn(DebugLevel level, string message)
    {

    }

    public void OnEvent(EventData eventData)
    {

    }

    public void OnOperationResponse(OperationResponse operationResponse)
    {
        MyPeer._instance.GetMsg(operationResponse.OperationCode, operationResponse.Parameters);
    }

    public void OnStatusChanged(StatusCode statusCode)
    {
        switch (statusCode)
        {
            case StatusCode.Connect:
                MyPeer._instance.HadConnected();
                break;
            case StatusCode.Disconnect:
                MyPeer._instance.HadDisConnected();
                break;          
            default:
                break;
        }
    }

    public void SendMsg(byte code, Dictionary<byte,object> msg)
    {
        peer.OpCustom(code, msg, true);
    }

}
