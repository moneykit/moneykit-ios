import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    // MARK: - Internal properties

    var window: UIWindow?

    // MARK: - Private properties

    private let exampleViewController = ExampleViewController()

    // MARK: - UIWindowSceneDelegate functions

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let windowFromScene = UIWindow(windowScene: windowScene)

        windowFromScene.rootViewController = exampleViewController
        windowFromScene.makeKeyAndVisible()

        window = windowFromScene
    }

    func sceneDidDisconnect(_ scene: UIScene) { }

    func sceneDidBecomeActive(_ scene: UIScene) { }

    func sceneWillResignActive(_ scene: UIScene) { }

    func sceneWillEnterForeground(_ scene: UIScene) { }

    func sceneDidEnterBackground(_ scene: UIScene) { }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let urlContext = URLContexts.first else { return }

        exampleViewController.handleRedirect(url: urlContext.url)
    }
}

