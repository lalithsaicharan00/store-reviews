# Watch: apple-watch-ci2 @ bb8aef9

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38117649083 · 2026-10-11 06:47 UTC
Commit: Apple Watch: the paired check at this commit (scratch branch run)

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (none): skipped
- Screenshots: skipped
- Speed: skipped
- Paired simulators: failure

Embedded in the iPhone app: OftenEnoughWatch.app 

## Paired simulators

Paired simulators: FAILED (waited 262 s)

- iPhone 16E850B5-FA0C-42A6-8A3F-5A723185B7A3, Watch 36C9BF78-5317-42A5-93D1-49C6A22BE09C, pair 3BB18D2A-E116-4B85-8DCF-05F071B05E5A
- 91 s: booted the iPhone
- 270 s: booted the Watch
- 274 s: activated the pair FAILED or took over 60 s
- 290 s: installed the iPhone app
- 667 s: the Watch app never arrived from the iPhone in 240 s; installing it directly (the iPhone may refuse to send)
- 683 s: installed the Watch app directly
- 699 s: launched the iPhone app
- 715 s: launched the Watch app

iPhone:
```
   -0.0 s  phone: added Pair water and Pair timer, +1 glass
  300.5 s  never saw the Watch's two +1s (3 glasses) in 300 s
  300.5 s  # PAIR DONE failed
```
Watch:
```
    0.0 s  watch: waiting for the first fill
  300.2 s  never saw the first fill (Pair water at 1 glass, Pair timer) in 300 s
  300.2 s  # PAIR DONE failed
```
WatchConnectivity on the iPhone (last lines):
```
2026-10-11 06:41:25.554 E  Habits[51856:2211c] [com.apple.appintents:General] Failed to connect to linkd to request update AppShortcut parameters, error: Couldn’t communicate with a helper application.
2026-10-11 06:41:26.284 A  Habits[51856:22024] (WatchConnectivity) updateApplicationContext:error:
2026-10-11 06:41:26.284 Df Habits[51856:22024] [com.apple.wcd:WC] -[WCSession updateApplicationContext:error:]_block_invoke
2026-10-11 06:41:26.301 E  Habits[51856:22024] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-11 06:41:26.315 E  Habits[51856:22024] [com.apple.wcd:WC] -[WCSession updateApplicationContext:error:]_block_invoke failed due to WCErrorCodeWatchAppNotInstalled
2026-10-11 06:41:26.797 Df Habits[51856:2211c] [com.apple.wcd:WC] -[WCSession onqueue_completeSwitchTask:withSessionState:]_block_invoke_2 hasContentPending: YES
2026-10-11 06:41:26.797 Df Habits[51856:220d9] [com.apple.wcd:WC] -[WCSession handleApplicationContextWithPairingID:] 36C9BF78-5317-42A5-93D1-49C6A22BE09C
2026-10-11 06:41:26.797 Df Habits[51856:220d9] [com.apple.wcd:WC] -[WCSession handleFileResultWithPairingID:] 36C9BF78-5317-42A5-93D1-49C6A22BE09C
2026-10-11 06:41:26.797 Df Habits[51856:220d9] [com.apple.wcd:WC] -[WCSession handleIncomingFileWithPairingID:] 36C9BF78-5317-42A5-93D1-49C6A22BE09C
2026-10-11 06:41:26.797 Df Habits[51856:220d9] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:] 36C9BF78-5317-42A5-93D1-49C6A22BE09C
2026-10-11 06:41:26.797 Df Habits[51856:220d9] [com.apple.wcd:WC] -[WCSession handleIncomingUserInfoWithPairingID:] 36C9BF78-5317-42A5-93D1-49C6A22BE09C
2026-10-11 06:41:26.798 E  Habits[51856:2211c] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-11 06:41:26.798 Df Habits[51856:22118] [com.apple.wcd:WC] -[WCSession onqueue_startNextDeviceSwitch] no tasks queued after <WCActiveDeviceSwitchTask: 0x108f9de20, clientReadyForSessionState: YES, taskState: ActivationCompleted>
2026-10-11 06:41:26.798 Df Habits[51856:2211c] [com.apple.wcd:WC] -[WCSession didSessionStateChange:withChangeHandler:] no change
2026-10-11 06:41:26.799 Df Habits[51856:2211c] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/ -- purposeID: 06C4DF0F-6673-414B-A5A9-8FCDF127CAE3 -- claimID: 1E575785-CCC6-4FD9-9A22-3F24960D0953
2026-10-11 06:41:26.821 Df Habits[51856:220d9] [com.apple.foundation.filecoordination:presenter] Adding presenter 06C4DF0F-6673-414B-A5A9-8FCDF127CAE3 for URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/
2026-10-11 06:41:26.871 Df Habits[51856:220d9] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/ -- purposeID: 06C4DF0F-6673-414B-A5A9-8FCDF127CAE3 -- claimID: 12430CE2-8162-4525-81A5-4F8ADE6878DC
2026-10-11 06:41:26.920 Df Habits[51856:2211c] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/ -- purposeID: D5348F5A-B001-4B66-95EB-44F6B8EB2285 -- claimID: 0BD41FAA-405C-4D0F-BBF3-6E0430E01DEE
2026-10-11 06:41:26.933 Df Habits[51856:220d9] [com.apple.foundation.filecoordination:presenter] Adding presenter D5348F5A-B001-4B66-95EB-44F6B8EB2285 for URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/
2026-10-11 06:41:26.976 Df Habits[51856:22118] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/ -- purposeID: D5348F5A-B001-4B66-95EB-44F6B8EB2285 -- claimID: F9533AF8-D8BF-4318-AA28-C4CEFB2183DB
2026-10-11 06:41:27.003 Df Habits[51856:22118] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/ -- purposeID: D5348F5A-B001-4B66-95EB-44F6B8EB2285 -- claimID: 90391F76-4FCC-4720-901E-4239344F50EA
2026-10-11 06:41:27.055 Df Habits[51856:22118] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/36C9BF78-5317-42A5-93D1-49C6A22BE09C/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/16E850B5-FA0C-42A6-8A3F-5A723185B7A3/data/Containers/Data/Application/095AE750-2CB5-4ADD-8ACF-243FA39B1CF8/ -- purposeID: 06C4DF0F-6673-414B-A5A9-8FCDF127CAE3 -- claimID: 3456F480-4379-4D60-AB41-176E3358F92A
2026-10-11 06:41:27.092 Df Habits[51856:2211c] [com.apple.wcd:WC] -[WCSession onqueue_dequeueContent]_block_invoke_2 hasContentPending: NO
2026-10-11 06:41:50.925 Df Habits[51856:22117] [com.apple.wcd:WC] -[WCSession onqueue_completeSwitchTask:withSessionState:]_block_invoke_4 cleaning up directories for state: <WCSessionState: 0x116a46f40, reachable: NO, paired: YES, appInstalled: NO, complicationEnabled: NO(50), pairingID: 36C9BF78-5317-42A5-93D1-49C6A22BE09C, pairedDevicesPairingIDs: {("36C9BF78-5317-42A5-93D1-49C6A22BE09C")}, appInstallationID: (null)>
2026-10-11 06:43:19.797 Df wcd[30624:15800] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:43:22.496 Df wcd[30624:15800] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:43:24.982 Df wcd[30624:15800] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:43:52.609 Df wcd[30624:1bcb7] [com.apple.wcd:WC] -[WCDRetrieveInstalledAppsListOperation doWorkWithCompletionHandler:]
2026-10-11 06:43:53.837 Df wcd[30624:15800] [com.apple.wcd:WC] iOSApplicationsWithWatchAppInstalled: {(
2026-10-11 06:43:53.863 Df wcd[30624:15800] [com.apple.wcd:WC] <WatchConnectivityDaemon: 0x101c946e0> of systemObserverUpdatingInstalledApps
2026-10-11 06:43:53.863 Df wcd[30624:15800] [com.apple.wcd:WC] Updating other device that installed apps changed
2026-10-11 06:43:53.863 Df wcd[30624:15800] [com.apple.wcd:WC] -[WatchConnectivityDaemon sendInstalledAppsChangedMessage]
2026-10-11 06:43:53.869 Df wcd[30624:15800] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:43:53.873 Df wcd[30624:15800] [com.apple.Transport:_IDSService] !setState destination=__IDS_DEFAULT_PAIRED_DEVICE__
2026-10-11 06:43:54.313 Df wcd[30624:15800] [com.apple.wcd:WC] <WCDClient: 0x101c40c00, communicationID: com.oftenenough.app, identifier: com.oftenenough.app, connection: <<NSXPCConnection: 0x101c95c20> connection from pid 51856 on mach service named com.apple.wcd>(NO,NO), clientCurrentPairingID: 36C9BF78-5317-42A5-93D1-49C6A22BE09C> of systemObserverWatchAppsInstalledChanged
2026-10-11 06:43:54.324 Df Habits[51856:221d4] [com.apple.wcd:WC] -[WCSession handleSessionStateChanged:]_block_invoke <WCSessionState: 0x1178f0390, reachable: NO, paired: YES, appInstalled: YES, complicationEnabled: NO(50), pairingID: 36C9BF78-5317-42A5-93D1-49C6A22BE09C, pairedDevicesPairingIDs: {("36C9BF78-5317-42A5-93D1-49C6A22BE09C")}, appInstallationID: D63E8083F1D96D4C8389971150BA385F>
2026-10-11 06:43:54.325 Df Habits[51856:220d9] [com.apple.wcd:WC] -[WCSession onDelegateQueueIfTriggeringKVO_updateSessionState:triggerKVO:] <WCSessionState: 0x1178f0390, reachable: NO, paired: YES, appInstalled: YES, complicationEnabled: NO(50), pairingID: 36C9BF78-5317-42A5-93D1-49C6A22BE09C, pairedDevicesPairingIDs: {("36C9BF78-5317-42A5-93D1-49C6A22BE09C")}, appInstallationID: D63E8083F1D96D4C8389971150BA385F>, triggerKVO: YES
2026-10-11 06:43:54.328 Df Habits[51856:221d4] [com.apple.wcd:WC] -[WCSession onqueue_cancelMessagesIfAppropriate] shouldCancel: YES
2026-10-11 06:43:54.328 Df Habits[51856:220d9] [com.apple.wcd:WC] -[WCSession onqueue_handleUpdateSessionState:]_block_invoke_2 notifying client session state changed
2026-10-11 06:43:54.330 Df wcd[30624:15800] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
```
WatchConnectivity on the Watch (last lines):
```
2026-10-11 06:41:31.877 Df OftenEnoughWatch[52323:22503] [com.apple.BoardServices:XPCErrors] [C:1] Alloc com.apple.frontboard.systemappservices
2026-10-11 06:41:32.499 Df OftenEnoughWatch[52323:224f1] [com.apple.BoardServices:XPCErrors] [C:2] Alloc com.apple.backboard.hid-services.xpc
2026-10-11 06:41:32.505 Df OftenEnoughWatch[52323:224f1] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUIPrimaryGestureNegativeInteraction: 0x1061a7980>) installed: NO -> YES
2026-10-11 06:41:32.506 Df OftenEnoughWatch[52323:224f1] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUICrownPressDismissGestureInteraction: 0x10620e9c0>) installed: NO -> YES
2026-10-11 06:41:33.192 Df OftenEnoughWatch[52323:224f1] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUIPrimaryGestureViewInteraction: 0x106078b40>) installed: NO -> YES
2026-10-11 06:41:33.310 Df OftenEnoughWatch[52323:224f1] [com.apple.wcd:WC] -[WCSession _init] WCSession initialized
2026-10-11 06:41:33.310 Df OftenEnoughWatch[52323:224f1] [com.apple.wcd:WC] -[WCSession setDelegate:] delegateSupportsAsyncActivate: YES, delegateSupportsActiveDeviceSwitch: NO
2026-10-11 06:41:33.310 Df OftenEnoughWatch[52323:224f1] [com.apple.wcd:WC] -[WCSession activateSession]_block_invoke
2026-10-11 06:41:33.310 Df OftenEnoughWatch[52323:224f1] [com.apple.wcd:WC] -[WCSession activateSession]_block_invoke informing daemon ready for session state
2026-10-11 06:41:33.317 Df wcd[32693:1c6f1] [com.apple.wcd:WC] -[WCDRetrieveInstalledAppsListOperation doWorkWithCompletionHandler:]
2026-10-11 06:41:33.329 Df wcd[32693:15842] (libMobileGestalt.dylib) Failed to get battery level with error E00002D8
Paired Device Information: Production: iPhone18,3 (iPhone18,3), iPhone OS 26.5 (23F77), "Pair iPhone"
Operation Queue: <NSOperationQueue: 0x105420600>{name = 'NSOperationQueue 0x105420600'}, Operations: ("<WCDRetrieveInstalledAppsListOperation: 0x105462440>")
        companionAppInstalled = NO;
        companionAppInstalled = YES;
        companionAppInstalled = NO;
        companionAppInstalled = NO;
        companionAppInstalled = NO;
        companionAppInstalled = NO;
        companionAppInstalled = NO;
        companionAppInstalled = YES;
        companionAppInstalled = NO;
        companionAppInstalled = NO;
        companionAppInstalled = YES;
Pending Paired Sync Complications Started Identifier: NULL
    Reachable: NO
2026-10-11 06:41:33.353 Df OftenEnoughWatch[52323:224f1] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUIPrimaryGestureViewInteraction: 0x106089f40>) installed: NO -> YES
2026-10-11 06:41:33.375 Df OftenEnoughWatch[52323:224f1] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller((null)) installed: YES -> NO
2026-10-11 06:41:33.393 Df wcd[32693:15842] [com.apple.wcd:WC] <WatchConnectivityDaemon: 0x10547d0e0> of systemObserverInstalledApplicationsChanged
2026-10-11 06:41:33.448 E  wcd[32693:15842] [com.apple.wcd:WC] failed isPrivileged check. error: NanoTimeKit.WatchConnectivityMultiplexer.MultiplexierError:1
2026-10-11 06:43:54.070 Df wcd[32693:15842] [com.apple.wcd:WC] communicationID: , WCDPayloadSendType: InstalledAppsUpdated (17), protobufSize: 2
2026-10-11 06:43:54.070 Df wcd[32693:15842] [com.apple.wcd:WC] -[WCDSystemMonitor retryInstalledAppsUpdate] Updating installed apps list for request
2026-10-11 06:43:54.074 Df wcd[32693:2561f] [com.apple.wcd:WC] -[WCDRetrieveInstalledAppsListOperation doWorkWithCompletionHandler:]
2026-10-11 06:46:07.915 Df wcd[32693:15842] [com.apple.wcd:WC] Installed apps on companion have changed
2026-10-11 06:46:07.916 Df wcd[32693:1b6da] [com.apple.wcd:WC] -[WCDRetrieveInstalledAppsListOperation doWorkWithCompletionHandler:]
2026-10-11 06:46:10.963 Df wcd[32693:15842] [com.apple.wcd:WC] Installed apps on companion have changed
2026-10-11 06:46:10.963 Df wcd[32693:1b6da] [com.apple.wcd:WC] -[WCDRetrieveInstalledAppsListOperation doWorkWithCompletionHandler:]
2026-10-11 06:46:12.780 Df wcd[32693:15842] [com.apple.wcd:WC] Installed apps on companion have changed
2026-10-11 06:46:12.781 Df wcd[32693:1b6da] [com.apple.wcd:WC] -[WCDRetrieveInstalledAppsListOperation doWorkWithCompletionHandler:]
```
