//
//  MockRepositoryService.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import XCTest
import GitHubAPI
@testable import Sporty_Test

final class MockRepositoryService: RepositoryService {
    var repositories: [GitHubMinimalRepository] = []
    var error: Error?

    func fetchRepositories(organisation: String) async throws -> [GitHubMinimalRepository] {
        if let error {
            throw error
        }
        return repositories
    }
}
