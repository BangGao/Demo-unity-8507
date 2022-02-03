using System;
using Mirror;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NetworkConnectionToClient = Mirror.NetworkConnectionToClient;

public class tankPrefeb : NetworkBehaviour
{
    public GameObject PlayerGameObject;
    public GameObject cannonball;
    
    [Header("FireVectors")]
    public Transform headPointTransform;
    public Transform startPointTransform;

    public ParticleSystem smoke_fire;
    [Header("Attachment")]
    public GameObject _turretGameObject;
    public Transform _turrentTransform;
    public Transform _gun;

    [Header("MoveVector")]
    public float moveSpeed = 10.0f;
    [SerializeField] public GameObject myCamera;


    private Vector3 direction;
    Vector3 rotateAxis = new Vector3(0.0f, 1.0f, 0.0f);

    //[SyncVar(hook = nameof(OnCountChanged))]int count_cannonballs = 0;
   

    void Update()
    { 
        direction = headPointTransform.position - startPointTransform.position;
        MoveController();
    }

    public override void OnStartServer()
    {
        Debug.Log("Player has been spawned on the server");
    }

    void MoveController()
    {
        if (isLocalPlayer)
        {
           
            //float horizontal = Input.GetAxis("Horizontal");
            //float vertical = Input.GetAxis("Vertical");

            if (Input.GetKey(KeyCode.W))
            {
                PlayerGameObject.transform.Translate(Vector3.forward * moveSpeed * Time.deltaTime);
            }
            if (Input.GetKey(KeyCode.S))
            {
                PlayerGameObject.transform.Translate(Vector3.back * moveSpeed * Time.deltaTime);
            }
            if (Input.GetKey(KeyCode.A))
            {
                PlayerGameObject.transform.Rotate(rotateAxis, -0.1f);
            }
            if (Input.GetKey(KeyCode.D))
            {
                PlayerGameObject.transform.Rotate(rotateAxis, 0.1f);
            }

            //Controll the rotate of turrent
            if (Input.GetKey(KeyCode.L))
            {
                _turrentTransform.Rotate(0.0f, 0.0f, 0.14f);
                
            }
            if (Input.GetKey(KeyCode.J))
            {
                _turrentTransform.Rotate(0.0f, 0.0f, -0.14f);
               
            }

            if (Input.GetKey(KeyCode.I))//Up the Gun
            {
                _gun.transform.Rotate(-0.14f, 0.0f, 0.0f);
            }
            if (Input.GetKey(KeyCode.K))
            {
                _gun.transform.Rotate(0.14f, 0.0f, 0.0f);
            }
            //Fire Cannon
            if (Input.GetKeyDown(KeyCode.Space))
            {
                Fire();
            }
        }
    }

    [Command]
    void Fire()
    {
        smoke_fire.Play();
        GameObject newGameObject = Instantiate(cannonball, headPointTransform.position, headPointTransform.rotation);
        newGameObject.GetComponent<Rigidbody>().AddForce(direction * 100.0f);
        NetworkServer.Spawn(newGameObject);
    }


    

    public override void OnStartLocalPlayer()
    {
        myCamera.SetActive(true);
    }
} 