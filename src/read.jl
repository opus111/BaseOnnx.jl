
# Convenience function to allow for things like Array(tp) or CuArray(tp)
# Not sure if this counts as type piracy...
(::Type{T})(p::TensorProto) where T = array(p) |> T
(::Type{Ref{T}})(p::TensorProto) where T = array(p) |> T |> Ref


"""
    array(p::TensorProto)

Return `p` as an reshaped and reinterpreted array.
"""
function array(p::TensorProto)
    # Copy pasted from jl
    # Can probably be cleaned up a bit 
    # TODO: Add missing datatypes...
    if p.data_type === TensorProto_DataType.INT64
        if isdefined(p, :int64_data)
            return reshape(reinterpret(Int64, p.int64_data), reverse(p.dims)...)
        end
        return reshape(reinterpret(Int64, p.raw_data), reverse(p.dims)...)
    end

    if p.data_type === TensorProto_DataType.INT32
        if isdefined(p, :int32_data)
            return reshape(p.int32_data , reverse(p.dims)...)
        end
        return reshape(reinterpret(Int32, p.raw_data), reverse(p.dims)...)
    end

    if p.data_type === TensorProto_DataType.INT8
        return reshape(reinterpret(Int8, p.raw_data), reverse(p.dims)...)
    end

    if p.data_type === TensorProto_DataType.DOUBLE
        if isdefined(p, :double_data)
            return reshape(p.double_data , reverse(p.dims)...)
        end
        return reshape(reinterpret(Float64, p.raw_data), reverse(p.dims)...)
    end

    if p.data_type === TensorProto_DataType.FLOAT
        if isdefined(p,:float_data)
            return reshape(reinterpret(Float32, p.float_data), reverse(p.dims)...)
        end
        return reshape(reinterpret(Float32, p.raw_data), reverse(p.dims)...) 
    end

    if p.data_type === TensorProto_DataType.FLOAT16
        return reshape(reinterpret(Float16, p.raw_data), reverse(p.dims)...)
    end
end

Base.size(vip::ValueInfoProto) = size(vip._type)
Base.size(tp::TypeProto) = size(tp.tensor_type)
Base.size(tp_t::TypeProto_Tensor) = size(tp_t.shape)
Base.size(tsp::TensorShapeProto) = size.(Tuple(reverse(tsp.dim)))
Base.size(tsp_d::TensorShapeProto_Dimension) = isdefined(tsp_d, :dim_value) ? tsp_d.dim_value : missing

"""
    attribute(p::AttributeProto) 

Return attribute in `p` as a name => value pair.
"""
function attribute(p::AttributeProto)
    # Copy paste from ONNX.jl
    if (p._type != 0)
        field = [:f, :i, :s, :t, :g, :floats, :ints, :strings, :tensors, :graphs][p._type]
        if field === :s 
            return Symbol(p.name) => String(getfield(p, field))
        elseif  field === :strings
            return Symbol(p.name) => String.(getfield(p, field))
        end
        return Symbol(p.name) => getfield(p, field)
    end  
end
