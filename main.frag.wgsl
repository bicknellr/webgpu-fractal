struct Uniforms {
  viewMatrix: mat4x4<f32>;
  maxIterations: f32;
  cRe: f32;
  cIm: f32;
}

@group(0) @binding(0)
var<storage, read_write> uniforms: Uniforms;

fn cmul(a: vec2<f32>, b: vec2<f32>) -> vec2<f32> {
  let angle = atan(a.y / a.x) + atan(b.y / b.x);
  let length = length(a) * length(b);
  return length * vec2<f32>(cos(angle), sin(angle));
}

let palette_len = 12;
let palette = array<vec4<f32>, palette_len>(
  vec4<f32>(1.0, 0.0, 0.0, 1.0),
  vec4<f32>(1.0, 0.5, 0.0, 1.0),
  vec4<f32>(1.0, 1.0, 0.0, 1.0),
  vec4<f32>(0.5, 1.0, 0.0, 1.0),
  vec4<f32>(0.0, 1.0, 0.0, 1.0),
  vec4<f32>(0.0, 1.0, 0.5, 1.0),
  vec4<f32>(0.0, 1.0, 1.0, 1.0),
  vec4<f32>(0.0, 0.5, 1.0, 1.0),
  vec4<f32>(0.0, 0.0, 1.0, 1.0),
  vec4<f32>(0.5, 0.0, 1.0, 1.0),
  vec4<f32>(1.0, 0.0, 1.0, 1.0),
  vec4<f32>(1.0, 0.0, 0.5, 1.0),
);

@stage(fragment)
fn main(@builtin(position) position: vec4<f32>) -> @location(0) vec4<f32> {
  var pos = (uniforms.viewMatrix * position).xy;

  var i: i32 = 0;
  for (; length(pos) <= 4.0 && i < i32(uniforms.maxIterations); i = i + 1) {
    pos = cmul(pos, pos) + vec2<f32>(uniforms.cRe, uniforms.cIm);
  }

  if (length(pos) > 1.0) {
    return palette[i % palette_len];
  } else {
    return vec4<f32>(0.0, 0.0, 0.0, 1.0);
  }
}
