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
    if call.method == "getVolumes" {
      let session = DASessionCreate(kCFAllocatorDefault)
      var volumes = [[String: Any]]()

      let mountedVolumesURL = FileManager.default.mountedVolumeURLs(includingResourceValuesForKeys: nil, options: [])
      for volumeURL in mountedVolumesURL ?? [] {
        let disk = DADiskCreateFromVolumePath(kCFAllocatorDefault, session!, volumeURL as CFURL)
        let diskDescription = DADiskCopyDescription(disk!) as! NSDictionary

        var volumeData = [String: Any]()
        volumeData["path"] = volumeURL.absoluteString
        volumeData["kind"] = diskDescription[kDADiskDescriptionVolumeKindKey] as? String
        volumeData["name"] = diskDescription[kDADiskDescriptionVolumeNameKey] as? String
        volumeData["uuid"] = diskDescription[kDADiskDescriptionVolumeUUIDKey] as? String
        volumeData["mediaName"] = diskDescription[kDADiskDescriptionMediaNameKey] as? String
        volumeData["mediaIcon"] = diskDescription[kDADiskDescriptionMediaIconKey] as? String
        volumeData["mediaKind"] = diskDescription[kDADiskDescriptionMediaKindKey] as? String
        volumeData["mediaBlockSize"] = diskDescription[kDADiskDescriptionMediaBlockSizeKey] as? Int
        volumeData["mediaSize"] = diskDescription[kDADiskDescriptionMediaSizeKey] as? Int
        volumeData["mediaUUID"] = diskDescription[kDADiskDescriptionMediaUUIDKey] as? String
        volumeData["devicePath"] = diskDescription[kDADiskDescriptionDevicePathKey] as? String
        volumeData["deviceProtocol"] = diskDescription[kDADiskDescriptionDeviceProtocolKey] as? String
        volumeData["deviceInternal"] = diskDescription[kDADiskDescriptionDeviceInternalKey] as? Bool
        volumeData["deviceModel"] = diskDescription[kDADiskDescriptionDeviceModelKey] as? String
        volumeData["deviceRevision"] = diskDescription[kDADiskDescriptionDeviceRevisionKey] as? String
        volumeData["deviceVendor"] = diskDescription[kDADiskDescriptionDeviceVendorKey] as? String
        volumeData["mediaEjectable"] = diskDescription[kDADiskDescriptionMediaEjectableKey] as? Bool
        volumeData["mediaRemovable"] = diskDescription[kDADiskDescriptionMediaRemovableKey] as? Bool
        volumeData["mediaWhole"] = diskDescription[kDADiskDescriptionMediaWholeKey] as? Bool
        volumeData["mediaWritable"] = diskDescription[kDADiskDescriptionMediaWritableKey] as? Bool

        volumes.append(volumeData)
      }
      result(volumes)
    } else {
      result(FlutterMethodNotImplemented)
    }
  }
}

class VolumeEventStreamHandler: NSObject, FlutterStreamHandler {
    
    var volumesEventSink: FlutterEventSink?
    var session: DASession?
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        print("onListen")

        volumesEventSink = events
        session = DASessionCreate(kCFAllocatorDefault)
        
        DARegisterDiskDescriptionChangedCallback(session!, nil as CFDictionary?, nil as CFArray?, onDiscDescriptionChanged, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))
        DARegisterDiskAppearedCallback(session!, nil as CFDictionary?, onDiskAppeared, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))
        DARegisterDiskDisappearedCallback(session!, nil as CFDictionary?, onDiskDisappeared, UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque()))

        DASessionScheduleWithRunLoop(session!, CFRunLoopGetMain(), CFRunLoopMode.defaultMode.rawValue);
        
        return nil
    }

    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        volumesEventSink = nil
        session = nil
        return nil
    }

    private let onDiscDescriptionChanged: DADiskDescriptionChangedCallback = { disk, keys, context in
        print("onDiscDescriptionChanged")
        let this = Unmanaged<VolumeEventStreamHandler>.fromOpaque(context!).takeUnretainedValue()
        this.diskEvent("changed")
    }

    private let onDiskAppeared: DADiskAppearedCallback = { disk, context in
        print("onDiskAppeared")
        let this = Unmanaged<VolumeEventStreamHandler>.fromOpaque(context!).takeUnretainedValue()
        this.diskEvent("appeared")
    }

    private let onDiskDisappeared: DADiskDisappearedCallback = { disk, context in
        print("onDiskDisappeared")
        let this = Unmanaged<VolumeEventStreamHandler>.fromOpaque(context!).takeUnretainedValue()
        this.diskEvent("disappeared")
    }

    private func diskEvent(_ event: String) {
      print("diskEvent: \(event)")
        volumesEventSink?([
            "event": event,
            // Add the other properties here if needed.
        ])
    }
}
