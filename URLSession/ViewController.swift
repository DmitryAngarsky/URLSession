//
//  ViewController.swift
//  URLSession
//
//  Created by Дмитрий Тараканов on 08.12.2019.
//  Copyright © 2019 Dmitry Angarsky. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    let spinner = UIActivityIndicatorView(style: .large)
    
    let postCellIdentifier = "postCell"
    var posts: [Post] = []

    override func viewDidLoad() {
        
        var urlComponents = URLComponents()
        
        urlComponents.scheme = "http"
        urlComponents.host   = "jsonplaceholder.typicode.com"
        urlComponents.path   = "/posts"
        
        guard let url = urlComponents.url else { return }
        
        spinner.startAnimating()
        tableView.backgroundView = spinner
        URLSession.shared.dataTask(with: url) { (data, response, error) in
                
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let posts = try JSONDecoder().decode([Post].self, from: data)
                self.posts = posts
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.tableView.reloadData()
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: postCellIdentifier, for: indexPath) as! TableViewCell
        
        cell.id.text        = String(posts[indexPath.row].id)
        cell.userId.text    = String(posts[indexPath.section].userId)
        cell.titleCell.text = posts[indexPath.section].title
        cell.body.text      = posts[indexPath.section].body
        
        return cell
    }
}

