import GitHubAPI
import SwiftUI
import UIKit

/// A view controller that displays the details of a GitHub repository.
final class RepositoryViewController: UIViewController {
    private var viewModel: RepositoryDetailsViewModel

    init(viewModel: RepositoryDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)

        title = viewModel.minimalRepository.name
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let hostingViewController = UIHostingController(rootView: RepositoryView(viewModel: viewModel))
        addChild(hostingViewController)
        view.addSubview(hostingViewController.view)
        hostingViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        hostingViewController.didMove(toParent: self)
    }
}
