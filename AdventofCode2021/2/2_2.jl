x = readlines("2/data.csv")
x = x[2:end]

depth = BigInt(0)
horizontal = BigInt(0)
aim = BigInt(0) 

for (word, val) in split.(x, ",")
    val = parse(Int, val)
    if word == "down"
        aim += val
    elseif word == "up"
        aim -= val
    elseif word == "forward"
        horizontal += val
        depth = depth + val * aim
    end
end

println(depth)
println(horizontal)
println("Ergebis: $(depth*horizontal)")
