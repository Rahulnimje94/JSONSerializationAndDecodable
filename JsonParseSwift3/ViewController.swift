//
//  ViewController.swift
//  JsonParseSwift3
//
//  Created by Anand on 31/08/18.
//  Copyright © 2018 Rahul. All rights reserved.
//

import UIKit

//use in Xcode 9
/*struct WebsiteDescription: Decodable {
    let name: String
    let description: String
    let courses: [Course]
}*/

struct WebsiteDescription {
    let name: String
    let description: String
    let courses: [Course]
}

struct Course {
    let id: Int
    let name: String
    let link: String
    let imageUrl: String
    
//  Remove this init method in Decodable Method
    
    init(json: [String: Any]) {
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        link = json["link"] as? String ?? ""
        imageUrl = json["imageUrl"] as? String ?? ""
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jsonUrlString = "http://api.letsbuildthatapp.com/jsondecodable/course"
        
//        let jsonUrlString = "http://api.letsbuildthatapp.com/jsondecodable/website_description"
        
        //UnWrepping jsonUrlString
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            //Guard let for optional binding
            guard let data = data else { return }
            
            //            let dataAsString = String(data: data, encoding: .utf8)
            //            print(dataAsString)
            
            do {
                
                /*let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                 print(websiteDescription.name, websiteDescription.description)*/
                //---------------------------------------------------------------------
                
                
                //Mark:- IF Response is array of dic use this otherwise use next method
                
                /*let courses = try JSONDecoder().decode([Course].self, from: data)
                 print(courses)*/
                
                //---------------------------------------------------------------------
                
                
                //MARK:-  first Conform your Data model object to -> Decodable
                
                /*     let course = try JSONDecoder().decode(Course.self, from: data)
                 print(course.name)*/
                
                //---------------------------------------------------------------------
                
                
                //   MARK:- Swift 2/3/Objective C
                
                guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else { return }
                
                let course = Course(json: json)
                print(course.name)
                //----------------------------------------------------------------------
                
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
            }.resume()
        
    }
    
}

