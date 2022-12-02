inp = [16,1,2,0,4,2,7,1,2,14]
inp = parse.(Int, split(readline("7/data.txt"),","))
l = []
for pos in minimum(inp):maximum(inp)
    push!(l,abs.(pos .- inp) |> sum)
end
findmin(l)