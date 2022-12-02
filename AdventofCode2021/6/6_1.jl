inp = "3,4,3,1,2"
#inp = readline("6/data.txt")
ttd = 7
ttd_fresh = 9
mutable struct Fish
    internal_value::Int
    first_cicle::Bool
    ttd::Int
    Fish(internal_value, first_cicle) = new(internal_value, first_cicle, first_cicle ? ttd_fresh : ttd)
end

Fish(val) = Fish(val, false)

function pass_day(f::Fish)
    f.internal_value = mod(f.internal_value - 1, f.ttd)
    return f
end

function main(fish, days)
    for i = 1:days-1
        fish = pass_day.(fish)
        new_fish = Vector{Fish}()
        for f in fish
            if f.internal_value == 0
                setfield!(f, :ttd, ttd)
                push!(new_fish, Fish(ttd_fresh, true))
            end
        end
        #println("Day $i ", getproperty.(fish,:internal_value))
        append!(fish, new_fish)
    end
    return fish#length(fish)
end

inp = parse.(Int, split(inp, ","))
main(Fish.(inp), 19)
