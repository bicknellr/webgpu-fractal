struct Uniforms {
  position: vec2<f32>;
}

@group(0) @binding(0)
var<storage, read_write> uniforms: Uniforms;

fn cmul(a: vec2<f32>, b: vec2<f32>) -> vec2<f32> {
  let angle = atan(a.y / a.x) + atan(b.y / b.x);
  let length = length(a) * length(b);
  return length * vec2<f32>(cos(angle), sin(angle));
}

@stage(fragment)
fn main(@builtin(position) position: vec4<f32>) -> @location(0) vec4<f32> {
  var pos = (position.xy / 640.0 - 0.5) * 2.0 + uniforms.position;

  for (var i: i32; i < 256; i = i + 1) {
    pos = cmul(pos, pos) + vec2<f32>(0.31, 0.5);
  }

  if (length(pos) < 1.0) {
    return vec4<f32>(1.0, 1.0, 1.0, 1.0);
  } else {
    return vec4<f32>(0.0, 0.0, 0.0, 1.0);
  }
}
