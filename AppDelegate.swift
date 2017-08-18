//
//  AppDelegate.swift
//  Final_project
//
//  Created by u1015168 on 11/1/16.
//  Copyright © 2016 u1015168. All rights reserved.
//

import UIKit
import Darwin
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var price: Double = 0.0
    var flightInfo: String = ""
    
    var price_Label: UILabel!
    var targetCity_Label: UILabel!
    var Button: UIButton!
    var orderButton: UIButton!
    var clearButton: UIButton!
    
    var city1_name: UITextField!
    var city2_name: UITextField!
    var date_picker: UITextField!
    
    var city1_nameLabel: UILabel!
    var city2_nameLabel: UILabel!
    var date_pickerLabel:UILabel!
    
    var flight_info1: UILabel!
    var flight_info2: UILabel!
    
    var city1: String!
    var city2: String!
    var date: String!
    
    var city1_tableView: UITableView!
    var city2_tableView: UITableView!
    
    var camera: GMSCameraPosition!
    var mapView: GMSMapView!
    
    let rootViewController: UIViewController = UIViewController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        rootViewController.view.backgroundColor = UIColor.darkGray
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
        
        GMSServices.provideAPIKey("AIzaSyAWc3Q9PIf5WbKX5NwkDRi8luSXncVjYQc")
        camera = GMSCameraPosition.camera(withLatitude: 32.899411, longitude: -97.041376, zoom: 4)
        mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 1024-500, width: 768, height: 500), camera: camera)
        rootViewController.view.addSubview(mapView)
        
        
        city1_tableView = UITableView(frame: CGRect(x: 132, y: 130, width: 115, height: 300))
        city1_tableView.backgroundColor = UIColor.white
        city1_tableView.isHidden = false
        rootViewController.view.addSubview(city1_tableView)
        
        city1_nameLabel = UILabel(frame:CGRect(x: 82,y: 100,width: 120,height: 30))
        city1_nameLabel.text = "City1:"
        city1_nameLabel.textColor = UIColor.white
        rootViewController.view.addSubview(city1_nameLabel)
        
        city1_name = UITextField(frame: CGRect(x: 132,y: 100,width: 115,height: 30))
        city1_name.backgroundColor = UIColor.white
        city1_name.placeholder = "City1"
        rootViewController.view.addSubview(city1_name)
        
        date_pickerLabel = UILabel(frame: CGRect(x: 290,y: 100,width: 120,height: 30))
        date_pickerLabel.text = "Date: "
        date_pickerLabel.textColor = UIColor.white
        rootViewController.view.addSubview(date_pickerLabel)
        
        date_picker = UITextField(frame: CGRect(x: 340,y: 100,width: 105,height: 30))
        date_picker.backgroundColor = UIColor.white
        date_picker.placeholder = "Date"
        date_picker.addTarget(self, action: #selector(AppDelegate.createDatePicker), for: UIControlEvents.touchDown)
        rootViewController.view.addSubview(date_picker)
        
        city2_nameLabel = UILabel(frame: CGRect(x: 480,y: 100,width: 120,height: 30))
        city2_nameLabel.text = "City2: "
        city2_nameLabel.textColor = UIColor.white
        rootViewController.view.addSubview(city2_nameLabel)
        
        city2_name = UITextField(frame: CGRect(x: 535,y: 100,width: 115,height: 30))
        city2_name.backgroundColor = UIColor.white
        city2_name.placeholder = "City2"
        rootViewController.view.addSubview(city2_name)
        
        targetCity_Label = UILabel(frame: CGRect(x: 82,y: 250,width: 300,height: 30))
        targetCity_Label.text = "Common_city:"
        targetCity_Label.textColor = UIColor.white
        rootViewController.view.addSubview(targetCity_Label)
        
        price_Label = UILabel(frame: CGRect(x: 480,y: 250,width: 300,height: 30))
        price_Label.text = "Total Price: $"
        price_Label.textColor = UIColor.white
        rootViewController.view.addSubview(price_Label)
        
        flight_info1 = UILabel(frame: CGRect(x: 35,y: 250,width: 350,height: 300))
        flight_info1.lineBreakMode = NSLineBreakMode.byWordWrapping
        flight_info1.numberOfLines = 5
        flight_info1.textColor = UIColor.white
        flight_info1.text = "flight info1 \r  \r  \r  \r "
        rootViewController.view.addSubview(flight_info1)

        flight_info2 = UILabel(frame: CGRect(x: 415,y: 250,width: 350,height: 300))
        flight_info2.lineBreakMode = NSLineBreakMode.byWordWrapping
        flight_info2.numberOfLines = 5
        flight_info2.textColor = UIColor.white
        flight_info2.text = "flight info2 \r  \r  \r  \r "
        rootViewController.view.addSubview(flight_info2)
        
        Button = UIButton(frame: CGRect(x: 160,y: 200,width: 70,height: 20))
        Button.setTitle("Search", for: UIControlState())
        Button.backgroundColor = UIColor.black
        Button.addTarget(self, action: #selector(AppDelegate.begin_search), for: UIControlEvents.touchDown)
        rootViewController.view.addSubview(Button)
        
        
        orderButton = UIButton(frame: CGRect(x: 360,y: 200,width: 70,height: 20))
        orderButton.setTitle("order", for: UIControlState())
        orderButton.backgroundColor = UIColor.black
//        orderButton.addTarget(self, action: #selector(AppDelegate.order), for: UIControlEvents.touchDown)
        rootViewController.view.addSubview(orderButton)
        
        clearButton = UIButton(frame: CGRect(x: 560,y: 200,width: 70,height: 20))
        clearButton.setTitle("Clear", for: UIControlState())
        clearButton.backgroundColor = UIColor.black
        clearButton.addTarget(self, action: #selector(AppDelegate.clearAll), for: UIControlEvents.touchDown)
        rootViewController.view.addSubview(clearButton)
        
        
        return true
    }
    
    
//    var autoCompletePossibilities: [String] = ["China","Chil","USA"]
//    var autoComplete: [String] = []
//    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
//        
//        searchAutocompleteEntriesWithSubstring(substring)
//        
//        return true
//        
//    }
//    
//    
//    func searchAutocompleteEntriesWithSubstring(_ substring: String) {
//        autoComplete.removeAll(keepingCapacity: false)
//        
//        for key in autoCompletePossibilities {
//            
//            let myString:NSString! = key as NSString
//            
//            let substringRange :NSRange! = myString.range(of: substring)
//            
//            if (substringRange.location  == 0) {
//                autoComplete.append(key)
//            }
//        }
//        
//        tableView.reloadData()
//    }
//    
//    
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
//        
//        let index = indexPath.row as Int
//        
//        cell.textLabel!.text = autoComplete[index]
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return autoComplete.count
//        
//    }
//    
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        
//        let selectedCell: UITableViewCell = tableView.cellForRow(at: indexPath)!
//        
//        city1_name.text = selectedCell.textLabel!.text!
//        
//        
//    }

    let datePicker = UIDatePicker()
    
    func createDatePicker() {
        //format for picker
        datePicker.datePickerMode = .date
        
        //toolbar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        date_picker.inputAccessoryView = toolbar
        
        //asigning data picker to text field
         date_picker.inputView = datePicker
    
    }
    func donePressed() {
        //format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        date_picker.text = dateFormatter.string(from: datePicker.date)
        self.inputView?.endEditing(true)
    }
    
    func clearAll(){
        city1_name.text = ""
        city2_name.text = ""
        date_picker.text = ""
        targetCity_Label.text = "Common_city:"
        price_Label.text = "Total Price: $"
        flight_info1.text = "flight info2 \r  \r  \r  \r "
        flight_info2.text = "flight info2 \r  \r  \r  \r "
        mapView.clear()
    }
    
    
    func display_map(_ city1: String, city2: String, target_city: String) {
        
        
        let location_city1 = getLocation(city1)
        let location_city2 = getLocation(city2)
        let location_targetCity = getLocation(target_city)
        
        print("lan: \(location_city1[0])   lon: \(location_city1[1])")
        print("lan: \(location_targetCity[0])   lon: \(location_targetCity[1])")
        print("lan: \(location_city2[0])   lon: \(location_city2[1])")

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location_city1[0], longitude: location_city1[1])
        marker.title = city1
        marker.map = mapView
        
//        let price = 232
        let marker1 = GMSMarker()
        marker1.position = CLLocationCoordinate2D(latitude: location_city2[0], longitude: location_city2[1])
        marker1.title = city2
//        marker1.snippet = "Price: $\(price) Depart at: 5:23am Arrive at: 4:32am Flight Number: United 888"
        marker1.map = mapView
        
        let marker2 = GMSMarker()
        marker2.position = CLLocationCoordinate2D(latitude: location_targetCity[0], longitude: location_targetCity[1])
        marker2.title = target_city
        marker2.map = mapView
        
        
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: location_city1[0], longitude: location_city1[1]))
        path.add(CLLocationCoordinate2D(latitude: location_targetCity[0], longitude: location_targetCity[1]))
        path.add(CLLocationCoordinate2D(latitude: location_city2[0], longitude: location_city2[1]))
        
        let rectangle = GMSPolyline(path: path)
        rectangle.strokeColor = UIColor.blue
        rectangle.strokeWidth = 2.0
        rectangle.map = mapView
        
    }
    
    
    var targetCity: String!
    
    func begin_search() {
        // let city1: String = "SLC"
        // let city2: String = "MIA"
        // let date: String = "2016-11-20"
        city1 = city1_name.text
        city2 = city2_name.text
        date = date_picker.text
        
        let result: [String] = loadAirportInfo(city1,City2: city2)
        
//        for city in result {
          display_map(city1, city2: city2, target_city: result[0])
          targetCity_Label.text = "Common_city:  \(result[0])"
//        }
        
        
//        var min: Double = 10000.0
//        
//        var flight_INFO1: String!
//        var flight_INFO2: String!
//        
//        for city in result {
//            search(city1, destination: city, date: date)
//            while(price == 0.0 || flightInfo == ""){}
//            let price1 = price
//            let flightinfo1 = flightInfo
//            
//            price = 0.0
//            flightInfo = ""
//            search(city2, destination: city, date: date)
//            while(price == 0.0 || flightInfo == ""){}
//            let price2 = price
//            let flightinfo2 = flightInfo
//            
//            if (price1 + price2) < min {
//                min = price1 + price2
//                targetCity = city
//                flight_INFO1 = flightinfo1
//                flight_INFO2 = flightinfo2
//            }
//            
//        }
//        
//        
//        display_map(city1, city2: city2, target_city: targetCity)
//        
//        
//        flight_info1.text = flight_INFO1
//        
//        flight_info2.text = flight_INFO2
//        
//        targetCity_Label.text = "Common_city:  \(targetCity)"
//        price_Label.text = "Total Price: $\(min)"
//        
//        print("Common City: \(targetCity)")
//        print("Total price: $\(min)")
        
    }
    
