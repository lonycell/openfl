package openfl.net; #if !flash


/**
	The ObjectEncoding class is used in defining serialization settings in
	classes that serialize objects (such as FileStream, NetStream,
	NetConnection, SharedObject, and ByteArray).
	
	Object encoding controls how objects are represented in serialized
	formats, such as the Active Message Format (AMF) used by the Flash
	runtime. Flash Player uses AMF to enable efficient communication
	between an application and a remote server. AMF encodes remote procedure
	calls into a compact binary representation that can be transferred over
	HTTP/HTTPS or the RTMP/RTMPS protocol used by Flash Media Server.
	Objects and data values are serialized into this binary format, which
	is generally more compact than other representations, such as XML.
	
	OpenFL supports additional object encoding formats on non-Flash targets,
	including the Haxe Serialization Format (HXSF) and JavaScript Object
	Notation (JSON) for efficient communication for objects.
	
	Although AMF support is included in the Flash runtime, use of AMF on
	other targets requires the Haxe "format" library.
	
	_You can add the "format" library to your project by using 
	`<haxelib name="format" />` in an OpenFL project XML file._
	
	Adobe AIR and Flash Player 9 can serialize in two different formats:
	AMF3 and AMF0. AMF3, the default serialization developed for
	ActionScript 3.0, provides various advantages over AMF0, which is used
	for ActionScript 1.0 and 2.0. AMF3 sends data over the network more
	efficiently than AMF0. AMF3 supports sending `int` and `uint` objects as
	integers and supports data types that are available only in
	ActionScript 3.0, such as ByteArray, XML, and IExternalizable. It is
	available only in ActionScript 3.0 and with servers that use AMF3
	encoding, such as Flex 2.
	
	The ByteArray, FileStream, NetConnection, NetStream, SharedObject,
	Socket, and URLStream classes contain an `objectEncoding` property that is
	assigned a constant from the ObjectEncoding class. The behavior of the
	`objectEncoding` property differs depending on the object; each class's
	`objectEncoding` property description explains the behavior more
	thoroughly.
**/
@:enum abstract ObjectEncoding(Int) from Int to Int from UInt to UInt {
	
	/**
		Specifies that objects are serialized using the
		Action Message Format for ActionScript 1.0 and 2.0.
	**/
	public var AMF0 = 0;
	
	/**
		Specifies that objects are serialized using the
		Action Message Format for ActionScript 3.0.
	**/
	public var AMF3 = 3;
	
	/**
		Specifies that objects are serialized using the
		Haxe Serialization Format.
	**/
	public var HXSF = 10;
	
	/**
		Specifies that objects are serialized using
		JavaScript Object Notation.
	**/
	public var JSON = 12;
	
	/**
		Specifies the default format for the current target and runtime.
		
		Currently, the default on the Flash and AIR targets is AMF3, and
		the default on other targets is HXSF. If, in the future, a newer
		version of OpenFL introduces support for a new object encoding
		format, this may change. You can use this constant only if you're
		not concerned about interoperability with previous versions.
	**/
	#if flash
	public var DEFAULT = 3;
	#else
	public var DEFAULT = 10;
	#end
	
}


#else
typedef ObjectEncoding = flash.net.ObjectEncoding;
#end