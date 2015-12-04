package openfl.events; #if (!display && !flash)


import openfl.events.Event;


class AccelerometerEvent extends Event {
	
	
	public static var UPDATE:String;
	
	public var accelerationX:Float;
	public var accelerationY:Float;
	public var accelerationZ:Float;
	public var timestamp:Float;
	
	
	public function new (type:String, bubbles:Bool = false, cancelable:Bool = false, timestamp:Float = 0, accelerationX:Float = 0, accelerationY:Float = 0, accelerationZ:Float = 0):Void {
		
		super (type, bubbles, cancelable);
		
		this.timestamp = timestamp;
		this.accelerationX = accelerationX;
		this.accelerationY = accelerationY;
		this.accelerationZ = accelerationZ;
		
	}
	
	
	public override function clone ():Event {
		
		var event = new AccelerometerEvent (type, bubbles, cancelable, timestamp, accelerationX, accelerationY, accelerationZ);
		event.target = target;
		event.currentTarget = currentTarget;
		#if !openfl_legacy
		event.eventPhase = eventPhase;
		#end
		return event;
		
	}
	
	
	public override function toString ():String {
		
		return __formatToString ("AccelerometerEvent",  [ "type", "bubbles", "cancelable", "timestamp", "accelerationX", "accelerationY", "accelerationZ" ]);
		
	}
	
	
}


#else


/**
 * The Accelerometer class dispatches AccelerometerEvent objects when
 * acceleration updates are obtained from the Accelerometer sensor installed
 * on the device.
 * 
 */

#if flash
@:native("flash.events.AccelerometerEvent")
@:require(flash10_1)
#end

class AccelerometerEvent extends Event {
	
	
	/**
	 * Defines the value of the <code>type</code> property of a
	 * <code>AccelerometerEvent</code> event object.
	 *
	 * <p>This event has the following properties:</p>
	 */
	public static var UPDATE:String;
	
	
	/**
	 * Acceleration along the x-axis, measured in Gs.(1 G is roughly 9.8
	 * m/sec/sec.) The x-axis runs from the left to the right of the device when
	 * it is in the upright position. The acceleration is positive if the device
	 * moves towards the right.
	 */
	public var accelerationX:Float;
	
	/**
	 * Acceleration along the y-axis, measured in Gs.(1 G is roughly 9.8
	 * m/sec/sec.). The y-axis runs from the bottom to the top of the device when
	 * it is in the upright position. The acceleration is positive if the device
	 * moves up relative to this axis.
	 */
	public var accelerationY:Float;
	
	/**
	 * Acceleration along the z-axis, measured in Gs.(1 G is roughly 9.8
	 * m/sec/sec.). The z-axis runs perpendicular to the face of the device. The
	 * acceleration is positive if you move the device so that the face moves
	 * higher.
	 */
	public var accelerationZ:Float;
	
	/**
	 * The number of milliseconds at the time of the event since the runtime was
	 * initialized. For example, if the device captures accelerometer data 4
	 * seconds after the application initializes, then the <code>timestamp</code>
	 * property of the event is set to 4000.
	 */
	public var timestamp:Float;
	
	
	/**
	 * Creates an AccelerometerEvent object that contains information about
	 * acceleration along three dimensional axis. Event objects are passed as
	 * parameters to event listeners.
	 * 
	 * @param type          The type of the event. Event listeners can access
	 *                      this information through the inherited
	 *                      <code>type</code> property. There is only one type of
	 *                      update event: <code>AccelerometerEvent.UPDATE</code>.
	 * @param bubbles       Determines whether the Event object bubbles. Event
	 *                      listeners can access this information through the
	 *                      inherited <code>bubbles</code> property.
	 * @param cancelable    Determines whether the Event object can be canceled.
	 *                      Event listeners can access this information through
	 *                      the inherited <code>cancelable</code> property.
	 * @param timestamp     The timestamp of the Accelerometer update.
	 * @param accelerationX The acceleration value in Gs(9.8m/sec/sec) along the
	 *                      x-axis.
	 * @param accelerationY The acceleration value in Gs(9.8m/sec/sec) along the
	 *                      y-axis.
	 * @param accelerationZ The acceleration value in Gs(9.8m/sec/sec) along the
	 *                      z-axis.
	 */
	public function new (type:String, bubbles:Bool = false, cancelable:Bool = false, timestamp:Float = 0, accelerationX:Float = 0, accelerationY:Float = 0, accelerationZ:Float = 0):Void;
	
	
}


#end