//    func order(){
//        
//        let from = city1_name.text!
//        let to = targetCity!
//        let date = date_picker.text!
//        UIApplication.shared.openURL(URL(string:"https://www.google.com/flights/#search;f=\(from);t=\(to);d=\(date);r=2016-11-24;tt=o")!)
//    }
    
    
    var dataArray = [String]()
    var mapping = Dictionary <String, Coordinate>()
    var result = [String]()
    
    
    func loadAirportInfo(_ City1: String, City2: String) -> Array<String> {
        
        let pathToFile = Bundle.main.path(forResource: "NEW", ofType: "txt")
        
        if let path = pathToFile{
            let airportInfo = try! String(contentsOfFile: path,encoding: String.Encoding.utf8)
            
            dataArray = airportInfo.components(separatedBy: "\n")
            
            
            for item in dataArray{
                var temp = [String]()
                temp = item.components(separatedBy: ",")
                var tempLan: Double!
                var tempLon: Double!
                tempLan = (temp[2] as NSString).doubleValue
                tempLon = (temp[3] as NSString).doubleValue
                mapping[temp[4]] = Coordinate(name: temp[4],lan: tempLan,lon: tempLon)
            }
            
            
            //            var Lan1: Double =  mapping["SLC"]!.lan
            //            var Lon1: Double =  mapping["SLC"]!.lon
            //            var Lan2: Double =  mapping["MIA"]!.lan
            //            var Lon2: Double =  mapping["MIA"]!.lon
            
            var Lan1: Double =  mapping[City1]!.lan
            var Lon1: Double =  mapping[City1]!.lon
            var Lan2: Double =  mapping[City2]!.lan
            var Lon2: Double =  mapping[City2]!.lon
            
            if Lan1 > Lan2 {
                let temp = Lan1
                Lan1 = Lan2
                Lan2 = temp
            }
            
            if Lon1 > Lon2 {
                let temp = Lon1
                Lon1 = Lon2
                Lon2 = temp
            }
            
            if Lan2 - Lan1 < 5.0 {
                Lan2 = Lan2 + 1.5
                Lan1 = Lan1 - 1.5
            }
            
            if Lon2 - Lon1 < 10 {
                Lon1 = Lon1 - 5.0
                Lon2 = Lon2 + 5.0
            }
            
            var cities = [Coordinate]()
            
            for s in mapping.keys {
                let temp: Coordinate =  mapping[s]!
                let lan: Double = temp.lan
                let lon: Double = temp.lon
                
                if lon > Lon1 && lon < Lon2 && lan > Lan1 && lan < Lan2 {
                    cities.append(temp)
                }
            }
            
            for c in cities {
                let dist: Double = sqrt((Lan1 - c.lan)*(Lan1 - c.lan) + (Lon1 - c.lon)*(Lon1 - c.lon)) + sqrt((Lan2 - c.lan)*(Lan2 - c.lan) + (Lon2 - c.lon)*(Lon2 - c.lon))
                c.totalDistance = dist
            }
            
            cities.sort{$0.totalDistance < $1.totalDistance}
            
            print(cities.count)
            
            for i in 0 ..< 1 {
                //print(cities[i].name + "  \(cities[i].totalDistance)")
                result.append(cities[i].name)
                print(cities[i].name)
            }
        }
        
        return result
    }
    
