module LoKIHelpers
using Interpolations

# not needed for now
# TODO: make LoKIReaction compatible with Catalyst reactions, some conversion
# function maybe
struct LoKIReaction{S,T}
    """The rate function (excluding mass action terms)."""
    rate::Any
    """Reaction substrates."""
    substrates::Vector{S}
    """Reaction products."""
    products::Vector{S}
    """The stoichiometric coefficients of the reactants."""
    substoich::Vector{T}
    """The stoichiometric coefficients of the products."""
    prodstoich::Vector{T}
    """Type of the collision (Effective, Excitation, etc)"""
    type::Any
end


struct LoKIRateCoefficient{I}
    name
    interp::I
end

Base.nameof(k::LoKIRateCoefficient) = k.name
# Base.show(io::IO, k::LoKIRateCoefficient) = Base.show(io::IO,k.name)
Base.show(io::IO, k::LoKIRateCoefficient) = Base.print(io::IO,"k[$(k.name)]")

using Symbolics: Num, unwrap, SymbolicUtils
(k::LoKIRateCoefficient)(t::Num) = SymbolicUtils.term(k, unwrap(t))
SymbolicUtils.promote_symtype(t::LoKIRateCoefficient, _...) = Real

(k::LoKIRateCoefficient)(t) = k.interp(t)
# (k::LoKIRateCoefficient)(t::Num) = k.interp(t)

include("utils.jl")
export loki_rate, loki_swarm

end




