using ProtoBuf

run(ProtoBuf.protoc(`-I=/Users/peter/onnx/onnx --julia_out=/Users/peter/.julia/dev/OnnxIO/src /Users/peter/onnx/onnx/onnx.proto`))