// glm function bindings
// adapted from https://github.com/IndiumGames/swig-wrapper-glm
//
// The MIT License (MIT)
//
// Copyright (c) 2016 Indium Games (www.indiumgames.fi)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

%define FLOAT_VECTOR(function_name)
    vec2 function_name(const vec2 &);
    vec3 function_name(const vec3 &);
    vec4 function_name(const vec4 &);
%enddef

%define FLOAT_VECTOR_2_PARAMS(function_name)
    vec2 function_name(const vec2 &, const vec2 &);
    vec3 function_name(const vec3 &, const vec3 &);
    vec4 function_name(const vec4 &, const vec4 &);
%enddef

%define FLOAT_VECTOR_3_PARAMS(function_name)
    vec2 function_name(const vec2 &, const vec2 &, const vec2 &);
    vec3 function_name(const vec3 &, const vec3 &, const vec3 &);
    vec4 function_name(const vec4 &, const vec4 &, const vec4 &);
%enddef

%define FLOAT_VECTOR_RETURN_VALUE(function_name)
    float function_name(const vec2 &);
    float function_name(const vec3 &);
    float function_name(const vec4 &);
%enddef

%define FLOAT_VECTOR_RETURN_VALUE_2_PARAMS(function_name)
    float function_name(const vec2 &, const vec2 &);
    float function_name(const vec3 &, const vec3 &);
    float function_name(const vec4 &, const vec4 &);
%enddef

%define FLOAT_SCALAR_OR_VECTOR(function_name)
    float function_name(const float &);
    vec2  function_name(const vec2 &);
    vec3  function_name(const vec3 &);
    vec4  function_name(const vec4 &);
%enddef

%define FLOAT_SCALAR_OR_VECTOR_RETURN_VALUE(function_name)
    float function_name(const float &);
    float function_name(const vec2 &);
    float function_name(const vec3 &);
    float function_name(const vec4 &);
%enddef

%define FLOAT_SCALAR_OR_VECTOR_2_PARAMS(function_name)
    float function_name(const float &, const float &);
    vec2 function_name(const vec2 &, const vec2 &);
    vec3 function_name(const vec3 &, const vec3 &);
    vec4 function_name(const vec4 &, const vec4 &);
%enddef

%define FLOAT_SCALAR_OR_VECTOR_2_PARAMS_VECTOR_VALUE(function_name)
    vec2 function_name(const vec2 &, const float &);
    vec3 function_name(const vec3 &, const float &);
    vec4 function_name(const vec4 &, const float &);
%enddef

%define FLOAT_SCALAR_OR_VECTOR_3_PARAMS(function_name)
    float function_name(const float &, const float &, const float &);
    vec2 function_name(const vec2 &, const vec2 &, const vec2  &);
    vec3 function_name(const vec3 &, const vec3 &, const vec3  &);
    vec4 function_name(const vec4 &, const vec4 &, const vec4  &);
%enddef

%define FLOAT_SCALAR_OR_VECTOR_3_PARAMS_VECTOR_VALUE_VALUE(function_name)
    vec2 function_name(const vec2 &, const float &, const float &);
    vec3 function_name(const vec3 &, const float &, const float &);
    vec4 function_name(const vec4 &, const float &, const float &);
%enddef

// ----- glm/detail/func_common.hpp -----

