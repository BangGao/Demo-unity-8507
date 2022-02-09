Shader "Custom/VertexOffset"
{
	Properties
	{
		_ColorA("Color",Color) = (1,1,1,1)
		_ColorB("Color",Color) = (1,1,1,1)
		_ColorStart("Color Start",Range(0,1)) = 0
		_ColorEnd("Color End",Range(0,1)) = 1
		_WaveAmp("Wave Amplitude",Range(0,0.2)) = 0.1
	}
		SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
			
		}
		LOD 100

		Pass
		{

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			#define TAU 6.28318530718

			float4 _ColorA;
			float4 _ColorB;
			float _ColorStart;
			float _ColorEnd;
			float _WaveAmp;


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

			float InverseLerp(float a, float b, float v)
			{
				return (v - a) / (b - a);
			}

			float GetWave(float2 uv)
			{
				float2 uvsCentered = uv * 2 - 1;

				float radialDistance = length(uvsCentered);
				//return float4(radialDistance.xxx,1);

				float wave = cos((radialDistance - _Time.y * 0.1f) * TAU * 5) * 0.5 + 0.5;
				wave *= 1 - radialDistance;
				return wave;
			}
			//Vertex Shader output
			Interpolatpors vert(MeshData v)
			{
				Interpolatpors o;

				v.vertex.y = GetWave(v.uv0) * _WaveAmp;

				o.vertex = UnityObjectToClipPos(v.vertex);
				o.normal = UnityObjectToWorldNormal(v.vertex); //From local space to world space
				o.uv = v.uv0; //(v.uv0 + _Offset) * _Scale;//passthrough
				return o;
			}

			

			//fragment shader
			fixed4 frag(Interpolatpors i) : SV_Target
			{
				return GetWave(i.uv);
			}
			ENDCG
		}
	}
}