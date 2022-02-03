Shader "Custom/Test01"
{
	properties
	{
		_Color("Main Color",Color) = (1,1,1,1)
	}
	
	
	SubShader
	{
	   pass{
	   	//HLSL codes
			CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
			fixed4 _Color;

			float4 vert(float4 vertex:POSITION) :SV_POSITION{
				return  UnityObjectToClipPos(vertex);
			}

				float4 frag() : SV_Target{
					return _Color;
			}
			ENDCG 
	   }
	}
}
