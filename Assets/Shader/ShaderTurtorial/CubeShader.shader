Shader "Custom/CubeShader"
{
	Properties
	{
		_ColorA("Color",Color) = (1,1,1,1)
		_ColorB("Color",Color) = (1,1,1,1)
		_ColorStart("Color Start",Range(0,1)) = 0
		_ColorEnd("Color End",Range(0,1)) = 1
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Transparent"
			"Queue"="Transparent"
		}
		LOD 100

		Pass
		{
			Cull off
			ZWrite off
			Blend one one//additive
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			#define TAU 6.28318530718

			float4 _ColorA;
			float4 _ColorB;
			float _ColorStart;
			float _ColorEnd;


			struct MeshData
			{
				float4 vertex : POSITION;
				float3 normals:NORMAL;
				float4 uv0:TEXCOORD0;
			};

			struct Interpolatpors
			{
				float4 vertex : SV_POSITION;
				float3 normal:TEXCOORD0;
				float2 uv :TEXCOORD1;
			};


			//Vertex Shader output
			Interpolatpors vert(MeshData v)
			{
				//o for output
				Interpolatpors o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.vertex); //From local space to world space
				o.uv = v.uv0; //(v.uv0 + _Offset) * _Scale;//passthrough
				return o;
			}

			float InverseLerp(float a, float b, float v)
			{
				return (v - a) / (b - a);
			}

			//fragment shader
			fixed4 frag(Interpolatpors i) : SV_Target
			{
				//lerp:Blend between two colors based on the x UV coord
				//float4 outColor = lerp(_ColorA,_ColorB,i.uv.x);
				//return outColor;

				//Clamp things
				//float t = saturate((InverseLerp(_ColorStart,_ColorEnd,i.uv.x)));

				float xOffset = cos(i.uv.x * TAU * 8) * 0.01;
				float t = cos((i.uv.x + xOffset - _Time.y *0.1f ) * TAU * 2)*0.5f + 0.5f;
				t *=1- i.uv.y;

				float topbuttomRemover = (abs(i.normal.y < 0.999));
				float waves = t * topbuttomRemover;

				float4 gradient = lerp(_ColorA, _ColorB, i.uv.y);

				return gradient ;

				//float4 outColor = lerp(_ColorA, _ColorB, t);
				//return outColor;
			}
			ENDCG
		}
	}
}