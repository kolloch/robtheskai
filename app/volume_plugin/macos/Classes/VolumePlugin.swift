import FlutterMacOS
import Cocoa
import DiskArbitration

public class VolumePlugin: NSObject, FlutterPlugin {
  var volumesEventChannel: FlutterEventChannel?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    print("register")

    let instance = VolumePlugin()
    instance.volumesEventChannel = FlutterEventChannel(name: "volumesEventChannel", binaryMessenger: registrar.messenger)
    instance.volumesEventChannel?.setStreamHandler(VolumeEventStreamHandler())

    let channel = FlutterMethodChannel(name: "volume_plugin", binaryMessenger: registrar.messenger)
    registrar.addMethodCallDelegate(instance, channel: channel)
 }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("handle call \(call.method)")
    fflush(stdout)

    if call.method == "eject" {
      eject(call, result: result)
    } else if call.method == "getVolumes" {
      let fm = FileManager.default
      let mountedVolumesURLs = fm.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: [
        .skipHiddenVolumes,
      ]) ?? []

      var volumes = [[String: Any]]()
      for volumeURL in mountedVolumesURLs {
        var values: URLResourceValues
        do {
          values = try volumeURL.resourceValues(forKeys: [
            .volumeNameKey,
            .volumeIsBrowsableKey,
            .volumeIsEjectableKey,
            .volumeIsRemovableKey, 
            .volumeIsInternalKey,
            .volumeIsAutomountedKey,
            .volumeIsLocalKey,
            .volumeIsReadOnlyKey,
            .volumeIsRootFileSystemKey,
            .volumeSupportsPersistentIDsKey,
            .volumeSupportsRenamingKey,
            .volumeCreationDateKey,
            .volumeIdentifierKey,
            .volumeLocalizedFormatDescriptionKey,
            .volumeLocalizedNameKey,
            .volumeURLKey,
            .volumeUUIDStringKey, 
            // .volumeTypeNameKey,
            // .volumeSubtypeKey,
            .volumeSupportsCasePreservedNamesKey,
            .volumeAvailableCapacityForImportantUsageKey,
            .volumeTotalCapacityKey,
          ])
        } catch {
          continue
        }

        var volumeData = [String: Any]()

        volumeData["url"] = volumeURL.absoluteString
        volumeData["name"] = values.volumeName
        volumeData["isBrowsable"] = values.volumeIsBrowsable
        volumeData["isEjectable"] = values.volumeIsEjectable
        volumeData["isRemovable"] = values.volumeIsRemovable
        volumeData["isInternal"] = values.volumeIsInternal
        volumeData["isAutomounted"] = values.volumeIsAutomounted
        volumeData["isLocal"] = values.volumeIsLocal
        volumeData["isReadOnly"] = values.volumeIsReadOnly
        volumeData["isRootFileSystem"] = values.volumeIsRootFileSystem
        volumeData["supportsPersistentIDs"] = values.volumeSupportsPersistentIDs
        volumeData["supportsRenaming"] = values.volumeSupportsRenaming
        volumeData["creationDate"] = values.volumeCreationDate.map { $0.timeIntervalSince1970 }
        volumeData["localizedFormatDescription"] = values.volumeLocalizedFormatDescription
        volumeData["localizedName"] = values.volumeLocalizedName
        volumeData["uuidString"] = values.volumeUUIDString
        // volumeData["type"] = values.volumeType
        // volumeData["subtype"] = values.volumeSubtype
        volumeData["supportsCasePreservedNames"] = values.volumeSupportsCasePreservedNames
        volumeData["availableCapacityForImportantUsage"] = values.volumeAvailableCapacityForImportantUsage
        volumeData["totalCapacity"] = values.volumeTotalCapacity

        volumes.append(volumeData)
      }
      result(volumes)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  public func eject(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    print("eject call \(call.method)")

    guard let args = call.arguments as? [String: Any],
        let volumePathString = args["url"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENTS",
                            message: "Invalid arguments, expected url",
                            details: nil))
        return
    }

    FileManager.default.unmountVolume(at: URL(string: volumePathString)!, 
      completionHandler: { error in
        if let error = error {
            result(FlutterError(code: "UNMOUNT_ERROR",
                                message: "Error unmounting volume: \(error.localizedDescription)",
                                details: nil))
        } else {
            result(nil)
        }
    })
  }
}

class FlutterResultWrapper: NSObject {
    let result: FlutterResult
    init(result: @escaping FlutterResult) {
        self.result = result
    }
}

class VolumeEventStreamHandler: NSObject, FlutterStreamHandler {
    
    var volumesEventSink: FlutterEventSink?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("onListen")
        fflush(stdout)

        let notificationCenter: NotificationCenter = NSWorkspace.shared.notificationCenter
        notificationCenter.addObserver(forName: NSWorkspace.didMountNotification, object: nil, queue: nil) { notification in
            print("didMountNotification")
            fflush(stdout)
            events([
                "event": "mounted",
            ])
        }
        notificationCenter.addObserver(forName: NSWorkspace.didUnmountNotification, object: nil, queue: nil) { notification in
            print("didUnmountNotification")
            fflush(stdout)
            events([
                "event": "unmounted",
            ])
        }
        notificationCenter.addObserver(forName: NSWorkspace.didRenameVolumeNotification, object: nil, queue: nil) { notification in
            print("didRenameVolumeNotification")
            fflush(stdout)
            events([
                "event": "renamed",
            ])
        }

        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        print("onCancel")
        fflush(stdout)
        volumesEventSink = nil
        return nil
    }
}
