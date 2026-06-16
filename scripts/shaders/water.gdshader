shader_type spatial;
render_mode blend_mix, depth_draw_always, diffuse_lambert, specular_schlick_ggx;

// Core appearance
uniform vec4 water_color : source_color = vec4(0.0, 0.4, 0.6, 0.85);
uniform float roughness : hint_range(0.0, 1.0) = 0.1;
uniform float metallic : hint_range(0.0, 1.0) = 0.0;

// Lighting normal textures
uniform sampler2D wave_noise1 : hint_normal;
uniform sampler2D wave_noise2 : hint_normal;
uniform float wave_strength : hint_range(0.0, 0.5) = 0.15;
uniform vec2 wave_speed1 = vec2(0.03, 0.01);
uniform vec2 wave_speed2 = vec2(-0.02, 0.02);

uniform float wave_height = 0.2;
uniform float wave_frequency = 1.5;

void vertex() {
	float wave = sin(NODE_POSITION_WORLD.x + VERTEX.x * wave_frequency + TIME) * 
	             cos(NODE_POSITION_WORLD.z + VERTEX.z * wave_frequency + TIME);
	VERTEX.y += wave * wave_height;
}

void fragment() {
	vec2 uv1 = UV + TIME * wave_speed1;
	vec2 uv2 = UV + TIME * wave_speed2;
	
	vec3 normal1 = texture(wave_noise1, uv1).rgb * 2.0 - 1.0;
	vec3 normal2 = texture(wave_noise2, uv2).rgb * 2.0 - 1.0;
	vec3 blended_normal = normalize(normal1 + normal2);
	
	NORMAL_MAP = mix(vec3(0.0, 0.0, 1.0), blended_normal, wave_strength);
	
	ALBEDO = water_color.rgb;
	ALPHA = water_color.a;
	ROUGHNESS = roughness;
	METALLIC = metallic;
}
