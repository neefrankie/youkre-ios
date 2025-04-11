//
//  ChapterWebView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/10.
//

import SwiftUI
import WebKit

struct LocalWebView: UIViewRepresentable {
    let bookSlug: String
    let fileName: String
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
                
        // ✅ Enable debugging (for iOS 16.4+)
        if #available(iOS 16.4, *) {
            configuration.preferences.javaScriptEnabled = true
            configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        }
        
        let webView = WKWebView(
            frame: .zero,
            configuration: configuration)
                
        // ✅ Enable inspectability
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        
        webView.isOpaque = false
        webView.backgroundColor = .clear
        // Allow vertical scrolling
        webView.scrollView.isScrollEnabled = true
        // Prevent horizontal bouncing
        webView.scrollView.bounces = false

        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let html = Bundle.main.htmlURL(
            forResource: fileName,
            of: bookSlug
        ) {
            if FileManager.default.fileExists(atPath: html.fileURL.path) {
                print("File exists at path \(html.fileURL)")
            } else {
                print("File does not exist at path \(html.fileURL)")
            }
            
            uiView.loadFileURL(
                html.fileURL,
                allowingReadAccessTo: html.readAccessURL
            )
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct ChapterView: View {
    var params: ChapterParams
    
    var body: some View {
        LocalWebView(
            bookSlug: params.book.slug,
            fileName: params.tocEntry.slug
        )
    }
}

#Preview {
    ChapterView(
        params: ChapterParams(
            book: DataStore.bookList[0],
            tocEntry: TocEntry(
                id: "25d704fe889cf1c4",
                slug: "3",
                text: "第 3 章 相对增长",
                title: "",
                subtitle: ""
            )
        )
    )
}
