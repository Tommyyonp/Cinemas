//
//  DetailViewModel.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation

class DetailViewModel {
    // MARK: - Properties
    let useCase : DetailUseCase
    var movieDetail : MovieDetail!
    var movieLink : MovieLink!
    var movieReview : MovieReview!
    
    init(useCase : DetailUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Input
    var didReceiveMovieDetail : (() -> Void)?
    var didReceiveMovieLink : (() -> Void)?
    var didReceiveMovieReview : (() -> Void)?
    var didReceiveError : ((String) -> Void)?
    
    // MARK: - Output
    func getMovieDetail(movieId : Int) {
        useCase.getMovieDetail(movieId: movieId) { [weak self] movie, error in
            if error != nil {
                self?.didReceiveError?(error?.localizedDescription ?? "")
            }
            if let movie = movie {
                self?.movieDetail = movie
                self?.didReceiveMovieDetail?()
            }
        }
    }
    func getMovieLink(movieId : Int) {
        useCase.getMovieLink(movieId: movieId) { [weak self] movie, error in
            guard let movie = movie,
                  error == nil
            else {
                self?.didReceiveError?(error?.localizedDescription ?? "")
                return
            }
            self?.movieLink = movie
            self?.didReceiveMovieLink?()
        }
    }
    func getMovieReview(movieId : Int) {
        useCase.getMovieReview(movieId: movieId) { [weak self] review, error in
            guard let review = review,
                  error == nil
            else {
                self?.didReceiveError?(error?.localizedDescription ?? "")
                return
            }
            self?.movieReview = review
            self?.didReceiveMovieReview?()
        }
    }
}
