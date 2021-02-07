


import Foundation
import UIKit

class ListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var user:[User] = []
  
    
    @IBOutlet weak var listView: UITableView!
    let alertService = AlertService()
    let request = Request()
    var listas : [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listView.dataSource = self
        listView.delegate = self
        

        request.getUsers(endpoint: "api/users") { [weak self] ( result ) in
                  
                       switch result{

                       case.success(let lista):
                        
                           print("imprimiendo")
                        
                          self!.listas = lista
                          
                          print(self!.listas)
                          DispatchQueue.main.async {
                              self!.listView.reloadData()
                          }
                         
                         
                        
                       case.failure(let error):

                           guard let alert = self?.alertService.alert(message: error.localizedDescription) else {
                                   return
                                   }
                           self?.present(alert,animated: true)

                           break

                
            }
    


}
    
}
    func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int
        {
            return listas.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = listView.dequeueReusableCell(withIdentifier: "cellId") as! userRow
           
            cell.nombre.text = listas[indexPath.row]
         
          return cell
        }
        

    

}
