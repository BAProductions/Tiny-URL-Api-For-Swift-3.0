//
//  TinyURLAPI.swift
//  Press Themes Portfolio
//
//  Created by BAproductions on 10/21/16.
// Copyright (C) <2016>  <DJABHipHop/BAProductions>

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import UIKit
extension UIViewController {
    func ShortenURL(URLToSorten:String) -> String {
        if verifyUrl(urlString:URLToSorten) != false{
            guard let apiEndpoint = URL(string: "http://tinyurl.com/api-create.php?url=\(URLToSorten)")else {
                self.ErrorMessage(error:("Error: doesn't seem to be a valid URL") as String)
                return "" as String
            }
            do {
                let shortURL = try String(contentsOf: apiEndpoint, encoding: String.Encoding.ascii)
                return shortURL as String
            } catch let Error{
                self.ErrorMessage(error:Error.localizedDescription)
                return URLToSorten as String
            }
        }else{
            self.ErrorMessage(error:"\(URLToSorten) doesn't seem to be a valid URL or is blank")
            return "" as String
        }
    }
    func verifyUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url  = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    func ErrorMessage(error:String) {
        let ErrorMessageAlert = UIAlertController(title:"Error", message: error, preferredStyle: UIAlertControllerStyle.alert)
        ErrorMessageAlert.addAction((UIAlertAction(title: "OK", style: .default, handler: nil)))
        self.present(ErrorMessageAlert, animated: true, completion: nil)
        print("Error:\(error)")
    }
}
