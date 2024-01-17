const points = array<vec2<f32>, 6>(
  vec2<f32>(-1.0, -1.0),
  vec2<f32>(1.0, -1.0),
  vec2<f32>(-1.0, 1.0),
  vec2<f32>(1.0, -1.0),
  vec2<f32>(-1.0, 1.0),
  vec2<f32>(1.0, 1.0),
);

@vertex
fn main(@builtin(vertex_index) index: u32) -> @builtin(position) vec4<f32> {
  return vec4<f32>(points[index], 0.0, 1.0);
}
