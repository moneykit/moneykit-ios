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
                onSuccess: { successType in
                    switch successType {
                    case let .linked(institution):
                        print("Linked - Token to exchange: \(institution.token.value)")
                    case .relinked:
                        print("Relinked")
                    @unknown default:
                        print("Future MKLinkSuccessType")
                    }
                },
                onExit: moneyLinkExit,
                onEvent: moneyLinkEvent(event:),
                onError: moneyLinkError(error:)
            )

            linkHandler = MKLinkHandler(configuration: configuration)
        } catch let error {
            print("Configuration error - \(error.localizedDescription)")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let presentationMethod = MKPresentationMethod.modal(presentingViewController: self)
        linkHandler?.presentLinkFlow(using: presentationMethod)
    }

    // MARK: - Internal functions

    func handleRedirect(url: URL) {
        linkHandler?.continueFlow(from: url)
    }

    // MARK: - Private functions

    private func moneyLinkExit() {
        print("MoneyLink session ended")
    }

    private func moneyLinkError(error: MKLinkError) {
        print("ERROR - \(error)")
    }

    private func moneyLinkEvent(event: MKLinkEvent) {
        print("EVENT - \(event)")
    }

}

