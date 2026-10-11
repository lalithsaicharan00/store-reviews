# Watch: apple-watch-ci2 @ aec323b

Run: https://github.com/lalithsaicharan00/store-reviews/actions/runs/38116345106 · 2026-10-11 06:17 UTC
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

Paired simulators: FAILED (waited 226 s)

- iPhone 69E47FE5-5104-4479-97AF-A81671CDA6B2, Watch 8FFD0DD3-977A-4610-A701-78D552BE81F5, pair BF117357-B17A-4373-9556-3B323B443D6D
- 157 s: booted the iPhone
- 344 s: booted the Watch FAILED or took over 180 s
- 404 s: activated the pair FAILED or took over 60 s
- 436 s: installed the iPhone app
- 474 s: installed the Watch app
- 490 s: launched the iPhone app
- 528 s: launched the Watch app

iPhone:
```
    0.0 s  phone: added Pair water and Pair timer, +1 glass
  300.3 s  never saw the Watch's two +1s (3 glasses) in 300 s
  300.4 s  # PAIR DONE failed
```
Watch:
```
    0.0 s  watch: waiting for the first fill
  300.4 s  never saw the first fill (Pair water at 1 glass, Pair timer) in 300 s
  300.4 s  # PAIR DONE failed
```
WatchConnectivity on the iPhone (last lines):
```
2026-10-11 06:15:09.757 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.761 Df Habits[29692:15243] [com.apple.wcd:WC] -[WCSession handleSessionStateChanged:]_block_invoke <WCSessionState: 0x11313ca80, reachable: NO, paired: YES, appInstalled: NO, complicationEnabled: NO(50), pairingID: 8FFD0DD3-977A-4610-A701-78D552BE81F5, pairedDevicesPairingIDs: {("8FFD0DD3-977A-4610-A701-78D552BE81F5")}, appInstallationID: (null)>
2026-10-11 06:15:09.778 E  Habits[29692:151f1] [com.apple.wcd:WC] WCSession counterpart app not installed
    kCLConnectionMessagePurposeKey = "Location in use on paired watch by 3rd party app";
2026-10-11 06:15:09.782 Df Habits[29692:151f1] [com.apple.wcd:WC] -[WCSession didSessionStateChange:withChangeHandler:] no change
2026-10-11 06:15:09.787 Df wcd[25102:13138] [com.apple.BoardServices:XPCErrors] [C:1] Alloc com.apple.frontboard.systemappservices
2026-10-11 06:15:09.802 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.803 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.803 Df Habits[29692:151f1] [com.apple.wcd:WC] -[WCSession onqueue_handleDictionaryMessageRequest:withPairingID:] <WCMessageRequest: 0x11313ca80, pairingID: 8FFD0DD3-977A-4610-A701-78D552BE81F5, identifier: E3270936-57CB-4A8A-B6FB-821F024E5D43, dataLength: 21, isDictionary:YES, expectsResponse: NO>
2026-10-11 06:15:09.803 Df Habits[29692:151f1] [com.apple.wcd:WC] NSDictionary<NSString *,id> *WCDeserializePayloadData(NSData *__strong, NSError *__autoreleasing *) success: YES
2026-10-11 06:15:09.804 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.808 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.810 Df Habits[29692:15243] [com.apple.wcd:WC] -[WCSession onqueue_handleDictionaryMessageRequest:withPairingID:] <WCMessageRequest: 0x11313cff0, pairingID: 8FFD0DD3-977A-4610-A701-78D552BE81F5, identifier: 38094E38-EFE3-43F0-B4E1-1EE4D3F085CF, dataLength: 28, isDictionary:YES, expectsResponse: NO>
2026-10-11 06:15:09.810 Df Habits[29692:15243] [com.apple.wcd:WC] NSDictionary<NSString *,id> *WCDeserializePayloadData(NSData *__strong, NSError *__autoreleasing *) success: YES
2026-10-11 06:15:09.811 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.813 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.815 Df Habits[29692:15297] [com.apple.wcd:WC] -[WCSession onqueue_handleDictionaryMessageRequest:withPairingID:] <WCMessageRequest: 0x11313e730, pairingID: 8FFD0DD3-977A-4610-A701-78D552BE81F5, identifier: 94104218-D626-441B-811D-5E8D7554EBA7, dataLength: 201, isDictionary:YES, expectsResponse: NO>
2026-10-11 06:15:09.815 Df Habits[29692:15297] [com.apple.wcd:WC] NSDictionary<NSString *,id> *WCDeserializePayloadData(NSData *__strong, NSError *__autoreleasing *) success: YES
2026-10-11 06:15:09.815 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:09.948 A  Habits[29692:15181] (WatchConnectivity) updateApplicationContext:error:
2026-10-11 06:15:09.948 Df Habits[29692:15181] [com.apple.wcd:WC] -[WCSession updateApplicationContext:error:]_block_invoke
2026-10-11 06:15:09.948 E  Habits[29692:15181] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-11 06:15:09.955 E  Habits[29692:15181] [com.apple.wcd:WC] -[WCSession updateApplicationContext:error:]_block_invoke failed due to WCErrorCodeWatchAppNotInstalled
2026-10-11 06:15:09.991 A  Habits[29692:15181] (WatchConnectivity) transferUserInfo:
2026-10-11 06:15:09.991 Df Habits[29692:15181] [com.apple.wcd:WC] -[WCSession transferUserInfo:]_block_invoke
2026-10-11 06:15:09.991 Df Habits[29692:15297] [com.apple.wcd:WC] -[WCSession onqueue_transferUserInfo:withUserInfo:]
2026-10-11 06:15:09.991 E  Habits[29692:15297] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-11 06:15:09.992 Df Habits[29692:151f1] [com.apple.wcd:WC] -[WCSession onqueue_notifyOfUserInfoError:withUserInfoTransfer:]_block_invoke delegate Habits.PhoneWatchLink does not implement session:didFinishUserInfoTransfer:error:
2026-10-11 06:15:09.998 A  Habits[29692:15181] (WatchConnectivity) transferFile:metadata:
2026-10-11 06:15:09.998 Df Habits[29692:15181] [com.apple.wcd:WC] -[WCSession transferFile:metadata:]_block_invoke
2026-10-11 06:15:09.998 E  Habits[29692:15181] [com.apple.wcd:WC] WCSession counterpart app not installed
2026-10-11 06:15:09.998 E  Habits[29692:15181] [com.apple.wcd:WC] -[WCSession notifyOfFileError:withFileTransfer:] <WCSessionFileTransfer: 0x112b0d310, session file: <WCSessionFile: 0x112b0e8a0, identifier: 6B3F6554-8DE4-493A-88E1-2D0D14373B8F, file: /Users/runner/Library/Developer/CoreSimulator/Devices/69E47FE5-5104-4479-97AF-A81671CDA6B2/data/Containers/Data/Application/51C768BB-2EAC-4C0E-8D60-0508531B5650/tmp/watch-fill-3D6AFFA7-53C9-480A-8E73-CA4878DE491E.zip, hasMetadata: NO>, transferring: NO> with WCErrorCodeWatchAppNotInstalled
2026-10-11 06:15:21.853 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:15:21.934 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:17:15.350 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:17:15.351 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:17:15.357 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:17:15.375 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:17:15.377 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
2026-10-11 06:17:15.378 Df wcd[25102:13138] [com.apple.IDS:Registration] XPC has informed us that a fatal error has occured, we will not be attempting to reconnect any further
```
WatchConnectivity on the Watch (last lines):
```
2026-10-11 06:12:21.202 Df wcd[27722:13159] [com.apple.wcd:WC] identifier: A8A5F723-7A40-491D-9011-10BCAD74F64C, communicationID: com.oftenenough.app was a user info transfer
2026-10-11 06:12:21.202 Df OftenEnoughWatch[29896:15e66] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:] 69E47FE5-5104-4479-97AF-A81671CDA6B2
2026-10-11 06:12:21.203 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke <WCSessionUserInfoTransfer: 0x107fe1b80, transferring: YES, hasUserInfo: YES>
2026-10-11 06:12:21.203 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke delegate OftenEnoughWatch.WatchLink does not implement session:didFinishUserInfoTransfer:error:
2026-10-11 06:12:21.205 Df wcd[27722:13159] [com.apple.foundation.filecoordination:claims] Write options: 8 -- URL: Library/Application%20Support/com.apple.watchconnectivity/69E47FE5-5104-4479-97AF-A81671CDA6B2/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/8FFD0DD3-977A-4610-A701-78D552BE81F5/data/Containers/Data/Application/F8253816-A974-41AA-A74D-46A3B1D75693/ -- purposeID: EBF8F5D7-BD3F-40C6-B2DA-5CDCF6B91120 -- claimID: D3706AF0-83F8-4841-A6A9-6569943D8B78
2026-10-11 06:12:21.205 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke <WCSessionUserInfoTransfer: 0x107fe2600, transferring: YES, hasUserInfo: YES>
2026-10-11 06:12:21.205 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke delegate OftenEnoughWatch.WatchLink does not implement session:didFinishUserInfoTransfer:error:
2026-10-11 06:12:21.207 Df OftenEnoughWatch[29896:15e4e] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/69E47FE5-5104-4479-97AF-A81671CDA6B2/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/8FFD0DD3-977A-4610-A701-78D552BE81F5/data/Containers/Data/Application/F8253816-A974-41AA-A74D-46A3B1D75693/ -- purposeID: 920A0E3C-092C-42D7-B7B3-193E40016331 -- claimID: E5AE7FDC-7684-4F39-A3FF-E7D88FDBBA5F
2026-10-11 06:12:21.207 Df wcd[27722:13159] [com.apple.foundation.filecoordination:claims] Write options: 8 -- URL: Library/Application%20Support/com.apple.watchconnectivity/69E47FE5-5104-4479-97AF-A81671CDA6B2/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/8FFD0DD3-977A-4610-A701-78D552BE81F5/data/Containers/Data/Application/F8253816-A974-41AA-A74D-46A3B1D75693/ -- purposeID: EBF8F5D7-BD3F-40C6-B2DA-5CDCF6B91120 -- claimID: E87193FF-94A8-4963-A2BB-3288CACA2C16
2026-10-11 06:12:21.215 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCFileStorage enumerateUserInfoResultsWithBlock:] result does not exist, removing from index AF27B6DD-4472-4CD5-BB37-0CBB5ACF0D8A due to NSFileReadNoSuchFileError -> ENOENT
2026-10-11 06:12:21.216 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke_2 ERROR: failed to load user info result with identifier AF27B6DD-4472-4CD5-BB37-0CBB5ACF0D8A
2026-10-11 06:12:21.218 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke <WCSessionUserInfoTransfer: 0x107fe2480, transferring: YES, hasUserInfo: YES>
2026-10-11 06:12:21.220 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke delegate OftenEnoughWatch.WatchLink does not implement session:didFinishUserInfoTransfer:error:
2026-10-11 06:12:21.221 Df OftenEnoughWatch[29896:15e66] [com.apple.foundation.filecoordination:claims] Read options: 1 -- URL: Library/Application%20Support/com.apple.watchconnectivity/69E47FE5-5104-4479-97AF-A81671CDA6B2/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/8FFD0DD3-977A-4610-A701-78D552BE81F5/data/Containers/Data/Application/F8253816-A974-41AA-A74D-46A3B1D75693/ -- purposeID: 920A0E3C-092C-42D7-B7B3-193E40016331 -- claimID: B85C2C2C-0C90-4377-BFB0-F9DFCDE23BBE
2026-10-11 06:12:21.221 Df wcd[27722:13159] [com.apple.foundation.filecoordination:claims] Write options: 8 -- URL: Library/Application%20Support/com.apple.watchconnectivity/69E47FE5-5104-4479-97AF-A81671CDA6B2/UserInfoTransfers/contents.index -- file:///Users/runner/Library/Developer/CoreSimulator/Devices/8FFD0DD3-977A-4610-A701-78D552BE81F5/data/Containers/Data/Application/F8253816-A974-41AA-A74D-46A3B1D75693/ -- purposeID: EBF8F5D7-BD3F-40C6-B2DA-5CDCF6B91120 -- claimID: 39D359B9-3C38-4B4F-B8FF-F915D444E0A8
2026-10-11 06:12:21.224 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCFileStorage enumerateUserInfoResultsWithBlock:] result does not exist, removing from index A8A5F723-7A40-491D-9011-10BCAD74F64C due to NSFileReadNoSuchFileError -> ENOENT
2026-10-11 06:12:21.224 Df OftenEnoughWatch[29896:15e60] [com.apple.wcd:WC] -[WCSession handleUserInfoResultWithPairingID:]_block_invoke_2 ERROR: failed to load user info result with identifier A8A5F723-7A40-491D-9011-10BCAD74F64C
2026-10-11 06:13:39.799 Df wcd[27722:13159] [com.apple.watchkit:default] -[SPGizmoApplicationManagerConnection _watchKitAppActiveUIStateDidChange]_block_invoke_3:380: calling callback with error=(null)
2026-10-11 06:14:40.134 Df wcd[27722:13159] [com.apple.wcd:WC] -[WatchConnectivityDaemon clientReachabilityDidChange:]
2026-10-11 06:14:42.726 Df wcd[27722:13159] [com.apple.wcd:WC] com.oftenenough.app.watchkitapp paired: YES, connected: YES, forgroundOrPrivileged: YES, remote first unlocked: YES
2026-10-11 06:14:42.727 Df wcd[27722:13159] [com.apple.wcd:WC] com.oftenenough.app.watchkitapp iOS app installed: YES, standalone: NO
2026-10-11 06:14:48.843 Df OftenEnoughWatch[29896:15e67] [com.apple.wcd:WC] -[WCSession handleSessionStateChanged:]_block_invoke <WCSessionState: 0x107ffadf0, reachable: YES, paired: YES, iOSDeviceNeedsFirstUnlock: NO, pairingID: 69E47FE5-5104-4479-97AF-A81671CDA6B2, pairedDevicesPairingIDs: (null), appInstallationID: (null), standalone: NO, companionAppInstalled: YES>
2026-10-11 06:14:48.867 Df OftenEnoughWatch[29896:15e4e] [com.apple.wcd:WC] -[WCSession onDelegateQueueIfTriggeringKVO_updateSessionState:triggerKVO:] <WCSessionState: 0x107ffadf0, reachable: YES, paired: YES, iOSDeviceNeedsFirstUnlock: NO, pairingID: 69E47FE5-5104-4479-97AF-A81671CDA6B2, pairedDevicesPairingIDs: (null), appInstallationID: (null), standalone: NO, companionAppInstalled: YES>, triggerKVO: YES
2026-10-11 06:14:48.867 Df OftenEnoughWatch[29896:15e4e] [com.apple.wcd:WC] -[WCSession onqueue_handleUpdateSessionState:]_block_invoke notifying client session reachability changed
2026-10-11 06:14:48.871 Df OftenEnoughWatch[29896:15e67] [com.apple.wcd:WC] -[WCSession onqueue_cancelMessagesIfAppropriate] shouldCancel: NO
2026-10-11 06:14:48.926 A  OftenEnoughWatch[29896:15dfa] (WatchConnectivity) sendMessage:replyHandler:errorHandler:
2026-10-11 06:14:48.926 Df OftenEnoughWatch[29896:15dfa] [com.apple.wcd:WC] -[WCSession sendMessage:replyHandler:errorHandler:]_block_invoke hasReplyHandler: NO, hasErrorHandler: YES
2026-10-11 06:14:48.927 Df OftenEnoughWatch[29896:15e4e] [com.apple.wcd:WC] NSData *WCSerializePayloadDictionary(NSDictionary<NSString *,id> *__strong, NSError *__autoreleasing *) success: YES
2026-10-11 06:14:48.927 A  OftenEnoughWatch[29896:15dfa] (WatchConnectivity) sendMessage:replyHandler:errorHandler:
2026-10-11 06:14:48.927 Df OftenEnoughWatch[29896:15dfa] [com.apple.wcd:WC] -[WCSession sendMessage:replyHandler:errorHandler:]_block_invoke hasReplyHandler: NO, hasErrorHandler: YES
2026-10-11 06:14:48.928 Df OftenEnoughWatch[29896:15e4e] [com.apple.wcd:WC] -[WCSession onqueue_sendMessageData:replyHandler:errorHandler:dictionaryMessage:] size: 21, messageID: E3270936-57CB-4A8A-B6FB-821F024E5D43
2026-10-11 06:14:48.929 Df OftenEnoughWatch[29896:15e4e] [com.apple.wcd:WC] NSData *WCSerializePayloadDictionary(NSDictionary<NSString *,id> *__strong, NSError *__autoreleasing *) success: YES
2026-10-11 06:14:48.931 Df OftenEnoughWatch[29896:15e4e] [com.apple.wcd:WC] -[WCSession onqueue_sendMessageData:replyHandler:errorHandler:dictionaryMessage:] size: 28, messageID: 38094E38-EFE3-43F0-B4E1-1EE4D3F085CF
2026-10-11 06:14:48.956 A  OftenEnoughWatch[29896:15dfa] (WatchConnectivity) sendMessage:replyHandler:errorHandler:
2026-10-11 06:14:48.956 Df OftenEnoughWatch[29896:15dfa] [com.apple.wcd:WC] -[WCSession sendMessage:replyHandler:errorHandler:]_block_invoke hasReplyHandler: NO, hasErrorHandler: YES
2026-10-11 06:14:48.956 Df OftenEnoughWatch[29896:15e67] [com.apple.wcd:WC] NSData *WCSerializePayloadDictionary(NSDictionary<NSString *,id> *__strong, NSError *__autoreleasing *) success: YES
2026-10-11 06:14:48.956 Df OftenEnoughWatch[29896:15e67] [com.apple.wcd:WC] -[WCSession onqueue_sendMessageData:replyHandler:errorHandler:dictionaryMessage:] size: 201, messageID: 94104218-D626-441B-811D-5E8D7554EBA7
2026-10-11 06:14:49.119 Df OftenEnoughWatch[29896:15e67] [com.apple.wcd:WC] -[WCQueueManager onqueue_handleSentMessageWithIdentifier:error:] id: E3270936-57CB-4A8A-B6FB-821F024E5D43 with kNoErr
2026-10-11 06:14:49.119 Df OftenEnoughWatch[29896:15e67] [com.apple.wcd:WC] -[WCQueueManager onqueue_handleSentMessageWithIdentifier:error:] id: 38094E38-EFE3-43F0-B4E1-1EE4D3F085CF with kNoErr
2026-10-11 06:14:49.119 Df OftenEnoughWatch[29896:15e67] [com.apple.wcd:WC] -[WCQueueManager onqueue_handleSentMessageWithIdentifier:error:] id: 94104218-D626-441B-811D-5E8D7554EBA7 with kNoErr
```
