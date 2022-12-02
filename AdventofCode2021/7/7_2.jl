inp = [16,1,2,0,4,2,7,1,2,14]
inp = parse.(Int, split(readline("7/data.txt"),","))
l = []
triangle_num(n) = n*(n+1) ÷ 2
for pos in minimum(inp):maximum(inp)
    distances = abs.(pos .- inp)
    distances = triangle_num.(distances)
    push!(l,sum(distances))
end
findmin(l)