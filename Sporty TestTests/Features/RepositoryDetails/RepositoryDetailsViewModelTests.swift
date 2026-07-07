//
//  RepositoryDetailsViewModelTests.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import XCTest
import GitHubAPI
@testable import Sporty_Test


@MainActor
final class RepositoryDetailsViewModelTests: XCTestCase {

    func test_loadRepositoryDetails_success() async {

        let minimal = makeMinimalRepository()
        let full = makeFullRepository(networkCount: 250)

        let service = MockRepositoryDetailsService()
        service.repository = full

        let sut = RepositoryDetailsViewModel(
            minimalRepository: minimal,
            repositoryDetailsService: service
        )

        await sut.loadRepositoryDetails()

        XCTAssertEqual(sut.repository?.networkCount, 250)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
    }

    func test_loadRepositoryDetails_failure() async {

        let minimal = makeMinimalRepository()

        let service = MockRepositoryDetailsService()
        service.error = URLError(.timedOut)

        let sut = RepositoryDetailsViewModel(
            minimalRepository: minimal,
            repositoryDetailsService: service
        )

        await sut.loadRepositoryDetails()

        XCTAssertNil(sut.repository)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
    }

    func test_loadRepositoryDetails_onlyLoadsOnce() async {

        let minimal = makeMinimalRepository()
        let full = makeFullRepository(networkCount: 100)

        let service = MockRepositoryDetailsService()
        service.repository = full

        let sut = RepositoryDetailsViewModel(
            minimalRepository: minimal,
            repositoryDetailsService: service
        )

        await sut.loadRepositoryDetails()
        await sut.loadRepositoryDetails()

        XCTAssertEqual(service.fetchCallCount, 1)
    }

    func test_computedProperties() {

        let minimal = makeMinimalRepository()

        let sut = RepositoryDetailsViewModel(
            minimalRepository: minimal,
            repositoryDetailsService: MockRepositoryDetailsService()
        )

        XCTAssertEqual(sut.minimalRepository.name, "swift")
        XCTAssertEqual(sut.minimalRepository.stargazersCount, 100)
    }
    
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

    private func makeFullRepository(networkCount: Int) -> GitHubFullRepository {

        let json = """
        {
            "id": 1,
            "name": "swift",
            "full_name": "swiftlang/swift",
            "description": "Swift language",
            "stargazers_count": 100,
            "network_count": \(networkCount)
        }
        """

        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            return try decoder.decode(
                GitHubFullRepository.self,
                from: Data(json.utf8)
            )
        } catch {
            XCTFail("Failed to decode test fixture: \(error)")
            fatalError("Unreachable")
        }
    }
}