FLOAT_SCALAR_OR_VECTOR(abs);
FLOAT_SCALAR_OR_VECTOR(sign);
FLOAT_SCALAR_OR_VECTOR(floor);
FLOAT_SCALAR_OR_VECTOR(trunc);
FLOAT_SCALAR_OR_VECTOR(round);
FLOAT_SCALAR_OR_VECTOR(roundEven);
FLOAT_SCALAR_OR_VECTOR(ceil);
FLOAT_SCALAR_OR_VECTOR(fract);
FLOAT_SCALAR_OR_VECTOR_2_PARAMS(mod);
FLOAT_SCALAR_OR_VECTOR_2_PARAMS_VECTOR_VALUE(mod);
float modf(const float &, float &);
vec2 modf(const vec2 &, vec2 &);
vec3 modf(const vec3 &, vec3 &);
vec4 modf(const vec4 &, vec4 &);
FLOAT_SCALAR_OR_VECTOR_2_PARAMS(min);
FLOAT_SCALAR_OR_VECTOR_2_PARAMS_VECTOR_VALUE(min);
FLOAT_SCALAR_OR_VECTOR_2_PARAMS(max);
FLOAT_SCALAR_OR_VECTOR_2_PARAMS_VECTOR_VALUE(max);
FLOAT_SCALAR_OR_VECTOR_3_PARAMS(clamp);
FLOAT_SCALAR_OR_VECTOR_3_PARAMS_VECTOR_VALUE_VALUE(clamp);
float mix(const float &, const float &, const float &);
float mix(const float &, const float &, const bool  &);
vec2 mix(const vec2 &, const vec2 &, const vec2  &);
vec3 mix(const vec3 &, const vec3 &, const vec3  &);
vec4 mix(const vec4 &, const vec4 &, const vec4  &);
vec2 mix(const vec2 &, const vec2 &, const bool &);
vec3 mix(const vec3 &, const vec3 &, const bool &);
vec4 mix(const vec4 &, const vec4 &, const bool &);
vec2 step(const vec2 &, const vec2 &);
vec3 step(const vec3 &, const vec3 &);
vec4 step(const vec4 &, const vec4 &);
vec2 step(const float &, const vec2 &);
vec3 step(const float &, const vec3 &);
vec4 step(const float &, const vec4 &);
FLOAT_SCALAR_OR_VECTOR_3_PARAMS(smoothstep);
vec2 smoothstep(const float &, const float &, const vec2 &);
vec3 smoothstep(const float &, const float &, const vec3 &);
vec4 smoothstep(const float &, const float &, const vec4 &);
bool isnan(const float &);
bool isinf(const float &);
FLOAT_SCALAR_OR_VECTOR_3_PARAMS(fma);

// ----- glm/detail/func_exponential.hpp -----

FLOAT_SCALAR_OR_VECTOR_2_PARAMS(pow);
FLOAT_SCALAR_OR_VECTOR(exp);
FLOAT_SCALAR_OR_VECTOR(log);
FLOAT_SCALAR_OR_VECTOR(exp2);
FLOAT_SCALAR_OR_VECTOR(log2);
FLOAT_VECTOR(sqrt);
FLOAT_SCALAR_OR_VECTOR(inversesqrt);

// ----- detail/func_geometric.hpp -----

FLOAT_VECTOR_RETURN_VALUE(length);
FLOAT_VECTOR_RETURN_VALUE_2_PARAMS(distance);
FLOAT_VECTOR_RETURN_VALUE_2_PARAMS(dot);
vec3 cross(const vec3 &, const vec3 &);
FLOAT_VECTOR(normalize);
FLOAT_VECTOR_3_PARAMS(faceforward);
FLOAT_VECTOR_2_PARAMS(reflect);
vec2 refract(const vec2 &, const vec2 &, const float &);
vec3 refract(const vec3 &, const vec3 &, const float &);
vec4 refract(const vec4 &, const vec4 &, const float &);

// ----- glm/detail/func_matrix.hpp -----

mat3 matrixCompMult(const mat3 &, const mat3 &);
mat4 matrixCompMult(const mat4 &, const mat4 &);
mat3 outerProduct(const vec3 &, const vec3 &);
mat4 outerProduct(const vec4 &, const vec4 &);
mat3 transpose(const mat3 &);
mat4 transpose(const mat4 &);
float determinant(const mat3 &);
float determinant(const mat4 &);
mat3 inverse(const mat3 &);
mat4 inverse(const mat4 &);

