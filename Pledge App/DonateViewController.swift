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
        
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    
}
