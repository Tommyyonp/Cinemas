//
//  HomeUseCase.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation
import Alamofire

struct HomeUseCase : MovieListNetworkProvider {
    
    typealias GetPopularMovies = ((Movies?, Error?) -> Void)
    typealias SearchMovie = ((Movies?, Error?) -> Void)
    
    private let decoder = JSONDecoder()
    
    func getPopularMovies(page: Int, completion: @escaping GetPopularMovies) {
        let url = "\(Constant.baseUrl)/movie/popular?api_key=\(Constant.apiKey)&page=\(page)"
        AF.request(url).response { response in
            do {
                guard let data = response.data else { return }
                let movies = try decoder.decode(Movies.self, from: data)
                completion(movies, nil)
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
