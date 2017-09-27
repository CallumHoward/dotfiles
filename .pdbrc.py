from pdb import DefaultConfig
try:
    HAS_PYGMENTS = True
    from pygments import token
except ImportError:
    HAS_PYGMENTS = False


class Config(DefaultConfig):
    """Config options for pdb++
    """

    # change the color to "inverse" so that all the colors show through
    current_line_color = 40

    from pdb import Color
    line_number_color = Color.darkblue

    #use_terminal256formatter = True

    # make sticky the default mode
    sticky_by_default = False

    if HAS_PYGMENTS:
        # Fix up the comment color for dark background (light, dark)
        colorscheme = {
            token.Token: ('', ''),
            token.Whitespace: ('lightgray', 'lightgray'),
            token.Comment: ('lightgray', 'darkblue'),
            token.Comment.Preproc: ('teal', '*blue*'),
            token.Keyword: ('darkblue', 'teal'),
            token.Keyword.Type: ('teal', 'blue'),
            token.Keyword.Namespace: ('purple', 'purple'),
            token.Operator: ('purple', 'lightgray'),
            token.Name.Builtin: ('teal', 'turquoise'),
            token.Name.Function: ('darkgreen', 'lightgray'),
            token.Name.Namespace: ('_teal_', 'lightgray'),
            token.Name.Class: ('_darkgreen_', '_green_'),
            token.Name.Exception: ('teal', 'turquoise'),
            token.Name.Decorator: ('darkgray', 'lightgray'),
            token.Name.Variable: ('darkred', 'darkred'),
            token.Name.Constant: ('darkred', 'darkred'),
            token.Name.Attribute: ('teal', 'turquoise'),
            token.Name.Tag: ('blue', 'lightgray'),
            token.String: ('brown', 'darkred'),
            token.Number: ('darkblue', 'darkred'),
            token.Generic.Deleted: ('red', 'red'),
            token.Generic.Inserted: ('darkgreen', 'green'),
            token.Generic.Heading: ('**', '**'),
            token.Generic.Subheading: ('*purple*', '*fuchsia*'),
            token.Generic.Error: ('red', 'red'),
            token.Error: ('_red_', '_red_'),
        }
