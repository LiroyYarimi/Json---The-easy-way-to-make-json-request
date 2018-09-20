//
//  ViewController.swift
//  Json
//
//  Created by liroy yarimi on 15.9.2018.
//  Copyright © 2018 Liroy Yarimi. All rights reserved.
//

import UIKit

struct WebsiteDescription : Decodable{ //:Decodable - for our new way
    let name : String
    let description: String
    let courses : [Cource]
}

struct Cource :Decodable{ //:Decodable - for our new way
    let id: Int? //the qustion mark is for Missing Fields URL
    let name: String?
    let link: String?
    let imageUrl: String?
    
    //this is the old way to do it
//    init(json: [String:Any]) {
//        id = json["id"] as? Int ?? -1
//        name = json["name"] as? String ?? ""
//        link = json["link"] as? String ?? ""
//        imageUrl = json["imageUrl"] as? String ?? ""
//    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/website_description"
        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses_missing_fields"
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
//        let jsonUrlString = "https://api.letsbuildthatapp.com/jsondecodable/course"
        
        //check for urlJson
        guard let url = URL(string: jsonUrlString) else
        {
            print("url is nil")
            return}
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            //check error
            if error != nil{
                print(error!)
                return
            }
            //check data
            guard let data = data else {
                print("data is nil")
                return
            }
//            do{//start working
            
//            print data as a string
//            self.printDataAsString(data: data)
//
//            this is the old way to do it
//            self.theOldWay(data: data)
//
//            cource call
//            self.courceCall(data: data)
//
//            cources call
//            self.courcesCall(data: data)
//
//            website description call
//            self.websiteDescriptionCall(data: data)
//
            //courses missing fields call is like courcesCall but we need to add questions mark '?' to Cource struct
            self.courcesCall(data: data)
                

                

//            } catch let jsonErr{
//                print("Error serializing json:",jsonErr)
//            }
            
        }.resume()
    }
    
    func websiteDescriptionCall(data: Data){
        do{
            let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
//            print(websiteDescription.name, websiteDescription.description)
            print("name: \(websiteDescription.name)\ndescription: \(websiteDescription.description)")
            for i in websiteDescription.courses{
                if let id = i.id{
                    print("id: \(id)\tname: \(i.name!)\tlink: \(i.link!)\timageUrl: \(i.imageUrl!)\n")
                }
            }

        } catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
    }
    
    func courcesCall(data:Data){
        do{
            let cources = try JSONDecoder().decode([Cource].self, from: data)
            print(cources)
            print("item 1: \(cources[1].name!)")
        } catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        
    }
    
    func courceCall(data:Data){
        do{
            let cource = try JSONDecoder().decode(Cource.self, from: data)
            print(cource)
        } catch let jsonErr{
            print("Error serializing json:",jsonErr)
        }
        
    }
    
//    //this is the old way to do it
//    func theOldWay(data: Data){
//        do{
//            guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else{ return}
//            let cource = Cource(json: json)
//            print(cource.name)
//        } catch let jsonErr{
//            print("Error serializing json:",jsonErr)
//        }
//    }

    //print data as a string
    func printDataAsString(data : Data){
        let dataAsString = String(data: data ,encoding: .utf8)
        print(dataAsString!)
    }

}

