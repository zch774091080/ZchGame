using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;
using LuaInterface;
using ExitGames.Client.Photon;

namespace LuaFramework {
    public class NetworkManager : Manager
    {

        #region  原来的


        private SocketClient socket;
        static readonly object m_lockObject = new object();
        static Queue<KeyValuePair<int, ByteBuffer>> mEvents = new Queue<KeyValuePair<int, ByteBuffer>>();

        SocketClient SocketClient
        {
            get
            {
                if (socket == null)
                    socket = new SocketClient();
                return socket;
            }
        }

        void Awake()
        {
            Init();
        }

        void Init()
        {
            SocketClient.OnRegister();
        }

        public void OnInit()
        {
            CallMethod("Start");
        }

        public void Unload()
        {
            CallMethod("Unload");
        }

        /// <summary>
        /// 执行Lua方法
        /// </summary>
        public object[] CallMethod(string func, params object[] args)
        {
            return Util.CallMethod("Network", func, args);
        }

        ///------------------------------------------------------------------------------------
        public static void AddEvent(int _event, ByteBuffer data)
        {
            lock (m_lockObject)
            {
                mEvents.Enqueue(new KeyValuePair<int, ByteBuffer>(_event, data));
            }
        }

        /// <summary>
        /// 交给Command，这里不想关心发给谁。
        /// </summary>
        void Update()
        {
            if (mEvents.Count > 0)
            {
                while (mEvents.Count > 0)
                {
                    KeyValuePair<int, ByteBuffer> _event = mEvents.Dequeue();
                    facade.SendMessageCommand(NotiConst.DISPATCH_MESSAGE, _event);
                }
            }
        }

        /// <summary>
        /// 发送链接请求
        /// </summary>
        public void SendConnect()
        {
            SocketClient.SendConnect();
        }

        /// <summary>
        /// 发送SOCKET消息
        /// </summary>
        public void SendMessage(ByteBuffer buffer)
        {
            SocketClient.SendMessage(buffer);
        }

        /// <summary>
        /// 析构函数
        /// </summary>
        new void OnDestroy()
        {
            SocketClient.OnRemove();
            Debug.Log("~NetworkManager was destroy");
        }

        #endregion

        //private PhotonPeer peer;
        //private void Awake()
        //{
        //    peer = new PhotonPeer(this, ConnectionProtocol.Tcp);
          
        //}


        //void ConnectedToMyPhotonServer()
        //{
        //    peer.Connect("192.168.2.122:6080", "MyPhotonServer");
        //}
        //public void DebugReturn(DebugLevel level, string message)
        //{
        //    throw new NotImplementedException();
        //}

        //public void OnEvent(EventData eventData)
        //{
        //    throw new NotImplementedException();
        //}

        //public void OnOperationResponse(OperationResponse operationResponse)
        //{
        //    throw new NotImplementedException();
        //}

        //public void OnStatusChanged(StatusCode statusCode)
        //{
        //    switch (statusCode)
        //    {
        //        case StatusCode.Connect:

        //            break;
        //        case StatusCode.Disconnect:
        //            Invoke("ConnectedToMyPhotonServer", 0.5f);
        //            break;
        //        case StatusCode.Exception:
        //            break;
        //        case StatusCode.ExceptionOnConnect:
        //            break;
        //        case StatusCode.SecurityExceptionOnConnect:
        //            break;
        //        case StatusCode.QueueOutgoingReliableWarning:
        //            break;
        //        case StatusCode.QueueOutgoingUnreliableWarning:
        //            break;
        //        case StatusCode.SendError:
        //            break;
        //        case StatusCode.QueueOutgoingAcksWarning:
        //            break;
        //        case StatusCode.QueueIncomingReliableWarning:
        //            break;
        //        case StatusCode.QueueIncomingUnreliableWarning:
        //            break;
        //        case StatusCode.QueueSentWarning:
        //            break;
        //        case StatusCode.InternalReceiveException:
        //            break;
        //        case StatusCode.TimeoutDisconnect:
        //            break;
        //        case StatusCode.DisconnectByServer:
        //            break;
        //        case StatusCode.DisconnectByServerUserLimit:
        //            break;
        //        case StatusCode.DisconnectByServerLogic:
        //            break;
        //        case StatusCode.TcpRouterResponseOk:
        //            break;
        //        case StatusCode.TcpRouterResponseNodeIdUnknown:
        //            break;
        //        case StatusCode.TcpRouterResponseEndpointUnknown:
        //            break;
        //        case StatusCode.TcpRouterResponseNodeNotReady:
        //            break;
        //        case StatusCode.EncryptionEstablished:
        //            break;
        //        case StatusCode.EncryptionFailedToEstablish:
        //            break;
        //        default:
        //            break;
        //    }
        //}
    }
}