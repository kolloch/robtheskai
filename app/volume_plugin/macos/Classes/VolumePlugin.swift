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
    if call.method == "eject" {
      eject(call, result: result)
    } else if call.method == "getVolumes" {
      let session = DASessionCreate(kCFAllocatorDefault)

      let mountedVolumesURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: []) ?? []
      var volumes = [[String: Any]]()
      for volumeURL in mountedVolumesURLs {
        let disk = DADiskCreateFromVolumePath(kCFAllocatorDefault, session!, volumeURL as CFURL)
        let diskDescriptionNullable = DADiskCopyDescription(disk!)
        if diskDescriptionNullable == nil {
          continue
        }
        let diskDescription = diskDescriptionNullable! as NSDictionary

        var volumeData = [String: Any]()
        volumeData["volumePath"] = volumeURL.absoluteString
        volumeData["volumeKind"] = diskDescription[kDADiskDescriptionVolumeKindKey] as? String
        volumeData["volumeName"] = diskDescription[kDADiskDescriptionVolumeNameKey] as? String
        if let volumeUUID = diskDescription[kDADiskDescriptionVolumeUUIDKey] {
            let uuidString = CFUUIDCreateString(nil, volumeUUID as! CFUUID) as String
            volumeData["volumeUUID"] = uuidString
        }
        volumeData["mediaName"] = diskDescription[kDADiskDescriptionMediaNameKey] as? String
        if let mediaIcon = diskDescription[kDADiskDescriptionMediaIconKey] as? [String: Any] {
            let mediaIconData = try? JSONSerialization.data(withJSONObject: mediaIcon)
            volumeData["mediaIcon"] = String(data: mediaIconData!, encoding: .utf8)
        }
        volumeData["mediaKind"] = diskDescription[kDADiskDescriptionMediaKindKey] as? String
        volumeData["mediaBlockSize"] = (diskDescription[kDADiskDescriptionMediaBlockSizeKey] as? NSNumber)?.intValue
        volumeData["mediaSize"] = (diskDescription[kDADiskDescriptionMediaSizeKey] as? NSNumber)?.intValue
        if let mediaUUID = diskDescription[kDADiskDescriptionMediaUUIDKey] {
            let uuidString = CFUUIDCreateString(nil, mediaUUID as! CFUUID) as String
            volumeData["mediaUUID"] = uuidString
        }
        volumeData["devicePath"] = diskDescription[kDADiskDescriptionDevicePathKey] as? String
        volumeData["deviceProtocol"] = diskDescription[kDADiskDescriptionDeviceProtocolKey] as? String
        volumeData["deviceInternal"] = (diskDescription[kDADiskDescriptionDeviceInternalKey] as? NSNumber)?.boolValue
        volumeData["deviceModel"] = diskDescription[kDADiskDescriptionDeviceModelKey] as? String
        volumeData["deviceRevision"] = diskDescription[kDADiskDescriptionDeviceRevisionKey] as? String
        volumeData["deviceVendor"] = diskDescription[kDADiskDescriptionDeviceVendorKey] as? String
        volumeData["mediaEjectable"] = (diskDescription[kDADiskDescriptionMediaEjectableKey] as? NSNumber)?.boolValue
        volumeData["mediaRemovable"] = (diskDescription[kDADiskDescriptionMediaRemovableKey] as? NSNumber)?.boolValue
        volumeData["mediaWhole"] = (diskDescription[kDADiskDescriptionMediaWholeKey] as? NSNumber)?.boolValue
        volumeData["mediaWritable"] = (diskDescription[kDADiskDescriptionMediaWritableKey] as? NSNumber)?.boolValue

        volumes.append(volumeData)
      }
      result(volumes)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }

  public func eject(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any],
          let uuidString = args["uuid"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENTS",
                            message: "Invalid arguments",
                            details: nil))
        return
    }

    guard let session = DASessionCreate(kCFAllocatorDefault) else {
        result(FlutterError(code: "SESSION_CREATION_FAILED",
                            message: "Failed to create DA session",
                            details: nil))
        return
    }

    let mountedVolumesURLs = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: []) ?? []
      for volumeURL in mountedVolumesURLs {
        guard let disk = DADiskCreateFromVolumePath(kCFAllocatorDefault, session, volumeURL as CFURL) else {
          continue
        }
        guard let diskDescription = DADiskCopyDescription(disk) as? NSDictionary else {
          continue
        }
        if let mediaUUID = diskDescription[kDADiskDescriptionVolumeUUIDKey] {
            let uuid = CFUUIDCreateString(nil, mediaUUID as! CFUUID) as String
            if uuid == uuidString {
                let result = FlutterResultWrapper(result: result)
                DADiskEject(disk, DADiskEjectOptions(kDADiskEjectOptionDefault), { (disk, dissenter, context) in
                    let result = Unmanaged<FlutterResultWrapper>.fromOpaque(context!).takeUnretainedValue()

                    if dissenter != nil {
                        print("Failed to eject volume: \(dissenter!)")
                        result.result(FlutterError(code: "EJECT_FAILED",
                                            message: "Failed to eject volume",
                                            details: nil))
                    } else {
                      print("Ejected volume successfully")
                      result.result(nil)
                    }
                    // flush stdout
                    fflush(stdout)
                }, Unmanaged<FlutterResultWrapper>.passUnretained(result).toOpaque())
                return
            }
        }
    }

    result(FlutterError(code: "INVALID_UUID",
                        message: "Disk with specified UUID not found",
                        details: nil))
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
    var session: DASession?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("onListen")
        fflush(stdout)

        volumesEventSink = events
        session = DASessionCreate(kCFAllocatorDefault)
        
        DARegisterDiskDescriptionChangedCallback(session!, nil as CFDictionary?, nil as CFArray?, onDiscDescriptionChanged, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))
        DARegisterDiskAppearedCallback(session!, nil as CFDictionary?, onDiskAppeared, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))
        DARegisterDiskDisappearedCallback(session!, nil as CFDictionary?, onDiskDisappeared, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))

        DASessionScheduleWithRunLoop(session!, CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue);
        
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        print("onCancel")
        fflush(stdout)
        volumesEventSink = nil
        session = nil
        return nil
    }

    private let onDiscDescriptionChanged: DADiskDescriptionChangedCallback = { disk, keys, context in
        print("onDiscDescriptionChanged")
        fflush(stdout)
        let this = Unmanaged<VolumeEventStreamHandler>.fromOpaque(context!).takeUnretainedValue()
        this.diskEvent("changed")
    }

    private let onDiskAppeared: DADiskAppearedCallback = { disk, context in
        print("onDiskAppeared")
        fflush(stdout)
        let this = Unmanaged<VolumeEventStreamHandler>.fromOpaque(context!).takeUnretainedValue()
        this.diskEvent("appeared")
    }

    private let onDiskDisappeared: DADiskDisappearedCallback = { disk, context in
        print("onDiskDisappeared")
        fflush(stdout)
        let this = Unmanaged<VolumeEventStreamHandler>.fromOpaque(context!).takeUnretainedValue()
        this.diskEvent("disappeared")
    }

    private func diskEvent(_ event: String) {
        print("diskEvent: \(event)")
        fflush(stdout)
        volumesEventSink?([
            "event": event,
            // Add the other properties here if needed.
        ])
    }
}
