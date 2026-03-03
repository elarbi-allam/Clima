import Foundation
import CoreLocation
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    var delegate: WeatherManagerDelegate?  
    let apiKey: String
    let baseURL: String = "https://api.openweathermap.org/data/2.5/weather"
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchWeather(cityName: String){
        let urlString = "\(baseURL)?q=\(cityName)&appid=\(apiKey)&units=metric"
        performRequest(with: urlString)
    }
    func fetchWeather(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees){
        let urlString = "\(baseURL)?appid=\(apiKey)&units=metric&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    func performRequest(with urlString: String){
        //1 Create a URL
        if let url = URL(string: urlString) {
            //2 Create a UrlSession
            let session = URLSession(configuration: .default)
            //3 Give the Sessio n a task
            let task = session.dataTask(with: url) { (data: Data? , response: URLResponse?, error: Error?) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error! )
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            //4 Start the task
            task.resume()
        }
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
         let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name ,temperature: temp)
            
            return weather
            
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
    // we can use this function in the session task , but we prefer using Closures
    
//    func handle(data: Data? , response: URLResponse?, error: Error?){
//        if error != nil {
//            print(error!)
//            return
//        }
//        
//        if let safeData = data {
//            let stringData = String(data: safeData, encoding: .utf8)
//            print(stringData!)
//        }
//    }

}
