//
//  MovieDetailNetworkProvider.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation

protocol MovieDetailNetworkProvider {
    func getMovieDetail(movieId : Int, completion: @escaping ((MovieDetail?, Error?) -> Void))
    func getMovieLink(movieId : Int, completion: @escaping ((MovieLink?, Error?) -> Void))
    func getMovieReview(movieId : Int, completion: @escaping ((MovieReview?, Error?) -> Void))
}

