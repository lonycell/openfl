package openfl.net; #if (!display && !flash)


import haxe.Timer;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.NetStatusEvent;
import openfl.media.SoundTransform;

#if (js && html5)
import js.html.VideoElement;
import js.Browser;
#end


class NetStream extends EventDispatcher {
	
	
	public var audioCodec (default, null):Int;
	public var bufferLength (default, null):Float;
	public var bufferTime:Float;
	public var bytesLoaded (default, null):Int;
	public var bytesTotal (default, null):Int;
	public var checkPolicyFile:Bool;
	public var client:Dynamic;
	public var currentFPS (default, null):Float;
	public var decodedFrames (default, null):Int;
	public var liveDelay (default, null):Float;
	public var objectEncoding (default, null):Int;
	public var soundTransform:SoundTransform;
	public var speed (get, set):Float;
	public var time (default, null):Float;
	public var videoCode (default, null)c:Int;
	
	private var __connection:NetConnection;
	private var __timer:Timer;
	
	#if (js && html5)
	private var __video (default, null):VideoElement;
	#end
	
	
	public function new (connection:NetConnection, peerID:String = null):Void {
		
		super ();
		
		__connection = connection;
		
		#if (js && html5)
		__video = cast Browser.document.createElement ("video");
		
		__video.addEventListener ("error", video_onError, false);
		__video.addEventListener ("waiting", video_onWaiting, false);
		__video.addEventListener ("ended", video_onEnd, false);
		__video.addEventListener ("pause", video_onPause, false);
		__video.addEventListener ("seeking", video_onSeeking, false);
		__video.addEventListener ("playing", video_onPlaying, false);
		__video.addEventListener ("timeupdate", video_onTimeUpdate, false);
		__video.addEventListener ("loadstart", video_onLoadStart, false);
		__video.addEventListener ("stalled", video_onStalled, false);
		__video.addEventListener ("durationchanged", video_onDurationChanged, false);
		__video.addEventListener ("canplay", video_onCanPlay, false);
		__video.addEventListener ("canplaythrough", video_onCanPlayThrough, false);
		#end
		
	}
	
	
	public function close ():Void {
		
		#if (js && html5)
		__video.pause ();
		__video.src = "";
		time = 0;
		#end
		
	}
	
	
	public function pause ():Void {
		
		#if (js && html5)
		__video.pause ();
		#end
		
	}
	
	
	public function play (url:String, ?_, ?_, ?_, ?_, ?_):Void {
		
		#if (js && html5)
		__video.src = url;
		__video.play ();
		#end
		
	}
	
	
	public function requestVideoStatus ():Void {
		
		#if (js && html5)
		if (__timer == null) {
			
			__timer = new Timer (1);
			
		}
		
		__timer.run = function () {
			
			if (__video.paused) {
				
				__playStatus ("NetStream.Play.pause");
				
			} else {
				
				__playStatus ("NetStream.Play.playing");
				
			}
			
			__timer.stop ();
			
		};
		#end
		
	}
	
	
	public function resume ():Void {
		
		#if (js && html5)
		__video.play ();
		#end
		
	}
	
	
	public function seek (offset:Float):Void {
		
		#if (js && html5)
		var time = __video.currentTime + offset;
		
		if (time < 0) {
			
			time = 0;
			
		} else if (time > __video.duration) {
			
			time = __video.duration;
			
		}
		
		__video.currentTime = time;
		#end
		
	}
	
	
	public function togglePause ():Void {
		
		#if (js && html5)
		if (__video.paused) {
			
			__video.play ();
			
		} else {
			
			__video.pause ();
			
		}
		#end
		
	}
	
	
	private function __playStatus (code:String):Void {
		
		#if (js && html5)
		if (client != null) {
			
			try {
				
				var handler = client.onPlayStatus;
				handler ({ 
					
					code: code,
					duration: __video.duration,
					position: __video.currentTime,
					speed: __video.playbackRate,
					start: untyped __video.startTime
					
				});
				
			} catch (e:Dynamic) {}
			
		}
		#end
		
	}
	
	
	
	
	// Event Handlers
	
	
	
	
	private function video_onCanPlay (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.canplay");
		
	}
	
	
	private function video_onCanPlayThrough (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.canplaythrough");
		
	}
	
	
	private function video_onDurationChanged (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.durationchanged");
		
	}
	
	
	private function video_onEnd (event:Dynamic):Void {
		
		__connection.dispatchEvent (new NetStatusEvent (NetStatusEvent.NET_STATUS, false, false, { code : "NetStream.Play.Stop" } ));
		__playStatus ("NetStream.Play.Complete");
		
	}
	
	
	private function video_onError (event:Dynamic):Void {
		
		__connection.dispatchEvent (new NetStatusEvent (NetStatusEvent.NET_STATUS, false, false, { code : "NetStream.Play.Stop" } ));
		__playStatus ("NetStream.Play.error");
		
	}
	
	
	private function video_onLoadStart (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.loadstart");
		
	}
	
	
	private function video_onPause (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.pause");
		
	}
	
	
	private function video_onPlaying (event:Dynamic):Void {
		
		__connection.dispatchEvent (new NetStatusEvent (NetStatusEvent.NET_STATUS, false, false, { code : "NetStream.Play.Start" } ));
		__playStatus ("NetStream.Play.playing");
		
	}
	
	
	private function video_onSeeking (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.seeking");
		
	}
	
	
	private function video_onStalled (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.stalled");
		
	}
	
	
	private function video_onTimeUpdate (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.timeupdate");
		
	}
	
	
	private function video_onWaiting (event:Dynamic):Void {
		
		__playStatus ("NetStream.Play.waiting");
		
	}
	
	
	
	
	// Get & Set Methods
	
	
	
	
	private function get_speed ():Float {
		
		#if (js && html5)
		return __video.playbackRate;
		#else
		return 1;
		#end
		
	}
	
	
	private function set_speed (value:Float):Float {
		
		#if (js && html5)
		return __video.playbackRate = value;
		#else
		return value;
		#end
		
	}
	
	
}


