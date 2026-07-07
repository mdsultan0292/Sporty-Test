//
//  RepositoriesViewModelTests.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import XCTest
import GitHubAPI
@testable import Sporty_Test

@MainActor
final class RepositoriesViewModelTests: XCTestCase {

    func test_loadRepositories_success() async throws {
        let service = MockRepositoryService()
        service.repositories = [makeMinimalRepository()]

        let sut = RepositoriesViewModel(repositoryService: service)

        await sut.loadRepositories()

        XCTAssertEqual(sut.repositories.count, 1)
        XCTAssertEqual(sut.repositories.first?.name, "swift")
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }

    func test_loadRepositories_failure() async {
        let service = MockRepositoryService()
        service.error = URLError(.notConnectedToInternet)

        let sut = RepositoriesViewModel(repositoryService: service)

        await sut.loadRepositories()

        XCTAssertTrue(sut.repositories.isEmpty)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_repository_returnsRepositoryAtIndex() async throws {
        let service = MockRepositoryService()
        service.repositories = [makeMinimalRepository()]

        let sut = RepositoriesViewModel(repositoryService: service)

        await sut.loadRepositories()

        let repository = sut.repository(0)

        XCTAssertNotNil(repository)
        XCTAssertEqual(repository?.name, "swift")
    }

    func test_repository_invalidIndex_returnsNil() {
        let sut = RepositoriesViewModel(repositoryService: MockRepositoryService())

        XCTAssertNil(sut.repository(0))
    }

    // MARK: - Helpers

    private func makeMinimalRepository() -> GitHubMinimalRepository {
        let json = """
        {
            "id": 1,
            "name": "swift",
            "full_name": "swiftlang/swift",
            "description": "Swift language",
            "stargazers_count": 100
        }
        """
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            return try decoder.decode(
                GitHubMinimalRepository.self,
                from: Data(json.utf8)
            )
        } catch {
            XCTFail("Failed to decode test fixture: \(error)")
            fatalError("Unreachable")
        }
    }
}
