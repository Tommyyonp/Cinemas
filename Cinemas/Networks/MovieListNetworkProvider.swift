//
//  MovieListNetworkProvider.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation

protocol MovieListNetworkProvider {
    func getPopularMovies(page: Int, completion: @escaping ((Movies?, Error?) -> Void))
}
