//
//  ListView.swift
//  usuarios
//
//  Created by user177248 on 2/5/21.
//


import Foundation
import UIKit



class ListView: UIViewController {
  
    let request = Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        request.getUsers(endpoint: "api/users") { [weak self] (result) in
            
            switch result{
                
            case.success(let lista):
                print("imprimiendo desde getusers")
                print(lista)
               
                
                break
              
            case.failure(let error):
               
              print("error")
                
                break
                
            }
    


}
    
}



    

}
