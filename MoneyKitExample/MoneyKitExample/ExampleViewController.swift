import UIKit
import MoneyKit

class ExampleViewController: UIViewController {

    // MARK: - Private properties

    private var linkHandler: MKLinkHandler?

    // MARK: UIViewController overrides

    override func viewDidLoad() {
        super.viewDidLoad()

        #warning("Replace <#YOUR_LINK_SESSION_TOKEN#> below")
        let linkSessionToken: String = "<#YOUR_LINK_SESSION_TOKEN#>"

        do {
            let configuration = try MKConfiguration(
                sessionToken: linkSessionToken,
                onSuccess: onSuccess(successType:),
                onExit: onExit(error:),
                onEvent: onEvent(event:)
            )

            linkHandler = MKLinkHandler(configuration: configuration)
        } catch let error {
            print("Configuration error - \(error.localizedDescription)")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        linkHandler?.presentLinkFlow(on: self)
    }

    // MARK: - Internal functions

    func handleRedirect(url: URL) {
        linkHandler?.continueFlow(from: url)
    }

    // MARK: - Private functions

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
        print("Connect session ended")
    }

    private func onEvent(event: MKLinkEvent) {
        print("EVENT - \(event)")
    }
}
