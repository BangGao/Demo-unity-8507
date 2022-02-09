Shader "Custom/sdfs"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct MeshData
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Interpolators
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			Interpolators vert (MeshData v)
			{
				Interpolators o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = v.uv*2 -1;
				return o;
			}

			float3 test(float a, float b)
			{
				if (b>=a)
				{
					return float3(1,1,1);
				}
				else
				{
					return float3(1, 0, 0);
				}
			}

			float4 frag(Interpolators i) : SV_Target
			{
				

				float dist = length(i.uv) - 0.3;

				//float3 outColor =  test(0, dist);
				//return float4(outColor.xyz,1);
				return float4(dist.xxx,1);

			}
			ENDCG
		}
	}
}
