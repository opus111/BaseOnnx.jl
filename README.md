# BaseOnnx

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://opus111.github.io/BaseOnnx.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://opus111.github.io/BaseOnnx.jl/dev)
[![Build Status](https://travis-ci.com/opus111/BaseOnnx.jl.svg?branch=master)](https://travis-ci.com/opus111/BaseOnnx.jl)

# About
Core library for reading and writing ONNX formatted model files. Mostly contains generated ProtoBuf.jl code

# Test with
```
open("data/mnist-8.onnx", "r") do io
    BaseOnnx.read(io) 
end
```

