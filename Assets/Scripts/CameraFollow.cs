using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEditor.Build.Content;
using UnityEngine;

public class CameraFollow : MonoBehaviour
{
    public GameObject playerPrefeb;

    private Transform playerTrans;

    private Vector3 offset;

    private void Awake()
    {
        playerTrans = playerTrans.transform;
        playerTrans = GameObject.FindWithTag("Player").transform;
        offset = transform.position - playerTrans.position;
        offset = new Vector3(0, offset.y, offset.z);
    }

    void Start()
    {
        
    }

    
    void Update()
    {
        Vector3 startPos = playerTrans.position + offset;
        Vector3 endPos = playerTrans.position + offset.magnitude * Vector3.up;
        Vector3[] points = new Vector3[]
        {
            startPos,
            Vector3.Lerp(startPos,endPos,0.25f), 
            Vector3.Lerp(startPos,endPos,0.5f), 
            Vector3.Lerp(startPos,endPos,0.75f), 
            endPos
        };

        Vector3 target = points[0];
        for (int i = 0; i < points.Length; i++)
        {
            RaycastHit hit;
            if (Physics.Raycast(points[i],playerTrans.position - points[i],out hit))
            {
                if (hit.collider.tag == ("Player") || hit.collider.tag == ("Camera"))
                {
                    target = points[i];
                    break;
                }
            }
            else
            {
                target = points[i];
                break;
            }
        }
        transform.position =Vector3.Lerp(transform.position,target,Time.deltaTime);
        Quaternion rotate = transform.rotation;
        transform.LookAt(playerTrans.position);
        transform.rotation = Quaternion.Lerp(rotate,transform.rotation,Time.deltaTime * 10);
    }
}