#else


import openfl.events.EventDispatcher;
import openfl.media.SoundTransform;
import openfl.utils.ByteArray;

#if flash
@:native("flash.net.NetStream")
#end


extern class NetStream extends EventDispatcher {
	
	
	#if (flash && !display)
	@:require(flash10) public static var CONNECT_TO_FMS:String;
	#end
	
	#if (flash && !display)
	@:require(flash10) public static var DIRECT_CONNECTIONS:String;
	#end
	
	
	public var audioCodec (default, null):Int;
	
	#if (flash && !display)
	@:require(flash10_1) public var audioReliable:Bool;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var audioSampleAccess:Bool;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var backBufferLength (default, null):Float;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var backBufferTime:Float;
	#end
	
	public var bufferLength (default, null):Float;
	
	public var bufferTime:Float;
	
	#if (flash && !display)
	@:require(flash10_1) public var bufferTimeMax:Float;
	#end
	
	public var bytesLoaded (default, null):UInt;
	
	public var bytesTotal (default, null):UInt;
	
	public var checkPolicyFile:Bool;
	
	public var client:Dynamic;
	
	public var currentFPS (default, null):Float;
	
	#if (flash && !display)
	@:require(flash10_1) public var dataReliable:Bool;
	#end
	
	public var decodedFrames (default, null):UInt;
	
	#if (flash && !display)
	@:require(flash10) public var farID (default, null):String;
	#end
	
	#if (flash && !display)
	@:require(flash10) public var farNonce (default, null):String;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var inBufferSeek:Bool;
	#end
	
	#if (flash && !display)
	@:require(flash10) public var info (default, null):flash.net.NetStreamInfo;
	#end
	
	public var liveDelay (default, null):Float;
	
	#if (flash && !display)
	@:require(flash10) public var maxPauseBufferTime:Float;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var multicastAvailabilitySendToAll:Bool;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var multicastAvailabilityUpdatePeriod:Float;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var multicastFetchPeriod:Float;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var multicastInfo (default, null):flash.net.NetStreamMulticastInfo;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var multicastPushNeighborLimit:Float;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var multicastRelayMarginDuration:Float;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var multicastWindowDuration:Float;
	#end
	
	#if (flash && !display)
	@:require(flash10) public var nearNonce (default, null):String;
	#end
	
	public var objectEncoding (default, null):UInt;
	
	#if (flash && !display)
	@:require(flash10) public var peerStreams (default, null):Array<Dynamic>;
	#end
	
	public var soundTransform:SoundTransform;
	
	//public var speed (get, set):Float;
	
	public var time (default, null):Float;
	
	#if (flash && !display)
	@:require(flash11) public var useHardwareDecoder:Bool;
	#end
	
	#if (flash && !display)
	@:require(flash11_3) public var useJitterBuffer:Bool;
	#end
	
	public var videoCodec (default, null):UInt;
	
	#if (flash && !display)
	@:require(flash10_1) public var videoReliable:Bool;
	#end
	
	#if (flash && !display)
	@:require(flash10_1) public var videoSampleAccess:Bool;
	#end
	
	#if (flash && !display)
	@:require(flash11) public var videoStreamSettings:flash.media.VideoStreamSettings;
	#end
	
	
	public function new (connection:NetConnection, ?peerID:String);
	
	
	#if (flash && !display)
	@:require(flash10_1) public function appendBytes (bytes:ByteArray):Void;
	#end
	
	
	#if (flash && !display)
	@:require(flash10_1) public function appendBytesAction (netStreamAppendBytesAction:String):Void;
	#end
	
	
	#if (flash && !display)
	@:require(flash10_1) public function attach (connection:NetConnection):Void;
	#end
	
	
	#if (flash && !display)
	public function attachAudio (microphone:flash.media.Microphone):Void;
	#end
	
	
	#if (flash && !display)
	public function attachCamera (theCamera:flash.media.Camera, snapshotMilliseconds:Int = -1):Void;
	#end
	
	
	public function close ():Void;
	
	
	#if (flash && !display)
	@:require(flash11_2) public function dispose ():Void;
	#end
	
	
	#if (flash && !display)
	@:require(flash10) public function onPeerConnect (subscriber:NetStream):Bool;
	#end
	
	
	public function pause ():Void;
	
	
	public function play (?p1:Dynamic, ?p2:Dynamic, ?p3:Dynamic, ?p4:Dynamic, ?p5:Dynamic):Void;
	
	
	#if (flash && !display)
	@:require(flash10) public function play2 (param:flash.net.NetStreamPlayOptions):Void;
	#end
	
	
	#if (flash && !display)
	public function publish (?name:String, ?type:String):Void;
	#end
	
	
	#if (flash && !display)
	public function receiveAudio (flag:Bool):Void;
	#end
	
	
	#if (flash && !display)
	public function receiveVideo (flag:Bool):Void;
	#end
	
	
	#if (flash && !display)
	public function receiveVideoFPS (FPS:Float):Void;
	#end
	
	
	//public function requestVideoStatus ():Void;
	
	
	#if (flash && !display)
	static public function resetDRMVouchers ():Void;
	#end
	
	
	public function resume ():Void;
	
	
	public function seek (offset:Float):Void;
	
	
	#if (flash && !display)
	public function send (handlerName:String, ?p1:Dynamic, ?p2:Dynamic, ?p3:Dynamic, ?p4:Dynamic, ?p5:Dynamic):Void;
	#end
	
	
	#if (flash && !display)
	@:require(flash10_1) public function step (frames:Int):Void;
	#end
	
	
	public function togglePause ():Void;
	
	
}


#end