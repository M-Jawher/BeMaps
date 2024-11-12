//
//  ListUsersVC.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 10/11/2024.
//

import UIKit
import Firebase

class ListUsersVC: UIViewController {
    
    var dataList : [UsersM] = []
    var ref = Database.database().reference()
    
    
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ref.child("usersData").observe(.childAdded, with: { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
               return
           }
            print(dictionary["email"] as? String ?? "")
            let obj = UsersM(userId: Int(snapshot.key), userEmail: dictionary["email"] as? String, userPassword: "")
            if dictionary["status"] as? String ?? "" == "0"{
                self.dataList.append(obj)
            }
            self.SetUpTable()
        })
        
    }
    
    func SetUpTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 15
        self.tableView.register(UINib(nibName: "UsersCell", bundle: nil), forCellReuseIdentifier: "UsersCell")
        tableView.separatorStyle = .singleLine
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


// Mark TableView
extension ListUsersVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataList.count)
        return dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "UsersCell", for: indexPath) as! UsersCell
        cell.SetDataUsers(data: dataList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
}
