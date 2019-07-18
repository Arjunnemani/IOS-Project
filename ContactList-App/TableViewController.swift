//
//  TableViewController.swift
// 
//
//  

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrayUsers : [User]?
    
    var selectedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Get users random
        fetchUsers()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let detailViewController = segue.destination as? DetailViewController else {
            return
        }
        detailViewController.user = selectedUser
    }
    
    func formatName(userName: UserName) -> String {
        return userName.title.capitalized + ". " + userName.first.capitalized + " " + userName.last.uppercased()
    }
    
    func fetchUsers(){
        var request = URLRequest(url: URL(string: "https://randomuser.me/api/?results=50&seed=nemani")!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            do{
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(UserBase.self, from: data!)
                self.arrayUsers = responseModel.results
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                print(responseModel)
            } catch let error {
                print("JSON Serialization ERROR: ", error)
            }
        }.resume()
    }
    
}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayUsers?.count  ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "textCell") as? UserTableViewCell else {
            print("falied here.")
            return UITableViewCell()
        }
        print("falied not here.")
        
        if let user = arrayUsers?[indexPath.row] {
            let fullName = formatName(userName: user.name)
            cell.nameLabel.text = fullName
            cell.emailLabel.text = user.email
        } else {
            cell.nameLabel.text = "Undefined"
            cell.emailLabel.text = "Undefined"
        }
        
        
        if let picture = arrayUsers?[indexPath.row].picture {
            cell.avatarImageView.image = UIImage(named: picture.thumbnail)
        } else {
            cell.avatarImageView.image = UIImage(named: "")
        }
        return cell
    }
}

extension TableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedUser = arrayUsers![indexPath.row]
        performSegue(withIdentifier: "showd", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
