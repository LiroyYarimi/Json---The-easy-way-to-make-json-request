//
//  ViewController.swift
//  Json
//
//  Created by liroy yarimi on 15.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

struct WebsiteDescription : Decodable{
    let name : String
    let description: String
    let courses : [Cource]
}

struct Cource :Decodable{
    let id: Int? //the qustion mark is for Missing Fields URL
    let name: String?
    let link: String?
    let imageUrl: String?
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        let jsonUrlStringWebsiteDescription = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
//        let jsonUrlStringMissingFields = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
//        let jsonUrlStringCourses = "https://api.letsbuildthatapp.com/jsondecodable/courses"
//        let jsonUrlStringCourse = "https://api.letsbuildthatapp.com/jsondecodable/course"
        
        guard let url = URL(string: jsonUrlStringWebsiteDescription) else
        {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            guard let data = data else {
                print("data is nil")
                return
            }
            do{
                
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                print("name: \(websiteDescription.name)\ndescription: \(websiteDescription.description)")
                for i in websiteDescription.courses{
                    if let id = i.id{
                        print("id: \(id)\tname: \(i.name!)\tlink: \(i.link!)\timageUrl: \(i.imageUrl!)\n")
                    }
                }
                

            } catch let jsonErr{
                print("Error serializing json:",jsonErr)
            }
            
        }.resume()
    }


}

