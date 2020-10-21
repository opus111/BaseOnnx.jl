module BaseOnnx

using ProtoBuf
include("onnx_pb.jl") 
read(io) = readproto(io, ModelProto())

end


