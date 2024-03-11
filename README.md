# App Digio Store

O App Digio Store é uma aplicação de teste para o banco Digio, construída na plataforma iOS com a linguagem Swift. O projeto serve como uma demonstração de práticas recomendadas no desenvolvimento de software, seguindo os princípios de uma arquitetura limpa e implementando padrões de design que promovem modularidade, escalabilidade e manutenção eficiente.

## Arquitetura e Padrões de Design

A aplicação segue a **Clean Architecture**, separando o código em camadas claramente definidas:

- **Camada de Apresentação**: Utiliza o padrão **MVVM (Model-View-ViewModel)** para separar a lógica de apresentação da interface do usuário.

    ```swift
    class DigioStoreViewModel {
        // ...
        func fetchStoreData(completion: @escaping (Bool, ResponseError?) -> Void) {
            // Implementação de busca de dados
        }
    }
    ```

- **Camada de Domínio**: Contém as regras de negócio e os casos de uso, onde as `Entities` são definidas.

    ```swift
    struct DigioStoreEntity {
        // Definição de entidade
    }
    ```

- **Camada de Dados**: Define a fonte de dados e o repositório que abstrai a origem dos dados da camada de negócio.

    ```swift
    class DigioStoreRepositoryImpl: DigioStoreRepository {
        // ...
    }
    ```

O projeto também implementa **Injeção de Dependência** para facilitar a substituição de componentes e melhorar a testabilidade:

```swift
class StoreAssembler {
    func assemble(container: Container) {
        // Registro dos componentes
    }
}
```

## Componentes

Os componentes `CustomLabel` e `CustomViewController` adicionam personalização à interface do usuário no app:

### CustomLabel
É uma subclasse de `UILabel` que exibe texto com duas partes coloridas distintas:

```swift
let label = CustomLabel()
label.setParts(
    first: (text: "Primeira Parte", color: .red),
    second: (text: "Segunda Parte", color: .blue)
)
```

### CustomViewController
Configura a barra de navegação com uma logo e título personalizados:

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
}

func setupNavigationBar() {
    // Personaliza a barra de navegação aqui
}
```

Ambos oferecem uma maneira de adicionar estilo e marca própria aos elementos de UI.

### DataSource

Define o contrato para a origem de dados e é implementado para buscar dados da API.

```swift
protocol DigioStoreDatasource {
    // ...
}

class DigioStoreDatasourceImpl: DigioStoreDatasource {
    // Implementação que busca dados da loja
}
```

### Repositório

Fornece uma abstração sobre a fonte de dados, facilitando a troca entre diferentes formas de armazenamento.

```swift
class DigioStoreRepositoryImpl {
    // ...
}
```


### Protocols

- **DetailPresentable**: Define uma interface para detalhamento de itens.
    ```swift
    protocol DetailPresentable {
        // ...
    }
    ```
- **ItemSelectable**: Fornece um método de seleção para itens detalháveis.
    ```swift
    protocol ItemSelectable {
        // ...
    }
    ```

### Views

Representações visuais personalizadas para os itens destacados da loja, produtos e ofertas.

```swift
class SpotlightView {
    // ...
}

class ProductView {
    // ...
}
```

### ViewControllers

Gerencia a exibição e interação com a interface do usuário, atuando como o ponto de coordenação entre a UI e o modelo de dados.

```swift
class DetailViewController {
    // ...
}

class DigioStoreViewController {
    // ...
}
```
<img src="Assets/store.png" alt="Store" width="200"/> 

<img src="Assets/detail.png" alt="Detail" width="200"/> 



## Testes

Este conjunto de testes para o `DigioStoreViewModel` valida o comportamento de busca de dados da loja, simulando cenários de sucesso e falha utilizando um mock do repositório `DigioStoreRepositoryMock`.

No teste `testFetchStoreDataSuccess`, objetos mock são criados para simular dados bem-sucedidos retornados do repositório. O `viewModel` invoca `fetchStoreData`, e as asserções verificam se:

1. A chamada foi bem-sucedida (`isSuccess` é verdadeiro).
2. Nenhum erro foi retornado (`error` é nulo).
3. Os itens retornados estão corretamente atribuídos às propriedades do `viewModel`.

```swift
XCTAssertTrue(isSuccess)
XCTAssertNil(error)
XCTAssertEqual(viewModel.spotlightItems.count, spotlightMock.count)
XCTAssertEqual(viewModel.productItems.count, productMock.count)
XCTAssertNotNil(viewModel.cashItem)
```

No teste `testFetchStoreDataFailure`, o `repositoryMock` é configurado para simular uma condição de falha. As asserções verificam se:

1. A chamada resultou em falha (`isSuccess` é falso).
2. Um erro foi retornado (`error` não é nulo).
3. As propriedades do `viewModel` relacionadas aos itens da loja estão vazias ou nulas, indicando que nenhum dado foi erroneamente atribuído em caso de erro.

```swift
XCTAssertFalse(isSuccess)
XCTAssertNotNil(error)
XCTAssertTrue(viewModel.spotlightItems.isEmpty)
XCTAssertTrue(viewModel.productItems.isEmpty)
XCTAssertNil(viewModel.cashItem)
```

O `DigioStoreRepositoryMock` é uma classe de mock que implementa o protocolo `DigioStoreRepository`, permitindo simular o comportamento do repositório de dados real. Isso é útil para isolar os testes do `viewModel` de dependências externas, como chamadas de rede, e garantir que os testes sejam rápidos e confiáveis.

O mock verifica a flag `shouldReturnError` para decidir se deve retornar um sucesso com os dados fornecidos ou uma falha com um erro. Este design permite um controle preciso sobre o resultado dos testes e simula diferentes respostas do repositório.

## Frameworks

O projeto integra várias ferramentas e frameworks para otimizar o processo de desenvolvimento e manutenção do código:

### Fastlane

Fastlane é utilizado para automatizar tarefas repetitivas de desenvolvimento e release, como execução de testes, geração de screenshots, e deployment para a App Store.

```ruby
# Fastfile
lane :test do
  scan
end
```

### Kingfisher

Kingfisher é um poderoso framework para download e caching de imagens. É utilizado para carregar imagens de produtos e banners de forma eficiente e com cache automático.

```swift
imageView.kf.setImage(with: url)
```

### SwiftLint

SwiftLint é uma ferramenta de linter para a linguagem Swift, garantindo que o código siga as convenções e diretrizes de estilo.

```yaml
# .swiftlint.yml
line_length: 120
disabled_rules:
  - trailing_whitespace
```

### Swinject

Swinject é um container de injeção de dependência para Swift, usado para gerenciar as dependências do projeto de forma desacoplada e testável.

```swift
container.register(DigioStoreRepository.self) { _ in DigioStoreRepositoryImpl() }
```
