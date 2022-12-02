import Base.isless

coords = readlines("5/coords.txt")

mutable struct Point
    x::Int
    y::Int
end

Point(x::AbstractString, y::AbstractString) = begin
    x = parse(Int, x)
    y = parse(Int, y)
    return Point(x, y)
end

function isless(p1::Point, p2::Point)
    return p1.x < p2.x | p1.y < p2.y
end

mutable struct Line
    point_begin::Point
    point_end::Point
end

function path(line::Line)
    xs = []
    ys = []
    x_anf = min(line.point_begin.x, line.point_end.x)
    y_anf = min(line.point_begin.y, line.point_end.y)
    x_end = max(line.point_begin.x, line.point_end.x)
    y_end = max(line.point_begin.y, line.point_end.y)
    if (x_anf == x_end) | (y_anf == y_end)
        for x = x_anf:x_end
            for y = y_anf:y_end
                push!(xs,x)
                push!(ys,y)
            end
        end
    elseif line.point_begin.x < line.point_end.x # diagonals top-left -> bottom-right
        for offset = x_end-x_anf:-1:0
            x = x_anf + offset
            y = y_anf + offset
            push!(xs,x)
            push!(ys,y)
        end
    else # diagonals bottom-left -> top-rigth
        println(line)
        for offset = 0:line.point_end.x - line.point_begin.x
            x = x_anf + offset
            y = y_anf + offset
            push!(xs,x)
            push!(ys,y)
        end
    end
    path = [Point(xs[i], ys[i]) for i in eachindex(xs)]
    return path
end

function map_line!(line::Line, map_matrix)
    for points in path(line)
        map_matrix[points.y+1, points.x+1] += 1
    end
    return map_matrix
end

function parse_coordinates(coords)
    lines = []
    x_max = 0
    y_max = 0
    for coord_line in coords
        points = split(coord_line, " -> ")
        beginning, ending = split.(points, ",")
        beginning = Point(beginning...)
        ending = Point(ending...)
        x_max = maximum([x_max, beginning.x, ending.x])
        y_max = maximum([y_max, beginning.y, ending.y])
        line = Line(beginning, ending)
        push!(lines, line)
    end
    return lines, max(x_max + 1, y_max + 1)
end

function main(coords)
    lines, max_coords = parse_coordinates(coords)
    map_matrix = zeros(Int, max_coords, max_coords)
    for line in lines
        map_line!(line, map_matrix)
    end
    return map_matrix
end

#count(>=(2), main(coords))

p1 = Point(2,0)
p2 = Point(6,4)
line = Line(p2, p1)
path(line)


mat = zeros(Int, 3, 3)


c = [
    "0,0 -> 2,1",
    "2,2 -> 0,0"
]
main(c)