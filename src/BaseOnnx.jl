module BaseOnnx

using ProtoBuf
include("onnx_pb.jl") 
include("read.jl")
include("write.jl")

read(io) = readproto(io, ModelProto())

end


