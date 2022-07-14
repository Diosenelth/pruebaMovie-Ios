//
//  Service.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 27/06/22.
//

import Alamofire
import SwiftUI

class ServiceHome : ObservableObject{
    @Published var listMovies = [MovieModel]()
    @Published var movie = [MovieDetailModel]()
    @Published var error = false
    @Published var loading = true
    @Published var page = 1
    
    func getPopularMovies() async{
        error=false
        let relativePath = "movie/popular?page=\(page)&api_key=\(Constants.apiKey)&language=es&countries=CO"
        AF.request(Constants.url + relativePath)
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
        error=false
        let relativePath = "movie/\(id)?api_key=\(Constants.apiKey)&language=es&countries=CO"
        AF.request(Constants.url + relativePath)
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
