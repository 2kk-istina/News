//
//  ViewController.swift
//  News
//
//  Created by Истина on 09/05/2019.
//  Copyright © 2019 Истина. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newsTable: UITableView!
    var articles: [Article]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newsTable.delegate = self
        newsTable.dataSource = self
        recieveNews()
        
    }
    
    
    func recieveNews(){
        
        let jsonUrlString = "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=37aea00c369a4addb83a805be9911d69"
        
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            self.articles = [Article]()
            do {
               let jsonData = try
                JSONDecoder().decode(Root.self, from: data)
                self.articles = jsonData.articles
                DispatchQueue.main.async {
                    self.newsTable.reloadData()
                }
            } catch let jsonError {
                print("Error serializing:", jsonError)
            }
        }.resume()
        
        
            //Swift 2,3 Objective C
       /* let newsRequest = URLRequest(url: URL(string: "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=37aea00c369a4addb83a805be9911d69")!)
        let task = URLSession.shared.dataTask(with: newsRequest){ (data,response,error) in
            if error != nil {
                print(error as Any)
            }
            guard let data = data else { return }
            self.articles = [Article]()
            do {
                let JSONdata = try? (JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : AnyObject])
                if let articlesJ = JSONdata?["articles"] as? [[String: AnyObject]] {
                    for ` in articlesJ {
                        let article = Article()
                        article.author = articleItem["author"] as? String ?? "none"
                        article.headline = articleItem["description"] as? String ?? "none"
                        article.descriptions = articleItem["content"] as? String ?? "none"
                        article.urlImage = articleItem["urlToImage"] as? String ?? "none"
                        
                        self.articles?.append(article)
                    }
                }
                DispatchQueue.main.sync {
                    self.newsTable.reloadData()
                }
                
            } catch let error {
                print(error)
            }
            
        }
        task.resume()*/
    }
    
    
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsCell {
            
            let forArticle = self.articles?[indexPath.row]
            cell.newsTitle.text = forArticle?.title
            cell.article.text = forArticle?.description
            cell.newsAuthor.text = forArticle?.author
            
            let imageCache = AutoPurgingImageCache(memoryCapacity: 111_111_111, preferredMemoryUsageAfterPurge: 90_000_000)
            
            if let imageURL = forArticle?.urlToImage {
            Alamofire.request(imageURL).responseImage { response in
                if response.result.value != nil {
                    let image = UIImage(data: response.data!, scale: 1.0)!
                    imageCache.add(image, withIdentifier: imageURL)
                }
                if let image = imageCache.image(withIdentifier: imageURL) {
                    let size = CGSize(width: 160, height: 150)
                    let aspectScaledToFitImage = image.af_imageAspectScaled(toFit: size)
                    DispatchQueue.main.async {
                        cell.newsImage.image = aspectScaledToFitImage
                    }
                }
            }
            }
        return cell
    }
        return UITableViewCell()
    }
    
    }


