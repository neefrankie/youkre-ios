//
//  MeView.swift
//  Youkre
//
//  Created by Weiguo Ni on 2025/4/10.
//

import SwiftUI
import MessageUI
import StoreKit

struct SettingsView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var showMailView = false
    @State private var showMailErrorAlert = false
    @Environment(\.requestReview) var requestReview
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    ThemePicker(
                        themeManager: themeManager
                    )
                    .pickerStyle(.navigationLink)
                }
                Section {
                    NavigationLink(
                        destination: PrivacyView()
                    ) {
                        Text("隐私政策")
                    }
                    
                    NavigationLink(
                        destination: UserAgreementView()
                    ) {
                        Text("用户服务协议")
                    }
                }
                Section {
                    Button("建议反馈") {
                        if MFMailComposeViewController.canSendMail() {
                            showMailView = true
                        } else {
                            showMailErrorAlert = true
                        }
                    }
                    .buttonStyle(.plain)
                    .sheet(isPresented: $showMailView) {
                        MailView(
                            subject: "建议反馈",
                            messageBody: DeviceInfo.generatedFeedbackBody()
                        )
                    }
                    .alert(isPresented: $showMailErrorAlert) {
                        Alert(
                            title: Text("邮箱不可用"),
                            message: Text("请设置邮箱账号后发送反馈邮件。"),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    
                    
                    Button("给个好评") {
                        requestReview()
                    }
                    .buttonStyle(.plain)
                    
                    NavigationLink(
                        destination: AboutDetailView()
                    ) {
                        Text("关于")
                    }
                }
            }
            .navigationTitle("我的")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}


#Preview {
    @Previewable @StateObject var themeManager = ThemeManager.shared
    
    SettingsView()
        .environmentObject(themeManager)
        .preferredColorScheme(themeManager.preferredColorScheme)
}
