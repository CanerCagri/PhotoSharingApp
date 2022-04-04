//
//  FeedViewController.swift
//  PhotoSharingApp
//
//  Created by Caner Çağrı on 1.04.2022.
//

import UIKit
import Firebase
import SDWebImage

class FeedViewController: UIViewController {
    
    var postArray = [Post] ()
    
  

    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        LoadFirebaseData()
    }
}

extension FeedViewController: UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedTableViewCell
        
        //Using SD Web Image library for url link transform to image with async
        cell.feedImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].image))
        cell.emailText.text = postArray[indexPath.row].email
        cell.commentText.text = postArray[indexPath.row].comment
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
  
    func LoadFirebaseData() {
        let firestoreDatabase = Firestore.firestore()
        
        // when listing , checking date and first listing new posts 
        firestoreDatabase.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error try again")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        if let imageUrl = document.get("imageurl") as? String {
                            
                            if let email = document.get("email") as? String {
                                
                                if let comment = document.get("comment") as? String {
                                    let post = Post(email: email, comment: comment, image: imageUrl)
                                    self.postArray.append(post)
                                }
                            }
                        }
                        
                        
                            
                    }
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    
    
}
