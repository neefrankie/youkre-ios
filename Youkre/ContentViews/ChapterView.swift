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
    
    @ObservedObject var themeManager: ThemeManager
    @Binding var isLoading: Bool
    
    var onTap: (() -> Void)? = nil
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    private func themeScript() -> WKUserScript {
        let js = themeManager.jsThemeScript
        let userScript = WKUserScript(
            source: js,
            injectionTime: .atDocumentStart,
            forMainFrameOnly: true
        )
        
        return userScript
    }
    
    private func wvConfig() -> WKWebViewConfiguration {
        let config = WKWebViewConfiguration()
        config.userContentController.addUserScript(themeScript())
        
        // Enable debugging (for iOS 16.4+)
        if #available(iOS 16.4, *) {
            config
                .preferences
                .javaScriptEnabled = true
            config
                .defaultWebpagePreferences
                .allowsContentJavaScript = true
        }
        
        return config
    }
    
    private func tapScript() -> WKUserScript {
        // Inject JavaScript that sends tap messages
        
        let js = """
        document.addEventListener('click', function() {
            window.webkit.messageHandlers.tapHandler.postMessage(null);
        });
        """
        let script = WKUserScript(
            source: js,
            injectionTime: .atDocumentEnd,
            forMainFrameOnly: true
        )
        
        return script
    }
    
    
    func makeUIView(context: Context) -> WKWebView {
        let config = wvConfig()
        let webView = WKWebView(
            frame: .zero,
            configuration: config
        )
        print("makeUIView")
        
        context.coordinator.webView = webView
        webView.navigationDelegate = context.coordinator
        
        config.userContentController.add(
            context.coordinator,
            name: "tapHandler"
        )
        config.userContentController.addUserScript(tapScript())
        
        configWebView(webView: webView)
        
        loadHTML(webView: webView)
                
        return webView
    }
    
    private func configWebView(webView: WKWebView) {
        // Enable inspectability
        if #available(iOS 16.4, *) {
            webView.isInspectable = true
        }
        
        webView.isOpaque = false
        webView.backgroundColor = (themeManager.resolvedTheme == "dark") ? .black : .white
        webView.scrollView.backgroundColor = webView.backgroundColor
        // Allow vertical scrolling
        webView.scrollView.isScrollEnabled = true
        // Prevent horizontal bouncing
        webView.scrollView.bounces = false
    }
    
    private func loadHTML(webView: WKWebView) {
        print("loadHTML")
        
        if let html = Bundle.main.htmlURL(
            forResource: fileName,
            of: bookSlug
        ) {
            
            if !FileManager.default.fileExists(atPath: html.fileURL.path) {
                print("File does not exist at path \(html.fileURL)")
            }
            
            webView.loadFileURL(
                html.fileURL,
                allowingReadAccessTo: html.readAccessURL
            )
        }
    }
    
    // Determine if a webpage should be reloaded based on
    // whether we could build a new url different from
    // current one.
    private func reloadHTML(webView: WKWebView) {
        let currentURL = webView.url?.absoluteString ?? ""
        
        guard let html = Bundle.main.htmlURL(
            forResource: fileName,
            of: bookSlug
        ) else { return }
        
        let newURL = html.fileURL.absoluteString
        
        print("Current URL: \(currentURL), New HTML URL: \(newURL)")
        
        if currentURL != newURL {
            print("Reloading WebView content due to URL change.")
            webView.loadFileURL(
                html.fileURL,
                allowingReadAccessTo: html.readAccessURL
            )
        } else {
            print("No need to reload WebView content.")
        }
    }
    
    // State changes will trigger this method, so call
    // loadHTML unconditionally will cause circular loading.
    // 分析反复调用的成因：
    // 视图首次显示时调用 makeUIView，这里创建了WKWebView实例并且加载了HTML内容，
    // 进而触发 func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!)， isLoading = true，
    // HTML加载完成，调用 func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) ，isLoading = false，
    // 由于状态改变，触发 updateUIView，调用 loadHTML()，
    // 从头开始触发 isLoading = true -> false -> updateUIView -> loadHTML -> 死循环。
    func updateUIView(_ uiView: WKWebView, context: Context) {
        print("updateUIView url: \(String(describing: uiView.url))")
        reloadHTML(webView: uiView)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKScriptMessageHandler {
        weak var webView: WKWebView?
        var parent: LocalWebView
        
        init(_ parent: LocalWebView) {
            self.parent = parent
            super.init()
            
            NotificationCenter.default.addObserver(
                forName: .init("ThemeDidChange"),
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let webView = self?.webView else { return }
                self?.updateWebViewTheme(webView: webView)
            }
        }
        
        func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            
            if message.name == "tapHandler" {
                DispatchQueue.main.async {
                    self.parent.onTap?()
                }
            }
        }
        
        func updateWebViewTheme(webView: WKWebView) {

            print("updateWebViewTheme: \(parent.themeManager.resolvedTheme)")
            
            let js = parent.themeManager.jsThemeScript
            
            webView.evaluateJavaScript(js) { (result, error) in
                if let error = error {
                    print("updateWebViewThem: Error executing JavaScript: \(error)")
                } else {
                    print("updateWebViewTheme: JavaScript executed successfully")
                }
            }
        }
        
        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            print("webView didStartProvisionNavigation")
            // Change shouldRealod = false in updateUIView
            // is not enough.
            parent.isLoading = true
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            print("webView didFinish")
            parent.isLoading = false
        }
    }
}

struct ChapterView: View {
    @State var params: ChapterLink
    @EnvironmentObject var settings: ThemeManager
    
    @State private var isLoading = true
    @State private var shouldReload = false
    @State private var isBottomBarVisible = false
    
    init(params: ChapterLink) {
        self._params = State(initialValue: params)
    }
    
    var body: some View {
        // ZStack(alignment: .bottom) lets you anchor the bottom bar properly.
        ZStack(alignment: .bottom) {
            LocalWebView(
                bookSlug: params.courseSlug,
                fileName: params.chapterSlug,
                themeManager: settings,
                isLoading: $isLoading,
                onTap: {
                    withAnimation {
                        isBottomBarVisible.toggle()
                    }
                }
            )
            
            if isLoading {
                // The VStack with two Spacer()s vertically centers the ProgressView regardless of the parent alignment.
                VStack {
                    Spacer()
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            
            if isBottomBarVisible {
                BottomBar(
                    themeManager: settings,
                )
                .transition(
                    .move(edge: .bottom)
                    .combined(with: .opacity)
                )
            }
        }
        
        .animation(.easeInOut(duration: 0.3), value: isLoading)
        .onAppear {
            NotificationCenter.default.post(
                name: Notification.Name("ThemeDidChange"),
                object: nil
            )
        }
        .onChange(of: settings.selectedScheme) {
            NotificationCenter.default.post(
                name: Notification.Name("ThemeDidChange"),
                object: nil
            )
        }
        .background(AppColors.background)
    }
    

}


#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    ChapterView(params: ChapterLink(
        courseSlug: Course.courseList[0].slug,
        chapterSlug: "1"
    ))
    .environmentObject(themeManager)
    .preferredColorScheme(themeManager.preferredColorScheme)
}
