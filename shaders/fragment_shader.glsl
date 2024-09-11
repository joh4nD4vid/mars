#ifdef GL_ES
precision mediump float;
#endif

uniform float u_time;

varying vec2 v_uv;
varying vec3 v_normal;
varying vec3 vPosition;

uniform sampler2D u_day_mars_texture;
uniform sampler2D u_night_mars_texture;


uniform vec3 uAtmosphereDayColor;
uniform vec3 uAtmosphereTwilightColor;





void main() {

    vec3 viewDirection = normalize(vPosition - cameraPosition);

    vec3 normal = normalize( v_normal );

    float fresnel = dot(viewDirection, normal) + 1.0;
    fresnel = pow(fresnel, 2.0);

    vec3 sunDirection = vec3(0.0, 0.0, 1.0);
    float sunOrientation = dot( sunDirection, normal );
    float atmosphereDayMix = smoothstep(- 0.5, 1.0, sunOrientation);

    vec3 dayColor = texture( u_day_mars_texture, v_uv ).rgb;
    vec3 nightColor = texture( u_night_mars_texture, v_uv ).rgb;
    vec3 color = mix( nightColor, dayColor, atmosphereDayMix );


    vec3 atmosphereColor = mix(uAtmosphereTwilightColor, uAtmosphereDayColor, atmosphereDayMix);
    color = mix(color, atmosphereColor, fresnel * atmosphereDayMix);

    // Couleur du fragment
    gl_FragColor = vec4(color, 1.0);    

}