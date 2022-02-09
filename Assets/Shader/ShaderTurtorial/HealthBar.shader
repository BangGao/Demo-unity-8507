Shader "Custom/HealthBar"
{
    Properties
    {
        [NoScaleOffset]_MainTex ("Texture", 2D) = "black" {}
        _Health("Health",Range(0,1)) = 1
    	_BorderSize("Border Size",Range(0,0.5)) = 0.1
    }
    SubShader
    {
        Tags { "RenderType"="Trasparent" "Queue" = "Transparent"}

        Pass
        {
        	
        	ZWrite off
        	//src * X + dst * Y
        	Blend SrcAlpha OneMinusSrcAlpha
        	
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct MeshData
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct Interpolater
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float _Health;
            float _borderSize;

            Interpolater vert (MeshData v)
            {
                Interpolater o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv, _MainTex;
                return o;
            }

            float InversLerp(float a,float b,float v)
            {
                return (v - a) / (b - a);
            }

            float4 frag(Interpolater i) : SV_Target
            {
                //round cornor cliping
                float2 coords = i.uv;
                coords.x *= 8;

                float2 pointOnLineSeg = float2(clamp(coords.x,0.5,7.5), 0.5);
                float sdf = distance(coords, pointOnLineSeg) * 2 - 1;

                clip(-sdf);

                float borderSdf = sdf + _borderSize;
                float borderMask = step(0,-borderSdf);

                //return float4(borderMask.xxx, 1);

                float3 healthbarColor = tex2D( _MainTex, float2(_Health,i.uv.y));

                float flash = cos(_Time.y * 4) * 0.1 +1;
                float healthbarMask = _Health > i.uv.x;
                healthbarMask *= flash;


            	return float4(healthbarColor * healthbarMask * borderMask,1);

            }
            ENDCG
        }
    }
}
