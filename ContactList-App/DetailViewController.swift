//
//  DetailViewController.swift
//

//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var largePictureImageView: UIImageView!
    @IBOutlet weak var userDetailStack: UIStackView!
    
    var user : User?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.

    }
    
    func formatName(userName: UserName?) -> String {
           // return userName?.title.capitalized + ". " + userName?.first.capitalized + " " + userName?.last
   return "TITLE" //could not get the title and the picture for the detailed view 
    }
    
    func setupView(){
        if let _user = user {
            let fullName = formatName(userName: _user.name)
            nameLabel.text = fullName
        } else {
            nameLabel.text = "Undefined"
        }
        cityLabel.text = user?.location.city
        streetLabel.text = user?.location.street
        phoneLabel.text = user?.phone
        cellLabel.text = user?.cell
        emailLabel.text = user?.email
        let picture = user?.picture
        largePictureImageView.image = UIImage(named: picture?.large ?? " ")
    }
}
