x = readlines("9/data.txt")
x = collect.(x)
x = [parse.(Int, l) for l in x]
x = reduce(hcat, x)
mat = convert(Matrix{Int}, x)

lows = []
for x_idx in eachindex(mat[:, 1])
    for y_idx in eachindex(mat[1, :])
        max_x_idx = length(mat[:, 1])
        max_y_idx = length(mat[1, :])
        next_x_idx = min(max_x_idx, x_idx + 1)
        next_y_idx = min(max_y_idx, y_idx + 1)
        prev_x_idx = max(1, x_idx - 1)
        prev_y_idx = max(1, y_idx - 1)

        min_surrounding = minimum([
            mat[next_x_idx, y_idx],
            mat[x_idx, next_y_idx],
            mat[prev_x_idx, y_idx],
            mat[x_idx, prev_y_idx]])

        if mat[x_idx, y_idx] <= min_surrounding
            push!(lows, mat[x_idx, y_idx])
        end
    end
end

length(lows) + sum(lows)

using Plots

heatmap(mat)