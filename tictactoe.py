""""
Tic Tac Toe Player
"""
import math
import copy

X = "X"
O = "O"
EMPTY = None


def initial_state():
    """
    Returns starting state of the board.
    """
    return [[EMPTY, EMPTY, EMPTY],
            [EMPTY, EMPTY, EMPTY],
            [EMPTY, EMPTY, EMPTY]]


def player(board):
    """
    Returns player who has the next turn on a board.
    """
    num_of_X, num_of_O = 0, 0
    for i in range(len(board)):
        for j in range(len(board[i])):
            if board[i][j] == X:
                num_of_X += 1
            elif board[i][j] == O:
                num_of_O += 1
    if num_of_X > num_of_O:
        return O
    elif not terminal(board) and num_of_X == num_of_O:
        return X
    else:
        return None


def actions(board):
    """
    Returns set of all possible actions (i, j) available on the board.
    """
    set_of_actions = set()
    for i in range(len(board)):
        for j in range(len(board[i])):
            if board[i][j] is EMPTY:
                set_of_actions.add((i, j))
    return set_of_actions


def result(board, action):
    """
    Returns the board that results from making move (i, j) on the board.
    """

    if terminal(board):
        raise ValueError("Game Over.")
    elif action not in actions(board):
        raise ValueError("Invalid Action.")
    else:
        player_who_moves = player(board)
        result_board = copy.deepcopy(board)
        (i, j) = action
        result_board[i][j] = player_who_moves
        return result_board


def winner(board):
    """
    Returns the winner of the game, if there is one.
    """
    if board[0][0] == board[0][1] == board[0][2]:
        if board[0][0] == X:
            return X
        elif board[0][0] == O:
            return O
    elif board[1][0] == board[1][1] == board[1][2]:
        if board[1][0] == X:
            return X
        elif board[1][0] == O:
            return O
    elif board[2][0] == board[2][1] == board[2][2]:
        if board[2][0] == X:
            return X
        elif board[2][0] == O:
            return O
    elif board[0][0] == board[1][0] == board[2][0]:
        if board[0][0] == X:
            return X
        elif board[0][0] == O:
            return O
    elif board[0][1] == board[1][1] == board[2][1]:
        if board[0][1] == X:
            return X
        elif board[0][1] == O:
            return O
    elif board[0][2] == board[1][2] == board[2][2]:
        if board[0][2] == X:
            return X
        elif board[0][2] == O:
            return O
    elif board[0][0] == board[1][1] == board[2][2]:
        if board[0][0] == X:
            return X
        elif board[0][0] == O:
            return O
    elif board[0][2] == board[1][1] == board[2][0]:
        if board[0][2] == X:
            return X
        elif board[0][2] == O:
            return O
    return None


def terminal(board):
    """
    Returns True if game is over, False otherwise.
    """
    if winner(board) is not None:
        return True
    for i in range(len(board)):
        for j in range(len(board[i])):
            if board[i][j] == EMPTY:
                return False
    return True


def utility(board):
    """
    Returns 1 if X has won the game, -1 if O has won, 0 otherwise.
    """
    if winner(board) is X:
        return 1
    elif winner(board) is O:
        return -1
    else:
        return 0


def minimax(board):
    """
    Returns the optimal action for the current player on the board.
    """
    if board == [[EMPTY]*3]*3:
        return(1,1)
    if terminal(board):
        return None
    player_who_moves = player(board)
    selected_action = None
    if player_who_moves == X:
        value = -math.inf
        for action in actions(board):
            min_value_result = min_value(result(board, action))
            if min_value_result > value:
                value = min_value_result
                selected_action = action

    elif player_who_moves == O:
        value = math.inf
        for action in actions(board):
            max_value_result = max_value(result(board, action))
            if max_value_result < value:
                value = max_value_result
                selected_action = action
    return selected_action


def min_value(board):
    value = math.inf
    if terminal(board):
        return utility(board)
    for action in actions(board):
        value = min(value, max_value(result(board, action)))
    return value


def max_value(board):
    value = -math.inf
    if terminal(board):
        return utility(board)
    for action in actions(board):
        value = max(value, min_value(result(board, action)))
    return value
