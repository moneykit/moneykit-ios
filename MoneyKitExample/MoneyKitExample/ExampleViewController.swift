import MoneyKit
import SwiftUI

struct ContentView: View {

    // MARK: - Private properties

    @State private var isMoneyKitPresented = false
    @State private var isShowingError = false
    @State private var errorMessage = ""
    @State private var linkSessionToken: String?

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
        .alert(isPresented: $isShowingError) {
            Alert(
                title: Text("Error"),
                message: Text(errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .onOpenURL { incomingURL in
            handleIncomingURL(incomingURL)
        }
    }
}

extension ContentView {

    private func moneyKitConnect() -> some View {
        #warning("Replace <#YOUR_LINK_SESSION_TOKEN#> below")
        let linkSessionToken: String = ""

        do {
            let configuration = try MKConfiguration(
                sessionToken: linkSessionToken,
                onSuccess: onSuccess(successType:),
                onExit: onExit(error:),
                onEvent: onEvent(event:),
                onConnectManually: onConnectManually(searchTerm:)
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

    private func onConnectManually(searchTerm: String?) -> Bool {
        print("Connect Manually triggered with search term: \(searchTerm ?? "none")")

        // Note: Full Plaid integration requires access to internal MoneyKit APIs.
        // In a production app, you would either:
        // 1. Let the MoneyKit SDK handle Plaid internally (return true)
        // 2. Implement your own Plaid integration using public APIs

        // For this example, we just log and let the SDK handle it
        return true // Let SDK handle Plaid integration internally
    }

    @MainActor
    private func showError(_ message: String) {
        self.errorMessage = message
        self.isShowingError = true
    }

    private var window: UIWindow {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else {
            fatalError("No window available")
        }
        return window
    }

    private func handleIncomingURL(_ url: URL) {
        self.connectViewModel.linkHandler?.continueFlow(from: url)
    }
}

#Preview {
    ContentView()
}
