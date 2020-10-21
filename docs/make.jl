using BaseOnnx
using Documenter

makedocs(;
    modules=[BaseOnnx],
    authors="Peter Wolf, Julia Community",
    repo="https://github.com/opus111/BaseOnnx.jl/blob/{commit}{path}#L{line}",
    sitename="BaseOnnx.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://opus111.github.io/BaseOnnx.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/opus111/BaseOnnx.jl",
)
