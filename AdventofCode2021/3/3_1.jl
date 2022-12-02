using StatsBase

x = readlines("3/data.txt")

function invert_bit_str(str)
    if str == 1
        return 0
    elseif str == 0
        return 1
    end
end

x = reduce(hcat, collect.(x))
x = collect(parse.(Int, x)')

gamma_rate = reduce(*,["$(mode(i))" for i in eachcol(x)])
epsilon_rate = reduce(*,["$(invert_bit_str(mode(i)))" for i in eachcol(x)])

gamma_rate = parse(Int, gamma_rate, base=2)
epsilon_rate = parse(Int, epsilon_rate, base=2)
gamma_rate * epsilon_rate


