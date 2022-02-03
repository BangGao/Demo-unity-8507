using System;
using System.Collections;
using System.Collections.Generic;
using Mirror;
using UnityEngine;

public class SphereCollide : NetworkBehaviour
{
    public Rigidbody rigidbody;
    //private GameObject floor_collided;
    public GameObject headPoint;
    public GameObject startPoint;
 
    void Start()
    {
        rigidbody.AddForce((headPoint.transform.position - startPoint.transform.position) * 100.0f);
    }

    void Update()
    {

    }

    //[ServerCallback]
    void OnCollisionEnter(Collision collision)
    {
        ContactPoint contact = collision.contacts[0];
       
        if (collision.gameObject.tag == "Terrain")
        {
           
            //floor_collided = collision.gameObject;
            collision.gameObject.GetComponent<MeshRenderer>().material.color = Color.blue;
        }
        NetworkServer.Destroy(gameObject);
    }
}
