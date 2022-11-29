//
//  DetailUseCase.swift
//  Cinemas
//
//  Created by Tommy Yon Prakoso on 26/11/22.
//

import Foundation
import Alamofire

struct DetailUseCase : MovieDetailNetworkProvider {
    
    typealias GetMovieDetail = ((MovieDetail?, Error?) -> Void)
    typealias GetMovieLink = ((MovieLink?, Error?) -> Void)
    typealias GetMovieReview = ((MovieReview?, Error?) -> Void)
    
    private let decoder = JSONDecoder()
    
    func getMovieDetail(movieId: Int, completion: @escaping GetMovieDetail) {
        let url = "\(Constant.baseUrl)/movie/\(movieId)?api_key=\(Constant.apiKey)"
        print(url)
        AF.request(url).response { response in
            do {
                if let data = response.data {
                    let movie = try? JSONDecoder().decode(MovieDetail.self, from: data)
                    completion(movie, nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getMovieLink(movieId: Int, completion: @escaping GetMovieLink) {
        let url = "\(Constant.baseUrl)/movie/\(movieId)/videos?api_key=\(Constant.apiKey)&language=en-US"
        AF.request(url).response { response in
            do {
                if let data = response.data {
                    let movie = try? JSONDecoder().decode(MovieLink.self, from: data)
                    completion(movie, nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
    
    func getMovieReview(movieId: Int, completion: @escaping GetMovieReview) {
        let url = "\(Constant.baseUrl)/movie/\(movieId)/reviews?api_key=\(Constant.apiKey)&language=en-US&page=1"
        AF.request(url).response { response in
            do {
                if let data = response.data {
                    let movie = try? JSONDecoder().decode(MovieReview.self, from: data)
                    completion(movie, nil)
                }
            } catch let error {
                print(error.localizedDescription)
                completion(nil, error)
            }
        }
    }
}
