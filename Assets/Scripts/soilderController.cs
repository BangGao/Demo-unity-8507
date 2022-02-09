using System.Collections;
using System.Collections.Generic;
using UnityEditor.Animations;
using UnityEngine;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.UIElements;

public class soilderController : MonoBehaviour
{
    public Animator soilderAnimator;
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        Movement();
    }

    void Movement()
    {
        soilderAnimator.SetBool("moveForward", Input.GetKey(KeyCode.W));
        soilderAnimator.SetBool("moveBackward", Input.GetKey(KeyCode.S));
        soilderAnimator.SetBool("moveLeft", Input.GetKey(KeyCode.A));
        soilderAnimator.SetBool("moveRight", Input.GetKey(KeyCode.D));

    }
}
