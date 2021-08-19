// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Animmal/Skybox"
{
	Properties
	{
		[Gamma][Header(Cubemap)]_TintColor("Tint Color", Color) = (0.5,0.5,0.5,1)
		_Exposure("Exposure", Range( 0 , 8)) = 1
		[NoScaleOffset]_Tex("Cubemap (HDR)", CUBE) = "black" {}
		[Header(Rotation)][Toggle(_ENABLEROTATION_ON)] _EnableRotation("Enable Rotation", Float) = 0
		[HideInInspector]_Tex_HDR("DecodeInstructions", Vector) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Background"  "Queue" = "Background+0" "IgnoreProjector" = "True" "ForceNoShadowCasting" = "True" "IsEmissive" = "true"  "PreviewType"="Skybox" }
		LOD 100
		Cull Off
		ZWrite Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 2.0
		#pragma shader_feature _ENABLEROTATION_ON
		#pragma surface surf Unlit keepalpha noshadow noambient novertexlights nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd vertex:vertexDataFunc 
		struct Input
		{
			float3 vertexToFrag774;
			float3 worldPos;
		};

		uniform half4 _Tex_HDR;
		uniform samplerCUBE _Tex;
		uniform half4 _TintColor;
		uniform half _Exposure;


		inline half3 DecodeHDR1189( half4 Data )
		{
			return DecodeHDR(Data, _Tex_HDR);
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float lerpResult268 = lerp( 1.0 , ( unity_OrthoParams.y / unity_OrthoParams.x ) , unity_OrthoParams.w);
			float3 appendResult1129 = (float3(ase_worldPos.x , ( ase_worldPos.y * lerpResult268 ) , ase_worldPos.z));
			float3 normalizeResult1130 = normalize( appendResult1129 );
			float3 appendResult56 = (float3(cos( 0.0 ) , 0.0 , ( sin( 0.0 ) * -1.0 )));
			float3 appendResult266 = (float3(0.0 , lerpResult268 , 0.0));
			float3 appendResult58 = (float3(sin( 0.0 ) , 0.0 , cos( 0.0 )));
			float3 normalizeResult247 = normalize( ase_worldPos );
			#ifdef _ENABLEROTATION_ON
				float3 staticSwitch1164 = mul( float3x3(appendResult56, appendResult266, appendResult58), normalizeResult247 );
			#else
				float3 staticSwitch1164 = normalizeResult1130;
			#endif
			o.vertexToFrag774 = staticSwitch1164;
		}

		inline half4 LightingUnlit( SurfaceOutput s, half3 lightDir, half atten )
		{
			return half4 ( 0, 0, 0, s.Alpha );
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			half4 Data1189 = texCUBE( _Tex, i.vertexToFrag774 );
			half3 localDecodeHDR1189 = DecodeHDR1189( Data1189 );
			o.Emission = ( float4( localDecodeHDR1189 , 0.0 ) * unity_ColorSpaceDouble * _TintColor * _Exposure ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
}
/*ASEBEGIN
Version=15600
318;101;1273;899;2893.041;873.671;5.831149;True;False
Node;AmplifyShaderEditor.OrthoParams;267;620.1355,2080.718;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RelayNode;62;-221.0849,1789.085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1007;1068.136,2080.718;Half;False;Constant;_Float7;Float 7;47;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;309;924.1357,2080.718;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1080;130.9151,1661.085;Half;False;Constant;_Float26;Float 26;50;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;59;130.9151,1597.085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1081;130.9151,1837.085;Half;False;Constant;_Float27;Float 27;50;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;268;1260.136,2080.718;Float;False;3;0;FLOAT;1;False;1;FLOAT;0.5;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;61;130.9151,1917.085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CosOpNode;55;130.9151,1533.085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;60;322.9151,1597.085;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;238;770.9152,1757.085;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.CosOpNode;365;130.9151,1981.085;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1128;1026.915,1917.085;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;58;514.9152,1917.085;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;56;514.9152,1533.085;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;266;514.9152,1725.085;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.DynamicAppendNode;1129;1154.915,1789.085;Float;False;FLOAT3;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.MatrixFromVectors;54;770.9152,1533.085;Float;False;FLOAT3x3;True;4;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3x3;0
Node;AmplifyShaderEditor.NormalizeNode;247;1026.915,1661.085;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;49;1282.915,1613.085;Float;False;2;2;0;FLOAT3x3;0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.NormalizeNode;1130;1282.915,1789.085;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;1164;1632,1728;Float;False;Property;_EnableRotation;Enable Rotation;3;0;Create;True;0;0;False;1;Header(Rotation);0;0;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.VertexToFragmentNode;774;2048,1728;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;41;2428.793,1536;Float;True;Property;_Tex;Cubemap (HDR);2;1;[NoScaleOffset];Create;False;0;0;False;0;None;None;True;0;False;black;LockedToCube;False;Object;-1;Auto;Cube;6;0;SAMPLER2D;;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1177;2812.793,1968;Half;False;Property;_Exposure;Exposure;1;0;Create;True;0;0;False;0;1;2.12;0;8;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;1189;2812.793,1536;Half;False;DecodeHDR(Data, _Tex_HDR);3;False;1;True;Data;FLOAT4;0,0,0,0;In;;DecodeHDR;True;False;0;1;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;1173;2812.793,1792;Half;False;Property;_TintColor;Tint Color;0;1;[Gamma];Create;True;0;0;False;1;Header(Cubemap);0.5,0.5,0.5,1;0.5,0.5,0.5,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorSpaceDouble;1175;2812.793,1616;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1174;3324.793,1536;Float;False;4;4;0;FLOAT3;0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.Vector4Node;1190;2428.793,1792;Half;False;Property;_Tex_HDR;DecodeInstructions;5;1;[HideInInspector];Create;False;0;0;True;0;0,0,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;26;3337.885,1795.318;Float;False;True;0;Float;;100;0;Unlit;Animmal/Skybox;False;False;False;False;True;True;True;True;True;True;True;True;False;False;True;True;False;False;False;False;Off;2;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;False;0;True;Background;;Background;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;False;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;100;;4;-1;-1;-1;1;PreviewType=Skybox;False;0;0;False;-1;-1;0;False;-1;0;0;0;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;309;0;267;2
WireConnection;309;1;267;1
WireConnection;59;0;62;0
WireConnection;268;0;1007;0
WireConnection;268;1;309;0
WireConnection;268;2;267;4
WireConnection;61;0;62;0
WireConnection;55;0;62;0
WireConnection;60;0;59;0
WireConnection;60;1;1080;0
WireConnection;365;0;62;0
WireConnection;1128;0;238;2
WireConnection;1128;1;268;0
WireConnection;58;0;61;0
WireConnection;58;1;1081;0
WireConnection;58;2;365;0
WireConnection;56;0;55;0
WireConnection;56;1;1081;0
WireConnection;56;2;60;0
WireConnection;266;0;1081;0
WireConnection;266;1;268;0
WireConnection;266;2;1081;0
WireConnection;1129;0;238;1
WireConnection;1129;1;1128;0
WireConnection;1129;2;238;3
WireConnection;54;0;56;0
WireConnection;54;1;266;0
WireConnection;54;2;58;0
WireConnection;247;0;238;0
WireConnection;49;0;54;0
WireConnection;49;1;247;0
WireConnection;1130;0;1129;0
WireConnection;1164;1;1130;0
WireConnection;1164;0;49;0
WireConnection;774;0;1164;0
WireConnection;41;1;774;0
WireConnection;1189;0;41;0
WireConnection;1174;0;1189;0
WireConnection;1174;1;1175;0
WireConnection;1174;2;1173;0
WireConnection;1174;3;1177;0
WireConnection;26;2;1174;0
ASEEND*/
//CHKSM=001C7A64AAB3B72F571F9F8068EF1F0057794FF4