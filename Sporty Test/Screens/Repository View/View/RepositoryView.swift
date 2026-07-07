//
//  RepositoryView.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import SwiftUI
import GitHubAPI

/// A view displaying the details of a GitHub repository.
struct RepositoryView: View {

    @ObservedObject
    var viewModel: RepositoryDetailsViewModel

    var body: some View {

        List {
            Group {
                RepositoryValueView(key: "Name") {
                    Text(viewModel.minimalRepository.name)
                        .foregroundColor(.secondary)
                }

                RepositoryValueView(key: "Description") {
                    if let description = viewModel.minimalRepository.description {
                        Text(description)
                            .foregroundColor(.secondary)
                    } else {
                        Text("No description")
                            .foregroundColor(.secondary)
                            .italic()
                    }
                }

                RepositoryValueView(key: "Stars") {
                    Text("\(viewModel.minimalRepository.stargazersCount)")
                        .foregroundColor(.secondary)
                }

                RepositoryValueView(key: "Forks") {
                    if viewModel.isLoading {
                        ProgressView()
                    } else {
                        Text("\(viewModel.repository?.networkCount ?? 0)")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .task {
            await viewModel.loadRepositoryDetails()
        }
        .alert("Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in
                    viewModel.errorMessage = nil
                }
            )
        ) {
            Button("OK", role: .cancel) {}

        } message: {

            Text(viewModel.errorMessage ?? "")
        }
    }
}
