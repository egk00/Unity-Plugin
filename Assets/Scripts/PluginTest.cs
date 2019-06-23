using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Runtime.InteropServices;

public class PluginTest : MonoBehaviour {

# if UNITY_IOS
	[DllImport("__Internal")]
	private static extern double IOSgetElapsetTime(); 
# endif

	// Use this for initialization
	void Start () {
		Debug.Log("Elapsed Time : " + getElapsedTime());
	}

	int frameCounter = 0;
	
	// Update is called once per frame
	void Update () {
		frameCounter++;
		if (frameCounter >= 5)
		{
			Debug.Log("Tick : " + getElapsedTime());
			frameCounter = 0;
		}
	}

	double getElapsedTime()
	{
		if(Application.platform == RuntimePlatform.IPhonePlayer)
		{
			Debug.Log("IPhone");
			return IOSgetElapsetTime();
		}
			
		Debug.LogWarning("Wrong platform!");
		return 0;
	}
}
