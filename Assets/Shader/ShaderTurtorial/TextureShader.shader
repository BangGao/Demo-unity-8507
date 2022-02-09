Shader "Custom/TextureShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    	_Pattern("Pattern",2D) = "white"{}
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
                float3 worldPosition:TEXCOORD1;   //World coordinates
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;//optional

            sampler2D _Pattern;

            Interpolators vert (MeshData v)
            {
                Interpolators o;

                o.worldPosition = mul(UNITY_MATRIX_M, v.vertex);//object to world
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.uv.x += _Time.y * 0.1;
                return o;
            }

            float4 frag(Interpolators i) : SV_Target
            {
                float2 topDownProjection = i.worldPosition.xz;

                //return float4(topDownProjection,0,1);

                // sample the texture
                fixed4 col = tex2D(_MainTex, topDownProjection);
                return col;
            }
            ENDCG
        }
    }
}
