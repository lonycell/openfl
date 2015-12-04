package openfl.events; #if (!display && !flash)


class IOErrorEvent extends ErrorEvent {
	
	
	public static var IO_ERROR = "ioError";
	
	
	public function new (type:String, bubbles:Bool = true, cancelable:Bool = false, text:String = "", id:Int = 0) {
		
		super (type, bubbles, cancelable, text, id);
		
	}
	
	
	public override function clone ():Event {
		
		var event = new IOErrorEvent (type, bubbles, cancelable, text, errorID);
		event.target = target;
		event.currentTarget = currentTarget;
		#if !openfl_legacy
		event.eventPhase = eventPhase;
		#end
		return event;
		
	}
	
	
	public override function toString ():String {
		
		return __formatToString ("IOErrorEvent",  [ "type", "bubbles", "cancelable", "text", "errorID" ]);
		
	}
	
	
}


#else


/**
 * An IOErrorEvent object is dispatched when an error causes input or output
 * operations to fail.
 *
 * <p>You can check for error events that do not have any listeners by using
 * the debugger version of Flash Player or the AIR Debug Launcher(ADL). The
 * string defined by the <code>text</code> parameter of the IOErrorEvent
 * constructor is displayed.</p>
 * 
 */

#if flash
@:native("flash.events.IOErrorEvent")
#end

extern class IOErrorEvent extends ErrorEvent {
	
	
	#if (flash && !display)
	public static var DISK_ERROR:String;
	#end
	
	/**
	 * Defines the value of the <code>type</code> property of an
	 * <code>ioError</code> event object.
	 *
	 * <p>This event has the following properties:</p>
	 */
	public static var IO_ERROR:String;
	
	#if (flash && !display)
	public static var NETWORK_ERROR:String;
	#end
	
	#if (flash && !display)
	public static var VERIFY_ERROR:String;
	#end
	
	
	/**
	 * Creates an Event object that contains specific information about
	 * <code>ioError</code> events. Event objects are passed as parameters to
	 * Event listeners.
	 * 
	 * @param type       The type of the event. Event listeners can access this
	 *                   information through the inherited <code>type</code>
	 *                   property. There is only one type of input/output error
	 *                   event: <code>IOErrorEvent.IO_ERROR</code>.
	 * @param bubbles    Determines whether the Event object participates in the
	 *                   bubbling stage of the event flow. Event listeners can
	 *                   access this information through the inherited
	 *                   <code>bubbles</code> property.
	 * @param cancelable Determines whether the Event object can be canceled.
	 *                   Event listeners can access this information through the
	 *                   inherited <code>cancelable</code> property.
	 * @param text       Text to be displayed as an error message. Event
	 *                   listeners can access this information through the
	 *                   <code>text</code> property.
	 * @param id         A reference number to associate with the specific error
	 *                  (supported in Adobe AIR only).
	 */
	public function new (type:String, bubbles:Bool = true, cancelable:Bool = false, text:String = "", id:Int = 0);
	
	
}


#end