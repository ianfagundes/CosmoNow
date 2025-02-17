CosmoNow

📌 Sobre o Projeto

CosmoNow é um aplicativo desenvolvido para explorar o universo, trazendo imagens, vídeos e informações sobre o espaço. O projeto foi criado com foco em uma arquitetura escalável, utilizando Clean Architecture, MVVM e princípios SOLID.

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

📂 CosmoNow
│── 📂 Assets.xcassets
│   │── 📂 AppIcon.appiconset
│   │   ├── 🖼️ 1024.png, 120.png, 180.png, etc.
│   │   ├── 📄 Contents.json
│   │── 📂 Images
│   │   ├── 📂 cosmonow.imageset
│   │   │   ├── 🖼️ cosmonow.png, cosmonow 1.png
│   │   │   ├── 📄 Contents.json
│   │── 📄 Contents.json
│── 📄 ContentView.swift
│── 📄 CosmoNowApp.swift
│── 📂 Preview Content
│   ├── 📂 Preview Assets.xcassets
│   │   ├── 📄 Contents.json
│
├── 📂 Data
│   ├── 📂 Protocols
│   │   ├── 📄 CosmoRespositoryProtocol.swift
│   │   ├── 📄 CosmoServiceProtocol.swift
│   ├── 📂 Repositories
│   │   ├── 📄 CosmoRepository.swift
│   ├── 📂 Services
│   │   ├── 📄 CosmoService.swift
│
├── 📂 Domain
│   ├── 📂 Models
│   │   ├── 📄 CosmoModel.swift
│   ├── 📂 UseCases
│   │   ├── 📄 CosmoUseCaseModel.swift
│   │   ├── 📄 GetCosmoUseCase.swift
│   │   ├── 📂 Protocols
│   │   │   ├── 📄 GetCosmoUseCaseProtocol.swift
│
├── 📂 Infra
│   ├── 📂 Cache
│   │   ├── 📄 DataCacheManager.swift
│   │   ├── 📄 ImageCacheManager.swift
│   ├── 📂 Media
│   │   ├── 📄 MediaManager.swift
│   ├── 📂 Network
│   │   ├── 📄 APIConfig.swift
│   │   ├── 📄 NetworkError.swift
│   │   ├── 📄 NetworkManager.swift
│   │   ├── 📄 URLSessionProtocol.swift
│   ├── 📂 Storage
│   │   ├── 📄 FavoritesManager.swift
│
├── 📂 Presentation
│   ├── 📂 Components
│   │   ├── 📄 CachedAsyncImage.swift
│   │   ├── 📄 DatePickerModalView.swift
│   │   ├── 📄 FavoriteButton.swift
│   │   ├── 📄 MediaView.swift
│   │   ├── 📄 ThumbnailView.swift
│   │   ├── 📄 YouTubeWebView.swift
│   ├── 📂 ViewModels
│   │   ├── 📄 CachedImageViewModel.swift
│   │   ├── 📄 CosmoViewModel.swift
│   │   ├── 📄 FavoritesViewModel.swift
│   ├── 📂 Views
│   │   ├── 📄 CosmoDetailView.swift
│   │   ├── 📄 CosmoView.swift
│   │   ├── 📄 FavoritesView.swift
│   │   ├── 📄 MainTabView.swift
│
├── 📂 Resources
│   ├── 📄 Info.plist
│   ├── 📄 LaunchScreenView.swift
│   ├── 📄 ThemeManager.swift
│   ├── 📂 Utils
│   │   ├── 📂 DateUtils
│   │   │   ├── 📄 DateUtils.swift
│   │   ├── 📂 Extensions
│   │   │   ├── 📄 URL+Extensions.swift
│   │   ├── 📂 Helpers
│   │   │   ├── 📄 YouTubeUtils.swift
│
├── 📂 CosmoNowTests
│   ├── 📄 CosmoNowTests.swift
│   ├── 📂 DataTests
│   │   ├── 📄 MockCosmoRepository.swift
│   ├── 📄 DateUtilsTests.swift
│   ├── 📂 DomainTests
│   │   ├── 📄 GetCosmoUseCaseTests.swift
│   ├── 📂 PresentationTests
│   │   ├── 📄 ContentViewTests.swift
│   │   ├── 📄 ContentViewUITests.swift
│   │   ├── 📄 CosmoViewModelTests.swift
│   │   ├── 📄 DatePickerModalViewTests.swift
│   │   ├── 📄 NetworkErrorTests.swift
│   ├── 📄 FavoriteButtonUITests.swift
│   ├── 📄 FavoritesManagerTests.swift
│   ├── 📄 FavoritesViewModelTests.swift
│   ├── 📄 MockCosmoService.swift
│   ├── 📄 NetworkManagerTests.swift
│
├── 📂 CosmoNowUITests
│   ├── 📂 PresentationTests
│
├── 📄 CosmoNowUITests.xctestplan
├── 📂 CosmoNow.xcodeproj
│   ├── 📄 project.pbxproj
│   ├── 📂 xcshareddata
│   │   ├── 📂 xcschemes
│   │   │   ├── 📄 CosmoNow.xcscheme
│   │   │   ├── 📄 CosmoNowTests.xcscheme
│   │   │   ├── 📄 CosmoNowUITests.xcscheme
│   ├── 📂 xcuserdata
│   │   ├── 📂 ianfagundes.xcuserdatad
│   │   │   ├── 📂 xcdebugger
│   │   │   ├── 📂 xcschemes
│   │   │   │   ├── 📄 xcschememanagement.plist
│
├── 📂 CosmoNow.xcworkspace
│   ├── 📂 xcshareddata
│   │   ├── 📂 swiftpm
│   │   │   ├── 📄 configuration
│   ├── 📂 xcuserdata
│   │   ├── 📂 ianfagundes.xcuserdatad
│   │   │   ├── 📄 UserInterfaceState.xcuserstate
│
└── 📄 structure.txt

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

