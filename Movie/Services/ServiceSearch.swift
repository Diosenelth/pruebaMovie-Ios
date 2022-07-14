//
//  ServiceSearch.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 14/07/22.
//

import Alamofire
import SwiftUI


class ServiceSearch: ObservableObject{
    @Published var listMovies = [MovieModel]()
    @Published var movie = [MovieDetailModel]()
    @Published var error = false
    @Published var loading = false
    @Published var search = ""
    
    func getMovie(id:String) async{
        loading = true
        error = false
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
    
    func getSearchMovies(search:String) async{
        loading = true
        error = false
        let relativePath = "search/movie?api_key=\(Constants.apiKey)&query='\(search)'&language=es&countries=CO"
        AF.request(Constants.url + relativePath)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: MoviesModel.self){ response in
                guard let data = response.data else{
                    self.error = true
                    return
                }
                do{
                    let response = try JSONDecoder().decode(MoviesModel.self, from: data)
                    self.listMovies = response.results
                    self.loading = false
                }catch{
                    print("Error:           \(error)")
                    self.error = true
                }
            }
    }
}
