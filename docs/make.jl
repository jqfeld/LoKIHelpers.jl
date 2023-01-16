using LoKIHelpers
using Documenter

DocMeta.setdocmeta!(LoKIHelpers, :DocTestSetup, :(using LoKIHelpers); recursive=true)

makedocs(;
    modules=[LoKIHelpers],
    authors="Jan Kuhfeld <jan.kuhfeld@rub.de> and contributors",
    repo="https://github.com/jqfeld/LoKIHelpers.jl/blob/{commit}{path}#{line}",
    sitename="LoKIHelpers.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://jqfeld.github.io/LoKIHelpers.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/jqfeld/LoKIHelpers.jl",
    devbranch="main",
)
