using Statistics, RollingFunctions
x = readlines("1/data.txt")
x = parse.(Int, x)


print(sum(diff(x) .> 0))
print(sum(diff(rolling(sum, x, 3)) .> 0))