import MoneyKit
import SwiftUI

struct ContentView: View {

    // MARK: - Private properties

    @State private var isMoneyKitPresented = false

    @StateObject private var connectViewModel = MKConnectViewModel()

    // MARK: - View overrides

    var body: some View {
        VStack {
            Button("Add Bank") {
                isMoneyKitPresented = true
            }
            .sheet(
                isPresented: $isMoneyKitPresented,
                onDismiss: {
                    isMoneyKitPresented = false
                }, content: {
                moneyKitConnect()
            }
            )
        }
        .padding()

        .onOpenURL { incomingURL in
            handleIncomingURL(incomingURL)
        }
    }
}

extension ContentView {

    private func moneyKitConnect() -> some View {
        #warning("Replace <#YOUR_LINK_SESSION_TOKEN#> below")
        let linkSessionToken: String = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImtpZCI6IlB3Y2VfUGFfUV9jSWhkLTFWWlNGMjlzS3E4aWNfQmJYZTJJcG93Q3JaUDQiLCJlbnYiOiJwcm9kdWN0aW9uIiwibW9kZSI6ImxpdmUiLCJsaW5rX2lkIjpudWxsLCJpbnN0aXR1dGlvbl9pZCI6bnVsbCwiaW5zdGl0dXRpb25fY29sb3IiOm51bGwsImluc3RpdHV0aW9uX25hbWUiOm51bGwsImluc3RpdHV0aW9uX2F2YXRhciI6bnVsbCwiYXBwX25hbWUiOiJQbGF5Z3JvdW5kIiwicmVkaXJlY3RfdXJpIjoibW9uZXlraXRleGFtcGxlYXBwOi8vb2F1dGgiLCJjb25uZWN0X3RoZW1lX2xldmVsIjoiZnVsbF9jdXN0b20ifQ.eyJzdWIiOiJsaXZlX2RiOGNmNjRjLTZjMjEtNGVhNi04Mjg0LTViZWJjZDQzZDA1YiIsImF1ZCI6WyJodHRwczovL2FwaS5zdGFnZS51ZTIubW9uZXlraXQuY29tL2xpbmstc2Vzc2lvbiJdLCJjb25uZWN0X2ZlYXR1cmVzIjp7ImNvbm5lY3RfbWFudWFsbHkiOnRydWUsInByb3ZpZGVyX3NhbmRib3hfaW5zdGl0dXRpb25zIjp0cnVlfSwiYXBwX2lkIjoiYXBwX0phNlJMUHFSV3FiOUh0a3NpWXVtdk0iLCJhbGxvd2VkX2luc3RpdHV0aW9ucyI6WyJjaGFzZSIsIndlbGxzX2ZhcmdvIiwiYm9mYSIsInRkIiwiY2l0aSIsInVzX2JhbmsiLCJjaXRpemVucyIsInVzYWEiLCJzb2ZpIl0sImlzcyI6Imh0dHBzOi8vYXBpLnN0YWdlLnVlMi5tb25leWtpdC5jb20iLCJleHAiOjE3NzI3NTIyMjIsImlhdCI6MTc3Mjc0ODYyMn0.NdJ784hCEfZj74abs40-_6W_O5VeZW7gkDkx4woWkLs"

        do {
            let configuration = try MKConfiguration(
                sessionToken: linkSessionToken,
                onSuccess: onSuccess(successType:),
                onExit: onExit(error:),
                onEvent: onEvent(event:)
            )

            let linkHandler = MKLinkHandler(configuration: configuration)

            connectViewModel.linkHandler = linkHandler

            return AnyView(MKConnectView(viewModel: connectViewModel))
        } catch let error {
            return AnyView(Text("Link Configuration Error: \(error.localizedDescription)").font(.title2))
        }
    }

    private func onSuccess(successType: MKLinkSuccessType) {
        switch successType {
        case let .linked(institution):
            print("Linked - Token to exchange: \(institution.token.value)")
        case .relinked:
            print("Relinked")
        @unknown default:
            print("Future MKLinkSuccessType")
        }
    }

    private func onExit(error: MKLinkError?) {
        connectViewModel.linkHandler = nil

        if let error = error {
            print("Connect session ended with error: \(error.errorId)")
        } else {
            print("Connect session ended")
        }
    }

    private func onEvent(event: MKLinkEvent) {
        print("MKLinkEvent: \(event.name)")
    }

    private func handleIncomingURL(_ url: URL) {
        self.connectViewModel.linkHandler?.continueFlow(from: url)
    }
}

#Preview {
    ContentView()
}
