//
//  DonateViewController.swift
//  Pledge App
//
//  Created by Adrian McDaniel on 2/13/17.
//  Copyright © 2017 Adrian McDaniel. All rights reserved.
//

import WebKit
import UIKit

class DonateViewController: UIViewController, WKNavigationDelegate {
    
    var charity: Charity? = nil
    var webView: WKWebView!
    
    
    override func loadView() {
        
        webView = WKWebView()
        
        webView.navigationDelegate = self
        view = webView
        
        
        let url = URL(string: (charity?.donate)!)!
        
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Browser"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
