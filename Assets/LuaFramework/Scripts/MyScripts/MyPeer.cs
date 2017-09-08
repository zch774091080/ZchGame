using LuaFramework;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using LuaInterface;
// Name : 邹长洪 

namespace LuaFramework
{
    public class MyPeer : Manager
    {

        public static MyPeer _instance;

        private void Awake()
        {
            if (_instance == null)
            {
                _instance = this;
            }
        }
        // private MyPeer _MyClientPeer;

        private static ConnetedToMyPhotonServer ctps;

        private static bool isconnect;


        void Start()
        {
            ctps = new ConnetedToMyPhotonServer();
        }

        public static void Connected(string serverAddress, string applicationName)
        {
            isconnect = ctps.ConnectedToServer(serverAddress, applicationName);
        }

        public static void SendMsg(int code, LuaTable luatable)
        {
            Dictionary<byte, object> msg = new Dictionary<byte, object>();
            if (luatable != null)
            {
                object[] msgs = luatable.ToArray();
                for (int i = 0; i < msgs.Length; i++)
                {
                    msg.Add((byte)(i + 1), msgs[i]);
                }
            }                 
            ctps.SendMsg((byte)code, msg);
        }


        public void GetMsg(byte code, Dictionary<byte,object> msgs)
        {
            string luatable = "";
            luatable += code + "_";                   
            for (int i = 0; i < msgs.Count; i++)
            {
                luatable += msgs[(byte)(i+1)].ToString() + "_";
            }
           
            CallMethod("GetMsg", luatable);
        }
        void Update()
        {

            if (isconnect)
            {
                ctps.Peer.Service();
            }
        }

        public void HadConnected()
        {
            CallMethod("HadConnected");
        }

        public void HadDisConnected()
        {
            CallMethod("HadDisConnected");
        }

        public object[] CallMethod(string func, params object[] args)
        {
            return Util.CallMethod("ConnectedToServer", func, args);
        }
    }
}