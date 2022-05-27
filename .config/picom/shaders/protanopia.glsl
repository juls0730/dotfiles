 
uniform sampler2D tex;
uniform float opacity;

void main() {
  float intensity = 1.0;
  vec4 c = texture2D(tex, gl_TexCoord[0].xy);
  float y = dot(c.rgb, vec3(0.2126, 0.7152, 0.0722));
  float L = (17.8824 * c.r) + (43.5161 * c.g) + (4.11935 * c.b);
  float M = (3.45565 * c.r) + (27.1554 * c.g) + (3.86714 * c.b);
  float S = (0.0299566 * c.r) + (0.184309 * c.g) + (1.46709 * c.b);

  float l, m, s;
  l = 0.0 * L + 2.02344 * M + -2.52581 * S;
  m = 0.0 * L + 1.0 * M + 0.0 * S;
  s = 0.0 * L + 0.0 * M + 1.0 * S;

  vec4 error;
  error.r = (0.0809444479 * l) + (-0.130504409 * m) + (0.116721066 * s);
  error.g = (-0.0102485335 * l) + (0.0540193266 * m) + (-0.113614708 * s);
  error.b = (-0.000365296938 * l) + (-0.00412161469 * m) + (0.693511405 * s);
  error.a = 1.0;

  vec4 diff = c - error;
  vec4 correction;
  correction.r = 0.0;
  correction.g =  (diff.r * 0.7) + (diff.g * 1.0);
  correction.b =  (diff.r * 0.7) + (diff.b * 1.0);
  correction = c + correction;
  correction.a = c.a * intensity;


  gl_FragColor = opacity*correction;
}
