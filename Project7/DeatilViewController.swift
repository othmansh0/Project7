//
//  DeatilViewController.swift
//  Project7
//
//  Created by othman shahrouri on 8/16/21.
//

import UIKit
import WebKit

class DeatilViewController: UIViewController {
    var webView:WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let detailItem = detailItem else { return }

        let html = """
        <html>
        <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <style>
                body { font-size: 150%; }
        </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        //loading custom html into webView
        //baseUrl link external resources like pics,javascrit...
        webView.loadHTMLString(html, baseURL: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
