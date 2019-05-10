Shader "Unlit/NoiseShader"
{
    Properties
    {
        [HideInInspector]
        _MainTex ("Texture", 2D) = "white" {}

        _Color("Color", Color) = (1, 1, 1, 1)
        _NoiseFrequency ("Noise Frequency", float) = 5
        _NoiseClampLow ("Noise Clamp Low", Range(0,1.0)) = 0.0
        _NoiseClampHigh ("Noise Clamp High", Range(0,1.0)) = 0.2
        _NoiseOffset ("Noise Offset", Vector) = (0, 0, 0, 0)
    }
    SubShader
    {
        Tags {"Queue"="Transparent" "RenderType"="Transparent" }
        LOD 100

        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "noiseSimplex.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;

            fixed4 _Color;

            float _NoiseFrequency;
            float3 _NoiseOffset;
            float _NoiseClampLow;
            float _NoiseClampHigh;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = _Color;

                // perform simplex noise calculations
                float noise = snoise(float2(i.uv.x + _NoiseOffset.x, i.uv.y + _NoiseOffset.y) * _NoiseFrequency);
                if(!(noise >= _NoiseClampLow && noise <= _NoiseClampHigh))
                    col.a = 0;

                return col;
            }
            ENDCG
        }
    }
}
