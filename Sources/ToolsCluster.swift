//
//  DeployCluster.swift
//  Flock
//
//  Created by Jake Heiser on 12/28/15.
//  Copyright © 2015 jakeheis. All rights reserved.
//

extension Flock {
    public static let Tools = ToolsCluster()
}

extension Config {
    public static var swiftVersion: String? = nil
}

public class ToolsCluster: Cluster {
    public let name = "tools"
    public let tasks: [Task] = [
        DependencyInstallationTask(),
        SwiftInstallationTask()
    ]
}

class DependencyInstallationTask: Task {
    let name = "dependencies"
    
    func run(server: ServerType) {
        print("Installing Swift dependencies")
        server.execute("sudo apt-get -y install clang libicu-dev git")
    }
}

class SwiftInstallationTask: Task {
    let name = "swift"
    
    func run(server: ServerType) {
        print("Installing swiftenv")
        server.execute("git clone https://github.com/kylef/swiftenv.git ~/.swiftenv")
        
        let tmpFile = "/tmp/bashrc"
        let bashrc = "~/.bashrc"
        
        let bashRC = [
            "export SWIFTENV_ROOT=\"$HOME/.swiftenv\"",
            "export PATH=\"$SWIFTENV_ROOT/bin:$PATH\"",
            "eval \"$(swiftenv init -)\""
        ].joinWithSeparator("; ")
        server.execute("echo -e '\(bashRC)' > \(tmpFile)")
        server.execute("echo >> \(tmpFile)")
        server.execute("cat \(bashrc) >> \(tmpFile)")
        server.execute("cat \(tmpFile) > \(bashrc)")
        
        print("Installing Swift")
        guard let swiftVersion = Config.swiftVersion else {
            print("ERROR: You must specify in your configuration file which Swift version to install.")
            return
        }
        server.execute("swiftenv install \(swiftVersion)")
    }
}
