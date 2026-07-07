import Combine
import GitHubAPI
import MockLiveServer
import UIKit

/// A view controller that displays a list of GitHub repositories for the "swiftlang" organization.
final class RepositoriesViewController: UITableViewController {
    private let viewModel: RepositoriesViewModel
    private var cancellables = Set<AnyCancellable>()
    private let makeDetailsViewController: (GitHubMinimalRepository) -> UIViewController

    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    init(viewModel: RepositoriesViewModel, makeDetailsViewController: @escaping (GitHubMinimalRepository) -> UIViewController) {
        self.viewModel = viewModel
        self.makeDetailsViewController = makeDetailsViewController
        super.init(style: .insetGrouped)

        title = "swiftlang"
    }
    
    deinit {
        cancellables.removeAll()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureLoadingIndicator()
        bindViewModel()
        Task {
            await viewModel.loadRepositories()
        }
    }
    
    // MARK: - Configuration
    private func configureTableView() {
        tableView.register(
            RepositoryTableViewCell.self,
            forCellReuseIdentifier: "RepositoryCell"
        )
    }
    
    private func configureLoadingIndicator() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    
    private func bindViewModel() {
        
        viewModel.$repositories.receive(on: DispatchQueue.main).sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$errorMessage.compactMap { $0 }.sink { [weak self] message in
            self?.showError(message)
        }.store(in: &cancellables)
        
        viewModel.$isLoading.sink {[weak self] isLoading in
            isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
        }.store(in: &cancellables)
    }

    private func showError(_ message: String) {
        let alert = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))

        present(alert, animated: true)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.repositories.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let repository = viewModel.repository(indexPath.row),
              let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryCell",
                                                       for: indexPath) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(repository: repository)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let repository = viewModel.repository(indexPath.row) else { return }
        show(makeDetailsViewController(repository), sender: self)
    }
}
