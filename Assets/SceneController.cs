using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SceneController : MonoBehaviour
{
    public float speed = 1.0f;
    public float freq = 1.5f;

    public GameObject quad1;
    public GameObject quad2;
    public GameObject quad3;
    public GameObject quad4;

    public GameObject quadGround;

    Material quad1mat;
    Material quad2mat;
    Material quad3mat;
    Material quad4mat;

    float noiseOffset = 0.0f;

    // Start is called before the first frame update
    void Start()
    {
        quad1mat = quad1.GetComponent<Renderer>().material;
        quad2mat = quad2.GetComponent<Renderer>().material;
        quad3mat = quad3.GetComponent<Renderer>().material;
        quad4mat = quad4.GetComponent<Renderer>().material;

        
    }

    // Update is called once per frame
    void Update()
    {
        noiseOffset += Time.deltaTime * speed;
        quad1mat.SetVector("_NoiseOffset", new Vector4(noiseOffset, noiseOffset, 0.0f, 0.0f));
        quad2mat.SetVector("_NoiseOffset", new Vector4(noiseOffset, noiseOffset, 0.0f, 0.0f));
        quad3mat.SetVector("_NoiseOffset", new Vector4(noiseOffset, noiseOffset, 0.0f, 0.0f));
        quad4mat.SetVector("_NoiseOffset", new Vector4(noiseOffset, noiseOffset, 0.0f, 0.0f));

        quad1mat.SetFloat("_NoiseFrequency", freq);
        quad2mat.SetFloat("_NoiseFrequency", freq);
        quad3mat.SetFloat("_NoiseFrequency", freq);
        quad4mat.SetFloat("_NoiseFrequency", freq);
    }
}
