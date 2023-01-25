using CSV,DataFrames
using DataInterpolations

function lookup_rate(name, loki_folder)
    lookup_file = loki_folder * "lookUpTableRateCoeff.txt"
    df = CSV.read(lookup_file,DataFrame,
        comment="#",
        delim=' ',
        ignorerepeated=true
    )
    df[!,1], df[!,name*"(m^3s^-1)"]
end

function lookup_swarm(name, loki_folder)
    lookup_file = loki_folder * "lookUpTableSwarm.txt"
    df = CSV.read(lookup_file,DataFrame,
        comment="#",
        delim=' ',
        ignorerepeated=true
    )
    df[!,1], df[!,name]
end

findclosest(a,A) = findmin(x->abs.(x.-a), A)[2]
function reduced_interpolation(f,x, N; xmin=0, xmax=500, interpolation=LinearInterpolation)
    is = findclosest.([0;exp.(range(0,log(xmax),N))], Ref(x)) |> unique
    return interpolation(f[is], x[is])
end


function loki_rate(indices, loki_folder;name=nothing,N=20, interpolation=LinearInterpolation)
    if indices isa Vector 
        ks = []
        E = []
        for i in indices
            E, ki = lookup_rate(i,loki_folder)
            push!(ks, ki)
        end
        name = name === nothing ?  reduce((x,y)-> x*","*y,indices) : name
        k = sum(ks)
    else  
        E,k = lookup_rate(indices, loki_folder)
        name = name === nothing ?  indices : name
    end
    interp = N===nothing ? interpolation(k,E) : reduced_interpolation(k,E,N;interpolation)  
    return LoKIRateCoefficient(Symbol(name),interp)
end

function loki_swarm(indices, loki_folder; N=20, interpolation=LinearInterpolation)
    if indices isa Vector
        ks = []
        E = []
        for i in indices
            E, ki = lookup_swarm(i,loki_folder)
            push!(ks, ki)
        end
        k = sum(ks)
    else
        E, k = lookup_swarm(indices,loki_folder)
    end
    interp = N===nothing ? interpolation(k,E) : reduced_interpolation(k,E,N;interpolation)  
    return interp
end

