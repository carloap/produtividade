import os

class FileHandler:

    def __init__(self):
        # inicializa
        self.tree={}

    # Efetua reduce em 'self.tree'
    def _reduce(self, tree_dict, b_dict):
        for n in b_dict:
            if n in tree_dict:
                if type(tree_dict[n]) == dict and type(b_dict[n]) == dict:
                    self._reduce(tree_dict[n], b_dict[n])
            else:
                tree_dict[n] = b_dict[n]

    # Retornar um dict com a matriz do diretório observado
    def get_tree(self):
        return self.tree

    # Observa um diretório recursivamente
    def open_dir(self, base_dir):
        # quebrar path em lista
        list_tree = [lst for lst in (base_dir).split("/") if lst not in ['.', '..', '']]

        # TODO: validar se é diretório
        for f in os.listdir(base_dir):
            
            # TODO: tratar problema quando arquivos e diretórios forem encontrados juntos
            #main_dict = {f:{}} if os.path.isdir((base_dir + f)) else [f]  # se for um arquivo, transforma em lista
            main_dict = {f:{}}

            for y in list(reversed(list_tree)):
                main_dict={y:main_dict}

            self._reduce(self.tree, main_dict)

            if os.path.isdir((base_dir + f)) :
                # abrir diretório recursivamente
                self.open_dir((base_dir + f + "/"))
            
