//
//  Service.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 27/06/22.
//

import Foundation
import Alamofire
import SwiftUI

class Service : ObservableObject{
    fileprivate var url = "https://api.themoviedb.org/3/"
    let apikey = "cd221c9c9cdc3e0f8e4969a04e9dfc45"
    @Published var listMovies = [MovieModel]()
    @Published var movie = [MovieDetailModel]()
    @Published var error = false
    @Published var loading = true
    @Published var page = 1
    
    func getPopularMovies() async{
        let relativePath = "movie/popular?page=\(page)&api_key=\(apikey)&language=es&countries=CO"
        AF.request(self.url + relativePath)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MoviesModel.self){ response in
                guard let data = response.data else{
                    self.error = true
                    return
                }
                do{
                    let response = try JSONDecoder().decode(MoviesModel.self, from: data)
                    if self.listMovies.count > 0 {
                        response.results.forEach({ movie in
                            self.listMovies.append(movie)
                        })
                        self.page = self.page + 1
                    }else{
                        self.listMovies = response.results
                        self.page = self.page + 1
                    }
                    self.loading = false
                }catch{
                    print("Error: \(error) page: \(self.page)")
                    self.error = true
                }
            }
    }
    
    func getMovie(id:String) async{
        let relativePath = "movie/\(id)?api_key=\(apikey)&language=es&countries=CO"
        AF.request(self.url + relativePath)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MovieDetailModel.self){response in
                guard let data = response.data else{
                    self.error=true
                    return
                }
                do{
                    let res = try JSONDecoder().decode(MovieDetailModel.self, from: data)
                    if self.movie.count > 0{
                        self.movie[0]=res
                    }else{
                        self.movie.append(res)
                    }
                }catch{
                    self.error = true
                }
            }
    }
}
