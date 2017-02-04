//
//  ViewController.swift
//  WeatherApp
//
//  Created by Joni Nevalainen on 28/01/17.
//  Copyright © 2017 Joni Nevalainen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let WEATHER_URL_TEMPLATE = "http://www.weather-forecast.com/locations/{LOCATION}/forecasts/latest"

    @IBOutlet weak var locationInput: UITextField!

    @IBOutlet weak var output: UILabel!

    @IBAction func submitButton(_ sender: Any) {
        self.output.text = "";
        let location = locationInput.text!.replacingOccurrences(of: " ", with: "-")

        if !location.isEmpty {
            let url = WEATHER_URL_TEMPLATE.replacingOccurrences(of: "{LOCATION}", with: location)

            if let reqUrl = URL(string: url) {
                let request = NSMutableURLRequest(url: reqUrl)
                let task = URLSession.shared.dataTask(with: request as URLRequest) {
                    data, response, error in

                    var text = "";
                    if error == nil {
                        let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String
                        text = self.parseWeather(data: dataString)
                    } else {
                        text = "Error while fetching data from " + url
                    }
                    DispatchQueue.main.async {
                        self.output.text = text
                    }
                }

                task.resume()
            }
        } else {
            self.output.text = "Please enter a city in the location field"
        }
    }

    func parseWeather(data: String) -> String {
        var result = data
        let begin = "<span class=\"phrase\">"
        let end = "</span>"

        if let startIndex = result.range(of: begin)?.upperBound {
            result = result.substring(from: startIndex)

            if let endindex = result.range(of: end)?.lowerBound {
                return result.substring(to: endindex)
            }
        }

        return "Could not parse the result"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

