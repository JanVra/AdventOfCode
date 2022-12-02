strs = getindex.((split.(readlines("8/data.txt"),"| ")),2)
out_vals = split.(strs, " ")
l = []

for vals in out_vals
    tmp = length.(vals)
    sort!(tmp)
    #unique!(tmp)
    push!(l, tmp)
end

out = vcat(l...)

filter(x -> x ∈ [2, 4, 3, 7], out) |> length