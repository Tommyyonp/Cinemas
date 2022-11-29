//
//  HomeViewModel.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation


class HomeViewModel {
    
    // MARK: - Properties
    let useCase : HomeUseCase
    var moviesResult : Movies!

    init(useCase : HomeUseCase) {
        self.useCase = useCase
    }
    
    // MARK: - Output
    var didReceivePopularMovies : (() -> Void)?
    var didReceiveError : ((String) -> Void)?
    
    // MARK: - Input
    func getPopularMovies(page: Int) {
        useCase.getPopularMovies(page: page) { [weak self] movies, error in
            guard let movies = movies,
                  error == nil
            else {
                self?.didReceiveError?(error?.localizedDescription ?? "")
                return
            }
            self?.moviesResult = movies
            self?.didReceivePopularMovies?()
        }
    }
}
