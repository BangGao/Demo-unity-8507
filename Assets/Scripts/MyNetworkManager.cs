using Mirror;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MyNetworkManager : NetworkManager
{
    public override void OnStartServer()
    {
        Debug.Log("Server Started");
    }

    public override void OnStopServer()
    {
        Debug.Log("Server Stopped");
    }

    [System.Obsolete]
    public override void OnClientConnect(NetworkConnection conn)
    {
        Debug.Log("Connected to Server");
    }

    [System.Obsolete]
    public override void OnClientDisconnect(NetworkConnection conn)
    {
        Debug.Log("Disconnected from Server");
    }
}