// ----- glm/detail/func_trigonometric.hpp -----

FLOAT_SCALAR_OR_VECTOR(radians);
FLOAT_SCALAR_OR_VECTOR(degrees);
FLOAT_SCALAR_OR_VECTOR(sin);
FLOAT_SCALAR_OR_VECTOR(cos);
FLOAT_SCALAR_OR_VECTOR(tan);
FLOAT_SCALAR_OR_VECTOR(asin);
FLOAT_SCALAR_OR_VECTOR(acos);
FLOAT_SCALAR_OR_VECTOR_2_PARAMS(atan);
FLOAT_SCALAR_OR_VECTOR(atan);
FLOAT_SCALAR_OR_VECTOR(sinh);
FLOAT_SCALAR_OR_VECTOR(cosh);
FLOAT_SCALAR_OR_VECTOR(tanh);
FLOAT_SCALAR_OR_VECTOR(asinh);
FLOAT_SCALAR_OR_VECTOR(acosh);
FLOAT_SCALAR_OR_VECTOR(atanh);

// ----- glm/detail/func_vector_relational.hpp -----

// skipping for now due to bvec types

// ----- glm/gtc/matrix_access.hpp -----

vec3 row(const mat3 &,    const length_t &);
vec4 row(const mat4 &,    const length_t &);
mat3 row(const mat3 &,    const length_t &, const vec3 &);
mat4 row(const mat4 &,    const length_t &, const vec4 &);
vec3 column(const mat3 &, const length_t &);
vec4 column(const mat4 &, const length_t &);
mat3 column(const mat3 &, const length_t &, const vec3 &);
mat4 column(const mat4 &, const length_t &, const vec4 &);

// ----- glm/gtc/matrix_inverse.hpp -----

mat3 affineInverse(const mat3 &);
mat4 affineInverse(const mat4 &);
mat3 inverseTranspose(const mat3 &);
mat4 inverseTranspose(const mat4 &);

// ----- glm/gtc/matrix_transform.hpp -----

mat4 translate(const mat4 &, const vec3 &);
mat4 rotate(const mat4 &, const float &, const vec3 &);
mat4 scale(const mat4 &, const vec3 &);
mat4 ortho(const float &, const float &,
             const float &, const float &);
mat4 ortho(const float &, const float &,
             const float &, const float &,
             const float &, const float &);
mat4 frustum(const float &, const float &,
               const float &, const float &,
               const float &, const float &);
mat4 perspective(const float &, const float &,
                   const float &, const float &);
mat4 perspectiveFov(const float &,
                      const float &, const float &,
                      const float &, const float &);
mat4 infinitePerspective(const float &, const float &, const float &);
mat4 tweakedInfinitePerspective(const float &, const float &, const float &);
vec3 project(const vec3 &, const mat4 &, const mat4 &, const vec4 &);
vec3 unProject(const vec3 &, const mat4 &, const mat4 &, const vec4 &);
mat4 pickMatrix(const vec2 &, const vec2 &, const vec4 &);
mat4 lookAt(const vec3 &, const vec3 &, const vec3 &);

// ----- glm/gtc/reciprocal.hpp -----

FLOAT_SCALAR_OR_VECTOR(sec);
FLOAT_SCALAR_OR_VECTOR(csc);
FLOAT_SCALAR_OR_VECTOR(cot);
FLOAT_SCALAR_OR_VECTOR(asec);
FLOAT_SCALAR_OR_VECTOR(acsc);
FLOAT_SCALAR_OR_VECTOR(acot);
FLOAT_SCALAR_OR_VECTOR(sech);
FLOAT_SCALAR_OR_VECTOR(csch);
FLOAT_SCALAR_OR_VECTOR(coth);
FLOAT_SCALAR_OR_VECTOR(asech);
FLOAT_SCALAR_OR_VECTOR(acsch);
FLOAT_SCALAR_OR_VECTOR(acoth);
