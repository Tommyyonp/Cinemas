//
//  DetailViewController.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import UIKit
import SnapKit
import youtube_ios_player_helper

class DetailViewController: UIViewController {
    
    private lazy var scrollView = UIScrollView()
    private var playerView = YTPlayerView()
    private lazy var contentView = UIView()
    private lazy var titleLbl = UILabel()
    private lazy var releaseLbl = UILabel()
    private lazy var descLbl = UILabel()
    private lazy var detailView = UIView()
    private lazy var tableView = UITableView()
    
    var linkPlayer: String = "I9B6rwW35GQ"
    private lazy var movieResult = [Result]()
    private lazy var movieReviewResult = [Review]()
    
    var movieId : Int!
    var viewModel : DetailViewModel!
    var movieDetail : MovieDetail!
    var movieLink : MovieLink!
    var movieReview : MovieReview!
    
    init(movieId : Int) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    func setupUI(){
        title = "Detail Movie"
        navigationController?.navigationBar.prefersLargeTitles = false

        view.addSubview(scrollView)
        scrollView.backgroundColor = .white
        scrollView.showsVerticalScrollIndicator = false
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(scrollView)
            make.height.equalTo(1400)
        }
        
        contentView.addSubview(playerView)
        playerView.load(withVideoId: linkPlayer)
        playerView.backgroundColor = .black
        playerView.snp.makeConstraints { make in
            make.width.equalTo(scrollView)
            make.leading.trailing.top.equalTo(contentView)
            make.height.equalTo(300)
        }

        contentView.addSubview(detailView)
        detailView.backgroundColor = .white
        detailView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView)
            make.top.equalTo(playerView.snp.bottom)
            make.height.equalTo(200)
        }
        
        detailView.addSubview(titleLbl)
        titleLbl.text = "Title Movie"
        titleLbl.font = .systemFont(ofSize: 24, weight: .semibold)
        titleLbl.numberOfLines = 0
        titleLbl.textColor = .black
        titleLbl.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.top).offset(12)
            make.leading.trailing.equalTo(detailView).inset(24)
        }
        
        detailView.addSubview(releaseLbl)
        releaseLbl.textColor = .black
        releaseLbl.text = "Sep 20, 2021"
        releaseLbl.numberOfLines = 0
        releaseLbl.font = .systemFont(ofSize: 18, weight: .light)
        releaseLbl.snp.makeConstraints { make in
            make.top.equalTo(titleLbl.snp.bottom).offset(8)
            make.leading.trailing.equalTo(detailView).inset(24)
        }
        
        detailView.addSubview(descLbl)
        descLbl.textColor = .black
        descLbl.text = "Description"
        descLbl.font.withSize(20)
        descLbl.numberOfLines = 0
        descLbl.snp.makeConstraints { make in
            make.top.equalTo(releaseLbl.snp.bottom).offset(8)
            make.leading.trailing.equalTo(detailView).inset(24)
        }
        
        contentView.addSubview(tableView)
        tableView.isUserInteractionEnabled = false
        tableView.backgroundColor = .gray
        tableView.register(ReviewTableViewCell.self,
                           forCellReuseIdentifier: ReviewTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { make in
            make.top.equalTo(detailView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func bindViewModel(){
        viewModel = DetailViewModel(useCase: DetailUseCase())
        viewModel.getMovieDetail(movieId: movieId)
        viewModel.getMovieLink(movieId: movieId)
        viewModel.getMovieReview(movieId: movieId)
        
        viewModel.didReceiveMovieDetail = { [weak self] in
            self?.movieDetail = self?.viewModel.movieDetail
            DispatchQueue.main.async {
                self?.reloadUI()
            }
        }
        viewModel.didReceiveMovieLink = { [weak self] in
            guard let result = self?.viewModel.movieLink else { return }
            self?.movieResult.append(contentsOf: result.results)
            print("\(self?.movieResult)")
            DispatchQueue.main.async { self?.reloadUI() }
        }
        viewModel.didReceiveMovieReview = { [weak self] in
            guard let result = self?.viewModel.movieReview else { return }
            self?.movieReviewResult.append(contentsOf: result.results)
            print("\(self?.movieReview)")
            DispatchQueue.main.async { self?.reloadUI() }
        }
        viewModel.didReceiveError = { message in
            fatalError(message)
        }
    }
    
    private func reloadUI() {
        titleLbl.text = movieDetail.title
        if movieDetail.release_date != "" || !movieDetail.release_date.isEmpty {
            releaseLbl.text = "Release on \(movieDetail.release_date.getDateString(separator: "-"))"
        } else {
            releaseLbl.text = "Unknown Release Date"
        }
        descLbl.text = movieDetail.overview
//        linkPlayer = movieResult[movieId].key
    }
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier,
                                                      for: indexPath) as! ReviewTableViewCell
        cell.backgroundColor = .white
        cell.configureCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    
}
