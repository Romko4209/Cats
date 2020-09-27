//
//  WikiViewController.swift
//  Cats
//
//  Created by Romko on 27.09.2020.
//  Copyright © 2020 Romko. All rights reserved.
//

import UIKit
import WebKit

class WikiViewController: UIViewController,WKNavigationDelegate{

    var webView: WKWebView!
    var urlWiki: String?
    
    override func loadView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        guard let urlString = urlWiki else {return}
        guard let url = URL(string: urlString) else {return}
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
}
