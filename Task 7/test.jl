#=function next_split!(s::AbstractVector{Int}, k)
    k == 1 && return nothing
    i = k-1  
    while i > 1 && s[i-1]==s[i]
        i -= 1
    end

    s[i] += 1

    r = sum(@view(s[i+1:k]))
    k = i+r-1 # - это с учетом s[i] += 1
    for j in (i + 1):k
        s[j] = 1
    end
    sort!(s)
    summa = 0
    index = 1
    while summa < n
        summa +=s[index]
        index +=1
    end
    s[index:n]  .= 0

    return s, k
end
=#
#=
function next_split!(s::AbstractVector{Int}, k)
    k == 1 && return nothing
    
    i = k - 1
    while i > 1 && s[i-1] == s[i]
        i -= 1
    end

    s[i] += 1

    r = sum(@view(s[i+1:k]))
    k = i + r - 1 # - это с учетом s[i] += 1
    for j in (i + 1):k
        s[j] = 1
    end
    summa = 0
    index = 1
    while summa < n
        summa += s[index]
        index += 1
    end
    s[index:n] .= 0

    return s, k
end

=#

