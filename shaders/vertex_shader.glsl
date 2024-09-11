varying vec2 v_uv;
varying vec3 vPosition;
varying vec3 v_normal;


void main() {
    v_uv = uv;

    vec4 modelPosition = modelMatrix * vec4(position, 1.0);
    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition;
    
    vec3 modelNormal = (modelMatrix * vec4(normal, 0.0)).xyz;


    v_normal = modelNormal;
    vPosition = modelPosition.xyz;
    gl_Position = projectedPosition;
}
    