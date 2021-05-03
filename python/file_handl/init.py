from helper.FileHandler import FileHandler


directorio = "/Users/guest/Documents/github/project/"

file_handl = FileHandler()
file_handl.open_dir(directorio)

print( file_handl.get_tree() )

