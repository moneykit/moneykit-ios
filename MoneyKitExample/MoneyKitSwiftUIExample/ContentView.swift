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
        let linkSessionToken: String = ""

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
