CosmoNow

📌 Sobre o Projeto

CosmoNow é um aplicativo desenvolvido para explorar o universo, trazendo imagens, vídeos e informações sobre o espaço. O projeto foi criado com foco em uma arquitetura escalável, utilizando Clean Architecture, MVVM e princípios SOLID.

![Simulator Screenshot - iPhone SE (3rd generation) - 2025-02-17 at 12 02 05](https://github.com/user-attachments/assets/e80d30f1-ac9d-4d65-a225-2400c2e36a82)
![Simulator Screenshot - iPhone SE (3rd generation) - 2025-02-17 at 12 02 09](https://github.com/user-attachments/assets/0f765267-4613-4e2d-aade-9cf876eaf0f2)
![Simulator Screenshot - iPhone SE (3rd generation) - 2025-02-17 at 12 02 36](https://github.com/user-attachments/assets/cb852775-a33b-4a16-8bb6-e5b351f30d41)
![Simulator Screenshot - iPhone SE (3rd generation) - 2025-02-17 at 12 02 39](https://github.com/user-attachments/assets/2246dd29-ef13-408d-a771-6ce65714d9d2)
![Simulator Screenshot - iPhone SE (3rd generation) - 2025-02-17 at 12 02 44](https://github.com/user-attachments/assets/f69c3e96-9697-487b-9504-ac98e154a127)

🚀 Tecnologias Utilizadas

SwiftUI: Para criação da interface responsiva e moderna.

Combine: Para a gestão reativa dos dados.

URLSession: Para requisições HTTP.

Cache de imagens e vídeos: Para otimização do carregamento.

Cache de miniaturas do YouTube: Para exibição eficiente na lista.

Cache de dados da API: Para melhorar a performance e reduzir requisições desnecessárias.

Dependency Injection: Implementado para modularização do projeto.

Async/Await e Task: Para concorrência e melhor desempenho na execução assíncrona.

🏗️ Arquitetura

O projeto segue a Clean Architecture com separação de responsabilidades em camadas:

Presentation Layer: Camada de UI (SwiftUI) que interage com o ViewModel.

Domain Layer: Contém os casos de uso e entidades de negócio.

Data Layer: Responsável por interagir com APIs e fontes de dados locais.

📌 Funcionalidades Implementadas

GetCosmoUseCase: Caso de uso principal para buscar conteúdo espacial.

Exibição de imagens e vídeos: Suporte a diferentes formatos.

Miniaturas do YouTube na lista: Exibição eficiente com cache para melhor experiência.

Implementação de cache:

Cache de imagens: Armazena imagens localmente para evitar requisições repetidas.

Cache de miniaturas de vídeos: Otimiza a exibição de thumbnails do YouTube.

Cache de dados da API: Melhora o desempenho e permite acesso offline limitado.

CRUD de Favoritos: Permite salvar, apagar e editar a lista de favoritos.

Gestão de Erros: Tratamento de erros e exibição de mensagens adequadas ao usuário.

Modo Escuro: Suporte a dark mode para melhor experiência visual.

📂 Estrutura de Pastas

![Shottr 2025-02-17 12 05 32](https://github.com/user-attachments/assets/63406f15-59f0-4f03-b31b-1d5d39f4a764)

🔧 Como Rodar o Projeto

Clone o repositório:

git clone https://github.com/seu-usuario/cosmonow.git

Acesse a pasta do projeto:

cd cosmonow

Abra o projeto no Xcode e execute no simulador ou dispositivo.

✅ Testes

O projeto conta com testes unitários e testes de UI para garantir a qualidade do código.
Para rodar os testes:

CMD + U  # Rodar testes no Xcode

📊 Code Coverage

![Shottr 2025-02-17 07 39 13](https://github.com/user-attachments/assets/c2a7da96-68d6-4124-9715-35af5ea082c9)

![Shottr 2025-02-17 07 39 35](https://github.com/user-attachments/assets/ae3ecbe9-850f-4b6b-a869-7c71b3232bf6)

📝 Considerações Finais

Este projeto foi desenvolvido com um alto nível de qualidade, utilizando boas práticas de desenvolvimento, arquitetura modular e otimizações de desempenho. Qualquer sugestão ou contribuição é bem-vinda! 🚀

