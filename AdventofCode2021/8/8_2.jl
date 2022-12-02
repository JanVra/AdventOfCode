strs = getindex.((split.(readlines("8/data.txt"),"| ")),2)
strs = "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab | cdfeb fcadb cdfeb cdbaf"
strs = split(strs, " | ")
inp = split.(strs, " ")
# l = []

# for vals in out_vals
#     tmp = length.(vals)
#     sort!(tmp)
#     #unique!(tmp)
#     push!(l, tmp)
# end

# out = vcat(l...)

# filter(x -> x ∈ [2, 4, 3, 7], out) |> length

#for  in out_vals
vals , out_vals = inp
vals = collect.(vals)
out_vals = collect.(out_vals)
vals = vcat(vals, out_vals)

vals
translation = Dict()
length_dict = Dict()

[find_len.(vals, len) for len in 2:7]

find_len(vals, len) = vals[findall(x -> length(x) == len, vals)...]

translation[:1] = find_len(vals, 2)
translation[:4] = vals[findall(x -> length(x) == 4, vals)...]
translation[:7] = vals[findall(x -> length(x) == 3, vals)...]
translation[:8] = vals[findall(x -> length(x) == 7, vals)...]

segs_in_4_1 = union(translation[:1], translation[:4])