//    func search(_ original: String, destination: String, date: String) {
//        let Dep = original
//        let Arr = destination
//        let Date = date
//        let count = "1"
//        print(Arr)
//        
//        
//        let url = URL(string: "http://terminal2.expedia.com/x/mflights/search?departureAirport=" + Dep +
//            "&arrivalAirport=" + Arr +
//            "&departureDate=" + Date +
//            "&maxOfferCount=" + count +
//            "&apikey=8dfdQKc7NvAKGMDmGVd2GTwGcnuwL8gj")!
//        
//        let request = NSMutableURLRequest(url: url)
//        
//        request.httpMethod = "GET"
//        
//        let task = URLSession.shared.dataTask(with: request, completionHandler: {
//            data, response, error in
//            if error != nil
//            {
//                print("error=\(error)")
//                return
//            }
//            
//            do{
//                let data = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! NSDictionary
//                if ( data["legs"] as? NSArray)!.count != 0 {
//                    if let object = ((data["offers"]![0]!["totalFare"]!!) as? NSString)?.doubleValue {
//                        self.price = object
//                        print("correct")
//                    }
//                    else {
//                        print("Wrong")
//                    }
//                    
//                    let pri = data["offers"]![0]!["totalFare"]!!
//                    let depart_time =  data["legs"]![0]!["segments"]!![0]!["departureTime"]!!
//                    let arrive_time =  data["legs"]![0]!["segments"]!![0]!["arrivalTime"]!!
//                    let airlineName =  data["legs"]![0]!["segments"]!![0]!["airlineName"]!!
//                    let flightNumber =  data["legs"]![0]!["segments"]!![0]!["flightNumber"]!!
//                    let duration = data["legs"]![0]!["segments"]!![0]!["duration"]!!
//                    
//                    self.flightInfo = "Price:  $\(pri) \rDepature: \(depart_time) \rArrival: \(arrive_time) \rAirlineName: \(airlineName) \(flightNumber) \rDuration: \(duration)"
//                }
//                else {
//                    print("No Data")
//                    print((data["legs"] as? NSArray)?.count != 0)
//                    self.price = 100000.00
//                }
//                
//                
//            }
//            catch{
//                print("Error with Json: \(error)")
//            }
//        }) 
//        
//        task.resume()
//        
//    }
    
    
    
    class Coordinate {
        
        var lan: Double
        var lon: Double
        var totalDistance = 0.0
        var name: String
        
        init(name: String, lan: Double, lon: Double){
            self.lan = lan;
            self.lon = lon;
            self.name = name;
        }
        
    }

    func getLocation(_ cityName: String) ->Array<Double> {
        
        var line = [String]()
        var Mapping = Dictionary <String,Coordinate>()
        var location_Info = [Double]()
        
        let pathToFile = Bundle.main.path(forResource: "NEW", ofType: "txt")
        
        if let path = pathToFile{
            let airportInfo = try! String(contentsOfFile: path,encoding: String.Encoding.utf8)
            
            line = airportInfo.components(separatedBy: "\n")
            
            
            for item in line{
                var temp = [String]()
                temp = item.components(separatedBy: ",")
                var tempLan: Double!
                var tempLon: Double!
                tempLan = (temp[2] as NSString).doubleValue
                tempLon = (temp[3] as NSString).doubleValue
                Mapping[temp[4]] = Coordinate(name: temp[1],lan: tempLan,lon: tempLon)
            }
        }
        
        location_Info.append(Mapping[cityName]!.lan)
        location_Info.append(Mapping[cityName]!.lon)
        return location_Info
    }

    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

