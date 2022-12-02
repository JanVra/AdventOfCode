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

mutable struct Line
    point_begin::Point
    point_end::Point
end

function path(line::Line)
    path = []
    x_anf = min(line.point_begin.x, line.point_end.x)
    y_anf = min(line.point_begin.y, line.point_end.y)
    x_end = max(line.point_begin.x, line.point_end.x)
    y_end = max(line.point_begin.y, line.point_end.y)
    if (line.point_begin.x == line.point_end.x) | (line.point_begin.y == line.point_end.y)
        for x = x_anf:x_end#line.point_begin.x:line.point_end.x
            for y = y_anf:y_end
                push!(path, Point(x, y))
            end
        end
    end
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
    return lines, (x_max+1, y_max+1)
end

function main(coords)
    lines, max_coords = parse_coordinates(coords)
    map_matrix = zeros(Int, maximum(max_coords), maximum(max_coords))
    for line in lines
        map_line!(line, map_matrix)
    end
    return map_matrix
end

count(>=(2), main(coords))