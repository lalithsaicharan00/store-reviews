# Watch: claude/shared-habit-rules-ci13 @ c8ce841

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38236469621 · 2026-10-12 11:46 UTC
Commit: Current Work 92: paired iPhone and Watch end to end on the shared rules (scratch, safe to delete) [watch-pair]

- Core tests: skipped
- Watch build: success
- iPhone build with the Watch app: success
- Watch UI tests (none): skipped
- Screenshots: skipped
- Speed: skipped
- Paired simulators: failure

Embedded in the iPhone app: OftenEnoughWatch.app 

## Paired simulators

Paired simulators: FAILED (waited 266 s)

- iPhone 988E3014-CF08-448D-A9BC-635F45668EB5, Watch 4F35E3E6-3BF2-4822-9BCE-5FB705AC547A, pair 41188766-CA19-4A9B-826F-780F75798B9C
- 149 s: booted the iPhone
- 315 s: booted the Watch
- 332 s: activated the pair FAILED or took over 60 s
- 359 s: installed the iPhone app
- 788 s: the Watch app never arrived from the iPhone in 240 s; installing it directly (the iPhone may refuse to send)
- 797 s: installed the Watch app directly
- 817 s: launched the iPhone app
- 829 s: launched the Watch app

iPhone:
```
   -0.0 s  phone: added Pair water and Pair timer, +1 glass
  300.2 s  never saw the Watch's two +1s (3 glasses) in 300 s
  300.2 s  # PAIR DONE failed
```
Watch:
```
   -0.0 s  watch: waiting for the first fill
  300.1 s  never saw the first fill (Pair water at 1 glass, Pair timer) in 300 s
  300.1 s  # PAIR DONE failed
```
WatchConnectivity on the iPhone (last lines):
```
2026-10-12 11:40:36.428 Df Habits[47527:203ff] [com.apple.foundation.filecoordination:presenter] Adding presenter 0E8686B5-3E16-4266-B03F-CD388843AEE7 for URL: Library/Application%20Support/com.apple.watchconnectivity/4F35E3E6-3BF2-4822-9BCE-5FB705AC547A/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/988E3014-CF08-448D-A9BC-635F45668EB5/data/Containers/Data/Application/8AA805C2-DC7E-46CD-BDAF-3D0BA52F4797/
2026-10-12 11:40:36.433 Df Habits[47527:203ff] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/4F35E3E6-3BF2-4822-9BCE-5FB705AC547A/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/988E3014-CF08-448D-A9BC-635F45668EB5/data/Containers/Data/Application/8AA805C2-DC7E-46CD-BDAF-3D0BA52F4797/ -- purposeID: 0E8686B5-3E16-4266-B03F-CD388843AEE7 -- claimID: C1E0A609-3509-4493-BECF-55891AEE9039
2026-10-12 11:40:36.537 Df Habits[47527:203f5] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/4F35E3E6-3BF2-4822-9BCE-5FB705AC547A/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/988E3014-CF08-448D-A9BC-635F45668EB5/data/Containers/Data/Application/8AA805C2-DC7E-46CD-BDAF-3D0BA52F4797/ -- purposeID: 53C60AE5-3226-4DA5-91D8-EAF9A394C2A9 -- claimID: ED94C84A-B0DD-48B6-BF22-6D873454A7B3
2026-10-12 11:40:36.549 Df Habits[47527:20400] [com.apple.foundation.filecoordination:presenter] Adding presenter 53C60AE5-3226-4DA5-91D8-EAF9A394C2A9 for URL: Library/Application%20Support/com.apple.watchconnectivity/4F35E3E6-3BF2-4822-9BCE-5FB705AC547A/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/988E3014-CF08-448D-A9BC-635F45668EB5/data/Containers/Data/Application/8AA805C2-DC7E-46CD-BDAF-3D0BA52F4797/
2026-10-12 11:40:36.625 Df Habits[47527:20400] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/4F35E3E6-3BF2-4822-9BCE-5FB705AC547A/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/988E3014-CF08-448D-A9BC-635F45668EB5/data/Containers/Data/Application/8AA805C2-DC7E-46CD-BDAF-3D0BA52F4797/ -- purposeID: 53C60AE5-3226-4DA5-91D8-EAF9A394C2A9 -- claimID: 4032157F-A8F1-4FD9-AC81-1173DF5E046A
2026-10-12 11:40:36.933 Df Habits[47527:20401] [com.apple.xpc:connection] [0x1146bfac0] Re-initialization successful; calling out to event handler with XPC_ERROR_CONNECTION_INTERRUPTED
2026-10-12 11:40:36.951 Df Habits[47527:20401] [com.apple.xpc:connection] [0x1161b5540] Re-initialization successful; calling out to event handler with XPC_ERROR_CONNECTION_INTERRUPTED
2026-10-12 11:40:36.957 Df Habits[47527:203ff] [com.apple.xpc:connection] [0x1161b48c0] Re-initialization successful; calling out to event handler with XPC_ERROR_CONNECTION_INTERRUPTED
2026-10-12 11:40:37.094 Df Habits[47527:20406] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/4F35E3E6-3BF2-4822-9BCE-5FB705AC547A/FileTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/988E3014-CF08-448D-A9BC-635F45668EB5/data/Containers/Data/Application/8AA805C2-DC7E-46CD-BDAF-3D0BA52F4797/ -- purposeID: 53C60AE5-3226-4DA5-91D8-EAF9A394C2A9 -- claimID: F63C14CA-7624-465B-A770-8C4B73F93FE4
2026-10-12 11:40:37.132 Df Habits[47527:20400] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/4F35E3E6-3BF2-4822-9BCE-5FB705AC547A/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/988E3014-CF08-448D-A9BC-635F45668EB5/data/Containers/Data/Application/8AA805C2-DC7E-46CD-BDAF-3D0BA52F4797/ -- purposeID: 0E8686B5-3E16-4266-B03F-CD388843AEE7 -- claimID: 7515695D-BBB4-4F00-B693-3CB4D8D20264
2026-10-12 11:40:37.185 Df Habits[47527:203f5] [com.apple.wcd:WC] -[WCSession onqueue_dequeueContent]_block_invoke_2 hasContentPending: NO
2026-10-12 11:40:37.185 E  Habits[47527:203f5] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-12 11:40:37.185 Df Habits[47527:203f5] [com.apple.wcd:WC] -[WCSession didSessionStateChange:withChangeHandler:] no change
2026-10-12 11:40:37.186 E  Habits[47527:203f5] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-12 11:40:37.186 Df Habits[47527:203f5] [com.apple.wcd:WC] -[WCSession didSessionStateChange:withChangeHandler:] no change
2026-10-12 11:40:37.186 E  Habits[47527:203f5] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-12 11:40:37.186 Df Habits[47527:203f5] [com.apple.wcd:WC] -[WCSession didSessionStateChange:withChangeHandler:] no change
2026-10-12 11:41:04.472 Df Habits[47527:20404] [com.apple.wcd:WC] -[WCSession onqueue_completeSwitchTask:withSessionState:]_block_invoke_4 cleaning up directories for state: <WCSessionState: 0x1160e0d80, reachable: NO, paired: YES, appInstalled: NO, complicationEnabled: NO(50), pairingID: 4F35E3E6-3BF2-4822-9BCE-5FB705AC547A, pairedDevicesPairingIDs: {("4F35E3E6-3BF2-4822-9BCE-5FB705AC547A")}, appInstallationID: (null)>
2026-10-12 11:41:52.928 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:52.930 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:52.936 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:54.223 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:54.738 Df wcd[28810:1571f] [com.apple.Transport:_IDSService] !setState destination=__IDS_DEFAULT_PAIRED_DEVICE__
2026-10-12 11:41:54.741 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:54.746 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:55.464 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:55.465 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:58.833 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:58.836 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:41:59.523 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:01.802 Df wcd[28810:1571f] [com.apple.Transport:_IDSService] !setState destination=__IDS_DEFAULT_PAIRED_DEVICE__
2026-10-12 11:42:01.803 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:43.397 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:48.655 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:48.655 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:49.804 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:50.033 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:50.396 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:50.397 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-12 11:42:50.398 Df wcd[28810:1571f] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
```
WatchConnectivity on the Watch (last lines):
```
2026-10-12 11:40:26.068 Df wcd[31172:1571a] [com.apple.wcd:WC] <WCDFirstUnlockManager: 0x10310b920> of systemObserverPairedListChanged
2026-10-12 11:40:48.303 Df OftenEnoughWatch[47891:20792] [com.apple.BoardServices:XPCErrors] [C:1] Alloc com.apple.frontboard.systemappservices
2026-10-12 11:40:48.600 Df OftenEnoughWatch[47891:2077e] [com.apple.BoardServices:XPCErrors] [C:2] Alloc com.apple.backboard.hid-services.xpc
2026-10-12 11:40:48.602 Df OftenEnoughWatch[47891:2077e] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUIPrimaryGestureNegativeInteraction: 0x105121090>) installed: NO -> YES
2026-10-12 11:40:48.603 Df OftenEnoughWatch[47891:2077e] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUICrownPressDismissGestureInteraction: 0x10840d340>) installed: NO -> YES
2026-10-12 11:40:49.178 Df OftenEnoughWatch[47891:2077e] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUIPrimaryGestureViewInteraction: 0x105078780>) installed: NO -> YES
2026-10-12 11:40:49.304 Df OftenEnoughWatch[47891:2077e] [com.apple.wcd:WC] -[WCSession _init] WCSession initialized
2026-10-12 11:40:49.304 Df OftenEnoughWatch[47891:2077e] [com.apple.wcd:WC] -[WCSession setDelegate:] delegateSupportsAsyncActivate: YES, delegateSupportsActiveDeviceSwitch: NO
2026-10-12 11:40:49.304 Df OftenEnoughWatch[47891:2077e] [com.apple.wcd:WC] -[WCSession activateSession]_block_invoke
2026-10-12 11:40:49.304 Df OftenEnoughWatch[47891:2077e] [com.apple.wcd:WC] -[WCSession activateSession]_block_invoke informing daemon ready for session state
2026-10-12 11:40:49.328 Df wcd[31172:1571a] (libMobileGestalt.dylib) Failed to get battery level with error E00002D8
Paired Device Information: Production: iPhone18,3 (iPhone18,3), iPhone OS 26.5 (23F77), "Pair iPhone"
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
2026-10-12 11:40:49.352 Df OftenEnoughWatch[47891:2077e] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller(<WAGUIPrimaryGestureViewInteraction: 0x10508af80>) installed: NO -> YES
2026-10-12 11:40:49.375 Df OftenEnoughWatch[47891:2077e] [com.apple.WatchGestures:ui] WAGUIGestureRecognizerInstaller((null)) installed: YES -> NO
2026-10-12 11:40:49.376 E  wcd[31172:1571a] [com.apple.wcd:WC] failed isPrivileged check. error: NanoTimeKit.WatchConnectivityMultiplexer.MultiplexierError:1
2026-10-12 11:40:59.431 Df wcd[31172:1571a] [com.apple.wcd:WC] <WatchConnectivityDaemon: 0x10307ce60> of systemObserverInstalledApplicationsChanged
```
