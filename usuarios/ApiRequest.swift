//
//  ApiRequest.swift
//  rutas
//
//  Created by alumnos on 29/01/2021.
//  Copyright © 2021 alumnos. All rights reserved.
//

import Foundation
import UIKit




enum MyResult<T,E:Error> {
    case succes(T)
    case failure(E)
}


class APIRequest  {
    let resourceURL: URL
    
    init(endpoint: String) {
        
        
        let resourceString = "https://superapi.netlify.app/\(endpoint)"
        
        guard let resourceURL = URL(string: resourceString)else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func save(_ userToSave: User, completion: @escaping(Result<User,Error>)->Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userToSave)
            
            
            
            let dataTask = URLSession.shared.dataTask(with: urlRequest){ data, response, _ in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                    let jsonData = data else {
                        completion(.failure(APIError.responseProblem))
                        return
                }
                
                do {
                    let userData = try JSONDecoder().decode(User.self, from: jsonData)
                    print(userData)
                    
                    
                }catch{
                    completion(.failure(APIError.decodingProblem))
                }
            }
            
            dataTask.resume()
            
            
        }catch{
            completion(.failure(APIError.encodingProblem))
        }
    }
    enum logInError: Error{
        case badURL
        case badResponse
    }
    

    func login(_ userLogin: User, completion: @escaping(Result<User,Error>)->Void) {
        do{
            var urlRequest = URLRequest(url: resourceURL)
            
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = try JSONEncoder().encode(userLogin)
            
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                
                DispatchQueue.main.async {
                    
                    guard let unwrappedResponse = response as? HTTPURLResponse else{
                        
                        completion(.failure(NetworkingError.badResponse))
                        return
                    }
                    
                    print(unwrappedResponse.statusCode)
                    
                    switch unwrappedResponse.statusCode{
                        
                    case 200 ..< 300:
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                                
                                let vc = storyboard.instantiateViewController(identifier: "listview") as! ListView
                                        
                                vc.modalPresentationStyle = .overFullScreen
                                
                                
                        
                        print("Sesión iniciada")
                        
                        
                        
                    default:
                        print("No se ha podido iniciar sesión")
                    }
                    
                }
                
                
            }
            
            task.resume()
            
            
        }catch{
            completion(.failure(APIError.encodingProblem))
        }
    }
    
}

enum APIError:Error {
    case responseProblem
    case decodingProblem
    case encodingProblem
}
