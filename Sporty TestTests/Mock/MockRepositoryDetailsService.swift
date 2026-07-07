//
//  MockRepositoryDetailsService.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import XCTest
import GitHubAPI
@testable import Sporty_Test

final class MockRepositoryDetailsService: RepositoryDetailsService {
    var repository: GitHubFullRepository?
    var error: Error?
    var fetchCallCount = 0

    func fetchRepositoryDetails(fullName: String) async throws -> GitHubFullRepository {
        fetchCallCount += 1

        if let error {
            throw error
        }

        guard let repository else {
            fatalError("Repository not configured")
        }

        return repository
    }
}
