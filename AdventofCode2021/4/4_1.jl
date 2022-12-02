nums = readline("4/nums.txt")
boards_str = read("4/boards.txt", String)

mutable struct Board
    board_nums::Matrix{Int}
    played_nums::BitMatrix
    Board(board_nums) = begin
        played_nums = trues(size(board_nums))
        new(board_nums, played_nums)
    end
end

function parse_boards(boards_str)
    boards_str = replace(boards_str, "\r" => "\n")
    x = split(boards_str, "\n\n")
    x = split.(x, "\n")
    x = Iterators.partition(x, 6) |> collect
    l = []
    for vec_of_vecs in x
        inner_l = []
        vec_of_vecs = vcat(vec_of_vecs...)
        for vec_of_strings in vec_of_vecs
            if vec_of_strings != ""
                t = split(vec_of_strings, " ")
                t = filter(x -> x != "", t)
                t = parse.(Int, t)
                push!(inner_l, t)
            end
        end
        push!(l, inner_l)
    end
    return reduce.(hcat, l)
end

function play_num!(board::Board, num)
    indicis = findall(x -> x==num, board.board_nums)
    for idx in indicis
        board.played_nums[idx] = 0
    end
end

function is_won(board::Board)
    col_sum = sum(board.played_nums, dims = 1)
    row_sum = sum(board.played_nums, dims = 2)
    if any(col_sum .== 0)
        return true
    elseif any(row_sum .== 0)
        return true
    else
        return false
    end
end

function calc_score(board::Board)
    sum(board.board_nums[board.played_nums])
end

function main(nums, boards_str)
    boards = parse_boards(boards_str)
    nums = parse.(Int, split(nums, ","))
    boards = Board.(boards)
    for num in nums
        play_num!.(boards, num)
        won = is_won.(boards)
        for board in boards[won]
            println(board)
            println(num)
            return calc_score(board) * num
        end
    end
end

main(nums, boards_str)