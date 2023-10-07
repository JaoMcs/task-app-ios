# Aplicativo de Gerenciamento de Tarefas

Bem-vindo ao Aplicativo de Gerenciamento de Tarefas! Este é um aplicativo simples e intuitivo para ajudá-lo a gerenciar tarefas.

Lista de Tarefas: Crie, visualize e edite suas tarefas em uma lista organizada.
Persistência de dados: Tarefas criadas não serão perdidas após finalizar o app.
Interface Simples e Intuitiva: Uma interface fácil de usar para uma experiência de gerenciamento de tarefas sem complicações.

Funcionalidades desenvolvidas:
- Criação de tarefa
- Editar tarefa já existente
- Apagar tarefa existente
- Visualizar detalhes de tarefa existente


# Framework utilizado: UIKit e SwiftUI
UIKit foi utilizado com Storyboard para manter o padrão do projeto.
SwiftUI foi utilizado na tela de criação de nova tarefa, feito de forma rapida e responsiva.

# Arquitetura
MVVM
- Arquitetura MVVM feita para desacoplar uma boa parte da logica das Controllers.

# Banco de dados Interno
Core Data
- Foi utilizado o Core Data por ter a capacidade de manter dados mais robustos do banco de dados interno do aparalho.
- Não foi utilizado UserDefaults pela necessidade de se guardar uma estrutura de dados um pouco mais complexa, deixando em aberto a possibilidade de escalar para dados mais robustos e compelexos.
