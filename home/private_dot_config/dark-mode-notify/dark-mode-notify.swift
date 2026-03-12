import Cocoa

let task = Process()
task.launchPath = "/bin/sh"
task.arguments = ["-c", NSHomeDirectory() + "/.change_background.sh"]
try task.run()
task.waitUntilExit()

DistributedNotificationCenter.default().addObserver(
  forName: NSNotification.Name("AppleInterfaceThemeChangedNotification"),
  object: nil,
  queue: .main
) { _ in
  let task = Process()
  task.launchPath = "/bin/sh"
  task.arguments = ["-c", NSHomeDirectory() + "/.change_background.sh"]
  try? task.run()
  task.waitUntilExit()
}

RunLoop.main.run()
