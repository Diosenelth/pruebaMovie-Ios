//
//  Service.swift
//  Movie
//
//  Created by Diosenelth De la hoz Fonseca on 27/06/22.
//

import Foundation
import Alamofire

class Service : ObservableObject{
    fileprivate var url = "https://api.themoviedb.org/3/"
    let apikey = "cd221c9c9cdc3e0f8e4969a04e9dfc45"
    //typealias moviesCallBack = (_ response:Movies?, _ status: Bool, _ message:String) -> Void
    //var callBack:moviesCallBack?
    @Published var listMovies = [Movie]()
    @Published var error = false
    
    
    func getPopularMovies(page: String) async{
        let relativePath = "movie/popular?page=\(page)&api_key=\(apikey)&language=es&countries=CO"
        AF.request(self.url + relativePath)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Movies.self){ response in
                guard let data = response.data else{
                    self.error = true
                    return
                }
                do{
                    let response = try JSONDecoder().decode(Movies.self, from: data)
                    self.listMovies = response.results
                }catch{
                    self.error = true
                    //self.callBack?(nil, false, error.localizedDescription)
                }
            }
    }
    
    /*func completionHandler(callBack: @escaping moviesCallBack){
        self.callBack = callBack
    }*/
}