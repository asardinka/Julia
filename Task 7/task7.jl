include("utils.jl")
abstract type AbstractCombinObject
    # value Vector{Int} - это поле предполагается у всех
    # конкретных типов, наследующих от данного типа
end
Base.iterate(obj::AbstractCombinObject) = (get(obj), nothing)
Base.iterate(obj::AbstractCombinObject, state) = 
    if isnothing(next!(obj)) #  false
        nothing
    else
        (get(obj), nothing)
    end
    
# Размещения с повторениями
struct RepitPlacement{N,K} <: AbstractCombinObject
    value::Vector{Int}
    RepitPlacement{N,K}() where {N, K} = new(ones(Int, K))
end

Base.get(p::RepitPlacement) = p.value
next!(p::RepitPlacement{N,K}) where {N, K} = next_repit_placement!(p.value, N)
    
#=
for a in RepitPlacement{2,3}()
    println(a)
end
=#

# Перестановки
struct Permute{N} <: AbstractCombinObject
    value::Vector{Int}
    Permute{N}() where N = new(collect(1:N))
end


Base.get(obj::Permute) = obj.value
next!(permute::Permute) = next_permute!(permute.value)
#=
for p in Permute{4}()
    println(p)
end
=#

#  Все подмножества N-элементного множества
struct Subsets{N} <: AbstractCombinObject
    indicator::Vector{Bool}
    Subsets{N}() where N = new(zeros(Bool, N))
end
Base.get(sub::Subsets) = sub.indicator
next!(sub::Subsets) = next_indicator!(sub.indicator)

#=
for sub in Subsets{2}()
    println(sub)
end
=#

# k-элементные подмножества n-элементного множества

struct KSubsets{M,K} <: AbstractCombinObject
    indicator::Vector{Bool}
    KSubsets{M, K}() where{M, K} = new([zeros(Bool, length(M)-K); ones(Bool, K)])
end
Base.get(sub::KSubsets) = sub.indicator
next!(sub::KSubsets{M, K}) where{M, K} = next_indicator!(sub.indicator)

#=
for sub in KSubsets{1:3, 3}()
    sub |> println
end
=#   


# Разбиения
#=
struct NSplit{N} <: AbstractCombinObject
    value::Vector{Int64}
    num_terms::Int # число слагаемых (это число мы обозначали - k)
    NSplit{N}() where N = new(collect(1:N), N)
end

Base.get(nsplit::NSplit) = nsplit.value[begin:nsplit.num_terms]

function next!(nsplit::NSplit)
    #nsplit.value, nsplit.num_terms = 
    next_split!(nsplit.value, nsplit.num_terms)
    #get(nsplit)
end

n = 5
for s in NSplit{n}()
    println(s)
end
=#

#Алгоритмы обхода графа "поиск в глубину" и "поиск в ширину"


function dfs(graph::Dict{I, Vector{I}}, vstart::I) where I <: Integer
    stack = [vstart]
    mark = zeros(Bool, length(graph)) 
    mark[vstart] = true
    while !isempty(stack)
        v = pop!(stack)
        println("Visited: $v")
        for u in graph[v]
            if !mark[u]
                mark[u] = true
                push!(stack,u)
            end
        end
    end
end

graph = Dict(
    1 => [2, 3],
    2 => [1, 4, 5],
    3 => [1, 6, 7],
    4 => [2],
    5 => [2],
    6 => [3],
    7 => [3]
)

dfs(graph, 1)