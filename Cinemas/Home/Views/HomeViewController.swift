//
//  HomeViewController.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {

    private var viewModel : HomeViewModel!
    private lazy var tableView = UITableView()
    private lazy var isLoading = false
    private lazy var movies = [Movie]()
    private lazy var currentPage = 1
    private lazy var currentMovieId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
        func setupUI() {
            title = "Cinemas"
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.isNavigationBarHidden = false
            
            view.backgroundColor = .white
            view.addSubview(tableView)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifer)
            tableView.backgroundColor = .white
            tableView.snp.makeConstraints { make in
                make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
            }
        }
    
        func bindViewModel() {
        viewModel = HomeViewModel(useCase: HomeUseCase())
        viewModel.getPopularMovies(page: currentPage)
        
        viewModel.didReceivePopularMovies = { [weak self] in
            guard let result = self?.viewModel.moviesResult else { return }
            self?.movies.append(contentsOf: result.results)
            self?.currentPage = result.page
            DispatchQueue.main.async { self?.updateTableView() }
        }
        viewModel.didReceiveError = { error in
            fatalError(error)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if position >
            (tableView.contentSize.height - 100 - scrollView.frame.size.height) {
            loadMoreData()
        }
    }
    
    func loadMoreData() {
        let nextPage = currentPage + 1
        if currentPage >= 1 {
            if !self.isLoading {
                self.isLoading = true
                DispatchQueue.global().async { [weak self] in
                    self?.viewModel.getPopularMovies(page: nextPage)
                }
            }
        }
    }
    
    func updateTableView() {
        tableView.reloadData()
        isLoading = false
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifer, for: indexPath) as? HomeTableViewCell
        cell?.configureCell(movie: movies[indexPath.row])
        return cell ?? UITableViewCell()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section != 0 { return 55 }
        return 240
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController(movieId: movies[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: true)
    }
}
