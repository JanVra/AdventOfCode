using StatsBase

x = readlines("3/data.txt")

function invert_bit(bit)
    if bit == 1
        return 0
    elseif bit == 0
        return 1
    end
end

function find_idx_mode(col)
    cmap = countmap(col)
    if length(cmap) == 1
        key = keys(cmap) |> collect
        if key == 1
            m = 0
        else
            m = 0
        end
    elseif cmap[:1] < cmap[:0]
        m = 0
    else
        m = 1
    end
    idxs = findall(x -> x == m, col)
    return idxs
end

function find_idx_least_common(col)
    cmap = countmap(col)
    if length(cmap) == 1
        key = keys(cmap) |> collect
        if key == 1
            m = 0
        else
            m = 0
        end
    elseif cmap[:1] < cmap[:0]
        m = 1
    else
        m = 0
    end
    idxs = findall(x -> x == m, col)
    return idxs
end

function find_bin_mode(x)
    for col in 1:size(x)[2]
        idx = find_idx_mode(x[:,col])
        x = x[idx,:]
    end
    x = vec(x)
    x = ["$n" for n in x]
    return reduce(*,x)
end

function find_bin_least(x)
    for col in 1:size(x)[2]
        idx = find_idx_least_common(x[:,col])
        x = x[idx,:]
    end
    x = vec(x)
    x = ["$n" for n in x]
    return reduce(*,x)
end

x = reduce(hcat, collect.(x))
x = collect(parse.(Int, x)')

gamma_rate = find_bin_mode(x)
epsilon_rate = find_bin_least(x)

gamma_rate = parse(Int, gamma_rate, base=2)
epsilon_rate = parse(Int, epsilon_rate, base=2)

gamma_rate * epsilon_rate