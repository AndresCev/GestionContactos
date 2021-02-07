import Foundation
import UIKit

class PerfilControler: UIViewController {
   
    @IBOutlet weak var nombreUsuario: UILabel!
    
    @IBOutlet weak var passwordUsuaraio: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let userText = nombreUsuario.text!
        let pass = passwordUsuaraio.text!
        let user = User(user: userText, pass: pass)
        print(user)
      

}
    
}
    

        
         
