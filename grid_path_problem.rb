require 'pry'

# coordinate = [ row, column ]

def adjacent_squares( board, coordinates )
    rows = [ coordinates[ 0 ] - 1, coordinates[ 0 ], coordinates[ 0 ] + 1 ]
    columns = [ coordinates[ 1 ] - 1, coordinates[ 1 ], coordinates[ 1 ] + 1 ]
    all_adjacent_squares = rows.product( columns )
    all_adjacent_squares.select{ | square | square[ 0 ].between?( 0, board.size - 1) && square[ 1 ].between?( 0, board.first.size - 1 ) && square != coordinates }
end

def orthogonally_adjacent_squares( board, coordinates )
    row = coordinates[ 0 ]
    column = coordinates[ 1 ]
    all_adjacent_squares = [ row ].product( [ row - 1, row + 1 ] ) + [ column - 1, column + 1 ].product( [ row ] )
    all_adjacent_squares.select{ | square | square[ 0 ].between?( 0, board.size - 1) && square[ 1 ].between?( 0, board.first.size - 1 ) && square != coordinates }
end

def possible_paths( board, current_coordinates, destination, path_so_far, path_list )
    current_square_value = board[ current_coordinates[ 0 ] ][ current_coordinates[ 1 ] ]
    if current_coordinates == destination
        path_so_far.push( current_square_value )
        path_list << path_so_far
    else
        adjacent_squares( board, current_coordinates ).each do | adjacent_coordinate |
            if !path_so_far.include?( current_square_value )
                next_possible_path = path_so_far.clone.push( current_square_value )
                possible_paths( board, adjacent_coordinate, destination, next_possible_path, path_list )
            end
        end
    end
end

def shortest_path( board, start_coordinates, end_coordinates )
    path_list = []
    possible_paths( board, start_coordinates, end_coordinates, [], path_list)
    path_list.sort_by( &:size ).first
end

four_by_four = [
    [ "00", "01", "02", "03" ],
    [ "10", "11", "12", "13" ],
    [ "20", "21", "22", "23" ],
    [ "30", "31", "32", "33" ] ]

three_by_six = [
    [ "00", "01", "02", "03", "04", "05" ],
    [ "10", "11", "12", "13", "14", "15" ],
    [ "20", "21", "22", "23", "24", "25" ] ]

seven_by_seven = [
    [ "00", "01", "02", "03", "04", "05", "06" ],
    [ "10", "11", "12", "13", "14", "15", "16" ],
    [ "20", "21", "22", "23", "24", "25", "26" ],
    [ "30", "31", "32", "33", "34", "35", "36" ],
    [ "40", "41", "42", "43", "44", "45", "46" ],
    [ "50", "51", "52", "53", "54", "55", "56" ],
    [ "60", "61", "62", "63", "64", "65", "66" ],
]

binding.pry
false